/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/

module  mux3to1  #(parameter width = 8)
				 (input [width-1:0] a,b,c,
				  input [1:0] sel,
				  output reg [width-1:0] out); 									

	always @(a,b,c,sel) begin 
		case (sel)
			0: out = a;
			1: out = b;
			2: out = c;
			default: out = 0;
		endcase			
	end
endmodule

