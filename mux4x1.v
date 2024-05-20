/*******************************************************************
*
* Module: mux4x1.v
* Project: Alarm/Clock
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module implements a 4-to-1 multiplexer.
*
* Change history: 05/13/24 - Initial implementation
*
**********************************************************************/

`timescale 1ns / 1ps

module mux4x1 (
    input wire [3:0] data0,
    input wire [3:0] data1,
    input wire [3:0] data2,
    input wire [3:0] data3,
    input wire [1:0] sel,
    output reg [3:0] out
);

    always @(*) begin
        case (sel)
            2'b00: out = data0;
            2'b01: out = data1;
            2'b10: out = data2;
            2'b11: out = data3;
            default: out = 4'b0000; // Default case to handle unexpected sel values
        endcase
    end

endmodule
