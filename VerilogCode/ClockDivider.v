/*******************************************************************
*
* Module: ClockDivider.v
* Project: Alarm/Clock
* Author: Mostafa Gaafar, mostafa21314@aucegypt.edu
* Author: Malek Mahmoud, Malekrouk@aucegypt.edu
* Author: Saif Ahmed, saif_ahmed@aucegypt.edu
* Author: Habiba Seif, habibaseif@aucegypt.edu
* Description: This module divides the input clock signal by a specified factor 'n' to generate an output clock signal.
*
* Change history: 
* 05/13/24 - Initial implementation
* 05/17/24 - changed the default divider to synchronize different modules together
**********************************************************************/

`timescale 1ns / 1ps

module ClockDivider #
(parameter n = 250000)
(
    input wire clk,
    input wire rst,
    output reg clk_out
);

wire [31:0] count;
// Big enough to hold the maximum possible value
// Increment count
ModuloCounter #(32, n) counterMod (
    .clk(clk),
    .reset(rst),
    .en(1),
    .count(count)
);

// Handle the output clock
always @ (posedge clk or posedge rst) begin
    if (rst) // Asynchronous Reset
        clk_out <= 0;
    else if (count == n - 1)
        clk_out <= ~clk_out;
end

endmodule
