module pc_mux
(	input logic [1:0] sel,
	input logic [15:0] curr_pc, bus, adder,
	output logic [15:0] out
	);
	always_comb
		begin
			case (sel)
				2'b00:
					out= curr_pc + 1'b1;
				2'b01:
					out = bus;
				2'b10:
					out = adder;
				default:
					out = 16'bxxxxxxxxxxxxxxxx;
			endcase
		end
				

endmodule

module bus_mux (
	input logic gate_PC, gate_MDR, gate_ALU, gate_MARMUX,
	input logic [15:0] PC, MDR, ALU, MARMUX,
	output logic [15:0] out );
	logic [3:0] sel;
	always_comb
		begin
		sel = {gate_PC, gate_MDR, gate_ALU, gate_MARMUX};
			case (sel)
				4'b1000:
					out= PC;
				4'b0100:
					out = MDR;
				4'b0010:
					out = ALU;
				4'b0001:
					out = MARMUX;
				default:
					out = 16'bxxxxxxxxxxxxxxxx;
			endcase
		end
endmodule

module dr_mux(
	input logic sel,
	input logic [2:0] IR11_9,
	output logic [2:0] out);
	always_comb
		begin
			case(sel)
				1'b0:
					out = IR11_9;
				1'b1:
					out = 3'b111;
			endcase
		end
endmodule

module adr1_mux(
	input logic sel,
	input logic [15:0] PC, SR1_out,
	output logic [15:0] out);
	always_comb
		begin
			case(sel)
				1'b0:
					out = PC;
				1'b1:
					out = SR1_out;
			endcase
		end
endmodule


module adr2_mux(
	input logic [1:0] sel,
	input logic [15:0] SEXT10_0,
	input logic [15:0] SEXT8_0,
	input logic [15:0] SEXT5_0, 
	output logic [15:0] out);
	always_comb
		begin
			case(sel)
				2'b00:
					out = SEXT10_0;
				2'b01:
					out = SEXT8_0;
				2'b10:
					out = SEXT5_0;
				2'b11:
					out = 16'h0000;
			endcase
		end
endmodule

module sr1_mux (
	input logic sel,
	input logic [2:0] IR11_9, IR8_6,
	output logic [2:0] out);
	always_comb
		begin
			case(sel)
				1'b0:
					out = IR11_9;
				1'b1:
					out = IR8_6;
			endcase
		end
endmodule

module sr2_mux (
	input logic sel,
	input logic [15:0] SR2_out, SEXT4_0,
	output logic [15:0] out);
	always_comb
		begin
			case(sel)
				1'b0:
					out = SR2_out;
				1'b1:
					out = SEXT4_0;
			endcase
		end
endmodule

module mdr_mux (
	input logic sel,
	input logic [15:0] bus, mem2IO,
	output logic [15:0] out);
	always_comb
		begin
			case(sel)
				1'b0:
					out = bus;
				1'b1:
					out = mem2IO;
			endcase
		end
endmodule
	