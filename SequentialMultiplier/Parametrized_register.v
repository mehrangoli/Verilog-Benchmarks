//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns
	
module register #(parameter n = 8)
						(input clk, rst, enable,
						input [n-1:0] reg_in,
						output reg [n-1:0] reg_out);
					
	always @(posedge clk) begin
		if (rst)
			reg_out <= 0;
		else if (enable)
			reg_out <= reg_in;	
	end
		
endmodule


