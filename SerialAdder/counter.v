/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module counter(count_en,complete,rst,clk);
	
	input  count_en,clk,rst; 
	output  complete; 

	reg [3:0] temp=0;
	
////////////////////////////////////////////////////////////////////////////////////////////

	always @ (posedge clk,posedge rst) begin
		if(rst)begin
			temp=0;
		end
		else if (count_en) begin
			temp = temp+1;
		end	
	end
	
	assign complete = (temp==9) ? 1 : 0;

endmodule
