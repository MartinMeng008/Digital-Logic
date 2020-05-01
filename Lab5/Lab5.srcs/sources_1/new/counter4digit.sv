`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 01:56:13 AM
// Design Name: 
// Module Name: counter4digit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module counter4digit(
    input wire clock,
    output wire [7:0] digitselect,
    output wire [7:0] segments
    );
    
    wire [15:0] value;
    
    counter C(.clock(clock), .value(value));
    display4digit D(.val(value), .clk(clock), 
                    .digitselect(digitselect), 
                    .segments(segments));
    
endmodule
