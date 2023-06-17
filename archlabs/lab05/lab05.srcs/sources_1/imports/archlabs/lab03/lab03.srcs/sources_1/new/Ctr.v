`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 20:29:12
// Design Name: 
// Module Name: Ctr
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


module Ctr(
    input [5:0] OpCode,
    input [5:0] Funct,
    output RegDst,
    output ALUSrc,
    output MemToReg,
    output RegWrite,
    output MemRead,
    output MemWrite,
    output Branch,
    output [2:0] ALUOp,
    output Jump,
    output Jr
    );
    reg regDst;
    reg aluSrc;
    reg memToReg;
    reg regWrite;
    reg memRead;
    reg memWrite;
    reg branch;
    reg [2:0] aluOp;
    reg jump;
    reg jr;
    
    always @(OpCode)
    begin
        if ({OpCode, Funct} == 12'b000000001000)
        begin
            regDst = 0;
            aluSrc = 0;
            memToReg = 0;
            regWrite = 0;
            memRead = 0;
            memWrite = 0;
            branch = 0;
            aluOp = 3'b000;
            jump = 1;
            jr = 1;
        end
    else
        begin
            case(OpCode)
            6'b000000: //R type
                begin
                    regDst = 1;
                    aluSrc = 0;
                    memToReg = 0;
                    regWrite = 1;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b100;
                    jump = 0;
                    jr = 0;
                end
            6'b100011: //lw
                begin
                    regDst = 0;
                    aluSrc = 1;
                    memToReg = 1;
                    regWrite = 1;
                    memRead = 1;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 0;
                    jr = 0;
                end
            6'b101011: //sw
                begin
                    regDst = 0;
                    aluSrc = 1;
                    memToReg = 0;
                    regWrite = 0;
                    memRead = 0;
                    memWrite = 1;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 0;
                    jr = 0;
                end
            6'b000100: //beq
                begin
                    regDst = 0;
                    aluSrc = 0;
                    memToReg = 0;
                    regWrite = 0;
                    memRead = 0;
                    memWrite = 0;
                    branch = 1;
                    aluOp = 3'b010;
                    jump = 0;
                    jr = 0;
                end
            6'b000010: //J
                begin
                    regDst = 0;
                    aluSrc = 0;
                    memToReg = 0;
                    regWrite = 0;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 1;
                    jr = 0;
                end
            6'b001000: //addi
                begin
                    regDst = 1;
                    aluSrc = 1;
                    memToReg = 0;
                    regWrite = 1;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 0;
                    jr = 0;
                end
            6'b001100: //andi
                begin
                    regDst = 1;
                    aluSrc = 1;
                    memToReg = 0;
                    regWrite = 1;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b001;
                    jump = 0;
                    jr = 0;
                end
            6'b001101: //ori
                begin
                    regDst = 1;
                    aluSrc = 1;
                    memToReg = 0;
                    regWrite = 1;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b011;
                    jump = 0;
                    jr = 0;
                end
            6'b000010: //jal
                begin
                    regDst = 0;
                    aluSrc = 0;
                    memToReg = 0;
                    regWrite = 1;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 1;
                end
            default:
                begin
                    regDst = 0;
                    aluSrc = 0;
                    memToReg = 0;
                    regWrite = 0;
                    memRead = 0;
                    memWrite = 0;
                    branch = 0;
                    aluOp = 3'b000;
                    jump = 0;
                    jr = 0;
                end
            endcase
        end
    end
    assign RegDst = regDst;
    assign ALUSrc = aluSrc;
    assign MemToReg = memToReg;
    assign RegWrite = regWrite;
    assign MemRead = memRead;
    assign MemWrite = memWrite;
    assign Branch = branch;
    assign ALUOp = aluOp;
    assign Jump = jump;
    assign Jr = jr;
endmodule
