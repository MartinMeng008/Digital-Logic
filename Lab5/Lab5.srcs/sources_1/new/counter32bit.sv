`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 09:55:24 PM
// Design Name: 
// Module Name: counter32bit
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


module counter32bit(
    input wire clock,
    output wire [31:0] value
    );
    
    logic [63:0] internalvalue = 0;
    
    always_ff @(posedge clock)
        internalvalue <= internalvalue + 1;
    
    assign value = internalvalue[50:19];
    
endmodule
