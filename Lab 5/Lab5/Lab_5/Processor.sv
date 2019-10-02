module Processor
(
	input logic Clk, // Clock
	input logic Run, // Executes operation
	input logic ClearA_LoadB,
	input logic Reset, // Reset (i.e registers to zero, etc)
	input logic[7:0] S,
	output  logic[6:0] AhexL, AhexU, BhexL, BhexU,
	output logic X
	);
	
	//local logic variables go here
	logic Reset_SH, ClearA_LoadB_SH, Run_SH; // Sync HIGH for push buttons
	logic Shift_En, Add, Sub, Clr_XA, Clr_B, Ld_B; // Logic for control unit
	logic [7:0] A, B; // Registers A, B
	logic [8:0] Sum; // Output of Add/Sub module
	logic [7:0] S_S; // Sync LOW for switches
	logic A_shift_out;


	
	
	one_register X_reg ( .in(Sum[8]),
								.clk(Clk), 
								.reset(Clr_XA),
								.load (Add), 
								.out(X));
	
	
	nine_bit_adder add_sub (		.A(A), 
									.B(S_S), 
									.Sel(Sub), 
									.Sum(Sum));
									
	eight_shift_register reg_A (	.Din(Sum[7:0]), 
									.clk(Clk), 
									.reset(Clr_XA),
									.load(Add), 
									 .shift_en(Shift_En),
									.shift_in(X), 
									.shift_out(A_shift_out), 
									.Dout(A));
									
	eight_shift_register reg_B  (   .Din(S_S), 
									.clk(Clk), 
									.reset(Clr_B),
									.load(Ld_B), 
									.shift_en(Shift_En), 
									.shift_in(A_shift_out), 
									.Dout(B));
									
	control_unit FSM (.Reset(Reset_SH),
							.Clk(Clk),
							.Run(Run_SH),
							.ClearA_LoadB(ClearA_LoadB_SH),
							.M(B[1]),
							.M_init(B[0]),
							.Shift_En(Shift_En),
							.Sub(Sub),
							.Clr_XA(Clr_XA),
							.Clr_B(Clr_B),
							.Ld_B(Ld_B),
							.Add(Add));
	
	HexDriver HexAL (.In0(A[3:0]),.Out0(AhexL) );
	HexDriver HexBL (.In0(B[3:0]), .Out0(BhexL) );							
	HexDriver HexAU (.In0(A[7:4]), .Out0(AhexU) );	
	HexDriver HexBU (.In0(B[7:4]), .Out0(BhexU) );
								
	
								
								
	sync button_sync[2:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH, Run_SH});
	sync S_sync[7:0] (Clk, S, S_S);
	

endmodule
