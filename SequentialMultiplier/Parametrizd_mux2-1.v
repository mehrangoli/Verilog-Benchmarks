//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns
	
module mux2to1 #(parameter width = 8) 
				(input [width-1:0] a,b,
				 input sel,
				 output reg [width-1:0] out);

	always @(*) begin
		case (sel)
			0: out = a;
			1: out = b;
			default: out = {width{1'b0}};
		endcase	
	end
	
endmodule






