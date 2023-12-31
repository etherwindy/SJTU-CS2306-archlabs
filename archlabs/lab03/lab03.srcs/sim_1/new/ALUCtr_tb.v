`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 21:34:22
// Design Name: 
// Module Name: ALUCtr_tb
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


module ALUCtr_tb(

    );
    reg [1:0] ALUOp;
    reg [5:0] Funct;
    wire [3:0] ALUCtrOut;
    
    ALUCtr u0 (
        .ALUOp(ALUOp),
        .Funct(Funct),
        .ALUCtrOut(ALUCtrOut)
    );
    
    initial begin
        // Initialize Inputs
        ALUOp = 0;
        Funct = 0;
        
        // Wait 100 ns for global reset to finish
        #100;
        
        #50 ALUOp = 2'b00; Funct = 6'bxxxxxx;
        #50 ALUOp = 2'bx1; Funct = 6'bxxxxxx;
        #50 ALUOp = 2'b1x; Funct = 6'bxx0000;
        #50 ALUOp = 2'b1x; Funct = 6'bxx0010;
        #50 ALUOp = 2'b1x; Funct = 6'bxx0100;
        #50 ALUOp = 2'b1x; Funct = 6'bxx0101;
        #50 ALUOp = 2'b1x; Funct = 6'bxx1010;
    end
endmodule
