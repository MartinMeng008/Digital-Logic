`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2020 04:16:11 AM
// Design Name: 
// Module Name: updowncounter
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


module updowncounter(
    input wire clock,
    input wire countup,
    input wire paused,
    output logic [31:0] value
    );
    
    logic [63:0] internalvalue = 0;
    always_ff @ (posedge clock) begin
        internalvalue <= (paused == 1) ? internalvalue :
                 (countup == 1) ? (internalvalue + 1) : 
                 (internalvalue - 1);
    end
    
    assign value = internalvalue[50:19]; // the least significant bit changes 256 times per second
 
endmodule
