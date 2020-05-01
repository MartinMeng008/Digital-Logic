`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2020 01:35:44 PM
// Design Name: 
// Module Name: hexcounterdisplay
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


module hexcounterdisplay(
    input wire clock,
    output wire [7:0] digitselect,
    output wire [7:0] segments
    );
    
    wire [3:0] value;
    
    assign digitselect = ~(8'b 0000_0001);
    
    counter1second CS(.clock(clock), .value(value));
    hexto7seg HS(.X(value), .segments(segments));
    
endmodule
