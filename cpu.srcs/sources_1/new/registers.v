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
    input reset,
    input clk,

    input to_read, //if read

    input [4:0] read1, //register number 1 to read
    input [4:0] read2, //register number 2 to read
    output reg [31:0] read_data1 = 32'b0, //data from register 1
    output reg [31:0] read_data2 = 32'b0, //data from register 2
    
    input to_write, //if write
    input [4:0] write, //register number to write
    input [31:0] write_data //data to write
    );
    reg [31:0] data [31:0];
    reg [5:0] i;
    
    initial begin
        for (i = 6'd0; i < 6'd32; i = i + 6'd1) begin
            data[i] = 32'd0;
        end
        data[28] = 32'h10008000;
        data[29] = 32'h7ffffffc;
    end
    
    always @(negedge clk) begin
        if (reset) begin
            for (i = 6'd0; i < 6'd32; i = i + 6'd1) begin
                data[i] = 32'd0;
            end
            data[28] = 32'h10008000;
            data[29] = 32'h7ffffffc;
        end else if (to_write) data[write] <= write_data;
        else if (to_read) begin
            read_data1 <= data[read1];
            read_data2 <= data[read2];
        end
    end
endmodule
