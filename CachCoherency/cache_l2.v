/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/

module cache_l2(data_out, data_in, address, address_out, write, read, ctrl_l1_id, w_select_0, w_select_1, w_select_2, w_select_3, clk, rst);
`include "parameter.v"

	
	input  wire[`address_rang-1:0] address; 
	input  wire[`data_siz-1:0] data_in;
	input  clk,rst ;
	input  wire read,write ;
	input  wire[`sel_siz-1:0] ctrl_l1_id ;
	output reg[`address_rang-1:0] address_out; 
	output reg[`data_siz-1:0] data_out;
	output reg  w_select_0,w_select_1,w_select_2,w_select_3 ;

	integer i=0,k=0;
	reg[`data_siz-1:0] cache2 [`cach_size-1:0];

	
	
	reg [1:0] ps,ns;
	parameter init_s=0,write_s=1, read_s=2 ;
	
	
	initial begin
		for (k = 0; k < `cach_size ; k = k + 1)
			begin
				cache2[k] = k ;
		end
	end	
	
	
	always @ (ps,write,read,address,data_in,ctrl_l1_id)
	 begin
		  w_select_0= 0;
		  w_select_1= 0;
		  w_select_2= 0;
		  w_select_3= 0;
          case (ps)
               init_s:begin
				if (write)
					ns = write_s;
				else if (read)
					ns = read_s;
				else
					ps= init_s;
				
				end
               write_s:begin
					cache2[address][`data_siz-2:0] = data_in[`data_siz-2:0]; //data
					cache2[address][`data_siz-1] = 1; // valid
					//othercach_addrss = address;
					ns =init_s;
				end
				
               read_s:begin
					address_out = address;
					data_out = cache2[address][`data_siz-1:0];
					if (ctrl_l1_id == 2'b00)
						w_select_0= 1;
					else if (ctrl_l1_id == 2'b01)	 
						w_select_1= 1;
					else if (ctrl_l1_id == 2'b10)	 
						w_select_2= 1;
					else if (ctrl_l1_id == 2'b11)	 
						w_select_3= 1;
					ns =init_s;
				end	
               default:
                    ns = init_s;
          endcase
     end
////////////////////////////////////////////////////////////////////////////////////////////

	always @ (posedge clk or posedge rst) begin
		if (rst == 1)
			ns=init_s;
		else
			ps=ns;
	end
endmodule
