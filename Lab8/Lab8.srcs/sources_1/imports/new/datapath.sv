`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Martin Meng
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
    parameter Nreg = 32,
    parameter Dbits = 16
)(
    input wire clk,
    input wire reset,
    input wire enable,
    input wire [31:0] instr,
    input wire [1:0] pcsel,
    input wire [1:0] wasel,
    input wire sext,
    input wire bsel,
    input wire [1:0] wdsel,
    input wire [4:0] alufn,
    input wire werf,
    input wire [1:0] asel,
    input wire [31:0] mem_readdata,
    
    output logic [31:0] pc = 32'h00400000,
    output wire Z,
    output wire [31 : 0] mem_addr,
    output wire [31:0] mem_writedata
    );
    
    wire [31:0] JT;
    wire [25:0] J;
    wire [31:0] BT;
    wire [31:0] pcPlus4;
    wire [4:0] Rd, Rt, Rs;
    wire [$clog2(Nreg)-1 : 0] reg_writeaddr;
    wire [Dbits-1:0] reg_writedata;
    wire [Dbits-1:0] ReadData1, ReadData2, alu_result;
    wire [15:0] Imm;
    wire [31:0] signImm;
    wire [Dbits-1:0] aluA, aluB;
    wire [4:0] shamt;
    wire [31:0] newPC; 
       
    assign newPC = (pcsel == 2'b00) ? pcPlus4:
                   (pcsel == 2'b01) ? BT:
                   (pcsel == 2'b10) ? {pc[31:28], J[25:0], 2'b00}:
                    JT;  
    assign J = instr[25:0];
    assign pcPlus4 = pc + 4;
    assign Rd = instr[15:11];
    assign Rt = instr[20:16];
    assign Rs = instr[25:21];
    assign reg_writeaddr = (wasel == 2'b00) ? Rd:
                           (wasel == 2'b01) ? Rt:
                           (wasel == 2'b10) ? 5'b 11111 : // 31
                           5'b xxxxx;
    assign Imm = instr[15:0];
    assign signImm = sext ? {{16{Imm[15]}}, Imm} : {{16{1'b0}}, Imm};
    assign JT = ReadData1;
    assign BT = pcPlus4 + (signImm << 2);
    assign shamt[4:0] = instr[10:6];
    assign aluA = (asel == 2'b00) ? ReadData1:
                  (asel == 2'b01) ? shamt:
                   5'b 1_0000; // 16
    assign aluB = bsel ? signImm : ReadData2;
    assign mem_addr = alu_result;
    assign reg_writedata = (wdsel == 2'b00) ? pcPlus4:
                           (wdsel == 2'b01) ? alu_result:
                           (wdsel == 2'b10) ? mem_readdata:
                            32'bx;
    assign mem_writedata = ReadData2;
    
    always_ff@(posedge clk)
        pc <= reset ? 32'h00400000:
                (~enable) ? pc:  
                    newPC;
    
    register_file #(.Nloc(Nreg), .Dbits(Dbits)) RF (
        .clock(clk), 
        .wr(werf), 
        .ReadAddr1(Rs), 
        .ReadAddr2(Rt),
        .WriteAddr(reg_writeaddr),
        .WriteData(reg_writedata),
        .ReadData1(ReadData1),
        .ReadData2(ReadData2)
    );
    
    ALU #(.N(Dbits)) ALU (
        .A(aluA),
        .B(aluB),
        .R(alu_result),
        .ALUfn(alufn),
        .FlagZ(Z)
    );
    
    
    
endmodule
