`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 01:43:19 PM
// Design Name: 
// Module Name: exp5
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


module exp5(input clk, reset, en,output [6:0] segments,output [3:0] anode_active, output reg DP);


wire [3:0] sec_units;
wire [2:0] sec_tens;
wire [3:0] Min_units;
wire [2:0] Min_Tens ;
wire [3:0] Hour_units;
wire [1:0] Hour_Tens ;
wire [1:0] sel;
wire[3:0] out;
wire clk_out;
wire clk_1hz;

//module MinsAndSecCounter(input clk,reset, output [3:0] count1, [3:0]count3, [2:0] count2,[2:0] count4, [3:0] count5,[1:0] count6);

MinsAndSecCounter digitalClk( .clk(clk), .reset(reset),.en(en), .count1(sec_units), .count3(Min_units), .count2(sec_tens), .count4(Min_Tens),.count5(Hour_units),.count6(Hour_Tens));

ClockDivider #(250000)div(clk, reset, clk_out);
ClockDivider #(50000000) clockdiv_1hz(clk,reset,clk_1hz);

always @(*) begin
    if(anode_active==4'b1011 && clk_1hz)
        DP=0; //active low, so the DP activates
    else 
       DP=1;
    end

ModuloCounter #(2,4) counter(.clk(clk_out), .reset(reset),.en(1'b1), .count(sel));

mux4x1 mux(.data0({1'b0, 1'b0,Hour_Tens}),.data1(Hour_units),.data2({1'b0,Min_Tens}),.data3(Min_units),.sel(sel), .out(out));

sevenSeg seg(.en(sel),.in(out),.segments(segments), .anode_active(anode_active));  

endmodule
