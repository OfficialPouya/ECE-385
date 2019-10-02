module control_unit
(
	input logic Reset, Clk, Run, ClearA_LoadB, M, M_init,
	output logic Shift_En, Clr_XA, Clr_B, Ld_B, Sub, Add);
	logic initialize;
	
	enum logic [4:0] 
	{	START, END, INIT,
		S1, S2, S3, S4, S5, S6, S7, S8, 
		A1, A2, A3, A4, A5, A6, A7, SUB} curr_state, next_state;
		
		assign Clr_XA = Reset + ClearA_LoadB+ initialize;
		assign Clr_B = Reset;
		assign Ld_B = ClearA_LoadB;
		
		always_ff @ (posedge Clk)
		begin
			
			if (Reset)
				if (Run)
					curr_state <= END;
				else
					curr_state <= START;
			else
				curr_state <= next_state;
		end
		always_comb
		begin
			///// STATE TRANSITIONS //////
			next_state = curr_state;
			unique case (curr_state)
				START:
					if (Run)
						next_state <= INIT;
					else
						next_state <= START;
				INIT:
					if(M_init)
							next_state <= A1;
						else
							next_state <=S1;
				END:
					if (Run)
						next_state <= END;
					else
						next_state <= START;
				S1:
					if (M)
						next_state <= A2;
					else
						next_state <= S2;
				S2:
					if (M)
						next_state <= A3;
					else
						next_state <= S3;
				S3:
					if (M)
						next_state <= A4;
					else
						next_state <= S4;
				S4:
					if (M)
						next_state <= A5;
					else
						next_state <= S5;
				S5:
					if (M)
						next_state <= A6;
					else
						next_state <= S6;
				S6:
					if (M)
						next_state <= A7;
					else
						next_state <= S7;
				S7:
					if (M)
						next_state <= SUB;
					else
						next_state <= S8;
				S8:
					next_state <= END;
				// ADD/ LOAD SEQUENCE //
				A1:
					next_state <= S1;
					
				A2:
					next_state <= S2;
					
				A3:
					next_state <= S3;
				
					
				A4:
					next_state <= S4;
			
				
				A5:
					next_state <= S5;
				
					
				A6:
					next_state <= S6;
				
				
				A7:
					next_state <= S7;
					
					
				SUB:
					next_state <= S8;
			endcase
			
			///// STATE OUTPUTS //////
			case (curr_state)
				START: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=0;
					
				end
				
				INIT: begin
					initialize =1;
					Shift_En=0;
					Sub=0;
					Add=0;
				end
				
				END: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=0;
				end
				
				S1: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S2: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S3: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S4: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S5: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S6: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S7: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				S8: begin
					initialize=0;
					Shift_En=1;
					Sub=0;
					Add=0;
				end
				
				
				A1: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;
				end
				
				A2: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;
				end
				
				A3: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;
				end
	
				
				A4: begin
					initialize=0;
					Shift_En=0;
					Add=1;
					Sub=0;
				end

				A5: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;

				end
				
				A6: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;
				end
				
				A7: begin
					initialize=0;
					Shift_En=0;
					Sub=0;
					Add=1;
				end
				
				
				SUB: begin
					initialize=0;
					Shift_En=0;
					Sub=1;
					Add=1;
				end
				
				default: begin
					initialize=0;
					Shift_En=0;
					Add=0;
					Sub=0;
					
				end		
			endcase
		end
endmodule
					
				