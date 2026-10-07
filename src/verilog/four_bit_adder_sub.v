`timescale 1ns/1ns
/*
   4-bit adder-subtractor
   if addb_sub == 1, sum = a + (-b) = a - b
   if addb_sub == 0, sum = a + b
*/

module four_bit_adder_sub
             ( input        addb_sub, // 0 for addition, 1 for subtraction
			   input  [3:0] a,        // 
               input  [3:0] b,
			   output [3:0] sumsub,   // a + b or a - b
			   output cout            // carry-out
			  );
			  
wire [3:0] bneg;

// bneg is the negation of b when addb_sub == 1:
// using the XOR operator:
assign bneg[0] = b[0] ^ addb_sub;
assign bneg[1] = b[1] ^ addb_sub;
assign bneg[2] = b[2] ^ addb_sub;
assign bneg[3] = b[3] ^ addb_sub;

// or using the conditional expression:
// assign bneg = addb_sub ? ~b : b;

// Instantiate the four_bit_adder connecting the addb_sub to the carryin input:
four_bit_adder  my_4_bit_add
                    ( .cin( addb_sub ),   // Carry in
                      .a( a ),            // operand a
                      .b( bneg ),         // operand b or ~b
					  .sum( sumsub ),     // add or sub result
					  .cout( cout )       // the sum carry out
					 );

			  
endmodule			  