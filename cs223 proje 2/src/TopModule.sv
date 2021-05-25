`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2020 01:42:58 PM
// Design Name: 
// Module Name: TopModule
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


module TopModule(
        input logic clk,
        input middleB,
        input upB,
        input leftB,
        input rightB,
        input downB,
        input [15:0]sw,
//out put 7segment
        output logic [6:0] seg, 
        output logic dp, 
        output logic [3:0]an,
        output logic [15:0]led
    );

    logic rightButtonPushed, leftButtonPushed, downButtonPushed, middleButtonPushed,upButtonPushed;
    debounce debounceModuleForRight(clk, rightB, rightButtonPushed);
    debounce debounceModuleForLeft(clk, leftB, leftButtonPushed);
    debounce debounceModuleForDown(clk, downB, downButtonPushed);
    debounce debounceModuleForMid(clk, middleB, middleButtonPushed);
    debounce debounceModuleForUp(clk, upB, upButtonPushed);


    
    logic [15:0] instructions; 
    
    //instruction memory
    logic [4:0]Ains;
    logic [15:0]RDinst;
        logic [15:0]RDinst2;

    
    //reg File
    logic regWE; 
    logic [3:0] A1reg;
    logic [3:0] A2reg;
    logic [7:0 ]RD1reg; 
    logic [7:0] RD2reg; 
    logic [3:0] A3reg;
    logic [3:0] WDreg;
    
    //mem 
    logic memWE; 
    logic [3:0] Amem;
    logic [3:0] Amem0;
    logic [7:0] RDmem; 
    logic [3:0] Areg;
    logic [7:0] WDmem;
    
    //controller
    logic  MemWrite;
    logic  W1;
    logic  W2;
    logic  W3;
    logic  memo;
    logic  ALUCONTROL;
    logic  Branch;
    logic  MemToReg;
    logic  RegWrite;
    logic  [3:0]Data;
    logic  [3:0]Adress;
    logic [3:0]newAins;
    logic jmp;
    logic reset;
    logic takeFromSw;
 //ALU
 logic oALU;
 //to reg
 logic toReg;
 // 7.4 or 11.8
 logic oMux;
    logic [15:0]cntInput;
    logic [3:0]Amem2;
    logic [7:0]RDmem2;
    initial begin
    RDinst2 = 0;
    Amem2=0;
    RDmem2 =0;
    takeFromSw = 0;
    reset = 0;
    rightButtonPushed = 0;
    newAins = Ains;
    leftButtonPushed = 0;
    downButtonPushed = 0;
    upButtonPushed = 0;
    middleButtonPushed = 0;
    Adress = 0;
    Data = 0; 
    Amem = 0;
    jmp = 0;
    cntInput = 0;

    Ains[4:0]=0;
    RDinst[15:0] = 0;

    //controller
      MemWrite=0;
      W1=0;
      W2=0;
      W3=0;
      memo=0;
      ALUCONTROL=0;
      Branch=0;
      MemToReg=0;
      RegWrite=0;
      WDmem = 0;
      RDmem = 0;
    end
       
  
    
    always_ff@ (posedge clk) begin
    if (rightButtonPushed) begin 
    takeFromSw <= 0;
    reset <= 0;
        if (Amem < 15)
            Amem <= Amem + 1; 
        else 
            Amem <= 0; 
    end 
    else if (leftButtonPushed)begin 
      takeFromSw <= 0;
     reset <= 0;
        if (Amem > 0) 
            Amem <= Amem - 1; 
        else 
            Amem <= 15; 
    end
    //next instruction
    else if(downButtonPushed)begin
        takeFromSw <= 0;
        reset <= 0;
       if(jmp)
            Ains <= RDinst[12:8];
        else if (Ains < 32)
            Ains <= Ains + 1; 
        else 
            Ains <= 0; 
    end
    else if (upButtonPushed)begin
    reset <= 1;
       takeFromSw <= 0;
   end
    else if(middleButtonPushed)begin
    takeFromSw <= 1;
     reset <= 0;
    end
   end  
    
   instruction instruction(clk, Ains, RDinst,RDinst2);
    assign led = RDinst2;
    //Scp
     always_ff@ (posedge clk) 
    if(takeFromSw)
        cntInput <= sw;
    else
        cntInput <= RDinst;
    controller controller(clk, RDinst,RD1reg,RD2reg,RDmem2,
    ALUCONTROL, Branch, regWrite, memWrite, Adress,Data,jmp);

    registerFile register(clk,reset, regWrite, RDinst[7:4], RDinst[3:0],Adress,Data ,RD1reg, RD2reg);

    dataMemory memoryModule(clk,reset, memWrite, Amem, RDinst[3:0], Adress, Data, RDmem,RDmem2); 
    
    SevSeg_4digit displayModule(clk, Amem, 17, RDmem[7:4], RDmem[3:0], seg, dp, an);

endmodule
