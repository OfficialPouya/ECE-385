module carry_lookahead_adder
(
    input   logic[15:0]     A,
    input   logic[15:0]     B,
    output  logic[15:0]     Sum,
    output  logic           CO
);

						
four_bit_lookahead_carry CLA0(.A(A[3:0]), 		.B(B[3:0]), 		.cin(0), 		.Sum(Sum[3:0]), 			.cout(c0));
four_bit_lookahead_carry CLA1(.A(A[7:4]), 		.B(B[7:4]), 		.cin(c0), 		.Sum(Sum[7:4]), 			.cout(c1));
four_bit_lookahead_carry CLA2(.A(A[11:8]), 		.B(B[11:8]), 		.cin(c1), 		.Sum(Sum[11:8]), 			.cout(c2));
four_bit_lookahead_carry CLA3(.A(A[15:12]),		.B(B[15:12]), 		.cin(c2), 		.Sum(Sum[15:12]), 		.cout(CO)); 
    /* TODO
     *
     * Insert code here to implement a CLA adder.
     * Your code should be completly combinational (don't use always_ff or always_latch).
     * Feel free to create sub-modules or other files. */
     
endmodule

module four_bit_lookahead_carry(
						input [3:0] A,
						input [3:0] B,
						input  cin,
						output [3:0] Sum,
						output cout
						);
						
						logic c0, c1, c2, c3;
						logic G0, G1, G2, G3;	
						logic P0, P1, P2, P3;
						logic S0, S1, S2, S3;
						
						assign G0=A[0]&B[0];
						assign G1=A[1]&B[1];
						assign G2=A[2]&B[2];
						assign G3=A[3]&B[3];
						
						assign P0=A[0]^B[0];
						assign P1=A[1]^B[1];
						assign P2=A[2]^B[2];
						assign P3=A[3]^B[3];				
						
						assign c0=cin;
						assign c1=cin&P0 | G0;
						assign c2=cin&P0&P1 | G0&P1 | G1;
						assign c3=c0&P0&P1&P2 | G0&P1&P2 | G1&P2 | G2;
						
						//assign cout=CO;
						assign Sum[0] = A[0]^B[0]^c0; 
						assign Sum[1] = A[1]^B[1]^c1; 
						assign Sum[2] = A[2]^B[2]^c2; 
						assign Sum[3] = A[3]^B[3]^c3; 
						
						
						

endmodule




							
						
