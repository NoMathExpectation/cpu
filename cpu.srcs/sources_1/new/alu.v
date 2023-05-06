`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/12 11:31:00
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] op,
    output reg [31:0] result,
    output reg zero,
    output reg overflow
    );
    always @* begin
        overflow = 1'b0;
        case(op)
            4'b0: result = a & b;
            4'b1: result = a | b;
            4'b10: begin
                result = a + b;
                overflow = ( a[31] & b[31] & ~result[31] ) | (~a[31] & ~b[31] & result[31] );
            end
            4'b110: begin
                result = a - b;
                overflow = (~a[31] & b[31] & result[31] ) | (a[31] & ~b[31] & ~result[31] ); 
            end
            4'b111: if ((a[31] && ~b[31]) || ((a[31] ~^ b[31]) && (a[30:0] < b[30:0])))
                result = 31'b1;
            else
                result = 31'b0;
            4'b1100: result = ~(a | b);
        endcase
        zero = 1'b0 || result;
    end
endmodule
