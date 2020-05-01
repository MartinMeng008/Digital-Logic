`timescale 1ns / 1ps
`default_nettype none
//`include "display10x4.vh"
`include "display640x480.vh"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/04/2020 11:41:03 AM
// Design Name: 
// Module Name: vgatimer
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


module vgatimer(
    input wire clk,
    output wire hsync, vsync, activevideo,
    output wire [`xbits-1:0] x,
    output wire [`ybits-1:0] y
    );
    
    // These lines below allow you to count every 2nd clock tick and 4th clock tick
    // This is because, depending on the display mode, ve may need to count at 50 MHz or 25 MHz
    
    logic [1:0] clk_count=0;
    always_ff @(posedge clk)
        clk_count <= clk_count + 2'b 01;
    
    wire Every2ndTick = (clk_count[0] == 1'b 1);
    wire Every4thTick = (clk_count[1:0] == 2'b 11);
    
    // This part instantiates an xy-counter using the appropriate clock tick counter
    // xycounter #(`WholeLine, `WholeFrame) xy(clk, Every2ndTick, x, y); // Count at 50 MHz
    xycounter #(`WholeLine, `WholeFrame) xy(clk, Every4thTick, x, y); // Count at 25 MHz
    
    // Generate the monitor sync signals
    assign hsync = ((x >= `hSyncStart) && (x <= `hSyncEnd)) ? ~`hSyncPolarity : `hSyncPolarity;
    assign vsync = ((y >= `vSyncStart) && (y <=`vSyncEnd)) ? ~`vSyncPolarity : `vSyncPolarity;
    assign activevideo = ((x >= 0) && x < `hVisible) && ((y >= 0) && (y < `vVisible));
    
endmodule
