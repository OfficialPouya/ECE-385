module NZP_reg( 
	input logic LD_CC, Clk, Reset,
	input logic [15:0] in,
	output logic N, Z, P);
	
	logic new_N, new_Z, new_P;
	
	always_comb
	begin
		case (in[15])
			1'b1: //negative
			begin
				new_N= 1;
				new_Z= 0;
				new_P = 0;
			end
			
			1'b0: //not negative	
				if (in == 16'h000) // zero
				begin
					new_N= 0;
					new_Z= 1;
					new_P = 0;
				end
				
				else // positive
				begin
					new_N= 0;
					new_Z= 0;
					new_P = 1;
				end
		endcase
	end
	
	always_ff @ (posedge Clk)
	begin
		if (Reset)
		begin
			N <= 1'b0;
			Z <= 1'b0;
			P <= 1'b0;
		end
		else if(LD_CC)
		begin
			N <= new_N;
			Z <= new_Z;
			P <= new_P;
		end
	end
endmodule
	