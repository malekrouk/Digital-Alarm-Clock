`timescale 1ns / 1ps
module ModuloCounter_tb;
reg clk, reset, en, load, count_down;
reg [2:0] load_value;
wire [2:0] count;
ModuloCounter #(.x(3), .n(5)) mc(clk, reset, en, load, count_down, load_value, count);
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end
initial begin
    reset = 1;
    en = 0;
    load = 0;
    count_down = 0;
    load_value = 0;
    #10 reset = 0;
    #10 en = 1;
    #10 load = 1;
    #10 load_value = 3;
    #10 load = 0;
    #10 en = 0;
    #10 en = 1;
    #10 count_down = 1;
    #10 count_down = 0;
    #10 en = 0;
    #10 en = 1;
    #10 load = 1;
    #10 load_value = 4;
    #10 load = 0;
    #10 en = 0;
    #10 $finish;
end