/* 
Parametrized FIFo Memory
Author: Mehran Goli
Version: 1.0
Date: 01-10-2020
*/


module sts_module (input clk, rst, rd_en, wr_en,
                   output f_empty, f_full);
  
  reg [2:0] count;
  
  always @(clk) begin
    if (rst)
      count <= 0;
    else
      case ({wr_en, rd_en})
        2'b01: count <= count -1;
        2'b10: count <= count +1;
        default: count <= count;
      endcase  
  end
        
  assign  f_full = count == 3'b111 ? 1:0;
  assign  f_empty = count== 0 ? 1:0;  
endmodule  
