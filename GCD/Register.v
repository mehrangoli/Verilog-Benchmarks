/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

`timescale 1ns/1ns
		
module reg_module #(parameter width = 8)
				  (input clk, en,
				   input [width-1:0] in,
				   output reg [width-1:0] out);
				
	always @(posedge clk) begin
		if (en) begin
			out <= in;
		end	
	end
endmodule

