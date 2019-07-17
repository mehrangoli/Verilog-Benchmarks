/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module testbench();

reg  a_tb,b_tb,start_tb,rst_tb,clk_tb=0;
wire[8:0] result_tb;
wire ready;

 serial_adder add_cut ( a_tb,b_tb,start_tb,rst_tb,clk_tb, result_tb, ready_tb);
 always #4 clk_tb = ~clk_tb;
 initial begin
	rst_tb = 1; 
	#10 rst_tb = 0;
	start_tb = 0;
	#10 start_tb = 1;
	//@posedge(clk_tb);
	start_tb = 0;
	
	a_tb = 0;b_tb=0;
	#10 a_tb = 0;b_tb=1;
	#10 a_tb = 1;b_tb=0;
	#10 a_tb = 1;b_tb=1;
	#10 a_tb = 0;b_tb=0;
	#10 a_tb = 0;b_tb=1;
	#10 a_tb = 1;b_tb=0;
	#10 a_tb = 1;b_tb=1;
	end	
endmodule
