`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 12:05:03 PM
// Design Name: 
// Module Name: ClockDivider
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


//50000000
//module ClockDivider #(parameter n = 10000) (input clk, rst, output reg clk_out);
//parameter WIDTH = $clog2(n);
//reg [WIDTH-1:0] count;
//// Big enough to hold the maximum possible value// Increment count
//always @ (posedge clk, posedge rst) begin
//if (rst == 1'b1) // Asynchronous Reset  count <= 32'b0;
//    count <= 32'b0;
//else if (count == n-1)
// count <= 32'b0;
//else
// count <= count + 1;
//end
//// Handle the output clock
//always @ (posedge clk, posedge rst) begin
//if (rst) // Asynchronous Reset
// clk_out <= 0;
//else if (count == n-1)
// clk_out <= ~ clk_out;
//end
//endmodule 


module ClockDivider #(parameter n = 5000000)(input clk, rst, output reg clk_out);
wire [31:0] count;
// Big enough to hold the maximum possible value
// Increment count
ModuloCounter #(32,n) counterMod(.clk(clk), .reset(rst), .en(1),.count(count));
// Handle the output clock
always @ (posedge clk, posedge rst) begin
if (rst) // Asynchronous Reset
clk_out <= 0;
else if (count == n-1)
clk_out <= ~ clk_out;
end
endmodule

