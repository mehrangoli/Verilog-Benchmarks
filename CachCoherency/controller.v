/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module controller(data_sel,address_sel, grant_0, grant_1, grant_2, grant_3, req_0, req_1, req_2, req_3, l2_read_sel, l2_write_sel, l1_id,clk);
`include "parameter.v"
	

	input		req_0,req_1,req_2,req_3,clk ;
	output reg	[`sel_siz-1:0] data_sel,address_sel;
	output reg  grant_0,grant_1,grant_2,grant_3 ;
	
	output reg [`sel_siz-1:0] l2_read_sel, l2_write_sel ;	
	output reg [`sel_siz-1:0] l1_id;	
		
	always @ (posedge clk)//req_0,req_1,req_2,req_3
	begin
		
		grant_0 = 0; 
		grant_1 = 0;
		grant_2 = 0;
		grant_3 = 0;
		if (req_0)begin   // priority of cache's request, consider by cache's index. Lower index has upper periority 
			grant_0 = 1;
			data_sel = 2'b00;
			address_sel = 2'b00;
			l2_read_sel = 2'b00;
			l2_write_sel = 2'b00;
			l1_id = 2'b00;
		end
		else if (req_1)begin
			grant_1 = 1;
			data_sel = 2'b01;
			address_sel = 2'b01;
			l2_read_sel = 2'b01;
			l2_write_sel = 2'b01;
			l1_id = 2'b01;
		end
		else if (req_2) begin
			grant_2 = 1;
			data_sel = 2'b10;
			address_sel = 2'b10;
			l2_read_sel = 2'b10;
			l2_write_sel = 2'b10;
			l1_id = 2'b10;
		end
		else if (req_3)begin
			grant_3 = 1;
			data_sel = 2'b11;
			address_sel = 2'b11;		
			l2_read_sel = 2'b11;
			l2_write_sel = 2'b11;
			l1_id = 2'b11;
		end
	end
	
endmodule
	
