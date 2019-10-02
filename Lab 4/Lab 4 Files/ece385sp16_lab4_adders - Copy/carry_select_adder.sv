//module carry_select_adder
//(
//    input   logic[15:0]     A,
//    input   logic[15:0]     B,
//    output  logic[15:0]     Sum,
//    output  logic           CO
//);
//
//	logic c0, c1, c2;
//	select_adder SA_0(.A (A[3:0]), .B(B[3:0]), .select(0), .sum(Sum[3:0]), .c(c0));
//	select_adder SA_1(.A (A[7:4]), .B(B[7:4]), .select(c0), .sum(Sum[7:4]), .c(c1));
//	select_adder SA_2(.A (A[11:8]), .B(B[11:8]), .select(c1), .sum(Sum[11:8]), .c(c2));
//	select_adder SA_3(.A (A[15:12]), .B(B[15:12]), .select(c2), .sum(Sum[15:12]), .c(CO));
//endmodule
//
//
// 
//module mux2to1(
//		input [3:0] A,
//		input [3:0] B,
//		input	select,
//		output [3:0] sum 
//				);
//		always_comb
//		begin
//		if(select==0) 
//				sum=A;
//			else
//				sum=B;
//		end		
//endmodule
//
//	
//					
//
////module select_adder(
////		input [3:0] A,
////		input [3:0] B,
////		input	select,
////		output [3:0] sum
////		);
////logic c0, c1; 
////logic sum0, sum1;
////
////
////full_adder FA_1(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(sum0), .cout(c0));
////full_adder FA_2(.x(A[3:0]), .y(B[3:0]), .cin(0), .s(sum1), .cout(c1));
////
////mux2to1 (.A(sum0), .B(sum1), .select(select), .sum(sum) );
////assign cout=(select&c1) | c0;
//
//					
//endmodule	
//
//
//

