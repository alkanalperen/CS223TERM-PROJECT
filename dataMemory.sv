`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.12.2020 23:06:28
// Design Name: 
// Module Name: dataMemory
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module dataMemory(
input logic clk,
input logic reset,
input logic WE,
input logic [3:0] A,
input logic [3:0] A2,
input logic [3:0] address,
input logic [3:0] WD,
output logic [7:0] RD,
output logic [7:0] RD2
    );
    logic [7:0] memory [15:0];
    integer j;
    always_ff@(posedge clk)
    begin
    if(WE) memory[address] <= WD;
    if(reset)
    for (j=0; j < 16; j=j+1) begin
            memory[j] <= 8'b0; //reset array
        end
    end
    assign RD = memory[A];
    assign RD2 = memory[A2];
endmodule
