`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 11:41:20
// Design Name: 
// Module Name: Dmem
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


module Dmem(clock,address,Memwrite,write_data,read_data);

    input               clock; // ʱ���ź�
    input   [31:0]      address; // read/write memory address
    input               Memwrite; // ���� read memory ���� write memory
    input   [31:0]      write_data; // д����
    output  [31:0]      read_data; // ������


    // ����һ��ʱ���źţ�����ʱ�ӷ��ŵķ���ʱ��
    wire clk;
    assign clk = !clock;

    RAM ram (
        .clka(clk), // input wire clka
        .wea(Memwrite), // input wire [0 : 0] wea
        .addra(address[15:2]), // input wire [13 : 0] addra
        .dina(write_data), // input wire [31 : 0] dina
        .douta(read_data) // output wire [31 : 0] douta
    );

endmodule
