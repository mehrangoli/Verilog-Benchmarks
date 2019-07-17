/* 
Author: Mehran Goli
Version: 1.0
Date: 17-8-2019
*/
module BinaryToBcd(input[8:0] binary ,output [3:0] three,two,one);

	wire [3:0] A,B,C,D,E,F,G,H,I;

	add3if a1({1'b0,binary[8:6]} ,A);
	add3if a2({A[2:0],binary[5]} ,B);
	add3if a3({B[2:0],binary[4]} ,C);
	add3if a4({1'b0,A[3],B[3],C[3]} ,D);
	add3if a5({C[2:0],binary[3]} ,E);
	add3if a6({D[2:0],E[3]} ,F);
	add3if a7({E[2:0],binary[2]},G);
	add3if a8({F[2:0],G[3]} ,H);
	add3if a9({G[2:0],binary[1]} ,I);
	
	assign one = {I[2:0],1'b0};
	assign two = {H[2:0],I[3]};
	assign three = {1'b0,D[3],F[3],H[3]};

endmodule
