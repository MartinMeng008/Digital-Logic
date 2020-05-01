`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 05:38:37 PM
// Design Name: 
// Module Name: top
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


module screenmem #(
    parameter Nchar = 2,
    parameter Smem = "... .mem"
)(
    input wire [11:0] screen_addr,
    output wire [$clog2(Nchar)-1 : 0] char_code
    );
    
    rom_module #(
        .Nloc(1200),
        .Dbits($clog2(Nchar))
    ) smem(
        .addr(screen_addr),
        .dout(char_code)
    );
    
endmodule
