`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/18/2020 01:21:38 AM
// Design Name: 
// Module Name: instruction
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


module instruction(
    input logic clk,
    input logic[4:0] readAddress,
    output logic [15:0] readData,
    output logic [15:0] readData2
    
    );
    logic [15:0] instructions [31:0];
    always_ff@ (posedge clk)begin
        instructions[0] = 16'b001_1_0000_0000_0100; //Load 4 to RF[0]
        instructions[1] = 16'b001_1_0001_0000_0101; //Load 5 to RF[1]
        instructions[2] = 16'b000_0_0000_0000_0000; //Store RF[0] to DM[0]
        instructions[3] = 16'b000_0_0000_0001_0001; //Store RF[1] to Dm[1]
        instructions[4] = 16'b001_1_0100_00000010; //Load 2 to RF[4]
        instructions[5] = 16'b001_1_0101_00000011; //Load 3 to RF[5]
        instructions[6] = 16'b000_0_0000_0000_0100; //Store RF[4] to DM[0]
        instructions[7] = 16'b000_0_0000_0001_0101; //Store RF[5] to DM[1]

        instructions[8] = 16'b001_0_0000_0000_0000; //Load DM[0] to RF[0]
        instructions[9] = 16'b001_0_0000_0001_0001; //Load DM[1] to RF[1]
        instructions[10] = 16'b001_1_0010_00000000; //Load 0 immediately to RF[2]
        instructions[11] = 16'b001_1_1111_00000000; //Load 0 immediately to RF[15]
        instructions[12] = 16'b001_1_0100_00000001; //Load 1 immediately to RF[4]
        instructions[13] = 16'b101_10001_0010_0001; //Branch to IM[16] if RF[2] == RF[1]
        instructions[14] = 16'b010_0_1111_1111_0000; //Add RF[15] += RF[0]
        instructions[15] = 16'b010_0_0010_0010_0100; //Add RF[2] += RF[4]
        instructions[16] = 16'b101_01101_0000_0000; //Branch to IM[13] if RF[0] == RF[0]
        instructions[17] = 16'b000_0_0000_0011_1111; //Store RF[3] to DM[3]
        instructions[18] = 16'b111_0_0000_0011_0011; //Stop Code
        instructions[19] = 16'b001_1_0000_0000011; //Stop Code
//    instructions[0] <= 16'b0001_0000_00000110; //wait
//    instructions[1] <= 16'b0001_0001_00000010; //wait
//    instructions[2] <= 16'b001_0_0000_0000_0000; //to reg0  writeto mem0
//    instructions[3] <= 16'b001_0_0000_0001_0001; //to reg 1 write to mem1 1 
    
//    instructions[4] <= 16'b010_1_0011_0000_0000; // ad reg0 reg 0 to reg 3
//    instructions[5] <= 16'b000_0_0011_0100_0011; //mem4 is reg3
//    instructions[7] <= 16'b010_1_0100_0001_0001; // ad reg1 reg 1 to reg 3
//    instructions[8] <= 16'b000_0_0011_0101_0100; //mem5 is reg3

//    instructions[6] <= 16'b101_01011_0000_0001; ///ump reg1=reg0 to 1
//    instructions[7] <= 16'b101_00000_0000_0000; //mp 0
    
//    instructions[8] <= 16'b010_0_0011_0011_0000; //write 1 to register address 2 which means reg[2] = 1
//    instructions[9] <= 16'b010_0_0010_0010_0100; //write 2 to register address 1 which means reg[1] = 2
//    instructions[10] <= 16'b101_00111_0000_0000; //write reg1=2 to mem adress 6 mem(6)=2
//    instructions[11] <= 16'b000_0_0000_0011_0011; //write mem[2] to reg [0] which should make reg[0] = 2


//    instructions[0] <= 16'b0001_0000_00000010; //wait
//    instructions[1] <= 16'b0001_0001_00000011; //wait
//    instructions[2] <= 16'b001_0_0000_0000_0000; //wait
//    instructions[3] <= 16'b001_0_0000_0001_0001; //write 1 to memory address 0 which means mem [0] = 1
//    instructions[4] <= 16'b001_1_0010_00000000; //write 3 to memory address 1 which means mem[1] = 3
//    instructions[5] <= 16'b001_1_0011_00000000; //write 2 to memory address 2 which means mem[2] = 2
//    instructions[6] <= 16'b001_1_0100_00000001; //write 3 to memory address 3 which means mem[3] = 1
//    instructions[7] <= 16'b101_01011_0010_0001; //write reg0 to mem4 
//    instructions[8] <= 16'b010_0_0011_0011_0000; //write 1 to register address 2 which means reg[2] = 1
//    instructions[9] <= 16'b010_0_0010_0010_0100; //write 2 to register address 1 which means reg[1] = 2
//    instructions[10] <= 16'b101_00111_0000_0000; //write reg1=2 to mem adress 6 mem(6)=2
//    instructions[11] <= 16'b000_0_0000_0011_0011; //write mem[3] to reg [2] which should make reg[0] = 2
    end

    assign readData = instructions[readAddress];
    assign readData2 = instructions[readAddress+1];
endmodule
