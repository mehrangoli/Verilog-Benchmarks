/* 
Parametrized Greatest Common Divisors (GCD)
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


`timescale 1ns/1ns
	
	
module controller (input start, clk, rst, a_lt_b, b_zero,
				   output reg b_sel, a_en, b_en, ready,
				   output reg [1:0] a_sel);
				   		
	parameter [1:0] reset = 0, load = 1, comp = 2, done = 3;
	reg [1:0] current_state, next_state;
		
	always @(current_state, start, b_zero) begin :combinational

		case (current_state) 
			reset: begin
				if (start == 1) next_state = load;
				else next_state = reset;
			end	
			load: begin
				if (start == 0) next_state = comp;
				else next_state = load;
			end				
			comp: begin
				if (b_zero == 1) next_state = done;
				else next_state = comp;
			end	
			done: begin
				next_state = reset;
			end	
			default: next_state = reset;
		endcase
	end

	always @(current_state, a_lt_b, b_zero)
	begin :outputting
		a_en = 0;
		b_en = 0;
		ready = 0;
		case (current_state)
			reset: begin 
				a_en = 0;
				b_en = 0;
				b_sel = 0;
				a_sel = 0;
			end
			load: begin 
				a_en = 1;
				b_en = 1;
				b_sel = 0;
				a_sel = 0;
			end			
			comp: begin
				if (a_lt_b == 1) begin
					a_en = 1;
					b_en = 1;
					a_sel = 2;	 
					b_sel = 1;
				end	
				else if (!b_zero) begin
					a_sel = 1;
					a_en = 1;
				end	
			end	
			done: ready = 1;
			default: begin
				ready = 0;
				a_en = 0;
				b_en = 0;
				a_sel = 2'bxx;
				b_sel = 1'bx;
			end
		endcase
	end
	
	always @(posedge clk) begin :sequential

		if (~rst)
			current_state <= reset;
		else
			current_state <= next_state;
	end	
	
endmodule





