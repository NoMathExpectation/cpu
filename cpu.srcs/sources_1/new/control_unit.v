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
    output reg reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src
);

always@(posedge clk)
begin
    case(instruction[31:26])
        //jump
        6'h2:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00100000000;
            end
        //jal
        6'h3:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b01010000000;
            end        
        //beq
        6'h4:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00001000100;
            end
        //bne
        6'h5:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000100100;           
            end
        //lw
        6'h23:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;        
            end
        //sw
        6'h2b:
            begin
               {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;         
            end
        //addi
        6'h8:
            begin
               {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;          
            end        
        //addiu
        6'h9:
            begin
               {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;    
            end
        //slti
        6'ha:            
            begin
               {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        //sltiu
        6'hb:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        //andi
        6'hc:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        //ori
        6'hd:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        //xori
        6'he:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        //lui
        6'hf:
            begin
                {reg_dst,reg_write,jump,jal,branch,nbranch,mem_read,mem2reg,alu_op,mem_write,alu_src} = 11'b00000000000;     
            end
        
        
        
        
    endcase
    
end
    
endmodule
