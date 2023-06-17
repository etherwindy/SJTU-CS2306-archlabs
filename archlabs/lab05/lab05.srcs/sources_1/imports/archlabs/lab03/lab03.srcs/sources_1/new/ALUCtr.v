`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 21:16:39
// Design Name: 
// Module Name: ALUCtr
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


module ALUCtr(
    input [2:0] ALUOp,
    input [5:0] Funct,
    output [3:0] ALUCtrOut
    );
    reg [3:0] aluCtrOut;
    always @ (ALUOp or Funct)
    begin
        casex ({ALUOp, Funct})
            9'b000xxxxxx : aluCtrOut = 4'b0010;
            9'b010xxxxxx : aluCtrOut = 4'b0110;
            9'b001xxxxxx : aluCtrOut = 4'b0000;
            9'b011xxxxxx : aluCtrOut = 4'b0001;
            9'b100000010 : aluCtrOut = 4'b1010;
            9'b100000000 : aluCtrOut = 4'b1000;
            9'b100100000 : aluCtrOut = 4'b0010;
            9'b100100010 : aluCtrOut = 4'b0110;
            9'b100xx0100 : aluCtrOut = 4'b0000;
            9'b100xx0101 : aluCtrOut = 4'b0001;
            9'b100xx1010 : aluCtrOut = 4'b0111;
        endcase
    end
    assign ALUCtrOut = aluCtrOut;
endmodule
