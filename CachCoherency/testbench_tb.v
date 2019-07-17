/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/

module test(clk_tb); //processor
`include "parameter.v"

	
	wire[`address_rang-1:0] address_tb_0,address_tb_1,address_tb_2,address_tb_3; //CPU and l1 cache
	wire[`data_siz-1:0] data_in_tb_0,data_in_tb_1,data_in_tb_2,data_in_tb_3;
	wire[`data_siz-1:0] data_out_tb_0,data_out_tb_1,data_out_tb_2,data_out_tb_3; //CPU and l1 cache
	
	wire[`data_siz-1:0] l2_data_in_tb,data_from_l2_tb; // L2
	wire[`address_rang-1:0] l2_address_tb ,address_from_l2_tb;
	wire l2_write_tb, l2_read_tb;

	wire[`address_rang-1:0] valid_address_out_0_tb,valid_address_out_1_tb,valid_address_out_2_tb,valid_address_out_3_tb;
	
	wire[`address_rang-1:0] address_to_l2_tb_0,address_to_l2_tb_1,address_to_l2_tb_2,address_to_l2_tb_3; 
	
	wire[`data_siz-1:0] data_into_bus_tb_0,data_into_bus_tb_1,data_into_bus_tb_2,data_into_bus_tb_3; //bus wire
	
	
	output reg clk_tb = 0 ;
	reg rst_tb = 0 ;
	wire req_tb_0,req_tb_1,req_tb_2,req_tb_3;
	wire gnt_tb_0,gnt_tb_1,gnt_tb_2,gnt_tb_3;
	wire read_tb_0,read_tb_1,read_tb_2,read_tb_3,write_tb_0,write_tb_1,write_tb_2,write_tb_3 ;
	
	wire write_l2_tb_0,write_l2_tb_1,write_l2_tb_2,write_l2_tb_3 ;
	wire read_l2_tb_0,read_l2_tb_1,read_l2_tb_2,read_l2_tb_3 ;
	wire l2write_tol1_tb_0, l2write_tol1_tb_1, l2write_tol1_tb_2, l2write_tol1_tb_3 ; //when L2 wants to write miss data into L1
	
	wire validity_out_tb_0,validity_out_tb_1,validity_out_tb_2,validity_out_tb_3;
	
	wire[`sel_siz-1:0] data_sel_tb,address_sel_tb;
	wire[`sel_siz-1:0] l2_read_sel_tb,l2_write_sel_tb, l1_id_tb;
	
	//====================================== processor ==================================================
	processor0 PE_0(data_out_tb_0,data_in_tb_0,address_tb_0,write_tb_0,read_tb_0,clk_tb);
	processor1 PE_1(data_out_tb_1,data_in_tb_1,address_tb_1,write_tb_1,read_tb_1,clk_tb);
	processor2 PE_2(data_out_tb_2,data_in_tb_2,address_tb_2,write_tb_2,read_tb_2,clk_tb);
	processor3 PE_3(data_out_tb_3,data_in_tb_3,address_tb_3,write_tb_3,read_tb_3,clk_tb);
	
	//==================================== cache level 1 ================================================
	cache_l1 L1_0(data_in_tb_0, data_into_bus_tb_0, address_tb_0,address_to_l2_tb_0, write_tb_0, read_tb_0, data_out_tb_0, data_from_l2_tb, req_tb_0, gnt_tb_0, validity_out_tb_0, validity_out_tb_1,validity_out_tb_2,validity_out_tb_3, write_l2_tb_0, read_l2_tb_0 ,address_from_l2_tb, valid_address_out_1_tb, valid_address_out_2_tb,valid_address_out_3_tb, valid_address_out_0_tb ,l2write_tol1_tb_0, rst_tb, clk_tb);
	cache_l1 L1_1(data_in_tb_1, data_into_bus_tb_1, address_tb_1,address_to_l2_tb_1, write_tb_1, read_tb_1, data_out_tb_1, data_from_l2_tb, req_tb_1, gnt_tb_1, validity_out_tb_1, validity_out_tb_0,validity_out_tb_2,validity_out_tb_3, write_l2_tb_1, read_l2_tb_1 ,address_from_l2_tb, valid_address_out_0_tb, valid_address_out_2_tb,valid_address_out_3_tb, valid_address_out_1_tb ,l2write_tol1_tb_1, rst_tb, clk_tb);
	cache_l1 L1_2(data_in_tb_2, data_into_bus_tb_2, address_tb_2,address_to_l2_tb_2, write_tb_2, read_tb_2, data_out_tb_2, data_from_l2_tb, req_tb_2, gnt_tb_2, validity_out_tb_2, validity_out_tb_0,validity_out_tb_1,validity_out_tb_3, write_l2_tb_2, read_l2_tb_2 ,address_from_l2_tb, valid_address_out_0_tb, valid_address_out_1_tb,valid_address_out_3_tb, valid_address_out_2_tb ,l2write_tol1_tb_2, rst_tb, clk_tb);
	cache_l1 L1_3(data_in_tb_3, data_into_bus_tb_3, address_tb_3,address_to_l2_tb_3, write_tb_3, read_tb_3, data_out_tb_3, data_from_l2_tb, req_tb_3, gnt_tb_3, validity_out_tb_3, validity_out_tb_0,validity_out_tb_1,validity_out_tb_2, write_l2_tb_3, read_l2_tb_3 ,address_from_l2_tb, valid_address_out_0_tb, valid_address_out_1_tb,valid_address_out_2_tb, valid_address_out_3_tb ,l2write_tol1_tb_3, rst_tb, clk_tb);
	
	//======================================== cache coherency mechanise =================================	
	controller CONTROLLER (data_sel_tb,address_sel_tb, gnt_tb_0,gnt_tb_1,gnt_tb_2,gnt_tb_3, req_tb_0,req_tb_1,req_tb_2,req_tb_3, l2_read_sel_tb,l2_write_sel_tb, l1_id_tb,clk_tb);
	
	//============================ ===============BUS ====================================================
	mux_data   	DATA_MUX	  (data_into_bus_tb_0,data_into_bus_tb_1,data_into_bus_tb_2,data_into_bus_tb_3, data_sel_tb, l2_data_in_tb);
	mux_address ADDRESS_MUX (address_to_l2_tb_0,address_to_l2_tb_1,address_to_l2_tb_2,address_to_l2_tb_3, address_sel_tb, l2_address_tb);
	mux_small 	READ_MUX    (read_l2_tb_0,read_l2_tb_1,read_l2_tb_2,read_l2_tb_3,l2_read_sel_tb,l2_read_tb);
	mux_small 	WRITE_MUX   (write_l2_tb_0,write_l2_tb_1,write_l2_tb_2,write_l2_tb_3,l2_write_sel_tb,l2_write_tb);
	
	//===================================cache level 2 ====================================================
	cache_l2  L2(data_from_l2_tb, l2_data_in_tb, l2_address_tb, address_from_l2_tb, l2_write_tb, l2_read_tb, l1_id_tb, l2write_tol1_tb_0, l2write_tol1_tb_1, l2write_tol1_tb_2, l2write_tol1_tb_3, clk_tb, rst_tb);
	
 initial begin
	rst_tb = 1;
	#4;
	rst_tb = 0;

 end	
 always
   begin
      clk_tb = 0;
      #10;
      clk_tb = 1;
      #10;
   end

endmodule
