`timescale 1ns/1ns
/*
Behavioral model of a 8-bit register
*/

module updowncounter8b( 
                   input  upb_down,// 0 ("b" == "bar") for counting up, 1 for counting dopwn
                   input  clock,   // clock
			       input  reset,   // reset, assynchronous
				   input  enable,  // enable
				   input  [7:0] step_count,     // the value to increment/decrement
			       output [7:0] counter_output  // the counter output
			  );
			  
// Define a 8-bit register:
reg [7:0] counter;
always @(posedge clock or posedge reset)
begin
  if ( reset )
    counter <= 8'd0;
  else
    if ( enable )
	begin
	  if ( ~upb_down )
	    counter <= counter + step_count;
	  else
	    counter <= counter - step_count;
	end
end

// Connect the register to the module output:
assign counter_output = counter;
				   
endmodule			  