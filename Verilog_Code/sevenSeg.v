/*******************************************************************
*
* Module: sevenSeg.v
* Project: Alarm/Clock
* Author1: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author2: Saif Ahmed, saif_ahmed@aucegypt.edu
* Author3: Habiba Seif, habibaseif@aucegypt.edu

* Description: This module drives a 7-segment display based on the input value.
*
* Change history: 05/13/24 - Initial implementation 1&3
*                 05/17/24 - final tuning  2
*
**********************************************************************/

`timescale 1ns / 1ps

module sevenSeg (
    input wire [1:0] en,
    input wire [3:0] in,
    output reg [6:0] segments,
    output reg [3:0] anode_active
);

    always @ (in, en) begin
        // Determine which anode to activate based on 'en'
        case (en)
            2'b00: anode_active = 4'b0111;
            2'b01: anode_active = 4'b1011;
            2'b10: anode_active = 4'b1101;
            2'b11: anode_active = 4'b1110;
        endcase

        // Set the segments based on the 'in' value
        case (in)
            4'b0000: segments = 7'b0000001; 
            4'b0001: segments = 7'b1001111;
            4'b0010: segments = 7'b0010010;
            4'b0011: segments = 7'b0000110;
            4'b0100: segments = 7'b1001100;
            4'b0101: segments = 7'b0100100;
            4'b0110: segments = 7'b0100000;
            4'b0111: segments = 7'b0001111;
            4'b1000: segments = 7'b0000000;
            4'b1001: segments = 7'b0000100;
            default: segments = 7'b1111111; // Default to all segments off
        endcase
    end

endmodule
