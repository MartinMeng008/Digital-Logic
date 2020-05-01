//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 3/27/2020
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none


// NOTE: There should not be any need to modify anything below!!!!
// Any changes to parameters must be made in the tester, from which
// actual parameter values are inherited.


module top #(

// DO NOT CHANGE

    parameter Dbits=32,                                 // word size for the processor
    parameter Nreg=32,                                  // number of registers
    parameter imem_size=128,                            // imem size, must be >= # instructions in program
    parameter imem_init="wherever_code_is.mem",         // correct filename inherited from parent/tester
    parameter dmem_size=64,                             // dmem size, must be >= # words in .data of program + size of stack
    parameter dmem_init="wherever_data_is.mem"          // correct filename inherited from parent/tester
)(
    input wire clk, reset, enable
);

// DO NOT CHANGE
   
   wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
   wire mem_wr;

   mips #(.Dbits(Dbits), .Nreg(Nreg)) mips(clk, reset, enable, pc, instr, mem_wr, mem_addr, mem_writedata, mem_readdata);

   rom_module #(.Nloc(imem_size), .Dbits(Dbits), .initfile(imem_init)) imem(pc[31:2], instr);      
                // dropped two LSBs from address to instr mem to convert byte address to word address
                
   ram_module #(.Nloc(dmem_size), .Dbits(Dbits), .initfile(dmem_init)) dmem(clk, mem_wr, mem_addr[31:2], mem_writedata, mem_readdata);  
                // dropped two LSBs from address to data mem to convert byte address to word address

endmodule
