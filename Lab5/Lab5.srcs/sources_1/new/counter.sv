`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 03:51:48 PM
// Design Name: 
// Module Name: counter
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


module counter(
    input wire clock,
    output wire [15:0] value
    );
    
    logic [63:0] internalvalue = 0;
    
    always_ff @(posedge clock)
        internalvalue <= internalvalue + 1;
        
    assign value = internalvalue[38:23];
    
endmodule
