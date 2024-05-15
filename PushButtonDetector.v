`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
module debouncer(input clk, rst, in, output out);
reg q1,q2,q3;
always@(posedge clk, posedge rst) begin
 if(rst == 1'b1) begin
 q1 <= 0;
 q2 <= 0;
 q3 <= 0;
 end
 else begin
 q1 <= in;
 q2 <= q1;
 q3 <= q2;
 end
end
assign out = (rst) ? 0 : q1&q2&q3;
endmodule

module Synchronizer(input clk, rst, SIG, output reg SIG1);
reg META;
always@(posedge clk, posedge rst) begin
 if(rst == 1'b1) begin
 META <= 0;
 SIG1 <= 0;
 end
 else begin
 META <= SIG;
 SIG1 <= META;
 end
end
endmodule

module PushButtonDetector(input clk, rst, X, output Z);
wire clk_out;
ClockDivider #(250000)oneHundredHz(clk,rst,clk_out);
wire output1;
debouncer Debouncer (clk,rst,X,output1);
wire output2;
Synchronizer sync(clk, rst, output1,output2);
RisingEdgeDetector Detect(clk,rst,output2,Z);


endmodule
