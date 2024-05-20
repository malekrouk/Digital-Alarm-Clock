/*******************************************************************
*
* Module: Mod6Counter.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author3: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module implements a modulo-6 counter.
*
* Change history: 
*   05/13/24 - Initial implementation
*   05/18/24 - Added count down and count up functionality
**********************************************************************/

`timescale 1ns / 1ps

module Mod6Counter (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    output  [2:0] count
);
    wire clk_out;

    ClockDivider clkDivider (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    SPModuloCounter #(3, 6) mod6 (
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
* Module: Mod3Counter.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author3: Saif Ahmed, saif_ahmed@aucegypt.edu
* Author4: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module implements a modulo-3 counter with up and down functionality.
*
* Change history: 
*   05/13/24 - Initial implementation
*   05/18/24 - Added count down and up functionality
**********************************************************************/

`timescale 1ns / 1ps

module Mod3Counter (
    input wire clk,
    input wire rst,
    input wire en,
    input wire count_down,
    input wire count_up,
    output  [1:0] count
);
    wire clk_out;

    ClockDivider clkDivider (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    SPModuloCounter #(2, 3) mod3 (
        .clk(clk_out),
        .rst(rst),
        .en(en),
        .count_down(count_down),
        .count_up(count_up),
        .count(count)
    );

endmodule
