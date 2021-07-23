/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

`timescale 1ns/1ns

module gcd #(parameter width = 8)
		  (input [width-1:0] a, b,
		   input clk, start, rst,
		   output ready,
		   output [width-1:0] result);
					 
	wire en_a, en_b, sel_b, a_lt_b, b_zero;
	wire [1:0] sel_a;
	
	datapath #(width) datapath_instance (clk, rst, en_a, en_b, a, b, sel_a, sel_b, b_zero, a_lt_b, result); 
	controller controller_instance (start, clk, rst, a_lt_b, b_zero, sel_b, en_a, en_b, ready, sel_a);
	
	
endmodule	
	





