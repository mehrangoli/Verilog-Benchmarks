/* 
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module add(in1,in2,out);
				
	//`include "parameter.v"
	
	input  [11:0] in1,in2; 
	output [11:0] out; 

	reg [11:0]temp ;
	
////////////////////////////////////////////////////////////////////////////////////////////

	always @ (in1,in2) begin
		temp=in1+in2;
	end

	assign out = temp;
/////////////////////////////////////////////////////////////////////////////////////////////////	

endmodule
