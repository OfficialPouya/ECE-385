module testbench();
timeunit 10ns;
timeprecision 1ns;
//inputs

logic [15:0] S;
logic Clk, Reset, Run, Continue;
logic [11:0] LED;
logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7;
logic CE, UB, LB, OE, WE;
logic [19:0] ADDR;
wire [15:0] Data;
// Clock initialization

always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 0;
end

always begin : CONT_GENERATION
#8 Continue = ~Continue;
end


lab6_toplevel CPU(.*);
initial begin: TEST_VECTORS

// Push buttons active low
Reset = 1;
Continue = 1;
Run =1;


S= 16'h0031;

// Reset
#2 Reset = 0;
#2 Reset =1;

#2 Run = 0;
#2 Run = 1;

#120 S= 16'h0004;
#38 S= 16'h0002;

end
endmodule
/////////////////////////////////// LC3 TESTING ///////////////
/*
lab6_toplevel CPU(.*);


initial begin: TEST_VECTORS
// Push buttons active low
Reset = 1;
Continue = 1;
Run =1;

// Reset
#2 Reset = 0;
#2 Reset =1;

#2 Run = 0;
#2 Run = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

#8 Continue = 0;
#2 Continue = 1;

end

endmodule

*/