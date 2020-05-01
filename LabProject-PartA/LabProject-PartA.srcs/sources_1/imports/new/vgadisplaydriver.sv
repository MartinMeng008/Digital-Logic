`timescale 1ns / 1ps
`default_nettype none
//`include "display10x4.vh"
`include "display640x480.vh"


module vgadisplaydriver(
    input wire clk,
    output wire[3:0] red, green, blue,
    output wire hsync, vsync
    );
    
    wire [`xbits-1:0] x;
    wire [`ybits-1:0] y;
    wire activevideo;
    
//    wire redEnable = (x[1:0] == 2'b 11);
//    wire greenEnable = (y[1:0] == 2'b 11);
//    wire
    
    vgatimer myvgatimer(clk, hsync, vsync, activevideo, x, y);
    
    wire [`xbits+`ybits-1:0] z;
    assign z = x + y;
    
    assign red[3:0] = 
                        (activevideo == 1) ? 
                        ((x[1:0] == 2'b 11) ? 
                            (x[`xbits-1:2] + 1)
                          : x[`xbits-1:2]) 
                      : 
                      4'b0;
    assign green[3:0] = 
                        (activevideo == 1) ? 
                        ((y[1:0] == 2'b 11) ? 
                            (y[`ybits-1:2] + 1)
                          : y[`ybits-1:2]) 
                      : 
                      4'b0;
    assign blue[3:0] = 
                          (activevideo == 1) ? 
//                          ((z[1:0] == 2'b 11) ? 
//                            (z[`xbits+`ybits-1:2] + 1)
//                          : z[`xbits+`ybits-1:2]) 
                        red + green            
                        : 4'b0;
        
endmodule
