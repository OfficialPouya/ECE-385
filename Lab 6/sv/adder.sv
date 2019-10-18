module adder(input logic [15:0] ADDR2_OUT, ADDR1_OUT,
			output logic [15:0] out);
		always_comb
		begin
			out <= ADDR2_OUT+ADDR1_OUT;
		end
endmodule