`timescale 1ns / 1ps
`default_nettype none
`include "display640x480.vh"
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


module vgadisplaydriver #(
    parameter Nchar = 4,
    parameter bmem_init = "... .mem"
)(
    input wire clock,
    input wire [$clog2(Nchar)-1 : 0] char_code,
    output wire[3:0] red, green, blue,
    output wire hsync, vsync,
    output wire [11:0] screen_addr
    );
    
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire activevideo;
      
    localparam N_bitmap_addr = Nchar << 8; // # of bitmap address = # of characters * 256
 
    wire [$clog2(N_bitmap_addr)-1:0] bmem_addr; 
    wire [11:0] bmem_color;
    
    //////////////////////////// VGA Timer ////////////////////////////////////////
    vgatimer V(
        .clk(clock),
        .hsync(hsync), 
        .vsync(vsync),
        .activevideo(activevideo),
        .x(x),
        .y(y)    
    );
    
  
    //////////////////////////// Bitmap Memory /////////////////////////////////////////////
    rom_module #(
        .Nloc(N_bitmap_addr), 
        .Dbits(12),
        .initfile(bmem_init)
    ) bmmem(
        .addr(bmem_addr),
        .dout(bmem_color)
    );
    
    ////////////////////////// Calculate screen address /////////////////////////////////////
    wire [`xbits-1-4:0] col = x >> 4;
    wire [`ybits-1-4:0] row = y >> 4;
    assign screen_addr = (row << 5) + (row << 3) + col;
       
    ////////////////////////// Calculate bitmap address /////////////////////////////////////
    assign bmem_addr = {char_code, y[3:0], x[3:0]};
    ////////////////////////// output RGB value /////////////////////////////////////////////
    assign red[3:0] = (activevideo == 1) ? bmem_color[11:8] : 4'b0;
    assign green[3:0] = (activevideo == 1) ? bmem_color[7:4] : 4'b0;
    assign blue[3:0] = (activevideo == 1) ? bmem_color[3:0] : 4'b0;   
    
endmodule
