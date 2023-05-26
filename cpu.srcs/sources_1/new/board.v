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

    );
    reg [31:0] pc;
    reg [31:0] inst = 32'b0;
    
    wire [5:0] opcode = inst[31:26];
        
    wire [4:0] rs = inst[25:21];
    wire [4:0] rt = inst[20:16];
    wire [4:0] rd = inst[15:11];
    wire [4:0] shamt = inst[10:6];
    wire [5:0] funct = inst[5:0];
        
    wire [15:0] immediate = inst[15:0];
        
    wire [25:0] address = inst[25:0];
    
endmodule
