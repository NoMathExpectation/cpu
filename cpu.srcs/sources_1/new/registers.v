`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 10:53:31
// Design Name: 
// Module Name: registers
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


module registers(
    input is_write,
    input clk,
    input [4:0] read1,
    input [4:0] read2,
    input [4:0] write,
    input [31:0] write_data,
    output reg [31:0] read_data1,
    output reg [31:0] read_data2
    );
    reg [31:0] data [31:0];
    reg [5:0] i;
    
    initial begin
        for (i = 6'd0; i < 6'd32; i = i + 6'd1) begin
            data[i] <= 32'd0;
        end
    end
    
    always @(posedge clk) begin
        if (is_write) begin
            data[write] <= write_data;
        end else begin
            read_data1 <= data[read1];
            read_data2 <= data[read2];
        end
    end
    
endmodule
