module control_unit
(
	input logic Reset, Clk, Run, ClearA_LoadB, M,
	output logic Shift_En, Add, Sub, Clr_Ld);
	assign Clr_Ld = ClearA_LoadB;
	enum logic [4:0] 
	{	START, END,
		S1, S2, S3, S4, S5, S6, S7, S8, 
		A1, A2, A3, A4, A5, A6, A7, SUB } curr_state, next_state;
		assign Clr_Ld = ClearA_LoadB;
		always_ff @ (posedge Clk or posedge Reset)
		begin
			if (Reset)
				if (Run)
					curr_state <= END;
				else
					curr_state <= START;
			else
				curr_state <= next_state;`
		end
		always_comb
		begin
			next_state = curr_state;
			unique case (curr_state)
				START:
					if (Run)
						if(M)
							next_state <= A1;
						else
							next_state <=S1;
					else
						next_state <= START;
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

			case (curr_state)
				START: begin
					Shift_En=0;
					Add=0;
					Sub=0;
				end
				END: begin
					Shift_En=0;
					Add=0;
					Sub=0;
				end
				
				S1: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S2: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S3: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S4: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S5: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S6: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S7: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				S8: begin
					Shift_En=1;
					Add=0;
					Sub=0;
				end
				
				
				A1: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A2: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A3: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A4: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A5: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A6: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				A7: begin
					Shift_En=0;
					Add=1;
					Sub=0;
				end
				
				SUB: begin
					Shift_En=0;
					Add=0;
					Sub=1;
				end
				default: begin
					Shift_En=0;
					Add=0;
					Sub=0;
				end		
			endcase
		end
endmodule
					
				