`timescale 1ns/1ns
/*
Structural model of a 4-bit adder using the ripple-carry implementation
instantiates 4 blocks "fadder" 
*/

module four_bit_adder( input cin,		  // Carry in
                       input  [3:0] a,    // operand a
                       input  [3:0] b,    // operand b
					   output [3:0] sum,  // sum = a + b + cin
					   output       cout  // the sum carry out
					 );

// define local wires:
wire c12, c23, c34;

// Instantiate the four full-adders:
fadder  first_stage( .cin( cin ),
                     .a( a[0] ),
                     .b( b[0] ),
					 .sum( sum[0] ),
                     .cout( c12 )
                   ),
				   
       secnd_stage( .cin( c12 ),
                     .a( a[1] ),
                     .b( b[1] ),
					 .sum( sum[1] ),
                     .cout( c23 )
                   ),
				   
       third_stage( .cin( c23 ),
                     .a( a[2] ),
                     .b( b[2] ),
					 .sum( sum[2] ),
                     .cout( c34 )
                   ),
				   
      fourth_stage( .cin( c34 ),
                     .a( a[3] ),
                     .b( b[3] ),
					 .sum( sum[3] ),
                     .cout( cout )
                   );
				   
				   
endmodule			  