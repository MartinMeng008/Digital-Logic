`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/12/2020 09:30:19 PM
// Design Name: 
// Module Name: memIO
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


module memIO #(
    parameter dmem_size=64,
    parameter Dbits=32,
    parameter dmem_init="... .mem",
    parameter smem_size=1200,
    parameter smem_init="... .mem",
    parameter Nchar=4
    
)(
    input wire clock,
    input wire cpu_wr,
    input wire [31:0] cpu_addr,
    input wire [31:0] cpu_writedata,
    input wire [31:0] accel_val,
    input wire [31:0] keyb_char,
    input wire [10:0] vga_addr,
    
    output wire [31:0] cpu_readdata,
    output logic [15:0] lights,
    output logic unsigned [31:0] period,
    output logic [31:0] digit = 0,
    output wire [$clog2(Nchar)-1 : 0] vga_readdata
    );
    
    localparam charcode_size = $clog2(Nchar);
    
    wire dmem_wr, smem_wr, sound_wr, lights_wr, digit_wr;
    wire [31:0] dmem_readdata; 
    wire [charcode_size-1 : 0] smem_readdata;
    
    assign dmem_wr = cpu_wr & (cpu_addr[17:16] == 2'b 01);
    assign smem_wr = cpu_wr & (cpu_addr[17:16] == 2'b 10);
    assign sound_wr = cpu_wr & (cpu_addr[17:16] == 2'b 11) 
                            & (cpu_addr[3:2] == 2'b 10);
    assign lights_wr = cpu_wr & (cpu_addr[17:16] == 2'b 11) 
                             & (cpu_addr[3:2] == 2'b 11);
    assign digit_wr = cpu_wr & (cpu_addr[17:16] == 2'b 00);
    assign cpu_readdata = (cpu_addr[17:16] == 2'b 00) ? digit:
                          (cpu_addr[17:16] == 2'b 01) ? dmem_readdata : 
                          (cpu_addr[17:16] == 2'b 10) ? {{(32-charcode_size){1'b0}}, smem_readdata} :
                          ((cpu_addr[17:16] == 2'b 11) 
                             & (cpu_addr[3:2] == 2'b 00)) ? keyb_char :
                          ((cpu_addr[17:16] == 2'b 11) 
                             & (cpu_addr[3:2] == 2'b 01)) ? accel_val:
                          //32'b x;
                          32'b 0;
    
    always_ff @(posedge clock) begin
        if (lights_wr) begin
            lights <= cpu_writedata;
            end
        if (sound_wr) begin
            period <= cpu_writedata;
            end
        if (digit_wr) begin
            digit <= cpu_writedata;
            end
    end
    
    ram_module #(
        .Nloc(dmem_size),
        .Dbits(Dbits),
        .initfile(dmem_init)
    ) dmem (
        .clock(clock),
        .wr(dmem_wr),
        .addr(cpu_addr[31:2]),
        .din(cpu_writedata),
        .dout(dmem_readdata)
    );
    
    ram2port_module #(
        .Nloc(smem_size),
        .Dbits(charcode_size),
        .initfile(smem_init)
    ) smem (
        .clock(clock),
        .wr(smem_wr),
        .addr1(cpu_addr[31:2]),
        .addr2(vga_addr),
        .din(cpu_writedata),
        .dout1(smem_readdata),
        .dout2(vga_readdata)
    );
    
endmodule
