module nine_bit_adder
(
	input logic[7:0] A,B,
	input Sel,
	// Sel = 0 => Output = A + B
	// Sel = 1 => Output = A - B
	output logic[8:0] Sum
);
	logic c0, c1, c2, c3, c4, c5, c6, c7;				
	full_adder fa0(.A(A[0]), .B(Sel^B[0]), .Cin(Sel),.Sum(Sum[0]), .Cout(c0));
	full_adder fa1(.A(A[1]), .B(Sel^B[1]), .Cin(c0), .Sum(Sum[1]), .Cout(c1));
	full_adder fa2(.A(A[2]), .B(Sel^B[2]), .Cin(c1), .Sum(Sum[2]), .Cout(c2));
	full_adder fa3(.A(A[3]), .B(Sel^B[3]), .Cin(c2), .Sum(Sum[3]), .Cout(c3));
	full_adder fa4(.A(A[4]), .B(Sel^B[4]), .Cin(c3), .Sum(Sum[4]), .Cout(c4));
	full_adder fa5(.A(A[5]), .B(Sel^B[5]), .Cin(c4), .Sum(Sum[5]), .Cout(c5));
	full_adder fa6(.A(A[6]), .B(Sel^B[6]), .Cin(c5), .Sum(Sum[6]), .Cout(c6));
	full_adder fa7(.A(A[7]), .B(Sel^B[7]), .Cin(c6), .Sum(Sum[7]), .Cout(c7));
	full_adder fa8(.A(A[7]), .B(Sel^B[7]), .Cin(c7), .Sum(Sum[8]));
	
endmodule

