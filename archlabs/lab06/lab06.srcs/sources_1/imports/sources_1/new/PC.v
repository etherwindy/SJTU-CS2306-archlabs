`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 08:52:03
// Design Name: 
// Module Name: PC
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


module PC(
    input Clk,
    input reset,
    input STALL,
    input [31:0] NEXT_PC,
    output [31:0] PC
    );
    reg [31:0] pc;

    initial begin
        pc = 0;
    end 

    always @ (reset)
        pc = 0;

    always @(posedge Clk)
    if(!STALL)
        begin
            pc <= NEXT_PC;
        end
    assign PC = pc;
endmodule
