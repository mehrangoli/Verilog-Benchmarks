/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
 
 module mux_data(in0,in1,in2,in3,sel,out);
`include "parameter.v"
	
	input  wire[`data_siz-1:0] in0,in1,in2,in3; 
	input  wire[`sel_siz-1:0] sel ;
	output reg[`data_siz-1:0] out;

	always @ (in0,in1,in2,in3,sel)
	begin
		if (sel== 2'b00)
			out= in0;
		else if (sel== 2'b01)
			out= in1;
		else if (sel== 2'b10)
			out= in2;
		else if (sel== 2'b11)
			out= in3;			

	end
endmodule



 module mux_address(in0,in1,in2,in3,sel,out);
`include "parameter.v"
	
	input  wire[`address_rang-1:0] in0,in1,in2,in3; 
	input  wire[`sel_siz-1:0] sel ;
	output reg[`address_rang-1:0] out;

	always @ (in0,in1,in2,in3,sel)
	begin
		if (sel== 2'b00)
			out= in0;
		else if (sel== 2'b01)
			out= in1;
		else if (sel== 2'b10)
			out= in2;
		else if (sel== 2'b11)
			out= in3;			

	end
endmodule 


 module mux_small(in0,in1,in2,in3,sel,out);
`include "parameter.v"
	
	input  wire in0,in1,in2,in3; 
	input  wire[`sel_siz-1:0] sel ;
	output reg out;

	always @ (in0,in1,in2,in3,sel)
	begin
		if (sel== 2'b00)
			out= in0;
		else if (sel== 2'b01)
			out= in1;
		else if (sel== 2'b10)
			out= in2;
		else if (sel== 2'b11)
			out= in3;			

	end
endmodule 
