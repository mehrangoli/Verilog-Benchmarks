/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/
module fifo_tb ();
	
  parameter n = 8;
  reg clk =0, rst, rd, wr;
  reg [n-1:0] din;
  wire full, empty, ovf, undf;
  wire [n-1:0] dout;
  
  fifo DUT (clk, rst, rd, wr,din, full, empty, ovf, undf, dout);
  
 always #10 clk = ~clk;
  
 initial  
      begin 
        rst     = 1'b1;  
        wr     = 1'b0;  
        rd     = 1'b0;  
        din     = 8'd0;
        #20 
        rst     = 1'b0;  
        wr     = 1'b1;  
        rd     = 1'b0;  
        din     = 8'd10;
        #20
        wr     = 1'b0;  
        rd     = 1'b1;   
        #20 
        wr     = 1'b0;  
        rd     = 1'b1;  
        #20 
        
        $finish;
   end
  
  initial
    $monitor ("time[%0t]: clk = %b, rst = %b, rd = %b, wr = %b ,din = %b, full = %b, empty = %b, ovf = %b, undf = %b, dout = %b, wptr_f = %b, rptr_f = %b, top_writep.rw_en = %b,  mem = %p" , $time, clk, rst, rd, wr,din, full, empty, ovf, undf, dout, DUT.wptr_f, DUT.rptr_f, DUT.top_writep.rw_en, DUT.top_mem.fifo_mem);
  end
  
  
  
endmodule