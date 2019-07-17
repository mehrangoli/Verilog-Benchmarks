/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module seven_seg(in,out);
input [3:0] in;
output reg [6:0] out;

always@(in)begin
	case(in)
	0: out=~7'b0111111;
	1: out=~7'b0000110;
	2: out=~7'b1011011;
	3: out=~7'b1001111;
	4:	out=~7'b1100110;
	5:	out=~7'b1101101;
	6:	out=~7'b1111101;
	7:	out=~7'b0000111;
	default:
		out=~7'b0000000;
	endcase
end
endmodule
