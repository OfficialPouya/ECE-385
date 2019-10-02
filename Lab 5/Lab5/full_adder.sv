module full_adder
(
	input x,y,z,
	output sum, carry_out);
	
	assign sum = x ^ y ^z;
	assign carry_out = (x&y) | (y&z) | (x&z);
	
endmodule
