`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 17:31:30
// Design Name: 
// Module Name: board
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module board(
    input clk,
    
    input ok, //middle button
    input not_reset, //RESET#

    //number input pad
    input up,
    input down,
    input left,
    input right,
    
    input uart_rx, //receive data
    output uart_tx, //send data
    
    output [7:0] led_l, //left part of 7-seg led
    output [7:0] led_r, //right part of 7-seg led
    output [7:0] led_show, //used to control which part to show
    
    output [31:0] light //lights
    );
    wire reset = ~not_reset;

    reg cpu_mode = 1'b0;
    reg [2:0] cpu_step = 3'b0;
    
    wire cpu_clk, uart_clk;
    wire ctrl_cpu_clk;
    clk_adjust clk_adj(.input_clk(clk), .cpu_clk(cpu_clk), .uart_clk(uart_clk));
    
    wire uart_proc_clk, uart_write, uart_done;
    wire [14:0] uart_addr;
    wire [31:0] uart_data;
    uart u(.upg_clk_i(uart_clk), .upg_rst_i(reset), .upg_rx_i(uart_rx), .upg_clk_o(uart_proc_clk), .upg_wen_o(uart_write), .upg_adr_o(uart_addr), .upg_dat_o(uart_data), .upg_done_o(uart_done), .upg_tx_o(uart_tx));
    
    reg [31:0] pc = 32'h003ffffc;
    wire [31:0] inst;
    
    wire [5:0] opcode = inst[31:26];
    
    wire type_r = (opcode == 6'b0);
    wire type_j = (opcode[5:1] == 5'b00001);
    wire type_i = ~(type_r | type_j);
        
    wire [4:0] rs = inst[25:21];
    wire [4:0] rt = inst[20:16];
    wire [4:0] rd = inst[15:11];
    wire [4:0] shamt = inst[10:6];
    wire [5:0] funct = inst[5:0];
        
    wire [15:0] immediate = inst[15:0];
        
    wire [25:0] address = inst[25:0];
    
    wire syscall_inst = (opcode == 6'b0) & (funct == 6'hc);
    
    wire fetch_inst = (cpu_step == 3'b000);
    instruction_memory inst_mem(.cpu_mode(cpu_mode), .cpu_clk(fetch_inst), .cpu_next_addr(pc), .cpu_inst(inst), .uart_clk(uart_proc_clk), .uart_write(uart_write), .uart_addr(uart_addr), .uart_inst(uart_data));

    wire syscall_reg_write;
    wire [31:0] syscall_write;
    
    wire read_reg = (cpu_step == 3'b001);
    wire write_reg = (cpu_step == 3'b100) & ~((opcode == 6'b0) & ((funct == 6'b001000 /*jr*/) | ((funct == 6'hc) & ~syscall_reg_write /*syscall*/))) & (opcode != 6'b101011) /*sw*/ & (opcode != 6'b000010) /*j*/ & (opcode[5:1] != 6'b00010) /*beq bne*/;
    wire [4:0] reg_read1 = syscall_inst ? 5'd2 : rs;
    wire [4:0] reg_read2 = syscall_inst ? 5'd4 : rt;
    wire [4:0] reg_write = syscall_inst ? 5'd2 : (type_j ? 5'd31 : (type_r ? rd : rt));
    wire [31:0] read_data1, read_data2;
    
    wire [31:0] mem_data_out;
    wire [31:0] exec_res;
    wire [31:0] write_data = syscall_inst ? syscall_write : (opcode == 6'b100011 ? mem_data_out : (type_j ? pcp4 : exec_res));
    registers regs(.reset(reset), .clk(ctrl_cpu_clk), .to_read(read_reg), .read1(reg_read1), .read2(reg_read2), .read_data1(read_data1), .read_data2(read_data2), .to_write(write_reg), .write(reg_write), .write_data(write_data));
    
    wire call = (cpu_step == 3'b010) & syscall_inst;
    wire [31:0] mode = syscall_inst ? read_data1 : 32'b0;
    wire [31:0] value = syscall_inst ? read_data2 : 32'b0;
    wire [7:0] led_l_sys, led_r_sys;
    assign led_l = cpu_mode ? led_l_sys : (uart_done ? 8'b11111110 : {uart_rx, cpu_clk, ~cpu_clk, ctrl_cpu_clk, uart_clk, ~uart_clk, ~ctrl_cpu_clk, 1'b0});
    assign led_r = cpu_mode ? led_r_sys : (uart_done ? 8'b11111110 : {up, left, right, down, reset, ok, 2'b0});
    //assign led_l = led_l_sys;
    //assign led_r = led_r_sys;
    wire [31:0] light0;
    assign light = light0;
    syscall sys(.run(call), .reset(reset), .ok(ok), .up(up), .down(down), .left(left), .right(right), .cpu_clk(cpu_clk), .ctrl_cpu_clk(ctrl_cpu_clk), .led_l(led_l_sys), .led_r(led_r_sys), .led_show(led_show), .light(light0), .mode(mode), .value_in(value), .value_out(syscall_write), .reg_write(syscall_reg_write));
    
    wire calc = (cpu_step == 3'b010) & ~syscall_inst;
    execute exec(.run(calc), .opcode(opcode), .reg1(read_data1), .reg2(read_data2), .immediate(immediate), .out(exec_res), .shamt(shamt), .funct(funct));
    
    wire mem = (cpu_step == 3'b011) & ((opcode == 6'b100011) | (opcode == 6'b101011));
    wire mem_write = (opcode == 6'b101011);
    wire [31:0] mem_addr = exec_res;
    wire [31:0] mem_data_in = read_data2;
    data_memory data_mem(.cpu_mode(cpu_mode), .cpu_clk(mem), .cpu_write(mem_write), .cpu_addr(mem_addr), .cpu_data_in(mem_data_in), .cpu_data_out(mem_data_out), .uart_clk(uart_proc_clk), .uart_write(uart_write), .uart_addr(uart_addr), .uart_data_in(uart_data));
    
    wire jump = (cpu_step == 3'b101);
    wire [31:0] pcp4 = pc + 32'd4;
    wire [31:0] jump_addr = {pcp4[31:28], address, 2'b0};
    wire [31:0] branch_addr = {{14{immediate[15]}}, immediate, 2'b0};

    always @(posedge reset, posedge ctrl_cpu_clk) begin
        if (reset) begin
            cpu_mode = 1'b0;
            cpu_step = 3'b0;
            pc = 32'h003ffffc;
        end else begin
            if (ok/*  & uart_done */) cpu_mode = 1'b1;

            if (cpu_mode & ctrl_cpu_clk) begin
                cpu_step = cpu_step + 3'b1;
                
                if (jump) begin
                    if (opcode[5:1] == 5'b00010 & exec_res[0]) pc = pcp4 + branch_addr;
                    else if (type_j) pc = jump_addr;
                    else if ((opcode == 6'b0) & (funct == 6'b001000)) pc = read_data1;
                    else pc = pcp4;
                end
            end
        end
    end
    
endmodule
