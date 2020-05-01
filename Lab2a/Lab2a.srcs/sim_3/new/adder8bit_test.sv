`timescale 1ns / 1ps

`default_nettype none

module adder8bit_test();

    logic [7:0] A;
    logic [7:0] B;
    logic Cin;
    wire [7:0] Sum;
    wire Cout;
    
    adder8bit my8bitadder(A, B, Cin, Sum, Cout);
    
        integer i;
        
        initial begin
        // Initialize Inputs
        A = 0;
        B = 0;
        Cin = 0;
        
        // Wait 5 ns before changing inputs
        #5
        
        for (i = 0; i < 64; i = i + 1) 
        begin
            #1 A = A + 1; B = B + 2;
        end
        
        #5 $finish;
    end
    
endmodule