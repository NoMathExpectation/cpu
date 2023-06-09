`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/26 17:32:16
// Design Name: 
// Module Name: execute
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


module execute(
    input run, //if execute needs to run
    
    input [5:0] opcode,
    
    input [31:0] reg1, //data from register
    input [31:0] reg2, //data from register
    input [15:0] immediate,
    output reg [31:0] out = 32'b0, //result
    
    input [4:0] shamt,
    input [5:0] funct
    );
    wire [31:0] sign_ext_immediate = {{16{immediate[15]}}, immediate};
    wire [31:0] zero_ext_immediate = {16'b0, immediate};
    
    always @(posedge run) begin
        case(opcode)
            6'b000100: out = {31'b0, reg1 == reg2};
            6'b000101: out = {31'b0, reg1 != reg2}; 
            6'b100011, 6'b101011, 6'b001000, 6'b001001: out = reg1 + sign_ext_immediate;
            6'b001010: out = {31'b0, slt(reg1, sign_ext_immediate)};
            6'b001011: out = {31'b0, reg1 < sign_ext_immediate};
            6'b001100: out = reg1 & zero_ext_immediate;
            6'b001101: out = reg1 | zero_ext_immediate;
            6'b001110: out = reg1 ^ zero_ext_immediate;
            6'b001111: out = {immediate, 16'b0};
            
            6'b000000: case (funct)
                6'b000000: out = reg2 << shamt;
                6'b000010: out = reg2 >> shamt;
                6'b000100: out = reg2 << reg1;
                6'b000011: out = reg2 >>> shamt;
                6'b000111: out = reg2 >>> reg1;
                6'b100000, 6'b100001: out = reg1 + reg2;
                6'b100010, 6'b100011: out = reg1 - reg2;
                6'b100100: out = reg1 & reg2;
                6'b100101: out = reg1 | reg2;
                6'b100110: out = reg1 ^ reg2;
                6'b100111: out = ~(reg1 | reg2);
                6'b101010: out = {31'b0, slt(reg1, reg2)};
                6'b101011: out = {31'b0, reg1 < reg2};
            endcase
        endcase
    end
    
    function slt;
        input [31:0] a;
        input [31:0] b;
        begin
            slt = 1'b0;
            if (a[31] & ~b[31]) slt = 1'b1;
            else if ((a[31] ~^ b[31]) & (a[30:0] < b[30:0])) slt = 1'b1;
        end
    endfunction
endmodule
