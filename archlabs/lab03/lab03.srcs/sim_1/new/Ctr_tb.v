`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 20:47:45
// Design Name: 
// Module Name: Ctr_tb
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


module Ctr_tb(

    );
    reg [5:0] OpCode;
    wire RegDst;
    wire ALUSrc;
    wire MemToReg;
    wire RegWrite;
    wire MemRead;
    wire MemWrite;
    wire Branch;
    wire [1:0] ALUOp;
    wire Jump;
    
    Ctr u0 (
        .OpCode(OpCode),
        .RegDst(RegDst),
        .ALUSrc(ALUSrc),
        .MemToReg(MemToReg),
        .RegWrite(RegWrite),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .Branch(Branch),
        .ALUOp(ALUOp),
        .Jump(Jump)
    );
    
    initial begin
        // Initialize Inputs
        OpCode = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        #100 OpCode = 6'b000000;//R-type
        #100 OpCode = 6'b100011;//lw
        #100 OpCode = 6'b101011;//sw
        #100 OpCode = 6'b000100;//beq
        #100 OpCode = 6'b000010;//J
        #100 OpCode = 6'b010101;
    end
endmodule
