/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


module write_ptr_module (input clk, rst, wr_en,
                       	 output reg [2:0] wrt_ptr);
  
  always @ (posedge clk) begin
    if (rst)
    	wrt_ptr <= 0;
  	else if (wr_en)
   		wrt_ptr <= wrt_ptr +1;
    else 
      	wrt_ptr <= wrt_ptr;
  end 
endmodule  

