/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module shiftin_register(serial_in,shif_en,data_out,clk,rst);
	
	input  serial_in,shif_en,clk,rst; 
	output [8:0] data_out; 

	reg [8:0] temp;
	
////////////////////////////////////////////////////////////////////////////////////////////

	always @ (posedge clk,posedge rst) begin
		if(rst)
			temp=0;
		else if (shif_en) begin
			temp[7:0]= temp [8:1];
			temp[8]=serial_in;
		end	
	end
	assign data_out = temp;	

endmodule
