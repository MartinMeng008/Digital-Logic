`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/27/2020 03:56:05 PM
// Design Name: 
// Module Name: datapath
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


module datapath #(
    parameter Nloc = 32,
    parameter Dbits = 16
)(
    input wire clock,
    input wire RegWrite,
    input wire [$clog2(Nloc)-1 : 0] ReadAddr1, ReadAddr2, WriteAddr,
    input wire [4:0] ALUFN,
    input wire [Dbits-1:0] WriteData,
    output wire [Dbits-1:0] ReadData1, ReadData2, ALUResult,
    output wire FlagZ
    );
    
    register_file #(.Nloc(Nloc), .Dbits(Dbits)) RF (
        .clock(clock), 
        .wr(RegWrite), 
        .ReadAddr1(ReadAddr1), 
        .ReadAddr2(ReadAddr2),
        .WriteAddr(WriteAddr),
        .WriteData(WriteData),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    ALU #(.N(Dbits)) ALU (
        .A(ReadData1),
        .B(ReadData2),
        .R(ALUResult),
        .ALUfn(ALUFN),
        .FlagZ(FlagZ)
    );
    
    
    
endmodule
