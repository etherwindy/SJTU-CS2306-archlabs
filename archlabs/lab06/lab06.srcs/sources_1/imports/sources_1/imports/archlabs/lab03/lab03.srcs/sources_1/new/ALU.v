`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 22:36:58
// Design Name: 
// Module Name: ALU
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


module ALU(
    input [31:0] Input1,
    input [31:0] Input2,
    input [4:0] Input3,
    input [3:0] ALUCtr,
    output Zero,
    output [31:0] ALURes
    );
    reg zero;
    reg [31:0] aluRes;
    
    always @ (Input1 or Input2 or Input3 or ALUCtr)
    begin
        if (ALUCtr == 4'b0000) // AND
        begin
            aluRes = Input1 & Input2;
            if(aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b0001) // OR
        begin
            aluRes = Input1 | Input2;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b0010) // add
        begin
            aluRes = Input1 + Input2;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b0110) // sub
        begin
            aluRes = Input1 - Input2;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b1010) // srl
        begin
            aluRes = Input2 >> Input3;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b1000) // sll
        begin
            aluRes = Input2 << Input3;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b0111) // slt
        begin
            aluRes = Input2 > Input1 ? 1 : 0;
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
        else if (ALUCtr == 4'b1100) // NOR
        begin
            aluRes = ~(Input1 | Input2);
            if (aluRes == 0)
                zero = 1;
            else
                zero = 0;
        end
    end
    assign Zero = zero;
    assign ALURes = aluRes;
endmodule
