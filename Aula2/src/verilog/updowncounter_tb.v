`timescale 1ns/1ns
/*
   updown counter testbench
*/
module updowncounter_tb;

// Define registers to hold the data driving the inputs:
reg [7:0] stepcount;
reg       up0_down1;
reg       reset;
reg       clock;
reg       enable;

wire [7:0] counteroutput;


// Instantiate the block to verify (or "test"):
updowncounter8b DUV
              (
                .upb_down( up0_down1 ),           // 0 for counting up, 1 for counting dopwn
                .clock( clock ),                  // clock
			    .reset( reset ),                  // reset, assynchronous
				.enable( enable ),                // enable
				.step_count( stepcount ),         // the value to increment/decrement
			    .counter_output( counteroutput )  // the counter output
			  );

// create a VCD file (value change data) with the transitions of 
// all signals under module addsub_tb (the testbench):
initial
begin
  $dumpfile("updowncounter_simdata.vcd");
  $dumpvars(0, updowncounter_tb );
end	

//------------------------------------------------------
// Initialize signals, generate a free running clock:
initial
begin
  clock  = 1'b0;
  enable = 1'b0;
  up0_down1 = 1'b0;
  stepcount = 8'd0;
  #5
  forever #5 clock <= ~clock;
end

//------------------------------------------------------
// generate the reset pulse:
initial
begin
  reset <= 0;
  #22 reset <= 1;
  #10 reset <= 0;
end	 

//------------------------------------------------------
// Main simuolation "program":
initial
begin
  #1
  @(negedge reset); // wait for a negative edge of signal "reset"
  
  // enable is still low
  repeat (100)
    @(posedge clock);   // repeat 100 times: wait for the positive edge of signal "clock"
	
  // enable counter, count up, set stepcount to 1, run for 500 clocks:
  stepcount = 8'd1;
  up0_down1 = 1'b0;
  enable    = 1'b1;
  repeat (500)
    @(posedge clock);   // repeat 100 times: wait for the positive edge of signal "clock"
	
  // set step to 5, run for more 500 clocks:
  stepcount = 8'd5;
  up0_down1 = 1'b0;
  enable    = 1'b1;
  repeat (500)
    @(posedge clock);   // repeat 100 times: wait for the positive edge of signal "clock"
	
	
  // set step to 5, count down, run for more 500 clocks:
  stepcount = 8'd5;
  up0_down1 = 1'b1;
  enable    = 1'b1;
  repeat (500)
    @(posedge clock);   // repeat 100 times: wait for the positive edge of signal "clock"
	
	
  #100
  $finish;
end
			  
endmodule			  