module shift_register

	(	input logic [7:0] Din,
		input clk, reset, load, shift_en, shift_in,
		output logic shift_out,
		output logic [7:0] Dout );
		
		always_ff @ (posedge clk)
		begin
			if (reset)
				Dout <= 8'h0;
			else if (load)
				Dout <= Din;	
			else if (shift_en)
				Dout <= {shift_in, Dout[7:1]};
		end
		
		assign shift_out = Dout[0];
		
endmodule
	
	
		
					