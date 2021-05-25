`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2020 12:18:57 AM
// Design Name: 
// Module Name: register
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


module registerFile(
    input logic clk,
    input logic reset,
    input logic writeEnable,
    input logic[3:0] A1,
    input logic[3:0] A2,
    input logic[3:0] A3,
    input logic[7:0] WD3,
    output logic[7:0] RD1,
    output logic[7:0] RD2
    );
    logic [7:0] registerArr [15:0];
    integer j;
    always_ff@ (posedge clk)
    begin
        if(writeEnable) registerArr[A3] <= WD3;
        if(reset)
        for (j=0; j < 16; j=j+1) begin
            registerArr[j] <= 8'b0; //reset array
        end
       end
    assign RD1 = registerArr[A1];
    assign RD2 = registerArr[A2];

endmodule
