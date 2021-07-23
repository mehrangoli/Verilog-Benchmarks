/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

`timescale 1ns/1ns

module datapath #(parameter width = 8) 
				(input clk, rst, en_a, en_b,
				 input [width-1:0] a, b,
				 input [1:0] sel_a,
				 input sel_b,
				 output b_zero, a_lt_b,
				 output [width-1:0] result);
				 
	wire [width-1:0] reg_a_out, reg_b_out, a_mux_out, b_mux_out, sub_out;
	
	mux3to1 #(width) mux_A (a, sub_out, reg_b_out, sel_a, a_mux_out);
	reg_module #(width) reg_a (clk, en_a, a_mux_out, reg_a_out);
	reg_module #(width) reg_b (clk, en_b, b_mux_out, reg_b_out);
	
	assign b_zero = (reg_b_out == 0);
	assign a_lt_b = (reg_a_out < reg_b_out);
	assign b_mux_out = sel_b ? reg_a_out : b;
	assign sub_out = (reg_a_out - reg_b_out);
	assign result = reg_a_out;
	
endmodule	
	











