/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

module  gcd_behavioral #(parameter width = 8) //not synthesizable (only abstract model as reference)
						(input [width-1:0] a, b,
						 output reg [width-1:0] result);
	integer done;
	reg [width-1:0] a_reg, b_reg, swap;
	
	always @(*) begin
		done = 0;
		reg_a = a;
		reg_b = b;
		while (!done) begin
			if (reg_a < reg_b) begin
				swap = reg_a;
				reg_a = reg_b;
				reg_b = swap;
			end
			else if (reg_b != 0)
				reg_a = reg_a - reg_b;
			else
				done = 1;
		end		
		result = reg_a;
	end
endmodule

