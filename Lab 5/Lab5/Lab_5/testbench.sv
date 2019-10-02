
module testbench();

timeunit 10ns;	// Half clock cycle at 50 MHz
		// This is the amount of time represented by #1 
timeprecision 1ns;

// These signals are internal because the processor will be 
// instantiated as a submodule in testbench.
logic Clk; // Clock
logic Run; // Executes operation
logic ClearA_LoadB;
logic Reset; // Reset (i.e registers to zero, etc)
logic[7:0] S;
logic[6:0] AhexL, AhexU, BhexL, BhexU;
logic X;


Processor processor0(.*);

// Toggle the clock
// #1 means wait for a delay of 1 timeunit
always begin : CLOCK_GENERATION
#1 Clk = ~Clk;
end

initial begin: CLOCK_INITIALIZATION
Clk = 0;
end 

// All switches not pressed initially, Din switches set to x04
initial begin: TEST_VECTORS
Run= 1;
ClearA_LoadB=1;
Reset=1;


/////////////////////////////////////////////////////////
// TEST CASE 1: 12*9
//Toggle Reset

#2 Reset=0;
#2 Reset=1;
 
 // Set switches to +9
 S= 8'b0001001; 
// Load +9 into B
#2 ClearA_LoadB=0;
#2 ClearA_LoadB=1;

// Set switches to +12
#2 S= 8'b0001100;

//Run 12*9
#2 Run=0;
#2 Run=1;

/////////////////////////////////////////////////////////
// TEST CASE 2: 12*-9
//Toggle Reset
#40 Reset=0;
#2 Reset=1;

// Set switches to -9
#2 S= 8'b11110111;

// Load -9 into B
#2 ClearA_LoadB=0;
#2 ClearA_LoadB=1;

// Set switches to +12
#2 S= 8'b0001100;

//Run 12*-9
#2 Run=0;
#2 Run=1;

/////////////////////////////////////////////////////////
// TEST CASE 3: -12*9
//Toggle Reset
#40 Reset=0;
#2 Reset=1;

// Set switches to +9
 S= 8'b0001001; 

// Load +9 into B
#2 ClearA_LoadB=0;
#2 ClearA_LoadB=1;

// Set switches to -12
#2 S= 8'b11110100;

//Run -12*9
#2 Run=0;
#2 Run=1;

/////////////////////////////////////////////////////////
// TEST CASE 4: -12*-9
//Toggle Reset
#40 Reset=0;
#2 Reset=1;

// Set switches to -9
#2 S= 8'b11110111;

// Load +9 into B
#2 ClearA_LoadB=0;
#2 ClearA_LoadB=1;

// Set switches to -12
#2 S= 8'b11110100;

//Run -12*-9
#2 Run=0;
#2 Run=1;

/////////////////////////////////////////////////////////
// TEST CASE 4: -1*-1 (consecutive multiplication)
//Toggle Reset
#40 Reset=0;
#2 Reset=1;

// Set switches to -1
#2 S= 8'b11111111;

// Load -1 into B
#2 ClearA_LoadB=0;
#2 ClearA_LoadB=1;

// Set switches to -1
#2 S= 8'b11111111;

//Run -1*-1
#2 Run=0;
#2 Run=1;

//Result = 1. Now multiply by 1*-1 without clearing 
//Run 1*-1
#40 Run=0;
#2 Run=1;

//Result = -1. Now multiply by -1*-1 without clearing 
//Run -1*-1
#40 Run=0;
#2 Run=1;




end
endmodule


