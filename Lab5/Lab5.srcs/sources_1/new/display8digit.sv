`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/08/2020 09:45:34 PM
// Design Name: 
// Module Name: display8digit
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


module display8digit(
    input wire [31:0] val,
    input wire clk,
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    logic[31:0] c = 0;
 
    always_ff @(posedge clk)
        c <= c + 1;
    
    wire[2:0] topthree;
    wire [4:0] value4bit;
    
    assign topthree[2:0] = c[18:16];
    
    assign digitselect[7:0] = ~(
        topthree == 3'b 000 ? 8'b 0000_0001 :
        topthree == 3'b 001 ? 8'b 0000_0010 :
        topthree == 3'b 010 ? 8'b 0000_0100 :
        topthree == 3'b 011 ? 8'b 0000_1000 :
        topthree == 3'b 100 ? 8'b 0001_0000 :
        topthree == 3'b 101 ? 8'b 0010_0000 :
        topthree == 3'b 110 ? 8'b 0100_0000 :
        8'b 1000_0000
    );
    
    assign value4bit[3:0] = (
        topthree == 3'b 000 ? val[3:0] :
        topthree == 3'b 001 ? val[7:4] :
        topthree == 3'b 010 ? val[11:8] :
        topthree == 3'b 011 ? val[15:12] :
        topthree == 3'b 100 ? val[19:16] :
        topthree == 3'b 101 ? val[23:20] :
        topthree == 3'b 110 ? val[27:24] :
        val[31:28]
    );
    
    hexto7seg myhexdecoder(value4bit, segments);
    
endmodule
