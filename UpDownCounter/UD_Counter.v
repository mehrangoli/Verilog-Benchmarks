/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module UD_Counter(clk,rst,load,ud,init,out);
input clk,rst,ud,load;
input [3:0] init;
output [6:0]out;

reg [3:0] counter;

//Clock div
reg [23:0] div;
always@(posedge clk)
	div = div +1;
//////////////

//assign out = counter;
always@(posedge div[23] or posedge rst)begin
	if (rst==1'b1)
		counter = 4'b0;
	else
	begin
		if (load==1'b1)
			counter = init;
		else
			if (ud==1'b1)
				counter = counter+4'b0001;
			else
				counter = counter -4'b0001;
	end
end

seven_seg inst(counter,out);
endmodule
