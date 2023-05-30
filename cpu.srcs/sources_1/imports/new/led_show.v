`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/09 14:25:19
// Design Name: 
// Module Name: led_show
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


module led_show(
    input [63:0] led_in,
    input clk,
    output reg [7:0] led_out_l,
    output reg [7:0] led_out_r,
    output reg [3:0] led_show
    );
    reg [1:0] p = 2'b0;
    always @(posedge clk) begin
        p = p + 2'b1;
        led_show = 4'b0;       
        led_show[p] <= 1'b1;
        case (p)
            2'b00: begin
                led_out_l <= led_in[39:32];
                led_out_r <= led_in[7:0];
            end
            2'b01: begin
                led_out_l <= led_in[47:40];
                led_out_r <= led_in[15:8];
                end
            2'b10: begin
                led_out_l <= led_in[55:48];
                led_out_r <= led_in[23:16];
                end
            2'b11: begin
                led_out_l <= led_in[63:56];
                led_out_r <= led_in[31:24];
                end
        endcase
    end
    
endmodule
