`timescale 1ns / 1ps



module ClockDivider #(parameter n = 250000)(input clk, rst, output reg clk_out);
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


