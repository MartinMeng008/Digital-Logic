`timescale 1ns / 1ps
`default_nettype none
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/10/2020 07:43:10 PM
// Design Name: 
// Module Name: io_demo
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


module io_demo(
    input wire clk, //100MHz clock
    
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
	output wire [0:15] LED,
    
    // Display
    output wire [7:0] segments,
    output wire [7:0] digitselect
    );
    
    wire unsigned [31:0] period;
    wire [31:0] display;
    
    // Keyboard data
    wire [31:0] keyb_char;
    
    // Sound data
    //          B3, C4, C#4, D4, 
    //          D#4 E4, F4, F#4, 
    //          G4, G#4, A4, A#4, 
    //          B4, C5, C#5, D5, 
    //          D#5, E5, F5, F#5, 
    //          G5, G5#, A5, B5, 
    //          C6, G3
    wire [31:0] notes_periods[0:25] = {404957, 382219, 360776, 340530, 
                                      321409, 303370, 286344, 270278, 
                                      255102, 240790, 227273, 214519, 
                                      202478, 191113, 180385, 170262, 
                                      160707, 151687, 143172, 135137, 
                                      127552, 120393, 113636, 101238, 
                                      95557,  510204};
    
    //Accelerometer data
    wire [8:0] accelX, accelY;      // The accelX and accelY values are 9-bit values, ranging from 9'h 000 to 9'h 1FF
    wire [11:0] accelTmp;           // 12-bit value for temperature
        
    assign audEn = 1;
    
    // Sound
    assign period[31:0] = (
        (keyb_char == 32'h 58) ? notes_periods[0] :
        (keyb_char == 32'h 1c) ? notes_periods[1] :
        (keyb_char == 32'h 1d) ? notes_periods[2] :
        (keyb_char == 32'h 1b) ? notes_periods[3] :
        (keyb_char == 32'h 24) ? notes_periods[4] :
        (keyb_char == 32'h 23) ? notes_periods[5] :
        (keyb_char == 32'h 2b) ? notes_periods[6] :
        (keyb_char == 32'h 2c) ? notes_periods[7] :
        (keyb_char == 32'h 34) ? notes_periods[8] :
        (keyb_char == 32'h 35) ? notes_periods[9] :
        (keyb_char == 32'h 33) ? notes_periods[10] :
        (keyb_char == 32'h 3c) ? notes_periods[11] :
        (keyb_char == 32'h 3b) ? notes_periods[12] :
        (keyb_char == 32'h 42) ? notes_periods[13] :
        (keyb_char == 32'h 44) ? notes_periods[14] :
        (keyb_char == 32'h 4b) ? notes_periods[15] :
        (keyb_char == 32'h 4d) ? notes_periods[16] :
        (keyb_char == 32'h 4c) ? notes_periods[17] :
        (keyb_char == 32'h 52) ? notes_periods[18] :
        (keyb_char == 32'h 5b) ? notes_periods[19] :
        (keyb_char == 32'h 5a) ? notes_periods[20] :
        (keyb_char == 32'h 5d) ? notes_periods[21] :
        (keyb_char == 32'h e071) ? notes_periods[22] :
        (keyb_char == 32'h e069) ? notes_periods[23] :
        (keyb_char == 32'h e07a) ? notes_periods[24] :
        (keyb_char == 32'h 14) ? notes_periods[25] :
        0
    );// Sound data
    //          B3, C4, C#4, D4, 
    //          D#4 E4, F4, F#4, 
    //          G4, G#4, A4, A#4, 
    //          B4, C5, C#5, D5, 
    //          D#5, E5, F5, F#5, 
    //          G5, G5#, A5, B5, C6
    
    //Displays x and y accel values on 7-segment display
    assign display[31:0] = {7'b0, accelX, 7'b0, accelY};
    
    // LED
    assign LED[0:15] = (
        accelY < 9'd 30 ? {16'b 1000_0000_0000_0000} :
        accelY < 9'd 60 ? {16'b 0100_0000_0000_0000} :
        accelY < 9'd 90 ? {16'b 0010_0000_0000_0000} :
        accelY < 9'd 120 ? {16'b 0001_0000_0000_0000} :
        
        accelY < 9'd 150 ? {16'b 0000_1000_0000_0000} :
        accelY < 9'd 180 ? {16'b 0000_0100_0000_0000} :
        accelY < 9'd 210 ? {16'b 0000_0010_0000_0000} :
        accelY < 9'd 240 ? {16'b 0000_0001_0000_0000} :
        
        accelY < 9'd 270 ? {16'b 0000_0000_1000_0000} :
        accelY < 9'd 300 ? {16'b 0000_0000_0100_0000} :
        accelY < 9'd 330 ? {16'b 0000_0000_0010_0000} :
        accelY < 9'd 360 ? {16'b 0000_0000_0001_0000} :
        
        accelY < 9'd 390 ? {16'b 0000_0000_0000_1000} :
        accelY < 9'd 420 ? {16'b 0000_0000_0000_0100} :
        accelY < 9'd 450 ? {16'b 0000_0000_0000_0010} :
        {16'b 0000_0000_0000_0001}
    );

    //Period varies with Y accel (left to right)
    //Longer period means lower pitched tone
//    assign period[31:0] = {11'b0, accelY, 12'b0};
    
    accelerometer accel(clk, aclSCK, aclMOSI, aclMISO, aclSS, accelX, accelY, accelTmp);
    montek_sound_Nexys4 sound(clk, period, audPWM);
    // display8digit d8(display, clk, segments, digitselect);
    display8digit disp(keyb_char, clk, segments, digitselect);
    keyboard keyb(clk, ps2_clk, ps2_data, keyb_char);
    
    
endmodule
