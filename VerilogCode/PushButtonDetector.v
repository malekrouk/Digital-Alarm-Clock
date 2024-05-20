/*******************************************************************
*
* Module: debouncer.v
* Project: Alarm/Clock
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu

* Description: This module debounces a noisy input signal.
*
 Change history: 05/13/24 - Initial implementation
           
**********************************************************************/

`timescale 1ns / 1ps

module debouncer (
    input wire clk,
    input wire rst,
    input wire in,
    output wire out
);
    reg q1, q2, q3;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            q1 <= 0;
            q2 <= 0;
            q3 <= 0;
        end else begin
            q1 <= in;
            q2 <= q1;
            q3 <= q2;
        end
    end

    assign out = (rst) ? 0 : q1 & q2 & q3;

endmodule

/*******************************************************************
*
* Module: Synchronizer.v
* Project: Alarm/Clock
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module synchronizes an asynchronous input signal to the clock domain.
*
* Change history: 05/13/24 - Initial implementation
*
**********************************************************************/

`timescale 1ns / 1ps

module Synchronizer (
    input wire clk,
    input wire rst,
    input wire SIG,
    output reg SIG1
);
    reg META;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            META <= 0;
            SIG1 <= 0;
        end else begin
            META <= SIG;
            SIG1 <= META;
        end
    end

endmodule

/*******************************************************************
*
* Module: PushButtonDetector.v
* Project: Alarm/Clock
* Author1: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author2: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author3: Habiba Seif, habibaseif@aucegypt.edu

* Description: This module detects push button presses using debouncing and synchronization.
*
 Change history: 05/13/24 - Initial implementation 2&3
                 05/17/24 - final Tuning 1
*
**********************************************************************/

`timescale 1ns / 1ps

module PushButtonDetector (
    input wire clk,
    input wire rst,
    input wire X,
    output wire Z
);
    wire clk_out;
    wire output1;
    wire output2;

    ClockDivider #(75000) oneHundredHz (
        .clk(clk),
        .rst(rst),
        .clk_out(clk_out)
    );

    debouncer Debouncer (
        .clk(clk),
        .rst(rst),
        .in(X),
        .out(output1)
    );

    Synchronizer sync (
        .clk(clk),
        .rst(rst),
        .SIG(output1),
        .SIG1(output2)
    );

    RisingEdgeDetector Detect (
        .clk(clk),
        .rst(rst),
        .I(output2),
        .O(Z)
    );

endmodule
