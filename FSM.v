`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2024 05:04:57 PM
// Design Name: 
// Module Name: FSM
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

module fsm(input clk, rst, btn1,btn2,btn3,btn4,btn5, output [6:0]segments,output [3:0] anode_active, output  DP,  LD0,LD12, LD13, LD14, LD15);
reg [2:0] state, nextState;
wire BTNU, BTNC, BTND, BTNR, BTNL;
parameter [2:0] A= 3'b000,B=3'b001, C=3'b010, D= 3'b011, E= 3'b100;//F=3'b101;// States Encoding
wire clk_out;
ClockDivider #(250000)div(clk, reset, clk_out);

//A=clock/alarm
//B=time hour
//C=time minute
//D=alarm hour
//E=alarm minute
// Next state generation
reg enable_clock;
exp5 clock( clk, rst, enable_clock,segments, anode_active,  DP);
PushButtonDetector one(clk_out, rst, btn1, BTNU);
PushButtonDetector two(clk_out, rst, btn2, BTNC);
PushButtonDetector three(clk_out,rst, btn3, BTND);
PushButtonDetector four(clk_out,rst, btn4, BTNR);
PushButtonDetector five(clk_out,rst, btn5, BTNL);
//assign L = BTNC;
//
always @ (state,BTNC,BTNR,BTNL) begin
case (state)
A: if (BTNC==1'b1&BTND==1'b0&BTNU==1'b0&BTNR==1'b0&BTNL==1'b0)begin
        //assign LD0 = 1'b1;
        enable_clock = 1'b0;
        nextState = B;
     end
 else begin
    enable_clock = 1'b1;
    nextState =A;
 end
 
B:if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b1&BTNL==1'b0)begin
    nextState = C;
    end
    else if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b0&BTNL==1'b1)begin
    nextState = E;
    end
    else nextState = B;
    
C:  if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b1&BTNL==1'b0)begin
    nextState = D;
    end
    else if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b0&BTNL==1'b1)begin
    nextState = B;
    end
    else   nextState = C;
    
D:  if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b1&BTNL==1'b0)begin
    nextState = E;
    end
    else if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b0&BTNL==1'b1)begin
    nextState = C;
    end
    else  nextState = D;
    
E:  if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b1&BTNL==1'b0)begin
    nextState = B;
    end
    else if (BTNC==1'b0&BTND==1'b0&BTNU==1'b0&BTNR==1'b0&BTNL==1'b1)begin
    nextState = D;
    end
    else  nextState = E;
default: nextState = A;
endcase
end
// State register

always @ (posedge clk_out or posedge rst) begin
if(rst) state <= A;
else state <= nextState;
end
assign LD0 = (state==A) ?1:0;
assign LD12 = (state==B) ?1:0;
assign LD13 = (state==C) ?1:0;
assign LD14 = (state==D) ?1:0;
assign LD15 = (state==E) ?1:0;
endmodule