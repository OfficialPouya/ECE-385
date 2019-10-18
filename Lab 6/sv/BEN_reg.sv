module BEN_reg(
	input logic [2:0] IR_nzp,
	input logic N, Z, P,
	input logic Clk, Reset, LD_BEN,
	output logic BEN);

	always_ff @ (posedge Clk)
	begin
		if(Reset)
			BEN <= 1'b0;
		else if (LD_BEN)
			BEN <= (N & IR_nzp[2]) //n
				+  (Z & IR_nzp[1]) //z
				+  (P & IR_nzp[0]) ; //p
	end
endmodule
			
	