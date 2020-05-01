//////////////////////////////////////////////////////////////////////////////////
//
// Montek Singh
// 4/3/2019 
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
`default_nettype none

module top #(

    parameter Dbits=32,                                 // word size for the processor
    parameter Nreg=32,                                  // number of registers

    parameter imem_size=512,                            // imem size, must be >= # instructions in program
//    parameter imem_init="imem_screentest_nopause.mem",  // use this line for simulation/testing
//    parameter imem_init="imem_screentest.mem",          // use this line for synthesis/board deployment
//    parameter imem_init="imem_etchasketch.mem",          // use this line for synthesis/board deployment
    parameter imem_init="imem_finalproject.mem",  

    parameter dmem_size=128,                             // dmem size, must be >= # words in .data of program + size of stack
//    parameter dmem_init="dmem_screentest.mem",          // file to initialize data memory
//    parameter dmem_init="dmem_etchasketch.mem",
    parameter dmem_init="dmem_finalproject.mem",

    parameter smem_size=1200,                           // smem size, is 1200 for our chosen screen grid of 40x30
    parameter smem_init="smem_finalproject.mem", 	        // file to initialize screen memory

    parameter bmem_size=1024,                           // bmem size, 256 * # of characters.  For 4 chars, = 1024.
    parameter bmem_init="bmem_finalproject.mem", 	        // file to initialize bitmap memory

    parameter Nchar=6
)(
    input wire clk, reset,
    
    // add I/O signals here
    
    //Sound
    output wire audPWM,
    output wire audEn,
    
    //Accel
    output wire aclSCK,
    output wire aclMOSI,
    input wire aclMISO,
    output wire aclSS,
    
    // Keyboard
	input wire ps2_data,
	input wire ps2_clk,
	
	// LED
	output wire [15:0] LED,
    
    // Display
    output wire [7:0] segments,
    output wire [7:0] digitselect,
    
    // incl. VGA signals
    output wire[3:0] red, green, blue,
    output wire hsync, vsync
);

   wire enable = 1'b1;      // Available for debugging purposes.
   assign audEn = 1;
   wire [31:0] pc, instr, mem_readdata, mem_writedata, mem_addr;
   wire mem_wr;
   wire clk100, clk50, clk25, clk12;

   wire [10:0] smem_addr;
   wire [$clog2(Nchar)-1:0] charcode;                                 // increase #bits if using more than 16 characters
   wire [31:0] keyb_char;
   
   wire [8:0] accelX, accelY;      // The accelX and accelY values are 9-bit values, ranging from 9'h 000 to 9'h 1FF
   wire [11:0] accelTmp;           // 12-bit value for temperature

   wire unsigned [31:0] period;
   wire [31:0] digit;
//   wire [31:0] display;
   

   // Uncomment *only* one of the following two lines:
   //    when synthesizing, use the first line
   //    when simulating, get rid of the clock divider, and use the second line
   //
   clockdivider_Nexys4 clkdv(clk, clk100, clk50, clk25, clk12);   // use this line for synthesis/board deployment
//   assign clk100=clk; assign clk50=clk; assign clk25=clk; assign clk12=clk;  // use this line for simulation/testing

   // For synthesis:  use an appropriate clock frequency(ies) below
   //   clk100 will work for hardly anyone
   //   clk50 or clk 25 may work for some
   //   clk12 should work for everyone!  So, please use clk12 for your processor and data memory.
   //
   // Important:  Use the same clock frequency for the MIPS and the memIO modules.
   // The I/O devices, however, should keep the 100 MHz clock.
   // For example:

   mips #(
        .Dbits(Dbits), 
        .Nreg(Nreg)
   ) mips(
        .clk(clk12), 
        .reset(reset), 
        .enable(enable), 
        .pc(pc), 
        .instr(instr), 
        .mem_wr(mem_wr), 
        .mem_addr(mem_addr), 
        .mem_writedata(mem_writedata), 
        .mem_readdata(mem_readdata)
    );

   rom_module #(.Nloc(imem_size), .Dbits(Dbits), .initfile(imem_init)) imem(pc[31:2], instr);      
                // dropped two LSBs from address to instr mem to convert byte address to word address

   memIO #(
     .dmem_size(dmem_size), .Dbits(Dbits), .dmem_init(dmem_init), 
     .smem_size(smem_size), .smem_init(smem_init),
     .Nchar(Nchar)
                    // any other parameters you need  
   ) memIO(
     .clock(clk12),
     .cpu_wr(mem_wr), 
     .cpu_addr(mem_addr),
     .cpu_writedata(mem_writedata),
     .accel_val({7'b0, accelX, 7'b0, accelY}),
     .keyb_char(keyb_char),
     .vga_addr(smem_addr),
     .cpu_readdata(mem_readdata),
     .lights(LED),
     .period(period),
     .digit(digit),
     .vga_readdata(charcode)
   );  // fill in all the connections as per figure

   // I/O devices
   //
   // Note: All I/O devices were developed assuming a 100 MHz clock.
   //   Therefore, the clock sent to them must be clk100, not any of the
   //   slower clocks generated by the clock divider.

   vgadisplaydriver #(
//        .bmem_size(bmem_size),
        .Nchar(Nchar), 
        .bmem_init(bmem_init)
   ) display(
        .clock(clk100),
        .char_code(charcode),
        .red(red), .green(green), .blue(blue),
        .hsync(hsync), .vsync(vsync),
        .screen_addr(smem_addr)
    );

   // Uncomment the following to instantiate these other I/O devices.
   //   You will have to declare all the wires that connect to them.
   //
    keyboard keyb(clk100, ps2_clk, ps2_data, keyb_char);
    display8digit disp(digit, clk100, segments, digitselect);
    accelerometer accel(clk100, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTmp);
    montek_sound_Nexys4 sound(clk100, period, audPWM);


endmodule
