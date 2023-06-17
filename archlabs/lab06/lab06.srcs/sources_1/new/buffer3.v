`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 09:57:39
// Design Name: 
// Module Name: buffer3
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


module buffer3(
    input Clk,
    input reset,
    input [4:0] IDEX_ctrl,
    input ZERO,
    input [31:0] ALU_RES,
    input [31:0] MEM_WRITE_DATA,
    input [4:0] DST_REG,
    output [31:0] EXMEM_aluRes, EXMEM_writeData,
    output [4:0] EXMEM_ctrl,
    output [4:0] EXMEM_zero,
    output [4:0] EXMEM_dstReg
    );
    reg [31:0] aluRes, writeData;
    reg [4:0] dstReg;
    reg [4:0] ctrl;
    reg zero;
    
    always @(reset)
    begin
        aluRes = 0;
        writeData = 0;
        dstReg = 0;
        ctrl = 0;
        zero = 0;
    end
    
    always @ (posedge Clk)
    begin
        ctrl <= IDEX_ctrl;
        zero <= ZERO;
        aluRes <= ALU_RES;
        writeData <= MEM_WRITE_DATA;
        dstReg <= DST_REG;
    end 
    
    assign EXMEM_aluRes = aluRes, EXMEM_writeData = writeData,
        EXMEM_ctrl = ctrl, EXMEM_zero = zero, EXMEM_dstReg = dstReg;
endmodule
