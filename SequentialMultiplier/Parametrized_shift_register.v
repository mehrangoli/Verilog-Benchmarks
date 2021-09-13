//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns
	
module shift_register #(parameter n = 8)
						(input clk, rst, enable, load,
						input  ser_in,
						input [n-1:0] par_in,
						output reg [n-1:0] par_out);
				
	always @(posedge clk) begin
		if (rst)
			par_out <= 0;
		else if (load)
			par_out <= par_in;	
		else if (enable) begin
			par_out <= {ser_in, par_out[n-1:1]};
		end	
	end
		
endmodule


