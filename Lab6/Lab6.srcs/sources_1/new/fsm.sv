`timescale 1ns / 1ps
`default_nettype none

module fsm(
    input wire clock,
//    input wire RESET,                     // Comment this line out if no RESET input
    input wire up, center, down,            // List of inputs to FSM
    output logic countup, paused            // List of outputs of FSM
                                            // The outputs must be synthesized as combinational logic!
    );


      // The next line is our state encoding
      // You enumerate states, and the compiler decides state encoding

    enum { CountingUp, CountingDown, PausingUp, ResumingUp, ResumingDown, PausingDown, PausedUp, PausedDown } state, next_state;

      // -- OR --   
      // You can specify state encoding

//    enum { STATE0=2'b00, STATE1=2'b01, STATE2=2'b10, ... etc. } state, next_state;



        // Instantiate the state storage elements (flip-flops)
    always_ff @(posedge clock)
//      if (RESET == 1) state <= STATE_??;    // Remove the "if" part if no RESET input
//      else 
      state <= next_state;


        // Define next_state logic => combinational
        // Every case must either be a conditional expression
        //   or an "if" with a matching "else"
    always_comb     
      case (state)
            CountingUp: next_state <= (down == 1) ? CountingDown : 
                                      (center == 1) ? PausingUp :
                                      CountingUp;
            CountingDown: next_state <= (up == 1) ? CountingUp : 
                                        (center == 1) ? PausingDown :
                                        CountingDown;
            PausingUp: next_state <= (center == 1) ? PausingUp : PausedUp;
            ResumingUp: next_state <= (center == 1) ? ResumingUp : CountingUp;
            ResumingDown: next_state <= (center == 1) ? ResumingDown : CountingDown;
            PausingDown: next_state <= (center == 1) ? PausingDown : PausedDown;
            PausedUp: next_state <=  (down == 1) ? PausedDown : 
                                      (center == 1) ? ResumingUp :
                                      PausedUp;
            PausedDown: next_state <= (up == 1) ? PausedUp : 
                                      (center == 1) ? ResumingDown :
                                      PausedDown;
            default: next_state <= CountingUp;
      endcase



        // Define output logic => combinational
        // Every case must either be a conditional expression
        //   or an "if" with a matching "else"
    always_comb     
      case (state)
            CountingUp: {countup, paused} <= 2'b 10; 
            CountingDown: {countup, paused} <= 2'b 00;
            PausingUp: {countup, paused} <= 2'b 11;
            ResumingUp: {countup, paused} <= 2'b 10;
            ResumingDown: {countup, paused} <= 2'b 00;
            PausingDown: {countup, paused} <= 2'b 01;
            PausedUp: {countup, paused} <= 2'b 11;
            PausedDown: {countup, paused} <= 2'b 01;
           default: {countup, paused} <= 2'b 10;
      endcase

endmodule
