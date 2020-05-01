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


module top(
    input wire clock,
//    output wire char_code,
    output wire[3:0] red, green, blue,
    output wire hsync, vsync
    );
    
    localparam Nchar = 4;
    localparam Bmem = "bmem_screentest.mem";
    localparam Smem = "smem_screentest.mem";
    
    wire [$clog2(Nchar)-1 : 0] char_code;
    wire [10:0] screen_addr;
    
    vgadisplaydriver #(
        .Nchar(Nchar),
        .Bmem(Bmem)
    ) VDD(
        .clock(clock),
        .char_code(char_code),
        .red(red), .green(green), .blue(blue),
        .hsync(hsync), .vsync(vsync),
        .screen_addr(screen_addr)
    );
    
    rom_module #(
        .Nloc(1200),
        .Dbits($clog2(Nchar)),
        .initfile(Smem)
    ) smem(
        .addr(screen_addr),
        .dout(char_code)
    );
    
//    screenmem #(
//        .Nchar(Nchar),
//        .Smem(Smem)
//    ) SM(
//        .screen_addr(screen_addr),
//        .char_code(char_code)
//    );
    
    
endmodule
