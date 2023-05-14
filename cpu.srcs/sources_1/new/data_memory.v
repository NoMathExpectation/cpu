`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/14 20:13:05
// Design Name: 
// Module Name: data_memory
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


module data_memory(
    input cpu_clk,
    input cpu_write,
    input [13:0] cpu_addr,
    input [31:0] cpu_data_in,
    input [31:0] cpu_data_out,
    
    input uart_reset,
    input uart_clk,
    input uart_write,
    input [14:0] uart_addr,
    input [31:0] uart_data_in,
    input uart_done
    );
    wire cpu_mode = uart_reset | uart_done;
    wire uart_write_final = uart_write & uart_addr[14];
    
    data_memory_internal data_mem(
        .clka(cpu_mode ? ~cpu_clk : uart_clk),
        .wea(cpu_mode ? cpu_write : uart_write_final),
        .addra(cpu_mode ? cpu_addr : uart_addr[13:0]),
        .dina(cpu_mode ? cpu_data_in : uart_data_in),
        .douta(cpu_data_out)
    );
endmodule
