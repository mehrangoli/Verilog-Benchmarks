/* 
mealy detector module for sequence 101
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


`timescale 1ns/1ns
	
module mealy_101_detector (input x, clk, rst,
						   output reg z);
	parameter [1:0] reset = 0, got1 = 1, got10 = 2;
	reg [1:0] current_state, next_state;
		
	always @(current_state, x) begin :combinational

		case (current_state) 
			reset: begin
				if (x == 1) next_state = got1;
				else next_state = reset;
			end	
			got1: begin
				if (x == 0) next_state = got10;
				else next_state = got1;
			end	
			got10: begin
				if (x == 1) next_state = got1;
				else next_state = reset;
			end	
			default: next_state = reset;
		endcase
	end

	always @(current_state, x) begin :outputting
		case (current_state)
			reset: z = 0;
			got1: z = 0;
			got10: begin
				if (x == 1) 
					z = 1;
				else 
					z = 0;
			end	
			default: z = 0;
		endcase
	end
	
	always @(posedge clk) begin :sequential

		if (~rst)
			current_state <= reset;
		else
			current_state <= next_state;
	end	
	
endmodule

