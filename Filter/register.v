/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/

module register(data_in,data_out,ld_en,clk);
				
	`include "parameter.v"
	
	input  [`data_siz-1:0] data_in; 
	input   ld_en, clk; 
	output reg [`data_siz-1:0] data_out; 

	
	
////////////////////////////////////////////////////////////////////////////////////////////

	always @ (posedge clk) begin
		if (ld_en)
			data_out=data_in;
	end

/////////////////////////////////////////////////////////////////////////////////////////////////	

endmodule
