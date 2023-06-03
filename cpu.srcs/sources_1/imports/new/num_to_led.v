`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/01/07 23:08:38
// Design Name: 
// Module Name: num_to_led
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


module num_to_led(
    input [31:0] number, //number to show
    input sign, //show as signed number
    input [7:0] dot, //whether to show dots
    output reg [63:0] led = 64'b0 //output led signal
    );
    wire neg = sign & number[31];
    
    reg [3:0] i;
    reg [3:0] rem;
    reg [31:0] num;

    always @(number, sign, dot, neg) begin
        num = neg ? ~number + 32'b1 : number;
        
        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            rem = num % 32'd10;
            case (rem)
                4'd0: led[63:57] = 7'b1110111;
                4'd1: led[63:57] = 7'b0010010;
                4'd2: led[63:57] = 7'b1011101;
                4'd3: led[63:57] = 7'b1011011;
                4'd4: led[63:57] = 7'b0111010;
                4'd5: led[63:57] = 7'b1101011;
                4'd6: led[63:57] = 7'b1101111;
                4'd7: led[63:57] = 7'b1010010;
                4'd8: led[63:57] = 7'b1111111;
                4'd9: led[63:57] = 7'b1111011;
            endcase
            
            if (i < 4'd7) begin
                led = led >> 4'd8;
                num = num / 32'd10;
            end
        end

        for (i = 4'd0; i < 4'd8; i = i + 4'd1) begin
            led[8 * i] = dot[i];
        end
        
        if (neg) led[63:57] = 7'b0001000;
    end
endmodule
