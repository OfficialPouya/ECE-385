module RegFile(
	input logic LD_REG, Reset, Clk,
	input logic [15:0] in,
	input logic [2:0] SR1, SR2, DR,
	output logic [15:0] SR1_OUT, SR2_OUT);
	
	logic [15:0] R0, R1, R2, R3, R4, R5, R6, R7;
	
	always_ff @ (posedge Clk)
	begin
		if(Reset)
		begin
			R0 <= 16'h0000;
			R1 <= 16'h0000;
			R2 <= 16'h0000;
			R3 <= 16'h0000;
			R4 <= 16'h0000;
			R5 <= 16'h0000;
			R6 <= 16'h0000;
			R7 <= 16'h0000;	
		end
		else if(LD_REG)
		begin
			case(DR)
				3'b000: R0 <= in;
				3'b001: R1 <= in;
				3'b010: R2 <= in;
				3'b011: R3 <= in;
				3'b100: R4 <= in;
				3'b101: R5 <= in;
				3'b110: R6 <= in;
				3'b111: R7 <= in;
			endcase
		end
	end
	
	always_comb
	begin
		case(SR1)
			3'b000: SR1_OUT <= R0;
			3'b001: SR1_OUT <= R1;
			3'b010: SR1_OUT <= R2;
			3'b011: SR1_OUT <= R3;
			3'b100: SR1_OUT <= R4;
			3'b101: SR1_OUT <= R5;
			3'b110: SR1_OUT <= R6;
			3'b111: SR1_OUT <= R7;
		endcase
			
		case(SR2)
			3'b000: SR2_OUT <= R0;
			3'b001: SR2_OUT <= R1;
			3'b010: SR2_OUT <= R2;
			3'b011: SR2_OUT <= R3;
			3'b100: SR2_OUT <= R4;
			3'b101: SR2_OUT <= R5;
			3'b110: SR2_OUT <= R6;
			3'b111: SR2_OUT <= R7;
		endcase
	end
endmodule
	
	