module sext10_0( //works
	input logic [10:0] in,
	output logic [15:0] out);
	always_comb
	begin
		out[10:0] = in;
		if (in[10] == 0)
			out[15:11] = 5'b00000;
		else
			out[15:11] = 5'b11111;
	end
endmodule
		
		
module sext8_0(
	input logic [8:0] in,
	output logic [15:0] out);
	always_comb
	begin
		out[8:0] = in;
		if (in[8] == 0)
			out[15:9] = 7'b0000000;
		else
			out[15:9] = 7'b1111111;
	end
endmodule

module sext5_0(
	input logic [5:0] in,
	output logic [15:0] out);
	always_comb
	begin
		out[5:0] = in;
		if (in[5] == 0)
			out[15:6] = 10'b0000000000;
		else
			out[15:6] = 10'b1111111111;
	end
endmodule

module sext4_0(
	input logic [4:0] in,
	output logic [15:0] out);
	always_comb
	begin
		out[4:0] = in;
		if (in[4] == 0)
			out[15:5] = 11'b00000000000;
		else
			out[15:5] = 11'b11111111111;
	end
endmodule

module zext15_0(
	input logic [15:0] in,
	output logic [19:0] out);
	always_comb
	begin
		out[15:0] = in;
		out[19:16] = 4'b0000;
	end
endmodule
		