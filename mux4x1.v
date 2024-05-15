`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 01:46:02 PM
// Design Name: 
// Module Name: mux4x1
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


module mux4x1(input [3:0] data0,input [3:0] data1,input [3:0] data2,input [3:0] data3,input [1:0] sel,output reg [3:0] out);

always @(*) begin
    case(sel)
        2'b00: out = data0;
        2'b01: out = data1;
        2'b10: out = data2;
        2'b11: out = data3;
    endcase
end

endmodule