`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2020 01:24:49 AM
// Design Name: 
// Module Name: controller
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


module controller(
        input logic clk,
        input logic [15:0]RDinst,
        input logic [3:0]regData1,
        input logic [3:0]regData2,
        input logic [3:0]memData,
        output logic ALUCONTROL,
        output logic Branch,
        output logic regWrite,
        output logic memWrite,
        output logic [3:0]Adress,
        output logic [3:0]Data,
        output logic jmp
    );
    //local
    logic [3:0]LAdress;
    logic LALUCONTROL;
    logic LBranch;
    logic LregWrite;
    logic LmemWrite;
    logic [3:0]LData;
    logic [4:0]LAins;
    logic Ljmp;

initial begin
    LAdress =0;
    LALUCONTROL= 0;
    LBranch = 0;
    Ljmp = 0;
    LregWrite = 0;
    LmemWrite = 0;
    LData = 0;
end
    
      
      always_ff@ (posedge clk)
      begin
      if(RDinst[15:12] == 1)
      begin
      Ljmp <=0;
      LmemWrite <= 1;
      LregWrite <= 0;
      LAdress <= RDinst[11:8];
      LData <= RDinst[7:0];
      end
      else if(RDinst[15:12] == 0)
      begin
      Ljmp <=0;
      LmemWrite <= 1;
      LregWrite <= 0;
      LAdress <= RDinst[7:4];
      LData <= regData2;
      end
      else if(RDinst[15:12] == 3)
      begin
      Ljmp <=0;
      LregWrite <= 1;
      LmemWrite <= 0;
      LAdress <= RDinst[11:8];
      LData <= RDinst[7:0];
      end
      else if(RDinst[15:12] == 2)
      begin
      Ljmp <=0;
      LregWrite <= 1;
      LmemWrite <= 0;
      LAdress <= RDinst[7:4];
      LData <= memData;
      end
      else if(RDinst[15:12] == 4 || RDinst[15:12] == 5)
      begin
      Ljmp <=0;
      LregWrite <= 1;
      LmemWrite <= 0;
      LAdress <= RDinst[11:8];
      LData <= regData2+regData1;
     end
      else if((RDinst[15:12] == 10 || RDinst[15:12] == 11) && (regData2 == regData1 ))
      begin
      Ljmp <= 1;
      LregWrite <= 0;
      LmemWrite <= 0;
      end
      else
      begin
      Ljmp <= 0;
      LregWrite <= 0;
      LmemWrite <= 0;
      end
      end
      

      

assign ALUCONTROL = LALUCONTROL;
assign memWrite = LmemWrite;
assign regWrite = LregWrite;
assign Branch = LBranch;
assign Data = LData;
assign Adress = LAdress;
assign newAins = LAins;
assign jmp = Ljmp;

endmodule
