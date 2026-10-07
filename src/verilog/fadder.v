`timescale 1ns/1ns
/*
Behavioral model of a full-adder (adder of 3 bits)

*/

module fadder( input a,   // 3 input bits (order is not important!)
               input b,
			   input cin,
			   output sum, // the LSbit of the two bit result
			   output cout // the MSbit of the two bit result (or carry-out)
			  );
			  
// Combinational processes: assign this = that means "connect this to that"
assign sum = a ^ b ^ cin;	// output sum is the XOR of the three inputs

assign cout = (a & b) | (a & cin) | (b & cin);
			  
endmodule			  