/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/

module test(); 
`include "parameter.v"

	
	
	reg[`data_siz-1:0]  x_tb,c0_tb,c1_tb,c2_tb;//bus wire
	wire[`data_siz-1:0] y_tb;//bus wire
	
	
	reg clk_tb = 0 ;

	filter 	cut (x_tb,c0_tb,c1_tb,c2_tb,y_tb,clk_tb);
	
 initial begin
		  
	c0_tb= 12'b110000000000;
	c1_tb= 12'b110000000000;
	c2_tb= 12'b110000000000;
	
	x_tb= 12'b011111000000;
	#25;
	x_tb= 12'b011101000000;
	#25;
	x_tb= 12'b011011000000;
	#25;
 end
	
 always
   begin
      clk_tb = 0;
      #10;
      clk_tb = 1;
      #10;

   end

endmodule
