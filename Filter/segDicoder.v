/*
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module segDicoder(input [3:0] in ,output reg [7:0]out);

	always @(*)begin
		case(in)
			4'b0000: out<=8'b00111111;
			4'b0001: out<=8'b00000110;
			4'b0010: out<=8'b01011011;
			4'b0011: out<=8'b01001111;
			4'b0100: out<=8'b01100110;
			4'b0101: out<=8'b01101101;
			4'b0110: out<=8'b01111101;
			4'b0111: out<=8'b01000111;
			4'b1000: out<=8'b01111111;
			4'b1001: out<=8'b01101111;
		endcase
	end
endmodule
