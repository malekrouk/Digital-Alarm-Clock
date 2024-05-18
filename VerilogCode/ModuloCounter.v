`timescale 1ns / 1ps


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


module SPModuloCounter #(parameter x=3, n=5) (input clk, reset, en, count_down,count_up, output reg [x-1:0] count);
always @( posedge clk, posedge reset) begin
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
        
      else  if(count_up == 1)begin
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


module SPModuloCounter2 #(parameter x=3, n=5) (input clk, reset, en, count_down,count_up, noHours,output reg [x-1:0] count);
always @( posedge clk, posedge reset) begin
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
            begin
            if(noHours==1)
            count<=3;
            else
                count <= n-1;
                
                end
                
            else
                count <= count-1;
        end
        
      else  if(count_up == 1)begin
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



