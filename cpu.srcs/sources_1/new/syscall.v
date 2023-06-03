`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/28 23:46:52
// Design Name: 
// Module Name: syscall
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


module syscall(
    input run,
    input reset,
    input ok,
    
    input up,
    input down,
    input left,
    input right,
    
    input cpu_clk, //5MHz
    output ctrl_cpu_clk,
    
    output [7:0] led_l,
    output [7:0] led_r,
    output [7:0] led_show,
    
    output reg [31:0] light = 32'b0,
    
    input [31:0] mode,
    input [31:0] value_in,
    output reg [31:0] value_out = 32'b0,
    output reg_write
    );
    reg block = 1'b0;
    reg [63:0] sleep = 64'b0;
    
    assign ctrl_cpu_clk = cpu_clk & ~block & (sleep <= 64'b1);
    
    reg blink = 1'b0;
    reg [31:0] blink_switch_count = 32'd0;
    localparam [31:0] blink_switch_threshold = 32'd2500000; //0.5s
    always @(posedge cpu_clk) begin
        blink_switch_count = blink_switch_count + 32'b1;
        if (blink_switch_count >= blink_switch_threshold) begin
            blink_switch_count = 32'd0;
            blink = ~blink;
        end
    end
    
    reg [31:0] num_show = 32'b0;
    reg num_show_sign = 1'b0;
    
    wire [31:0] num_read;
    wire num_read_reset = reset | (cpu_clk & ~run);
    reg num_read_sign = 1'b1;
    wire [3:0] num_read_digit;
    reg [7:0] num_read_dot = 8'b1;
    number_input_pad read_pad(.clk(cpu_clk), .left(left), .right(right), .up(up), .down(down), .reset(num_read_reset), .number(num_read), .digit(num_read_digit));
    always @(num_read_digit) begin
        num_read_dot = 8'b0;
        num_read_dot[num_read_digit] = 1'b1;
    end
    
    wire [63:0] led_raw;
    num_to_led ntl(.number(block ? num_read : num_show), .sign(block ? num_read_sign : num_show_sign), .dot(block ? num_read_dot : 8'b0), .led(led_raw));
    //num_to_led ntl(.number(block ? num_read : sleep[47:16]), .sign(num_read_sign), .dot(num_read_dot), .led(led_raw)); //debug

    wire [3:0] led_show_no_blink;
    led_show show(.led_in(led_raw), .clk(cpu_clk), .led_out_l(led_l), .led_out_r(led_r), .led_show(led_show_no_blink));
    assign led_show = (block & blink) ? 8'b0 : {2{led_show_no_blink}};
    
    assign reg_write = (mode == 32'd5);

    reg [32:0] ok_cooldown = 32'b0;

    always @(negedge cpu_clk) begin
        if (reset) begin
            block <= 1'b0;
            sleep <= 64'b0;
        
            num_show <= 32'b0;
            num_show_sign <= 1'b0;
        
            num_read_sign <= 1'b0;
        
            value_out <= 32'b0;
            light <= 32'b0;
        end else begin
            if (sleep != 64'b0) sleep = sleep - 64'b1;

            if (sleep == 64'b0 & run) begin
                case (mode)
                    32'd1: begin
                        num_show = value_in;
                        num_show_sign = 1'b1;
                    end
                    32'd5: begin
                        block = 1'b1;
                    end
                    32'd32: begin
                        sleep = value_in * 64'd5000;
                    end
                    32'd35: begin
                        light = value_in;
                    end
                    32'd36: begin
                        num_show = value_in;
                        num_show_sign = 1'b0;
                    end
                endcase
            end

            if (block & ok & (ok_cooldown == 32'b0)) begin
                value_out = num_read;
                block = 1'b0;
            end

            if (ok_cooldown != 32'b0) ok_cooldown = ok_cooldown - 32'b1;
            if (ok) ok_cooldown = 32'd5000000;
        end
    end
endmodule
