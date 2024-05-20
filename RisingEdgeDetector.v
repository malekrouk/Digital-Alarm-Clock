/*******************************************************************
*
* Module: RisingEdgeDetector.v
* Project: Alarm/Clock
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu

* Description: This module detects rising edges on the input signal 'I'.
*
* Change history: 05/13/24 - Initial implementation
*
**********************************************************************/

`timescale 1ns / 1ps

module RisingEdgeDetector (
    input wire clk,
    input wire rst,
    input wire I,
    output wire O
);
    reg [1:0] state, nextState;
    parameter [1:0] A = 2'b00, B = 2'b01, C = 2'b10;

    // State transition logic
    always @(*) begin
        case (state)
            A: if (I == 0) nextState = A;
               else nextState = B;
            B: if (I == 0) nextState = A;
               else nextState = C;
            C: if (I == 0) nextState = A;
               else nextState = C;
            default: nextState = A;
        endcase
    end

    // State register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= A;
        end else begin
            state <= nextState;
        end
    end

    // Output logic
    assign O = (state == B);

endmodule
