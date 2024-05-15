`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 01:09:23 PM
// Design Name: 
// Module Name: Mod6Counter
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


module Mod6Counter(input clk, reset,en, output [2:0]count);
wire w1;
ClockDivider clkDivider(clk, rst, w1);
ModuloCounter #(3,6) mod10(w1,reset,en,count);
endmodule

module Mod3Counter(input clk, reset,en, output [2:0]count);
wire w1;
ClockDivider clkDivider(clk, rst, w1);
ModuloCounter #(2,3) mod10(w1,reset,en,count);
endmodule


