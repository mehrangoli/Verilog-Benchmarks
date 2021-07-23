/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/



module mem_module # (parameter width = 8, depth = 8)
  				(input clk, rst, wr_en,
                 input [2:0] read_ptr, wrt_ptr,
                 input [width-1:0] din,
                 output [width-1:0] dout);
  
  reg [width-1:0] f_mem [0:depth-1];
  
  always @(posedge clk) begin
    if (rst)
      f_mem <= '{default:0};
    else if (wr_en)
        f_mem [wrt_ptr] <= din;
  end
 
  assign dout = f_mem [read_ptr];
  
endmodule