/*******************************************************************
*
* Module: Mod10Counter.v
* Project: Alarm/Clock
* Author: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module implements a modulo-10 counter.
*
* Change history: 
*   05/13/24 - Initial implementation
*   05/17/24 - Added count down and count up functionality
**********************************************************************/

`timescale 1ns / 1ps

module Mod10Counter (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    output  [3:0] count
);
    wire clk_out;

    ClockDivider clkDivider (
        clk,
        rst,
        clk_out
    );

    SPModuloCounter #(4, 10) mod10 (
        .clk(clk_out),
        .rst(rst),
        .en(en),
        .count_down(count_down),
        .count_up(count_up),
        .count(count)
    );

endmodule

/*******************************************************************
*
* Module: Mod10Counter2.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Saif Ahmed, saif_ahmed@aucegypt.edu
* Description: This module implements a modulo-10 counter with additional noHours functionality.
*
* Change history: 
*   05/17/24 - Initial implementation
*   05/18/24 - Added load functionality
*   05/19/24 - Added no hours flag
**********************************************************************/

`timescale 1ns / 1ps

module Mod10Counter2 (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    input wire noHours,
    output  [3:0] count
);
    wire clk_out;

    ClockDivider clkDivider (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    SPModuloCounter2 #(4, 10) mod10 (
        .clk(clk_out),
        .rst(rst),
        .en(en),
        .count_down(count_down),
        .count_up(count_up),
        .noHours(noHours),
        .count(count)
    );

endmodule
