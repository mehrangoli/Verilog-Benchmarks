//Author: Mehran Goli
//Version: 1.0
//Date: 01-09-2021

`timescale 1ns/1ns

module seq_mult_tb #(parameter n = 8);
	reg start_tb, rst_tb, clk_tb =0;
	reg [n-1:0] a_tb, b_tb;
	wire valid_tb;
	wire [2*n-1:0] result_tb;
				

	seq_mult	DUT	(start_tb, rst_tb, clk_tb,a_tb, b_tb,valid_tb, result_tb);
	
	always #2 clk_tb = ~clk_tb;
	
	initial begin
		$monitor ("[%0t]: a = %d , b = %d, start = %b, rst = %b, valid = %b, result= %d",$time, a_tb, b_tb, start_tb, rst_tb,valid_tb, result_tb);
		
		rst_tb =1;
		start_tb =0;
		#10;
		rst_tb =0;
		
		repeat (20) begin	
			start_tb =1;
			a_tb = $random;
			b_tb = $random;
			#5
			start_tb =0;
			
			#100; 
		end
  
		$stop;
		
	end		
endmodule	


			