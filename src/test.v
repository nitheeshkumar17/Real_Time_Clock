`timescale 1ns / 1ps

//Testbench for the Real Time Clock module
// Created by Nitheesh Kumar - 09 Aug 2020

module test;


parameter n=5;

// inputs

reg clk, reset;

// outputs

wire [21:0] r_clock;

// DUT Instantiation

rt_clock dut (
	.clk (clk),
	.reset (reset),
	.r_clock(r_clock));

// Clock

initial begin
      clk=1;
#100000 $stop;
end
always begin
#n clk=~clk;
end

// Reset

initial begin

reset = 1;
#10 reset = 0;

end

endmodule
