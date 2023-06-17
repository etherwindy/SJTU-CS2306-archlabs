`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 08:43:34
// Design Name: 
// Module Name: InstMemory
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


module InstMemory(
    input [31:0] ReadAddress,
    output [31:0] Instruction
    );
    reg [31:0] InstMemFile[0:255];
    reg [31:0] address;
    reg [31:0] inst;
    integer i;

    always @(ReadAddress)
    begin
        address = ReadAddress / 4;
        inst = InstMemFile[address];
    end
    assign Instruction = inst;
endmodule
