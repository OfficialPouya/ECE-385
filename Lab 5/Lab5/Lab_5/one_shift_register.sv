module one_register

	(	input logic Din,
		input clk, reset, load, shift_en, shift_in,
		output logic shift_out,
		output logic Dout );
		
		always_ff @ (posedge clk)
		begin
			if (reset)
				Dout <= 0;
			else if (load)
				Dout <= Din;	
			else if (shift_en)
				shift_out <= Dout;
				Dout <= shift_in;
		end
		
		
endmodule
	
	
		
					