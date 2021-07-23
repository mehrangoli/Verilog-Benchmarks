/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


module fifo_design # (parameter width = 8, depth = 8)
  					(input clk, rst, f_rd, f_wr,
 					input [width-1:0] din,
					output f_empty, f_full,
 					output [width-1:0] dout);
  
  
  wire rd_en, wr_en;
  wire [2:0] read_ptr, wrt_ptr;
  	
  mem_module  m1 (clk, rst, wr_en, read_ptr, wrt_ptr, din, dout);
  
  read_ptr_module m2 (clk, rst, rd_en, read_ptr);
  
  write_ptr_module m3 (clk, rst, wr_en, wrt_ptr);
  
  sts_module m4(clk, rst, rd_en, wr_en, f_empty, f_full);
  
  assign rd_en = !f_empty & f_rd;  
  assign wr_en = !f_full & f_wr;
  
endmodule 
