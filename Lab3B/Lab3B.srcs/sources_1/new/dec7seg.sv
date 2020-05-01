`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2020 02:06:08 PM
// Design Name: 
// Module Name: dec7seg
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

`default_nettype none

module dec7seg(
    input wire [3:0] X,
    output wire [7:0] digitselect,
    output wire [7:0] segments
    );
    
    assign digitselect = ~(8'b 0000_0001);
    assign segments = ~(
            X == 4'h0 ? 8'b 1111_1100
        :   X == 4'h1 ? 8'b 0110_0000
        :   X == 4'h2 ? 8'b 1101_1010
        :   X == 4'h3 ? 8'b 1111_0010
        :   X == 4'h4 ? 8'b 0110_0110
        :   X == 4'h5 ? 8'b 1011_0110
        :   X == 4'h6 ? 8'b 1011_1110
        :   X == 4'h7 ? 8'b 1110_0000
        :   X == 4'h8 ? 8'b 1111_1110
        :   X == 4'h9 ? 8'b 1111_0110
        :   8'b 0000_0001);
        
    
endmodule
