/*******************************************************************
*
* Module: MinsAndSecCounter.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author3: Saif Ahmed, saif_ahmed@aucegypt.edu
* Author4: Habiba Seif, habibaseif@aucegypt.edu
*
* Description: This module implements a minutes and seconds counter with additional functionality for counting hours.
*
* Change history: 05/13/24 - Initial implementation   2,4
*                 05/17/24 - added load functionality     3
*                 05/18/24 - added count up/down  functionality    1
*
**********************************************************************/

`timescale 1ns / 1ps

module MinsAndSecCounter (
    input wire clk,
    input wire reset,
    input wire en,
    input wire c_up_min,
    input wire c_up_hour,
    input wire c_down_min,
    input wire c_down_hour,
    output  [3:0] count1,
    output  [3:0] count3,
    output  [2:0] count2,
    output  [2:0] count4,
    output  [3:0] count5,
    output  [1:0] count6
);

    // Seconds
    Mod10Counter sec_units (
        .clk(clk),
        .rst(reset),
        .en(en),
        .count_down(1'b0),
        .count_up(1'b0),
        .count(count1)
    );

    Mod6Counter sec_tens (
        .clk(clk),
        .rst(reset),
        .en(count1 == 4'b1001 & en),
        .count_down(1'b0),
        .count_up(1'b0),
        .count(count2)
    );

    // Minutes
    Mod10Counter minuites_units (
        .clk(clk),
        .rst(reset),
        .en(count1 == 4'b1001 & count2 == 3'b101 & en),
        .count_down(c_down_min),
        .count_up(c_up_min),
        .count(count3)
    );

    Mod6Counter minuites_tens (
        .clk(clk),
        .rst(reset),
        .en(count3 == 4'b1001 & count2 == 3'b101 & count1 == 4'b1001 & en),
        .count_down(c_down_min & count3 == 2'b00),
        .count_up(count3 == 4'b1001 & c_up_min),
        .count(count4)
    );

    // Hours
    Mod10Counter2 Hours_units (
        .clk(clk),
        .rst(reset | count5 == 4'b0100 & count6 == 2'b10),
        .en(count4 == 3'b101 & count3 == 4'b1001 & count2 == 3'b101 & count1 == 4'b1001 & en),
        .count_down(c_down_hour),
        .count_up(c_up_hour),
        .noHours(count6 == 2'b00),
        .count(count5)
    );

    Mod3Counter Hours_tens (
        .clk(clk),
        .rst(reset | count5 == 4'b0100 & count6 == 2'b10),
        .en(count5 == 4'b1001 & count4 == 3'b101 & count3 == 4'b1001 & count2 == 3'b101 & count1 == 4'b1001 & en),
        .count_down(c_down_hour & count5 == 2'b00),
        .count_up(c_up_hour & count5 == 4'b1001 & count6 != 2'b10),
        .count(count6)
    );

endmodule
