//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns

module seq_mult #(parameter n = 8)
				(input start, rst, clk,
				input [n-1:0] a, b,
				output valid,
				output [2*n-1:0] result);
				
	
	wire reg_b_enable, reg_a_enable, reg_p_enable, reg_a_load, sel_mux_reg_b_zero, sel_p_reg;

	datapath  dpth (.rst (rst), .clk (clk),
					.reg_b_enable (reg_b_enable), .reg_a_enable (reg_a_enable), .reg_p_enable(reg_p_enable), .reg_a_load(reg_a_load),
					.sel_mux_reg_b_zero(sel_mux_reg_b_zero), .sel_p_reg(sel_p_reg),
					.a (a), .b (b),
					.a_lsb (a_lsb),
					.mul_out(result));

	controller ctl (.start (start), .clk (clk), .rst (rst), .a_lsb (a_lsb),
				    .reg_b_enable (reg_b_enable), .reg_a_enable (reg_a_enable), .reg_p_enable(reg_p_enable), .sel_p_reg (sel_p_reg),
					.reg_a_load (reg_a_load), .sel_mux_reg_b_zero (sel_mux_reg_b_zero),
					.valid (valid));				
	
endmodule	


			