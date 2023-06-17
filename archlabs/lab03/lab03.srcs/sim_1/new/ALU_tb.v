`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 22:51:56
// Design Name: 
// Module Name: ALU_tb
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


module ALU_tb(

    );
    reg [31:0] Input1;
    reg [31:0] Input2;
    reg [3:0] ALUCtr;
    wire Zero;
    wire [31:0] ALURes;
    
    ALU u0 (
        .Input1(Input1),
        .Input2(Input2),
        .ALUCtr(ALUCtr),
        .Zero(Zero),
        .ALURes(ALURes)
    );
    
    initial begin
        Input1 = 0;
        Input2 = 0;
        ALUCtr = 0;
        
        #100 ALUCtr = 4'b0000; Input1 = 15; Input2 = 10;
        #100 ALUCtr = 4'b0001; Input1 = 15; Input2 = 10;
        #100 ALUCtr = 4'b0010; Input1 = 15; Input2 = 10;
        #100 ALUCtr = 4'b0110; Input1 = 15; Input2 = 10;
        #100 ALUCtr = 4'b0110; Input1 = 10; Input2 = 15;
        #100 ALUCtr = 4'b0111; Input1 = 15; Input2 = 10;
        #100 ALUCtr = 4'b0111; Input1 = 10; Input2 = 15;
        #100 ALUCtr = 4'b1100; Input1 = 1; Input2 = 1;
        #100 ALUCtr = 4'b1100; Input1 = 16; Input2 = 1;
    end
endmodule
