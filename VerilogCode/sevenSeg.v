`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2024 01:49:12 PM
// Design Name: 
// Module Name: sevenSeg
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


module sevenSeg(input [1:0] en,input [3:0] in,output reg [6:0] segments,output reg [3:0] anode_active);

always @ (in,en) begin
case(en)
2'b00: anode_active= 4'b0111;
2'b01: anode_active = 4'b1011;
2'b10: anode_active = 4'b1101;
2'b11: anode_active = 4'b1110;
endcase

 case(in)
  0: segments = 7'b0000001; 
  1: segments = 7'b1001111;
  2: segments = 7'b0010010;
  3: segments = 7'b0000110;
  4: segments = 7'b1001100;
  5: segments = 7'b0100100;
  6: segments = 7'b0100000;
  7: segments = 7'b0001111;
  8: segments = 7'b0000000;
  9: segments = 7'b0000100;
  endcase

end
endmodule

