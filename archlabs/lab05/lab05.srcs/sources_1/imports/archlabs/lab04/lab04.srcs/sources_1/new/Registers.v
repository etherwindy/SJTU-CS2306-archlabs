`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 20:51:55
// Design Name: 
// Module Name: Registers
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


module Registers(
    input reset,
    input Clk,
    input [25:21] readReg1,
    input [20:16] readReg2,
    input [4:0] writeReg,
    input [31:0] writeData,
    input regWrite,
    output [31:0] readData1,
    output [31:0] readData2
    );
    
    reg [31:0] regFile[0:31];
    reg [31:0] readdata1;
    reg [31:0] readdata2;
    integer i;

    initial begin
        for (i = 0; i < 32; i = i + 1)
            regFile[i] = 0;
    end
    
    always @(posedge Clk)
        begin
            if (reset)
            begin
                for ( i = 0; i < 32; i = i + 1)
                    regFile[i] = 0;
            end 
        end
    
    always @(readReg1 or readReg2 or writeReg)
        begin
            readdata1 = regFile[readReg1];
            readdata2 = regFile[readReg2];
        end
    
    always @(negedge Clk)
        begin
            if (regWrite)
                begin
                    regFile[writeReg] = writeData;
                    if (writeReg == readReg1)
                        readdata1 = regFile[readReg1];
                    if (writeReg == readReg2)
                        readdata2 = regFile[readReg2];
                end
        end
    assign readData1 = readdata1;
    assign readData2 = readdata2;
endmodule
