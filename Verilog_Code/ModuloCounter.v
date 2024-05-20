/*******************************************************************
*
* Module: ModuloCounter.v
* Project: Alarm/Clock
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module implements a modulo counter.
*
* Change history: 05/13/24 - Initial implementation
*
**********************************************************************/

`timescale 1ns / 1ps

module ModuloCounter #(
    parameter x = 3,
    parameter n = 5
) (
    input wire clk,
    input wire reset,
    input wire en,
    output reg [x-1:0] count
);
    always @(posedge clk or posedge reset) begin
        if (reset)
            count <= 0;
        else if (en) begin
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end
    end
endmodule

/*******************************************************************
*
* Module: SPModuloCounter.v
* Project: Alarm/Clock
* Author: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Description: This module implements a modulo counter with additional count up and count down functionality.
*
* Change history: 05/17/24 - Initial implementation
*                 05/18/24 - added better logic for the always block
**********************************************************************/

`timescale 1ns / 1ps

module SPModuloCounter #(
    parameter x = 3,
    parameter n = 5
) (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    output reg [x-1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (en) begin
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end else if (count_down) begin
            if (count == 0)
                count <= n-1;
            else
                count <= count - 1;
        end else if (count_up) begin
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end
    end
endmodule

/*******************************************************************
*
* Module: SPModuloCounter2.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Saif Ahmed, saif_ahmed@aucegypt.edu
* Description: This module implements a modulo counter with additional count up, count down, and noHours functionality.
*
* Change history: 05/17/24 - Initial implementation 1&2
*                 05/18/24 - added the noHour flag to the counter to accomodate for 24 hours 1&2
**********************************************************************/

`timescale 1ns / 1ps

module SPModuloCounter2 #(
    parameter x = 3,
    parameter n = 5
) (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    input wire noHours,
    output reg [x-1:0] count
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (en) begin
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end else if (count_down) begin
            if (count == 0) begin
                if (noHours)
                    count <= 3;
                else
                    count <= n-1;
            end else
                count <= count - 1;
        end else if (count_up) begin
            if (count == n-1)
                count <= 0;
            else
                count <= count + 1;
        end
    end
endmodule
