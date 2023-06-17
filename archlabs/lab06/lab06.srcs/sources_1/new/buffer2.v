`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 09:26:12
// Design Name: 
// Module Name: buffer2
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


module buffer2(
    input Clk,
    input reset,
    input STALL,
    input [8:0] CTRL_OUT,
    input [31:0] READ_DATA_1,
    input [31:0] READ_DATA_2,
    input [31:0] IMM_SEXT,
    input [4:0] IFID_INSTRS,
    input [4:0] IFID_INSTRT,
    input [4:0] IFID_INSTRD,
    output [31:0] IDEX_readData1, IDEX_readData2, IDEX_immSext,
    output [4:0] IDEX_instrRs, IDEX_instrRt, IDEX_instrRd,
    output [8:0] IDEX_ctrl
    );
    reg [31:0] readData1, readData2, immSext;
    reg [4:0] instrRs, instrRt, instrRd;
    reg [8:0] ctrl;
    
    always @(reset)
    begin
        instrRs = 0;
        readData1 = 0;
        readData2 = 0;
        immSext = 0;
        instrRt = 0;
        instrRd = 0;
        ctrl = 0;
    end
    
    always @ (posedge Clk)
    begin
        ctrl <= STALL ? 0 : CTRL_OUT;
        readData1 <= READ_DATA_1;
        readData2 <= READ_DATA_2;
        immSext <= IMM_SEXT;
        instrRs <= IFID_INSTRS;
        instrRt <= IFID_INSTRT;
        instrRd <= IFID_INSTRD;
    end
    
    assign IDEX_readData1 = readData1, IDEX_readData2 = readData2, IDEX_immSext = immSext,
        IDEX_instrRs = instrRs, IDEX_instrRt = instrRt, IDEX_instrRd = instrRd,
        IDEX_ctrl = ctrl;
endmodule
