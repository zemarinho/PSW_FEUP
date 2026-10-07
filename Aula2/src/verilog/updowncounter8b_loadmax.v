`timescale 1ns/1ns
/*
Structural model of a 8-bit register
*/

module updowncounter8b_loadmax(
                   input        upb_down,// 0 ("b" == "bar") for counting up, 1 for counting dopwn
                                clock,   // clock
			                    reset,   // reset, assynchronous
				                enable,  // enable
				   input  [7:0] step_count,     // the value to increment/decrement
			       output [7:0] counter_output, // the counter output

				   // additional inputs:
				   input load,					// set to 1 to load the counter register with data
				                                // at the input din_load[7:0]
                   input [7:0] din_load,        // data input to load to the counter register when load is 1
				   input [7:0] max_count        // maximum counting value: counter should not exceed this value
			  );

wire [7:0] next_count;
wire [7:0] mux_out;

mux2_8bit myMux (	.din_load(din_load),
					.din_max(max_count),
					.load(load),
					.mux_out(next_count));
//------------------------------------------------------
// Instantiate one 8-bit register:
register8b  register8b_1(
                   .d( next_count ),  // The register is loaded with signal next_count =counter_output + step_count
                   .clock( clock ),   // clock
			       .reset( reset ),   // reset, assynchronous
				   .enable( enable ), // enable
			       .q( counter_output ) // the register output == the counter output
				   );

//------------------------------------------------------
// 8-bit adder/subtractor with two 4-bit adders:
// add/sub "counter_output" with "step_count"
wire [7:0] bneg;

// bneg is the negation of "step_count" (the operand "b") when upb_down == 1:
// Connect each bit of bneg[] to the XOR between step_count[ ] and upb_down
assign bneg[0] = step_count[0] ^ upb_down;
assign bneg[1] = step_count[1] ^ upb_down;
assign bneg[2] = step_count[2] ^ upb_down;
assign bneg[3] = step_count[3] ^ upb_down;
assign bneg[4] = step_count[4] ^ upb_down;
assign bneg[5] = step_count[5] ^ upb_down;
assign bneg[6] = step_count[6] ^ upb_down;
assign bneg[7] = step_count[7] ^ upb_down;

// Instantiate two four_bit_adders:
wire cout34; // The carry from the first 4-bit half of the adder to the second half:
four_bit_adder  four_bit_add_low
                    ( .cin( upb_down ),           // Carry in
                      .a( counter_output[3:0] ),  // operand a
                      .b( bneg[3:0] ),            // operand b for add or ~b for sub
					  .sum( next_count[3:0] ),    // add or sub result
					  .cout( cout34 )       // the sum carry out
					 ),

				four_bit_add_high
                    ( .cin( cout34 ),             // Carry in is the carry out from the first section
                      .a( counter_output[7:4] ),  // operand a
                      .b( bneg[7:4] ),            // operand b for add or ~b for sub
					  .sum( next_count[7:4] ),    // add or sub result
					  .cout(  )                   // don't connect the output carryout
					 );

endmodule
