/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module filipflop(data_in,data_out,clk);

	input  data_in,clk;  
	output reg  data_out; 

	always @ (posedge clk) 
		data_out=data_in;
	

endmodule
