`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/22/2020 03:59:07 AM
// Design Name: 
// Module Name: stopwatch
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


module stopwatch(
    input wire clock,
    input wire up, center, down,
    output wire [7:0] digitselect,
    output wire [7:0] segments
    );
    
    // debouncers
    wire BTNU_clean, BTNC_clean, BTND_clean;
    debouncer #(22) D1(.raw(up), .clock(clock), .clean(BTNU_clean));
    debouncer #(22) D2(.raw(center), .clock(clock), .clean(BTNC_clean));
    debouncer #(22) D3(.raw(down), .clock(clock), .clean(BTND_clean));
    
    // fsm
    wire countup, paused;
    fsm F(
    .clock(clock),
    .up(BTNU_clean), .center(BTNC_clean), .down(BTND_clean),
    .countup(countup), .paused(paused)
    );
    
    // updowncounter
    wire [31:0] value;
    updowncounter UDC(
    .clock(clock),
    .countup(countup),
    .paused(paused),
    .value(value)
    );
    
    // display
    display8digit D(.val(value), .clock(clock), 
                    .digitselect(digitselect),
                    .segments(segments));
   
                     
endmodule
