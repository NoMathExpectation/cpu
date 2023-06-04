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
    input clk,

    input left,
    input right,
    input up,
    input down,
    input reset,

    output reg [31:0] number = 32'b0,
    output reg [3:0] digit = 4'b0
    );
    reg [31:0] multiplier = 32'd1;

    reg [31:0] number_temp = 32'd0;
    reg [3:0] digit_temp = 4'd0;
    reg [31:0] multiplier_temp = 32'd1;

    localparam [31:0] max = 32'd10000000;

    reg [31:0] cooldown = 32'b0;

    always @(posedge clk) begin
        if (cooldown != 32'b0) cooldown = cooldown - 32'b1;

        if (reset) begin
            number <= 32'd0;
            digit <= 4'd0;
            multiplier <= 32'd1;

            number_temp <= 32'd0;
            digit_temp <= 4'd0;
            multiplier_temp <= 32'd1;
        end else if ((up | down | left | right) & (cooldown == 32'b0)) begin
            if (up) begin
                number_temp = number + multiplier;
            end else if (down) begin
                number_temp = number - multiplier;
            end else if (left) begin
                multiplier_temp = multiplier * 32'd10;
                digit_temp = digit + 4'd1;
                if (multiplier_temp >= max) begin
                    multiplier_temp = 32'd1;
                    digit_temp = 4'd0;
                end
            end else if (right) begin
                multiplier_temp = multiplier / 32'd10;
                digit_temp = digit - 4'd1;
                if (multiplier_temp == 32'd0) begin
                    multiplier_temp = max / 32'd10;
                    digit_temp = 4'd6;
                end
            end

            cooldown = 32'd2500000;
        end else begin
            number <= number_temp;
            digit <= digit_temp;
            multiplier <= multiplier_temp;
        end
    end
endmodule
