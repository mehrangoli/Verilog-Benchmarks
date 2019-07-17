/* 
cache coherency invalidate base protocol
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/

module cache_l1(cpu_data_in
				,data_into_l2
				,cpu_address
				,address_to_l2
				,write,read
				,cpu_data_out
				,data_from_l2
				,req,gnt
				,validity_out
				,validity_in_0,validity_in_1,validity_in_2
				,write_l2,read_l2
				,l2_address
				,valid_address_in_0,valid_address_in_1,valid_address_in_2
				,valid_address_out
				,l2_write,rst,clk);
				
	`include "parameter.v"
	
	input  [`data_siz-1:0] cpu_data_out,data_from_l2; 
	input  [`address_rang-1:0] cpu_address; 
	input  [`address_rang-1:0] valid_address_in_0,valid_address_in_1,valid_address_in_2; 
	input  clk,read,write,l2_write,gnt,rst;
	input  validity_in_0,validity_in_1,validity_in_2;
	output reg[`data_siz-1:0] cpu_data_in,data_into_l2;
	output reg[`address_rang-1:0] address_to_l2;//,othercach_addrss;
	input [`address_rang-1:0] l2_address;//bus address to L1;
	
	output reg[`address_rang-1:0] valid_address_out;//bus address to L1;
	

	output  reg req,read_l2,write_l2;
	output  reg validity_out;

	reg[`data_siz-1:0] cache [`cach_size-1:0];
	integer k=0;
	reg write_alert;
	
	reg [2:0] ps,ns;
	parameter init_s=0,write_s=1, read_s=2, waite_gnt_s=3, write_from_l2_s=4;
	
	
	
	////////////observation signal/////
	integer counter_read=0;
	integer counter_write=0;
	integer counter_read_l2=0;
	integer counter_write_l2=0;
	
	//////////////////////////////////
	
	
	initial begin
		for (k = 0; k < `cach_size ; k = k + 1)
			begin
				cache[k] = 8'b10000111 + k ;
		end
	end
	
	
	always @ (ps,write,read,cpu_data_out,data_from_l2,l2_write,gnt,cpu_address)
	 begin
		  //write_alert = 0;
		  req = 0;
		  read_l2 = 0;
		  write_l2 = 0;
          case (ps)
               init_s:begin    // write has priority than read in all caches
				if (write)
					ns = write_s;
				else if (read)	//read has priority than L2 cache write into L1 
					ns = read_s;
				else if(l2_write)
                    ns = write_from_l2_s;
				else
					ps= init_s;
				end
				
               write_s:begin
					cache[cpu_address][`data_siz-2:0] = cpu_data_out[`data_siz-2:0]; //data
					cache[cpu_address][`data_siz-1] = 1; // valid
					validity_out= 1;				// invalid data in other cache
					valid_address_out = cpu_address;
					
					write_alert = 1;
					req=1;
					ns =waite_gnt_s;
					counter_write=counter_write+1; // ---------------write number
					
				end	
               read_s:begin
					counter_read= counter_read+1; //-------------------read number
                    if (cache[cpu_address][`data_siz-1] == 1)begin //hit
						cpu_data_in = cache[cpu_address][`data_siz-1:0];
						ns= init_s;
					end	
					else begin	//miss
						counter_read_l2 = counter_read_l2+1;
						req=1;
						ns= waite_gnt_s;
					end	
				end	
					
               waite_gnt_s:begin
                    if (gnt)begin
						address_to_l2 =  cpu_address;
						if(write_alert)begin
							write_alert=0;
							write_l2=1;
							data_into_l2 =  cpu_data_out;
							counter_write_l2 = counter_write_l2+1;
						end	
						else 
							read_l2 = 1;
						ns = init_s;
					end	
					else //begin
						ns = waite_gnt_s;
						//req=1;
					//end	
				end		
				write_from_l2_s:begin
					cache[l2_address][`data_siz-2:0] = data_from_l2[`data_siz-2:0]; //data
					cache[l2_address][`data_siz-1] = 1; // valid
					ns = init_s;	
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

////////////////////////////////////////////////////////////////////////////////////////////	
	always @ ( validity_in_0,validity_in_1,validity_in_2,valid_address_in_0,valid_address_in_1,valid_address_in_2)begin
		if (validity_in_0)
			cache[valid_address_in_0][`data_siz-1] = 0; // valid bit=0
		if (validity_in_1)
			cache[valid_address_in_1][`data_siz-1] = 0;
		if (validity_in_2)
			cache[valid_address_in_2][`data_siz-1] = 0;

	end
/////////////////////////////////////////////////////////////////////////////////////////////////	

endmodule
