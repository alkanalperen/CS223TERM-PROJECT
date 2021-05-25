`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.12.2020 13:45:47
// Design Name: 
// Module Name: DataPath
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


module DataPath(
    input clk,
    input [15:0] RDinst,
    input W1,W2,W3,ALUCONTROL,Branch,MemToReg,regWE,memWE,memo,
    output [3:0]Amem,
    output [7:0]RDmem
    );
    logic oMux;
    logic toReg;
    logic LRDmem;
    
    initial begin
    oMux = 0;
    toReg = 0;
    LRDmem = 0;
    end
   registerFile register(clk, regWE, RDinst[7:4], RDinst[3:0],oMux,WDreg ,RD1reg, RD2reg);
    mux(RDinst[11:8],RDinst[7:4],W1,oMux);
    mux(RDinst[7:0],toReg,W2,WDreg);
    mux(RDinst[7:0],RD2reg,W3,Amem);
    mux(oMux,RDinst[3:0],memo,Amem);
    mux(RDmem,oALU,MemToreg,toReg);

   dataMemory memoryModule(clk, memWE, oMux, WDmem,LRDmem );
   assign Amem = oMux;
   assign RDmem = LRDmem; 

endmodule
