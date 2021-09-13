//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns

module datapath #(parameter n = 8)
				(input rst, clk,
				input reg_b_enable, reg_a_enable, reg_p_enable, reg_a_load, sel_mux_reg_b_zero,
				input sel_p_reg,
				input [n-1:0] a, b,
				output a_lsb,
				output [2*n-1:0] mul_out);
	
	wire [n-1:0] b_to_mux, mux_to_adder, adder_sum, mux_to_p_out, reg_p_out;
	wire adder_cout;
				
	
	register  reg_partial_out (.clk(clk), .enable(reg_p_enable), .rst (rst), .reg_in(mux_to_p_out), .reg_out(reg_p_out));
	shift_register reg_a (.clk(clk), .rst (rst), .enable(reg_a_enable), .load (reg_a_load), .ser_in (adder_sum[0]), .par_in (a), .par_out(mul_out[n-1:0]));
	register  reg_b (.clk(clk), .rst (rst), .enable(reg_b_enable), .reg_in(b), .reg_out(b_to_mux));			
	full_adder fa (.a(reg_p_out), .b(mux_to_adder), .c(1'b0), .carry(adder_cout), .sum(adder_sum));

	mux2to1  mux_to_reg_p (.a({n{1'b0}}), .b({adder_cout,adder_sum[n-1:1]}), .sel(sel_p_reg), .out(mux_to_p_out)); // choose zero (initialized the reg_p) or reg_p (result of addition p+b) and send it to adder
	mux2to1  mux_reg_b_zero (.a({n{1'b0}}), .b(b_to_mux), .sel(sel_mux_reg_b_zero), .out(mux_to_adder)); // choose zero or reg_b and send it to adder


	assign a_lsb = (mul_out[0] == 1); // comparator to check the lsb of a_reg
	assign mul_out[2*n-1:n] = reg_p_out;
endmodule				