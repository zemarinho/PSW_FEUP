`timescale 1ns/1ns


module mux2_8bit (  input wire [7:0] din_load,
                    input wire [7:0] din_max,
                    input load,
                    output wire [7:0] mux_out);

    assign mux_out = load ? din_load : din_max;

endmodule