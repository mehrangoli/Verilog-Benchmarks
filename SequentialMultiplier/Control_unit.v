//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns
	
	
module controller #(parameter m = 3) // m = log (n)
					(input start, clk, rst, a_lsb,
					output reg reg_b_enable, reg_a_enable, reg_p_enable, sel_p_reg, reg_a_load, sel_mux_reg_b_zero,
					output reg valid);
				   		
	parameter [1:0] reset = 0, load = 1, addshift = 2, done = 3;
	reg [1:0] current_state, next_state;
	
	reg count_en;
	reg [m-1:0] count;
		
	always @(current_state, start, count) begin :combinational

		case (current_state) 
			reset: begin
				if (start == 1) next_state = load;
				else next_state = reset;
			end	
			load: begin
				if (start == 0) next_state = addshift;
				else next_state = load;
			end				
			addshift: begin
				if ( count == 7) next_state = done;
				else next_state = addshift;
			end	
			done: begin
				next_state = reset;
			end	
			default: next_state = reset;
		endcase
	end
	
	always @(current_state, a_lsb) begin :combinational_controlling_signals
		count_en = 0;
		reg_b_enable = 0;
		reg_a_enable = 0;
		reg_p_enable = 0;
		sel_p_reg = 0;
		reg_a_load = 0;
		sel_mux_reg_b_zero = 0;
		valid = 0;
	
		case (current_state) 
			reset: begin
				count_en = 0;
				reg_b_enable = 0;
				reg_a_enable = 0;
				reg_p_enable = 1;
				sel_p_reg = 0;
				reg_a_load = 0;
				sel_mux_reg_b_zero = 0;
				valid = 0;
				
			end	
			load: begin
				reg_a_load = 1;
				reg_b_enable =1;
			end				
			addshift: begin
				if (a_lsb == 0) begin
					reg_a_enable = 1;
					sel_mux_reg_b_zero = 0; // only perform shift (p + 0)
					reg_p_enable = 1;
				end	
				else begin
					reg_a_enable = 1;
					sel_mux_reg_b_zero = 1; // perform add and shift (p + b)
					reg_p_enable = 1;
					
				end	
				count_en = 1;
				sel_p_reg = 1;
					
			end	
			done: begin
				valid = 1;
			end	
			default: begin
				count_en = 0;
				reg_b_enable = 0;
				reg_a_enable = 0;
				reg_p_enable = 0;
				sel_p_reg = 0;
				reg_a_load = 0;
				sel_mux_reg_b_zero = 0;
				valid = 0;
			end
		endcase
	end
	
	

	
	always @(posedge clk) begin :sequential

		if (rst)
			current_state <= reset;
		else
			current_state <= next_state;
	end	
	
	
	always @(posedge clk) begin :counter_seq
		if (rst) begin
			count <= 0;
		end	
		else if (count_en == 1)
			count <= count + 1;
	end
	
	
endmodule





