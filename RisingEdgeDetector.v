`timescale 1ns / 1ps

module RisingEdgeDetector(input clk, rst, I, output O);
reg [1:0] state, nextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10; 

always @ (I or state)
case (state)
A: if (I==0) nextState = A;
 else nextState = B;
B: if (I==0) nextState = A;
 else nextState = C;
C: if (I==0) nextState = A;
 else nextState = C;
default: nextState = A;
endcase

always @ (posedge clk or posedge rst) begin
if(rst) state <= A;
else state <= nextState;
end

assign O = (state == B);
endmodule
