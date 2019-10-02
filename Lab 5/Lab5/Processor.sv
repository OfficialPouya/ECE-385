module top_level
(
	input logic Clk, // Clock
	input logic Run, // Executes operation
	input logic ClearA_LoadB,
	input logic Reset, // Reset (i.e registers to zero, etc)
	input logic S[7:0],
	
	output  logic[6:0] AhexL, AhexU, BhexL, BhexU,
	output logic X
	);
	
	//local logic variables go here
	logic Reset_SH, ClearA_LoadB_SH, Run_SH, Add, Sub, Ldr_ld
	
	
	
	//Instantiation of modules here
	shift_register RegA ( 
							.Din(S),
							.Clk(Clk),
							.Reset(Reset
							
	