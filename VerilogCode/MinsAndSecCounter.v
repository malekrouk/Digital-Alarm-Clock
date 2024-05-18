`timescale 1ns / 1ps
module MinsAndSecCounter(input clk,reset,en,c_up_min,c_up_hour,c_down_min,c_down_hour,
 
 output [3:0] count1, [3:0]count3, [2:0] count2,[2:0] count4, [3:0] count5,[1:0] count6);
 


Mod10Counter sec_units(.clk(clk),.reset(reset |count5==4 & count6==2),.en(en),.count_down(0),.count_up(0),.count(count1));// sec units
Mod6Counter sec_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count1==9 & en),.count_down(0),.count_up(0),.count(count2));// sec tens


//min
Mod10Counter minuites_units(.clk(clk),.reset(reset),.en(count1==9 & count2==5 & (en|c_up_min)),.count_down(c_down_min),
.count_up(c_up_min),.count(count3));// minuites units

Mod6Counter minuites_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en(count3==9 & count2==5 & count1==9 & (en|c_up_min)),
.count_down(c_down_min&count3==0),.count_up(count3==9&c_up_min)  ,.count(count4)); // Minutes tens


//hour
Mod10Counter2 Hours_units(.clk(clk),.reset(reset |count5==4 & count6==2 ),.en((count4==5 & count3==9 & count2==5 & count1==9 &en)),
.count_down(c_down_hour),.count_up(c_up_hour) ,.noHours(count6==0),.count(count5)); //hours units

Mod3Counter Hours_tens(.clk(clk),.reset(reset |count5==4 & count6==2),.en((count5==9&c_up_hour)|(count5==9&count4==5 & count3==9 & count2==5 & count1==9&en)),
.count_down(c_down_hour&count5==0),.count_up((c_up_hour&count5==9&count6!=2)) ,.count(count6)); // hours tens


endmodule
