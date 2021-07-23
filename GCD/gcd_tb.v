/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

`timescale 1ns/1ns

module gcd_tb ();
	parameter width = 8;				 
	reg [width-1:0] a_tb, b_tb;
	reg clk_tb, start_tb, rst_tb;
	wire ready_tb;
	wire [width-1:0] result_tb;
	
	gcd DUT (a_tb, b_tb, clk_tb, start_tb, rst_tb, ready_tb, result_tb);
	
	initial begin
		clk_tb = 0; rst_tb = 0; start_tb = 0;
		#13 rst_tb = 1; #6 start_tb = 1;
		#25 start_tb = 0; #200 start_tb = 1; #30 start_tb = 0;
	end

	always #35 a_tb = $random;
	always #35 b_tb = $random;

	always #5 clk_tb = ~clk_tb;
	 
	
endmodule	
	


