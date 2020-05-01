`timescale 1ns / 1ps
`default_nettype none

module top_test;

    // Inputs
    logic clock;
    
    // Outputs
    wire char_code;
    wire[3:0] red, green, blue;
    wire hsync, vsync;
    
    top T(
        .clock(clock),
        .char_code(char_code),
        .red(red), .green(green), .blue(blue),
        .hsync(hsync), .vsync(vsync)
    );
    
//    initial begin
//        $display("This ends with a new line ");
//        $write("This does not, ");
//        $write("like this.\
//        ");
//        $display("Hi there !"); 
//        clock = 0;
//    end
    
    initial begin
        #100
        #1 $finish;
    end
    
    initial begin
        #0.5 clock = 0;
        forever
            begin
                #0.5 clock = ~clock;
                $display(char_code);
            end
            
    end

endmodule