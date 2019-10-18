module reg_16
	(	input logic [15:0] in,
		input clk, reset, load,
		output logic [15:0] out );
		always_ff @ (posedge clk)
		begin
			if (reset)
				out <= 16'h0000;
			else if (load)
				out <= in;	
		end
endmodule
	
	
		
					