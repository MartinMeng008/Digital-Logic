`timescale 1ns / 1ps
`default_nettype none

module montek_sound_test(
    input wire clk,         // 100 MHz clock
    output wire audPWM,
    output wire audEn
    );
    
    assign audEn = 1;       // Always on; could be turned off
    
    logic [31:0] count=0;
    always_ff @(posedge clk)
        count <= count + 1;
        
    // These are periods (in units of 10 ns) for the notes on the normal C4 scale,
    //   i.e.:  B3, C4, C#4, D4, 
    //          D#4 E4, F4, F#4, 
    //          G4, G#4, A4, A#4, 
    //          B4, C5, C#5, D5, 
    //          D#5, E5, F5, F#5, 
    //          G5, G5#, A5, B5, C6
    wire [31:0] notes_periods[0:24] = {404957, 382219, 360776, 340530, 
                                      321409, 303370, 286344, 270278, 
                                      255102, 240790, 227273, 214519, 
                                      202478, 191113, 180385, 170262, 
                                      160707, 151687, 143172, 135137, 
                                      127552, 120393, 113636, 101238, 95557};
    // cycle through note 0 to 7, over and over, in approx. 1 sec increments
    wire [2:0] note_to_play = count[29:27];
    wire [31:0] period = notes_periods[note_to_play];
    
    montek_sound_Nexys4 snd(
       clk,             // 100 MHz clock
       period,          // sound period in tens of nanoseconds
                        // period = 1 means 10 ns (i.e., 100 MHz)      
       audPWM);
       
endmodule
