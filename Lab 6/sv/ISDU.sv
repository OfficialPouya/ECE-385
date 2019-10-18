//------------------------------------------------------------------------------
// Company:          UIUC ECE Dept.
// Engineer:         Stephen Kempf
//
// Create Date:    17:44:03 10/08/06
// Design Name:    ECE 385 Lab 6 Given Code - Incomplete ISDU
// Module Name:    ISDU - Behavioral
//
// Comments:
//    Revised 03-22-2007
//    Spring 2007 Distribution
//    Revised 07-26-2013
//    Spring 2015 Distribution
//    Revised 02-13-2017
//    Spring 2017 Distribution
//------------------------------------------------------------------------------
`include "SLC3_2.sv"
import SLC3_2::*;

module ISDU (   input logic         Clk, 
									Reset,
									Run,
									Continue,
									
				input logic[3:0]    Opcode, 
				input logic         IR_5,
				input logic         IR_11,
				input logic         BEN,
				  
				output logic        LD_MAR,
									LD_MDR,
									LD_IR,
									LD_BEN,
									LD_CC,
									LD_REG,
									LD_PC,
									LD_LED, // for PAUSE instruction
									
				output logic        GatePC,
									GateMDR,
									GateALU,
									GateMARMUX,
									
				output logic [1:0]  PCMUX,
				output logic        DRMUX,
									SR1MUX,
									SR2MUX,
									ADDR1MUX,
				output logic [1:0]  ADDR2MUX,
									ALUK,
				  
				output logic        Mem_CE,
									Mem_UB,
									Mem_LB,
									Mem_OE,
									Mem_WE
				);

	enum logic [5:0] { 	
						Halted, 
						S_13_1, 
						S_13_2,
						S_18, 
						S_33_1, 
						S_33_2, 
						S_35, 
						S_32, 
						S_01,
						S_05,
						S_09,
						S_06,
						S_25_1, 
						S_25_2,
						S_27,
						S_07,
						S_23,
						S_16_1, 
						S_16_2, 
						S_16_3,
						S_00,
						S_22,
						S_12,
						S_04,
						S_21}   State, Next_state;   // Internal state logic
		
	always_ff @ (posedge Clk)
	begin
		if (Reset) 
			State <= Halted;
		else 
			State <= Next_state;
	end
   
	always_comb
	begin 
		// Default next state is staying at current state
		Next_state = State;
		
		// Default controls signal values
		LD_MAR = 1'b0;
		LD_MDR = 1'b0;
		LD_IR = 1'b0;
		LD_BEN = 1'b0;
		LD_CC = 1'b0;
		LD_REG = 1'b0;
		LD_PC = 1'b0;
		LD_LED = 1'b0;
		 
		GatePC = 1'b0;
		GateMDR = 1'b0;
		GateALU = 1'b0;
		GateMARMUX = 1'b0;
		 
		ALUK = 2'b00;
		 
		PCMUX = 2'b00;
		DRMUX = 1'b0;
		SR1MUX = 1'b0;
		SR2MUX = 1'b0;
		ADDR1MUX = 1'b0;
		ADDR2MUX = 2'b00;
		 
		Mem_OE = 1'b1;
		Mem_WE = 1'b1;
	
		// Assign next state
		
		unique case (State)
			// HALT //
			Halted : 
				if (Run) 
					Next_state = S_18;   
			// FETCH //
			S_18 : 
				Next_state = S_33_1;
		
			S_33_1 : 
				Next_state = S_33_2;
			S_33_2 : 
				Next_state = S_35;
			S_35 : 
				Next_state = S_32;
			
			
			//DECODE
			S_32 : 
				case (Opcode)
					op_ADD : // ADD
						Next_state = S_01;
					op_AND : // AND
						Next_state = S_05;
					op_NOT: // NOT
						Next_state = S_09;
					op_BR: // BR
						Next_state = S_00;
					op_JMP: // JMP
						Next_state = S_12;
					op_JSR: // JSR
						Next_state = S_04;
					op_LDR: // LDR
						Next_state = S_06;
					op_STR: // STR
						Next_state = S_07;
					op_PSE: // PAUSE
						Next_state = S_13_1;
					default : Next_state = S_18;
				endcase
			// PAUSE //
			S_13_1 : 
				if (~Continue) 
					Next_state = S_13_1;
				else 
					Next_state = S_13_2;
			S_13_2 : 
				if (Continue) 
					Next_state = S_13_2;
				else 
					Next_state = S_18;
			// ADD //
			S_01 : 
				Next_state = S_18;
			// AND //
			S_05: 
				Next_state = S_18;
			// NOT //
			S_09: 
				Next_state = S_18;
			// LDR //
			S_06: 
				Next_state = S_25_1;
			S_25_1: 
				Next_state = S_25_2;
			S_25_2: 
				Next_state = S_27;
			S_27:
				Next_state = S_18;
				
			// STR //
			S_07:
				Next_state = S_23;
			S_23:
				Next_state = S_16_1;
			S_16_1:
				Next_state = S_16_2;
			S_16_2:
				Next_state = S_16_3;
			S_16_3:
				Next_state = S_18;
			// BR //
			 S_00:
			 begin
				if(BEN)
					Next_state = S_22;
				else
					Next_state = S_18;
			end
			 S_22:
				Next_state = S_18; 
			// JMP //
			S_12:
				Next_state = S_18;
			// JSR //
			S_04:
				Next_state = S_21;
			S_21:		
				Next_state = S_18;
			default : ;
		endcase
		
		// Assign control signals based on current state
		case (State)
			// HALT
			Halted: ;
			
			// FETCH //
			S_18 : // MAR = PC
					// PC = PC+1
				begin 
					GatePC = 1'b1;
					LD_MAR = 1'b1;
					PCMUX = 2'b00;
					LD_PC = 1'b1;
					
				end
			S_33_1 : //MDR = M[MAR];
				Mem_OE = 1'b0;

			S_33_2 : 
				begin 
					Mem_OE = 1'b0;
					LD_MDR = 1'b1;
				end
			S_35 : 
				begin 
					GateMDR = 1'b1;
					LD_IR = 1'b1;
				end

			
			//DECODE
			S_32 : 
				LD_BEN= 1;
			
			// PAUSE //
			S_13_1 : LD_LED = 1'b1;
				
			S_13_2 : LD_LED = 1'b1;
			
			
					
			// ADD //
			S_01 : 
				begin
				ALUK = 2'b00;
				GateALU = 1;
				SR2MUX = IR_5;
				SR1MUX = 1'b1;
				LD_REG = 1;
				LD_CC = 1;
				end
				
			// AND //
			S_05:
				begin
				ALUK = 2'b10;
				GateALU = 1;
				SR2MUX = IR_5;
				SR1MUX = 1'b1;
				LD_REG = 1;
				LD_CC = 1;
				end
			// NOT //
			S_09:
				begin
				ALUK = 2'b01;
				GateALU = 1;
				SR2MUX = IR_5;
				SR1MUX = 1'b1;
				LD_REG = 1;
				LD_CC = 1;
				end
				
			// LDR //
			S_06:
				begin
				ADDR1MUX= 1'b1;
				ADDR2MUX= 2'b10;
				SR1MUX= 1'b1;
				GateMARMUX= 1'b1;
				LD_MAR = 1;
				end
			S_25_1:
				Mem_OE = 1'b0;
			
			S_25_2:
				begin
				Mem_OE = 1'b0;
				LD_MDR = 1;
				end
			S_27:
				begin
				GateMDR = 1'b1;
				LD_REG = 1;
				LD_CC = 1;
				end
				
			// STR //
			S_07:
				begin
				GateMARMUX =1;
				LD_MAR =1;
				SR1MUX = 1'b1;
				ADDR1MUX= 1'b1;
				ADDR2MUX= 2'b10;
				end
				
				
			S_23: 
				begin
				GateALU =1;
				LD_MDR = 1;
				SR1MUX = 1'b0;
				ALUK= 2'b11;
				end
				
				
				
			S_16_1: Mem_WE =0;
				
			S_16_2: Mem_WE =0;
			
			S_16_3: Mem_WE =0;
				
			// BR //
			S_00: ;
				
				
			S_22: 
				begin
				LD_PC=1;
				ADDR1MUX= 0;
				ADDR2MUX = 2'b01;
				PCMUX = 2'b10;
				end
				
			// JMP //
			S_12: 
				begin
				LD_PC =1;
				PCMUX =2'b10;
				SR1MUX = 1'b1;
				ADDR1MUX = 1'b1;
				ADDR2MUX = 2'b11;
				end
				
			// JSR //
			S_04:
				begin
				GatePC=1;
				LD_REG =1;
				DRMUX= 1'b1;
				end
				
			S_21:	
				begin
				ADDR1MUX = 1'b0;
				ADDR2MUX= 2'b00;
				PCMUX = 2'b10;
				LD_PC = 1'b1;
				end
				
			default : ;
		endcase
	end 

	 // These should always be active
	assign Mem_CE = 1'b0;
	assign Mem_UB = 1'b0;
	assign Mem_LB = 1'b0;
	
endmodule
