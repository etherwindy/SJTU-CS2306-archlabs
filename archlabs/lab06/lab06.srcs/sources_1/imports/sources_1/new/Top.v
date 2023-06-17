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
    input clk,
    input reset
    );
    
    // Pipeline stage registers
    // IF/ID
    wire [31:0] IFID_pcPlus4, IFID_instr;
    wire [4:0] IFID_INSTRS = IFID_instr[25:21], IFID_INSTRT = IFID_instr[20:16],
         IFID_INSTRD = IFID_instr[15:11];
    wire BRANCH;
    wire JUMP;
    wire JUMP_REGISTER;
    
    // ID/EX
    wire [31:0] IDEX_readData1, IDEX_readData2, IDEX_immSext;
    wire [4:0] IDEX_instrRs, IDEX_instrRt, IDEX_instrRd;
    wire [8:0] IDEX_ctrl;
    wire [1:0] IDEX_ALUOP = IDEX_ctrl[7:6];
    wire IDEX_REGDST = IDEX_ctrl[8], IDEX_ALUSRC= IDEX_ctrl[5], 
        IDEX_BRANCH = IDEX_ctrl[4], IDEX_MEMREAD = IDEX_ctrl[3], 
        IDEX_MEMWRITE = IDEX_ctrl[2], IDEX_REGWRITE = IDEX_ctrl[1],
        IDEX_MEMTOREG = IDEX_ctrl[0];
        
    wire [4:0] DST_REG;
    wire [31:0] ALU_RES;
        
    // EX/EM
    wire [31:0] EXMEM_aluRes, EXMEM_writeData;
    wire [4:0] EXMEM_dstReg;
    wire [4:0] EXMEM_ctrl;
    wire EXMEM_zero;
    wire EXMEM_BRANCH = EXMEM_ctrl[4], EXMEM_MEMREAD = EXMEM_ctrl[3],
        EXMEM_MEMWRITE = EXMEM_ctrl[2], EXMEM_REGWRITE = EXMEM_ctrl[1],
        EXMEM_MEMTOREG = EXMEM_ctrl[0];
        
    // MEM/WB
    wire [31:0] MEMWB_readData, MEMWB_aluRes;
    wire [4:0] MEMWB_dstReg;
    wire [1:0] MEMWB_ctrl;
    wire MEMWB_REGWRITE = MEMWB_ctrl[1], MEMWB_MEMTOREG = MEMWB_ctrl[0];
    
    // Hazard detection
    wire STALL = IDEX_MEMREAD & 
        (IDEX_instrRt == IFID_INSTRS | IDEX_instrRt == IFID_INSTRT);
    
    // Stage settings
    // Instruction Fetch Stage
    wire [31:0] PC;
    wire [31:0] PC_PLUS_4, BRANCH_ADDR, JR_DST, SELECT_PC_A, SELECT_PC_B, NEXT_PC, IF_INSTR;
    assign JUMP = IF_INSTR[31:26] == 6'b000010 ? 1 : 0;
    assign PC_PLUS_4 = PC + 4;
    
    MUX_32bits selectPCMux_A(.Input2(PC_PLUS_4), .Input1({PC_PLUS_4[31:28], IF_INSTR[26:0], 2'b00}),
        .Out(SELECT_PC_A), .sel(JUMP));
    MUX_32bits selectPCMux_B(.Input2(SELECT_PC_A), .Input1(JR_DST),
        .Out(SELECT_PC_B), .sel(JUMP_REGISTER));
    MUX_32bits nextPCMux(.Input2(SELECT_PC_B), .Input1(BRANCH_ADDR), .Out(NEXT_PC),
        .sel(BRANCH));
    InstMemory instrMem(.ReadAddress(PC), .Instruction(IF_INSTR));
    
    PC mainPC(.Clk(clk), .reset(reset), .STALL(STALL), .NEXT_PC(NEXT_PC), .PC(PC));
    
    buffer1 IFID(.Clk(clk), .stall(STALL), .branch(BRANCH), .PC_PLUS_4(PC_PLUS_4),
        .IF_INSTR(IF_INSTR), .IFID_instr(IFID_instr), .IFID_pcPlus4(IFID_pcPlus4));
    
    // Decode Stage
    wire [8:0] CTRL_OUT;
    Ctr mainCtr(.OpCode(IFID_instr[31:26]), .RegDst(CTRL_OUT[8]), 
        .ALUOp(CTRL_OUT[7:6]), .ALUSrc(CTRL_OUT[5]), .Branch(CTRL_OUT[4]),
        .MemRead(CTRL_OUT[3]), .MemWrite(CTRL_OUT[2]), .RegWrite(CTRL_OUT[1]),
        .MemToReg(CTRL_OUT[0]));
    
    wire [31:0] READ_DATA_1, READ_DATA_2, REG_WRITE_DATA;
    Registers regs(.Clk(clk), .readReg1(IFID_INSTRS), .readReg2(IFID_INSTRT), 
        .writeReg(MEMWB_dstReg), .writeData(REG_WRITE_DATA), 
        .regWrite(MEMWB_REGWRITE), .reset(reset), .readData1(READ_DATA_1), 
        .readData2(READ_DATA_2));
    
    wire [31:0] IMM_SEXT;
    signext sext(.inst(IFID_instr[15:0]), .out(IMM_SEXT));
    wire [31:0] IMM_SEXT_SHIFT = IMM_SEXT << 2;
    
    wire BRANCH_FWD_ID_A =
        IDEX_ctrl[1] & DST_REG != 0 & DST_REG == IFID_INSTRS;
    wire BRANCH_FWD_ID_B =
        IDEX_ctrl[1] & DST_REG != 0 & DST_REG == IFID_INSTRT;
    wire BRANCH_FWD_EX_A = 
        EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg == IFID_INSTRS;
    wire BRANCH_FWD_EX_B = 
        EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg == IFID_INSTRT;
    wire BRANCH_FWD_MEM_A = 
        MEMWB_REGWRITE & MEMWB_dstReg != 0 & 
        !(EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg != IFID_INSTRS) &
        MEMWB_dstReg == IFID_INSTRS;
    wire BRANCH_FWD_MEM_B = 
        MEMWB_REGWRITE & MEMWB_dstReg != 0 & 
        !(EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg != IFID_INSTRT) &
        MEMWB_dstReg == IFID_INSTRT;
        
    wire [31:0] BRANCH_SRC_A = BRANCH_FWD_ID_A ? ALU_RES : BRANCH_FWD_EX_A ? EXMEM_aluRes : 
        BRANCH_FWD_MEM_A ? REG_WRITE_DATA : READ_DATA_1;

    wire [31:0] BRANCH_SRC_B = BRANCH_FWD_ID_B ? ALU_RES : BRANCH_FWD_EX_B ? EXMEM_aluRes : 
        BRANCH_FWD_MEM_B ? REG_WRITE_DATA : READ_DATA_2;
    
    assign BRANCH_ADDR = IMM_SEXT_SHIFT + IFID_pcPlus4;
    assign BRANCH = CTRL_OUT[4] ? (!IFID_instr[26] && BRANCH_SRC_A == BRANCH_SRC_B )
        || (IFID_instr[26] && BRANCH_SRC_A != BRANCH_SRC_B ) : 0;
    assign JUMP_REGISTER = CTRL_OUT[8] && IMM_SEXT[5:0]==6'b001000;
    assign JR_DST = BRANCH_SRC_A;
    
    buffer2 IDEX(.Clk(clk), .reset(reset), .STALL(STALL), .CTRL_OUT(CTRL_OUT),
        .READ_DATA_1(READ_DATA_1), .READ_DATA_2(READ_DATA_2), .IMM_SEXT(IMM_SEXT),
        .IFID_INSTRS(IFID_INSTRS), .IFID_INSTRT(IFID_INSTRT), .IFID_INSTRD(IFID_INSTRD),
        .IDEX_readData1(IDEX_readData1), .IDEX_readData2(IDEX_readData2), .IDEX_immSext(IDEX_immSext),
        .IDEX_instrRs(IDEX_instrRs), .IDEX_instrRt(IDEX_instrRt), .IDEX_instrRd(IDEX_instrRd),
        .IDEX_ctrl(IDEX_ctrl));
    
    // Forwarding Unit
    wire FWD_EX_A = 
        EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg == IDEX_instrRs;
    wire FWD_EX_B = 
        EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg == IDEX_instrRt;
    wire FWD_MEM_A = 
        MEMWB_REGWRITE & MEMWB_dstReg != 0 & 
        !(EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg != IDEX_instrRs) &
        MEMWB_dstReg == IDEX_instrRs;
    wire FWD_MEM_B = 
        MEMWB_REGWRITE & MEMWB_dstReg != 0 & 
        !(EXMEM_REGWRITE & EXMEM_dstReg != 0 & EXMEM_dstReg != IDEX_instrRt) &
        MEMWB_dstReg == IDEX_instrRt;
        
    // Execution Stage
    wire [31:0] ALU_SRC_A = FWD_EX_A ? EXMEM_aluRes : 
        FWD_MEM_A ? REG_WRITE_DATA : IDEX_readData1;
    wire [31:0] ALU_SRC_B = IDEX_ALUSRC ? IDEX_immSext : FWD_EX_B ? EXMEM_aluRes :
        FWD_EX_B ? EXMEM_aluRes : FWD_MEM_B ? REG_WRITE_DATA : IDEX_readData2;
    wire [31:0] MEM_WRITE_DATA = FWD_EX_B ? EXMEM_aluRes :
        FWD_EX_B ? EXMEM_aluRes : FWD_MEM_B ? REG_WRITE_DATA : IDEX_readData2;
         
    wire [3:0] ALU_CTRL_OUT;
    ALUCtr aluCtr(.Funct(IDEX_immSext[5:0]), .ALUOp(IDEX_ALUOP), 
        .ALUCtrOut(ALU_CTRL_OUT));
    
    wire ZERO;
    ALU alu(.Input1(ALU_SRC_A), .Input2(ALU_SRC_B), .Input3(IDEX_immSext[10:6]), .ALUCtr(ALU_CTRL_OUT), .Zero(ZERO),
        .ALURes(ALU_RES));
        
    MUX_5bits dstRegMux(.Input2(IDEX_instrRt), .Input1(IDEX_instrRd), .sel(IDEX_REGDST),
        .Out(DST_REG));
    
    buffer3 EXMEM(.Clk(clk), .reset(reset), .IDEX_ctrl(IDEX_ctrl), .ZERO(ZERO),
        .ALU_RES(ALU_RES), .MEM_WRITE_DATA(MEM_WRITE_DATA), .DST_REG(DST_REG),
        .EXMEM_aluRes(EXMEM_aluRes), .EXMEM_writeData(EXMEM_writeData),
        .EXMEM_ctrl(EXMEM_ctrl), .EXMEM_zero(EXMEM_zero), .EXMEM_dstReg(EXMEM_dstReg));
    
    // Memory Stage
    wire [31:0] MEM_READ_DATA;
    dataMemory dataMem(.Clk(clk), .address(EXMEM_aluRes), 
        .writeData(EXMEM_writeData), .memRead(EXMEM_MEMREAD), 
        .memWrite(EXMEM_MEMWRITE), .readData(MEM_READ_DATA));

    buffer4 MEMWB(.Clk(clk), .reset(reset), .EXMEM_ctrl(EXMEM_ctrl[1:0]),
        .MEM_READ_DATA(MEM_READ_DATA), .EXMEM_aluRes(EXMEM_aluRes), .EXMEM_dstReg(EXMEM_dstReg),
        .MEMWB_readData(MEMWB_readData), .MEMWB_aluRes(MEMWB_aluRes), .MEMWB_dstReg(MEMWB_dstReg), .MEMWB_ctrl(MEMWB_ctrl));
    
    // Write Back Stage
    MUX_32bits writeDataMux(.Input1(MEMWB_readData), .Input2(MEMWB_aluRes), 
        .sel(MEMWB_MEMTOREG), .Out(REG_WRITE_DATA));
    
endmodule
