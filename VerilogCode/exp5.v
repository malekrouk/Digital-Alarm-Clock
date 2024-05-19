`timescale 1ns / 1ps

module exp5(input clk, reset, en,
count_upMin,count_upHour,count_downMin,count_downHour,
output [6:0] segments,output [3:0] anode_active, output[19:0]allSum,output reg DP);





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
wire clk_250k;
ClockDivider #(250000)div(clk, reset, clk_out);
ClockDivider #(50000000) clockdiv_1hz(clk,reset,clk_1hz);
ClockDivider #(100) clock_250k(clk,reset,clk_250k);
wire clk_final;
assign clk_final = en? clk_250k:clk;
//assign clk_final = en? clk:clk  //comment out and comment the previous line for a faster clock

MinsAndSecCounter digitalClk( .clk(clk_final), .reset(reset),.en(en), 
 .c_up_min(count_upMin), .c_up_hour(count_upHour),
.c_down_min(count_downMin),.c_down_hour(count_downHour),
.count1(sec_units), .count3(Min_units), .count2(sec_tens), .count4(Min_Tens),
.count5(Hour_units),.count6(Hour_Tens));


always @(*) begin
if(en)
begin
    if(anode_active==4'b1011 && clk_1hz)
        DP=0; //active low, so the DP activates
    else 
       DP=1;
       end
       else begin
       DP=1;
       end
    end


ModuloCounter #(2,4) counter(.clk(clk_out), .reset(reset),.en(1'b1), .count(sel));

mux4x1 mux(.data0({1'b0, 1'b0,Hour_Tens}),.data1(Hour_units),.data2({1'b0,Min_Tens}),.data3(Min_units),.sel(sel), .out(out));

sevenSeg seg(.en(sel),.in(out),.segments(segments), .anode_active(anode_active));  

assign allSum = {Hour_Tens, Hour_units, Min_Tens,Min_units,sec_tens,sec_units};

endmodule
