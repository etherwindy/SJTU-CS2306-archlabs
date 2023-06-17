`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 10:58:23
// Design Name: 
// Module Name: buffer4
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


module buffer4(
    input Clk,
    input reset,
    input [1:0] EXMEM_ctrl,
    input [31:0] MEM_READ_DATA,
    input [31:0] EXMEM_aluRes,
    input [31:0] EXMEM_dstReg,
    output [31:0] MEMWB_readData, MEMWB_aluRes,
    output [4:0] MEMWB_dstReg,
    output [1:0] MEMWB_ctrl
    );
    reg [31:0] readData, aluRes;
    reg [4:0] dstReg;
    reg [1:0] ctrl;
    
    always @(reset)
    begin
        readData = 0;
        aluRes = 0;
        dstReg = 0;
        ctrl = 0;
    end
    
    always @ (posedge Clk)
    begin
        ctrl <= EXMEM_ctrl;
        readData <= MEM_READ_DATA;
        aluRes <= EXMEM_aluRes;
        dstReg <= EXMEM_dstReg;
    end
    
    assign MEMWB_readData = readData, MEMWB_aluRes = aluRes, MEMWB_dstReg = dstReg,
        MEMWB_ctrl = ctrl;
endmodule
