/* 
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module filter(x,c0,c1,c2,y,clk);
				
	`include "parameter.v"
	
	input  [11:0] x,c0,c1,c2; 
	input  clk; 
	output [11:0] y; 
/////////////////////////////////////////////////////////////////// middle signal
	wire  [11:0] data_x0x1,data_x1x2,x2mult, out1,out2,out3, data_out_c0,data_out_c1,data_out_c2, add_out,final_add;
	wire  en_x0,en_x1,en_x2, en_c0,en_c1,en_c2 ,en_y;
//************************************instantiate************************
 	
	register reg_c0(c0,data_out_c0,en_c0,clk);
	register reg_c1(c1,data_out_c1,en_c1,clk);
	register reg_c2(c2,data_out_c2,en_c2,clk);
//**********************************************************
	register reg_x0(x,data_x0x1,en_x0,clk);
	register reg_x1(data_x0x1,data_x1x2,en_x1,clk);
	register reg_x2(data_x1x2,x2mult,en_x2,clk);
//********************************************************	
	mult    multx0c0 (data_x0x1,data_out_c0,out1);
	mult    multx1c1 (data_x1x2,data_out_c1,out2);
	mult    multx2c2 (x2mult,data_out_c2,out3);
//****************************************************
	add	 add0(out1,out2,add_out);	
	add	 add1(add_out,out3,final_add);	
//****************************************************
	register reg_y(final_add,y,en_y,clk);	
	
////////////////////////////////////////controller////////////////////////////////////////////////////


	assign en_c0=1;
	assign en_c1=1;
	assign en_c2=1;
		
	assign en_x0=1;
	assign en_x1=1;
	assign en_x2=1;
	
	assign en_y=1;
	
	



/////////////////////////////////////////////////////////////////////////////////////////////////	

endmodule
