//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns

module full_adder #(parameter n = 8)
					(input [n-1:0] a, b,
					input c,
					output reg carry,
					output reg [n-1:0] sum);
  
  always@(*)
	{carry, sum} = a+b+c;
endmodule



