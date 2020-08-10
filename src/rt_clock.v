`timescale 1ns / 1ps

// Real Time Clock
// Created by Nitheesh Kumar - 09 Aug 2020

module rt_clock (
	input clk,
	input reset,
	output reg [21:0] r_clock);

//reg [3:0] HR_L, MIN_M, MIN_L, SEC_M, SEC_L;
//reg [1:0] HR_M;
reg [5:0] condition;

always @(posedge clk) begin
if (reset) begin
r_clock <= 22'h00_00_00;
condition <= 6'h0;
end
else begin
/*
condition[0] <= (r_clock[3:0] >= 4'h9);
condition[1] <= (r_clock[7:4] >= 4'h5) && (condition[0]);
condition[2] <= (r_clock[11:8] >= 4'h9) && (&condition[1:0]);
condition[3] <= (r_clock[15:12] >= 4'h5) && (&condition[2:0]);
condition[4] <= (r_clock[19:16] >= 4'h9) && (&condition[3:0]);
condition[5] <= (r_clock[21:16] >= 6'h23) && (&condition[3:0]);
*/
// Seconds

if (r_clock[3:0] == 4'h9) begin
r_clock[3:0] <= 4'h0;
end
else begin
r_clock[3:0] <= r_clock[3:0] + 4'h1;
end

if (r_clock[3:0] == 4'h9) begin
if (r_clock[7:4] == 4'h5) begin
r_clock[7:4] <= 4'h0;
end
else begin
r_clock[7:4] <= r_clock[7:4] + 4'h1;
end
end
else begin
r_clock[7:4] <= r_clock[7:4];
end

// Minutes

if (r_clock[7:4] == 4'h5 && r_clock[3:0] == 4'h9) begin
if (r_clock[11:8] == 4'h9) begin
r_clock[11:8] <= 4'h0;
end
else begin
r_clock[11:8] <= r_clock[11:8] + 4'h1;
end
end
else begin
r_clock[11:8] <= r_clock[11:8];
end

if (r_clock[7:4] == 4'h5 && r_clock[3:0] == 4'h9 && r_clock[11:8] == 4'h9) begin
if (r_clock[15:12] == 4'h5) begin
r_clock[15:12] <= 4'h0;
end
else begin
r_clock[15:12] <= r_clock[15:12] + 4'h1;
end
end
else begin
r_clock[15:12] <= r_clock[15:12];
end

// Hours

if (r_clock[7:4] == 4'h5 && r_clock[3:0] == 4'h9 && r_clock[11:8] == 4'h9 && r_clock[15:12] == 4'h5) begin
if (r_clock[19:16] == 4'h9) begin
r_clock[19:16] <= 4'h0;
end
else begin
r_clock[19:16] <= r_clock[19:16] + 4'h1;
end
end
else begin
r_clock[19:16] <= r_clock[19:16];
end

if (r_clock[7:4] == 4'h5 && r_clock[3:0] == 4'h9 && r_clock[11:8] == 4'h9 && r_clock[15:12] == 4'h5 && r_clock[19:16] == 4'h9) begin
r_clock[21:20] <= r_clock[21:20] + 2'h1;
end
else if (r_clock[21:20] == 2'h2 && r_clock[7:4] == 4'h5 && r_clock[3:0] == 4'h9 && r_clock[11:8] == 4'h9 && r_clock[15:12] == 4'h5 && r_clock[19:16] == 4'h3) begin
r_clock[21:20] <= 4'h0;
r_clock[19:16] <= 4'h0;
end
else begin
r_clock[21:20] <= r_clock[21:20];
end

end

end

endmodule
