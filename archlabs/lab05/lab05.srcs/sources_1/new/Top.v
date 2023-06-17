`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 08:41:03
// Design Name: 
// Module Name: Top
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


module Top(
    input RESET,
    input CLK
    );
    wire REG_DST,
        JUMP,
        JR,
        BRANCH,
        MEM_READ,
        MEM_TO_REG,
        MEM_WRITE;
    wire [2:0] ALU_OP;
    wire ALU_SRC,
        REG_WRITE;

    wire [31:0] PC_INPUT;
    wire [31:0] PC;
    wire [31:0] INST;
    wire [4:0] WRITE_REG;
    wire [31:0] REG_WRITE_DATA;
    wire [31:0] REG_DATA1;
    wire [31:0] REG_DATA2;
    wire [3:0] ALU_CTR;
    wire [31:0] ALU_INPUT1;
    wire [31:0] ALU_INPUT2;
    wire [31:0] ALU_RES;
    wire ZERO;
    wire [31:0] SIGN_DATA;
    wire [31:0] MEM_READ_DATA;
    wire [31:0] JUMP_ADDRESS;
    wire [31:0] PC_PLUS_FOUR;
    wire [31:0] ADD_RES;
    wire [31:0] MUX_RES;
    
    Ctr mainCtr (
        .OpCode(INST[31:26]),
        .Funct(INST[5:0]),
        .RegDst(REG_DST),
        .ALUSrc(ALU_SRC),
        .MemToReg(MEM_TO_REG),
        .RegWrite(REG_WRITE),
        .MemRead(MEM_READ),
        .MemWrite(MEM_WRITE),
        .Branch(BRANCH),
        .ALUOp(ALU_OP),
        .Jump(JUMP),
        .Jr(JR)
    );
    
    PC mainPC(
        .reset(RESET),
        .Clk(CLK),
        .Input(PC_INPUT),
        .PC(PC)
    );
    
    InstMemory mainInstMemory(
        .ReadAddress(PC),
        .Instruction(INST)
    );
    
    MUX_5bits mainMUX1(
        .Input1(INST[15:11]),
        .Input2(INST[20:16]),
        .sel(REG_DST),
        .Out(WRITE_REG)
    );
    
    Registers mainRegisters (
        .reset(RESET),
        .Clk(CLK),
        .readReg1(INST[25:21]),
        .readReg2(INST[20:16]),
        .writeReg(JUMP ? 0 : WRITE_REG),
        .writeData(JUMP ? {6'b000000, INST[25:0]} : REG_WRITE_DATA),
        .regWrite(REG_WRITE),
        .readData1(REG_DATA1),
        .readData2(REG_DATA2)
    );
    
    signext mainSignext(
        .inst(INST[15:0]),
        .data(SIGN_DATA)
    );
    
    ALUCtr mainALUCtr (
        .ALUOp(ALU_OP),
        .Funct(INST[5:0]),
        .ALUCtrOut(ALU_CTR)
    );
    
    MUX_32bits mainMUX2(
        .Input1(SIGN_DATA),
        .Input2(REG_DATA2),
        .sel(ALU_SRC),
        .Out(ALU_INPUT2)
    );
    
    ALU mainALU (
        .Input1(REG_DATA1),
        .Input2(ALU_INPUT2),
        .Input3(INST[10:6]),
        .ALUCtr(ALU_CTR),
        .Zero(ZERO),
        .ALURes(ALU_RES)
    );
    
    dataMemory mainDataMemory(
        .Clk(CLK),
        .address(ALU_RES),
        .writeData(REG_DATA2),
        .memWrite(MEM_WRITE),
        .memRead(MEM_READ),
        .readData(MEM_READ_DATA)
    );
    
    MUX_32bits mainMUX3(
        .Input1(MEM_READ_DATA),
        .Input2(ALU_RES),
        .sel(MEM_TO_REG),
        .Out(REG_WRITE_DATA)
    );
    
    Adder mainAdd1(
        .Input1(PC),
        .Input2(4),
        .Out(PC_PLUS_FOUR)
    );
    
    Adder mainAdd2(
        .Input1(PC_PLUS_FOUR),
        .Input2(SIGN_DATA << 2),
        .Out(ADD_RES)
    );
    
    MUX_32bits mainMUX4(
        .Input1(ADD_RES),
        .Input2(PC_PLUS_FOUR),
        .sel(BRANCH && ZERO),
        .Out(MUX_RES)
    );
    
    MUX_32bits mainMUX5(
        .Input1(JUMP_ADDRESS),
        .Input2(MUX_RES),
        .sel(JUMP),
        .Out(PC_INPUT)
    );
    
    assign JUMP_ADDRESS = JR ? REG_DATA1 : {PC_PLUS_FOUR[31:28], INST[25:0] << 2};
endmodule
