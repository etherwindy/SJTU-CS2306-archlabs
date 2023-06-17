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
    input [1:0] ALUOp,
    input [5:0] Funct,
    output [3:0] ALUCtrOut
    );
    reg [3:0] aluCtrOut;
    always @ (ALUOp or Funct)
    begin
        casex ({ALUOp, Funct})
            8'b00xxxxxx : aluCtrOut = 4'b0010;
            8'b01xxxxxx : aluCtrOut = 4'b0110;
            8'b10000010 : aluCtrOut = 4'b1010;
            8'b10000000 : aluCtrOut = 4'b1000;
            8'b1x100000 : aluCtrOut = 4'b0010;
            8'b1x100010 : aluCtrOut = 4'b0110;
            8'b1xxx0100 : aluCtrOut = 4'b0000;
            8'b1xxx0101 : aluCtrOut = 4'b0001;
            8'b1xxx1010 : aluCtrOut = 4'b0111;
        endcase
    end
    assign ALUCtrOut = aluCtrOut;
endmodule
