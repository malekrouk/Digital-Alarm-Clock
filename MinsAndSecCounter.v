`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 12:55:08 PM
// Design Name: 
// Module Name: MinsAndSecCounter
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


module MinsAndSecCounter(input clk,reset,en, output [3:0] count1, [3:0]count3, [2:0] count2,[2:0] count4, [3:0] count5,[1:0] count6);
//reg [3:0] en;

Mod10Counter sec_units(.clk(clk),.reset(reset |count5==4 & count6==2),.en(1'b1 & en),.count(count1));// sec units
Mod6Counter sec_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count1==9 & en),.count(count2));// sec tens

Mod10Counter minuites_units(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count1==9 & count2==5 & en),.count(count3));// minuites units
Mod6Counter minuites_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count3==9 & count2==5 & count1==9 & en),.count(count4)); // Minutes tens

Mod10Counter Hours_units(.clk(clk),.reset(reset |count5==4 & count6==2 ),.en(count4==5 & count3==9 & count2==5 & count1==9 & en),.count(count5)); //hours units
Mod3Counter Hours_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count5==9&count4==5 & count3==9 & count2==5 & count1==9 & en),.count(count6)); // hours tens



/*


Mod10Counter mod101(.clk(clk),.reset(reset),.en(en[0]),.count(count1));
Mod6Counter(.clk(clk),.reset(reset),.en(en[1]),.count(count2));

Mod10Counter mod102(.clk(clk),.reset(reset),.en(en[2]),.count(count3));
Mod6Counter(.clk(clk),.reset(reset),.en(en[3]),.count(count4));

always @ (*) begin
en[0]=1'b1;

if (count1==9)
    en[1]=1;
else
    en[1]=0;
    
if (count1==9 && count2==5)
    en[2]=1;
else
    en[2]=0;
    
if (count3==9 && count2==5 && count1==9)
    en[3]=1;
else
    en[3]=0;

end
*/
endmodule
