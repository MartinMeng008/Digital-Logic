`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 09:45:34 PM
// Design Name: 
// Module Name: counter8digit
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


module counter8digit(
    input wire clock,
    output wire [7:0] digitselect,
    output wire [7:0] segments
    );
    
    wire [31:0] value;
    
    counter32bit C(.clock(clock), .value(value));
    display8digit D(.val(value), .clk(clock), 
                    .digitselect(digitselect),
                    .segments(segments));
    
endmodule

