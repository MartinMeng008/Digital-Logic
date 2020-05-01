`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/01/2020 01:28:02 PM
// Design Name: 
// Module Name: counter1second
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


module counter1second(
    input wire clock,
    output wire [3:0] value
    );
    
    logic [31:0] internalvalue = 0;
    
    always_ff @(posedge clock) begin
        internalvalue <= internalvalue + 1;
    end
    
    // assign value = internalvalue[18:15];
    assign value = internalvalue[29:26];
    
endmodule
