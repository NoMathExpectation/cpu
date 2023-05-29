`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/06 15:19:49
// Design Name: 
// Module Name: number_input_pad
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


module number_input_pad(
    input left,
    input right,
    input up,
    input down,
    input reset,
    input [31:0] set_number,
    output reg [31:0] number = 32'd0,
    output reg [3:0] digit = 4'd0
    );
    reg [31:0] multiplier = 32'd1;
    reg [31:0] temp = 32'd0;
    localparam [31:0] max = 32'd9_999_999;

    always @(posedge reset, posedge up, posedge down, posedge left, posedge right) begin
        if (reset) begin
            number = set_number;
            digit = 4'd0;
            multiplier = 32'd1;
        end else if (up) begin
            temp = number + multiplier;
            number = temp;
        end else if (down) begin
            temp = number - multiplier;
            number = temp;
        end else if (left) begin
            multiplier = multiplier * 32'd10;
            digit = digit + 4'd1;
            if (multiplier > max) begin
                multiplier = 32'd1;
            digit = 4'd0;
            end
        end else if (right) begin
            multiplier = multiplier / 32'd10;
            digit = digit - 4'd1;
            if (multiplier == 32'd0) begin
                multiplier = max / 32'd10;
                digit = 4'd6;
            end
        end
    end
endmodule
