`timescale 1ns / 1ps
module ModuloCounter #(parameter x=3, n=5) (input clk, reset, en, load, count_down, input [x-1:0] load_value, output reg [x-1:0] count);
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
        else if(count_down == 1)begin
            if(count == 0)
                count <= n-1;
            else
                count <= count-1;
        end
        else if(load == 1)begin
            count <= load_value;
        end
        else
            count <= count;
    end
 end
endmodule

