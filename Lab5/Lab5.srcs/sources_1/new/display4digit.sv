`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 02:07:38 AM
// Design Name: 
// Module Name: display4digit
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


module display4digit(
    input wire [15:0] val,
    input wire clk,
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    logic [31:0] c = 0;
    wire [1:0] toptwo;
    wire [3:0] value4bit;
    
    always_ff @(posedge clk)
        c <= c + 1;
    
    assign toptwo[1:0] = c[18:17];
//     assign toptwo[1:0] = c[23:22];
    
    assign digitselect[3:0] = ~(
        toptwo == 2'b 00 ? 4'b 0001 :
        toptwo == 2'b 01 ? 4'b 0010 :
        toptwo == 2'b 10 ? 4'b 0100 :
        4'b 1000
    ); 
    
    assign digitselect[7:4] = ~(4'b 0000);
    
    assign value4bit = (
        toptwo == 2'b 00 ? val[3:0] :
        toptwo == 2'b 01 ? val[7:4] :
        toptwo == 2'b 10 ? val[11:8] :
        val[15:12]
    );
    
    hexto7seg myhexdecoder(value4bit, segments);
    
endmodule
