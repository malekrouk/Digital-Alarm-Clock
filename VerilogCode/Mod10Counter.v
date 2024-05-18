`timescale 1ns / 1ps

module Mod10Counter(input clk, reset,en,count_down,count_up, output [3:0]count);
wire w1;
ClockDivider clkDivider(clk, reset, w1);
SPModuloCounter #(4,10) mod10(w1,reset,en,count_down,count_up,count);
endmodule


module Mod10Counter2(input clk, reset,en,count_down,count_up,noHours, output [3:0]count);
wire w1;
ClockDivider clkDivider(clk, reset, w1);
SPModuloCounter2 #(4,10) mod10(w1,reset,en,count_down,count_up,noHours,count);
endmodule