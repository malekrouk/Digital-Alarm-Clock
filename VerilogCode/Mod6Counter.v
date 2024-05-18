`timescale 1ns / 1ps


module Mod6Counter(input clk, reset,en,count_down,count_up, output [2:0]count);
wire w1;
ClockDivider clkDivider(clk, reset, w1);
SPModuloCounter #(3,6) mod10(w1,reset,en,count_down,count_up,count);
endmodule

module Mod3Counter(input clk, reset,en,count_down,count_up, output [1:0]count);
wire w1;
ClockDivider clkDivider(clk, reset, w1);
SPModuloCounter #(2,3) mod10(w1,reset,en,count_down,count_up,count);
endmodule


