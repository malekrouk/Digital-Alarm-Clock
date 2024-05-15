`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 12:14:55 PM
// Design Name: 
// Module Name: Mod10Counter
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


module Mod10Counter(input clk, reset,en, output [3:0]count);
wire w1;
ClockDivider clkDivider(clk, rst, w1);
ModuloCounter #(4,10) mod10(w1,reset,en,count);
endmodule