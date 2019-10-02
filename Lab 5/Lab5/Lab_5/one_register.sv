module one_register

	(	input logic in,
		input logic clk, reset, load,
		output logic out );
		always_ff @ (posedge clk)
		begin
			if (reset)
				out <= 0;
			else if (load)
				out <= in;	
		end	
		
endmodule
	
	
		
					