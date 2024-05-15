`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2024 12:12:04 PM
// Design Name: 
// Module Name: ModuloCounter
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


module ModuloCounter #(parameter x=3, n=5) (input clk, reset, en, output count); 
reg [x-1:0] count;
always @(posedge clk, posedge reset) begin
    if(reset == 1)
        count <= 0;
    else begin
        if(en == 1)begin
            if(count == n-1)
                count <= 0;
            else
                count <= count+1;
        end
        else
            count <= count;
    end
 end       
endmodule
