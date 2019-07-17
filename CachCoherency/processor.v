/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module processor0(data_out,data_in,address,write,read,clk); //processor
`include "parameter.v"

	
	output [`address_rang-1:0] address; 
	input  wire[`data_siz-1:0] data_in;
	input  clk ;
	output read,write ;
	output [`data_siz-1:0] data_out;
	reg temp_write = 1'b0;
	reg temp_read = 1'b1;
	reg [`address_rang-1:0] temp_address;
	reg [`data_siz-1:0] temp_data = 1'b0;
	
	initial repeat (1000) #150 temp_read = ~temp_read;
	initial repeat (1000) #160 temp_write = ~temp_write;
	initial repeat (1000) #100 temp_address = $random % (`cach_size-1);
	initial repeat (1000) #100 temp_data = $random % (`data_siz-1-1);
	/* initial begin
		read = 1'b1;
		address = 4'b0001;
		#12;
		read = 1'b0;	
		#150;
		//read = 1'b1;
		//address = 4'b0011;
		//#12;
		//read = 1'b0; 
		//#150;		
		address = 4'b0010;
		data_out= 8'b01100000;
		write = 1'b1;
		#12;
		write = 1'b0;
	end */


assign read = temp_read;
assign write = temp_write;
assign address = temp_address;
assign data_out = temp_data;
endmodule
//======================================
module processor1(data_out,data_in,address,write,read,clk); //processor
`include "parameter.v"

	
	output [`address_rang-1:0] address; 
	input  wire[`data_siz-1:0] data_in;
	input  clk ;
	output read,write ;
	output [`data_siz-1:0] data_out;

	
	reg temp_write1 = 1'b0;
	reg temp_read1 = 1'b1;
	reg [`address_rang-1:0] temp_address1;
	reg [`data_siz-1:0] temp_data1 = 1'b0;
	
	initial repeat (1000) #500 temp_read1 = ~temp_read1;
	initial repeat (1000) #510 temp_write1 = ~temp_write1;
	initial repeat (1000) #100 temp_address1 = $random % (`cach_size-1);
	initial repeat (1000) #100 temp_data1 = $random % (`data_siz-1-1);
	
	
	/* initial 
	begin
		read = 1'b0;
		#250;
		read = 1'b1;
		address = 4'b0101;
		#12;
		read = 1'b0;	
		#150;
		read = 1'b1;
		address = 4'b0111;
		#12;
		read = 1'b0;
		#150;		
		address = 4'b0110;
		data_out= 8'b01110000;
		write = 1'b1;
		#12;
		write = 1'b0;
	end */
	
assign read = temp_read1;
assign write = temp_write1;
assign address = temp_address1;
assign data_out = temp_data1;
endmodule

//=============================================
module processor2(data_out,data_in,address,write,read,clk); //processor
`include "parameter.v"

	
	output reg[`address_rang-1:0] address; 
	input  wire[`data_siz-1:0] data_in;
	input  clk ;
	output  reg read,write ;
	output reg[`data_siz-1:0] data_out;

	
	initial 
	begin
		read = 1'b0;
		//#450;
		#750;
		read = 1'b1;
		address = 4'b0110;
		#12;
		read = 1'b0;	
		#150;
		read = 1'b1;
		address = 4'b0111;
		#12;
		read = 1'b0;
		#150;		
		address = 4'b1001;
		data_out= 8'b01111000;
		write = 1'b1;
		#12;
		write = 1'b0;
	end
endmodule


//============================================================
module processor3(data_out,data_in,address,write,read,clk); //processor
`include "parameter.v"

	
	output reg[`address_rang-1:0] address; 
	input  wire[`data_siz-1:0] data_in;
	input  clk ;
	output  reg read,write ;
	output reg[`data_siz-1:0] data_out;

	
	initial 
	begin
		#200;
		read = 1'b1;
		address = 4'b0110;
		#12;
		read = 1'b0;	
		#150;
		read = 1'b1;
		address = 4'b0111;
		#12;
		read = 1'b0;
		#150;		
		address = 4'b1001;
		data_out= 8'b01111000;
		write = 1'b1;
		#12;
		write = 1'b0;
	end
endmodule
