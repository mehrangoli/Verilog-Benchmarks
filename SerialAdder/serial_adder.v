/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module serial_adder (input ain,bin,start,rst,clk, output[8:0] result, output reg ready);
//============input
//SW0 :clk
//SW1 :rst
//SW2 :start
//SW3 :ain
//SW4 :bin
//============ output
//LED  :output
//LEDR :ready
//===========

wire cin,cout,out,and_out,complete;
reg shift_en,init,cout_en;
reg [2:0] ps,ns;
parameter s0=3'b000,s1=3'b001, s2=3'b010;

	add 				adder_cut (ain,bin,cin,cout,out);
	and					and_cut   (and_out,cout, ~init);
	filipflop 			filipflop_cut (and_out,cin,clk);
	shiftin_register 	a_cut (out,shift_en,result,clk,rst);
	counter 			counter_cut (cout_en,complete,init,clk);
		

	always @(ps,ain,bin,start,complete)
	 begin
			ready= 1'b0;
			init= 0;
			shift_en = 0;
			cout_en = 0;
          case (ps)
            s0:begin   
					if (start)
						ns = s1;
					else begin
						ns = s0;
					end	
				end				
            s1:begin
					if (start==0)begin
						init=1;
						ns = s2;
					end	
					else
						ns = s1;
				end	
            s2:begin
					if (complete == 0)begin
						shift_en=1;
						cout_en = 1;
//						cout_en = 1;
						ns = s2;
					end	
					else begin
						ready = 1'b1;
						ns = s0;
					end
				end	    		
            default:
                    ns = s0;
          endcase
   end
////////////////////////////////////////////////////////////////////////////////////////////

	always @(posedge clk ,posedge rst) begin
		if (rst)
			ps=s0;
		else
			ps=ns;
	end	

endmodule
