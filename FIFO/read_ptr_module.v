/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


module read_ptr_module (input clk, rst, rd_en,
                        output reg [2:0] read_ptr);
  
  always @ (posedge clk) begin
    if (rst)
    	read_ptr <= 0;
  	else if (rd_en)
   		read_ptr <= read_ptr +1;
    else 
      	read_ptr <= read_ptr;
  end 
endmodule