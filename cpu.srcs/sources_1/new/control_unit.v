`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 11:32:24
// Design Name: 
// Module Name: control_unit
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
module control_unit(
    input clk,
    input [31:0] instruction,
    output reg_dst,reg_write,jump,jal,sftmd,jr,branch,nbranch,mem2reg,mem_write,alu_src,
    output [1:0] alu_op
    
);
wire i_format,r_format; 
assign i_format = (instruction[31:29]==3'b001) ? 1'b1 : 1'b0;
assign r_format = (instruction[31:26]==6'b000000)? 1'b1:1'b0;
assign jump = (instruction[31:26]==6'b000010);
assign jr = ((instruction[31:26]==6'b000000)&&(instruction[5:0]==6'b001000)) ? 1'b1 : 1'b0;

assign branch = (instruction[31:26]==6'b000100);
assign nbranch = (instruction[31:26]==6'b000101);
assign mem2reg = (instruction[31:26]==6'b100100)||(instruction[31:26]==6'b100101)||(instruction[31:26]==6'b110000)||(instruction[31:26]==6'b100011);
assign mem_write = (instruction[31:26]==6'b101011)||(instruction[31:26]==6'b101000)||(instruction[31:26]==6'b101001)||(instruction[31:26]==6'b111000);
assign alu_src = (i_format)&&!(branch)&&!(nbranch);

assign reg_dst = r_format; 
assign reg_write = (r_format || (instruction[31:26]==6'b100011) || jal || i_format) &&!(jr);
assign alu_op = { (r_format || i_format) , (branch || nbranch)};
assign sftmd = (((instruction[5:0]==6'b000000)||(instruction[5:0]==6'b000010)||(instruction[5:0]==6'b000011)||(instruction[5:0]==6'b000100)||(instruction[5:0]==6'b000110)||(instruction[5:0]==6'b000111))&& r_format) ? 1'b1 : 1'b0;    

    
endmodule

