`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/27/2020 10:20:10 AM
// Design Name: 
// Module Name: CounterMod4
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


module CounterMod4(
    input wire clock,
    input wire reset,
    output logic [1:0] value = 0
    );
    
    always_ff @ (posedge clock) begin
        value <= reset ? 2'b 00 : (value + 1);
    end
    
endmodule
