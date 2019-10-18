module ALU(
	input logic [1:0] sel,
	input logic [15:0] A, B,
	output logic [15:0] out);
	always_comb
	begin
		case(sel)
			2'b00: out = A+B;
			2'b01: out = ~A;
			2'b10: out = A & B;
			2'b11: out = A;
		endcase
	end
endmodule