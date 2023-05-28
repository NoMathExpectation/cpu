`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/14 20:40:02
// Design Name: 
// Module Name: instruction_memory
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


module instruction_memory(
    input cpu_mode,

    input cpu_clk,
    input [31:0] cpu_next_addr,
    output [31:0] cpu_inst,
    
    input uart_clk,
    input uart_write,
    input [14:0] uart_addr,
    input [31:0] uart_inst
    );
    wire uart_write_final = uart_write & ~uart_addr[14];
        
    data_memory_internal inst_mem(
        .clka(cpu_mode ? cpu_clk : uart_clk),
        .wea(cpu_mode ? 1'b0 : uart_write_final),
        .addra(cpu_mode ? cpu_next_addr[13:0] : uart_addr[13:0]),
        .dina(cpu_mode ? 32'b0 : uart_inst),
        .douta(cpu_inst)
    );
endmodule
