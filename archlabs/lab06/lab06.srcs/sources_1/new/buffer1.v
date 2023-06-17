`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/24 09:14:30
// Design Name: 
// Module Name: buffer1
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


module buffer1(
    input Clk,
    input reset,
    input stall,
    input branch,
    input [31:0] PC_PLUS_4,
    input [31:0] IF_INSTR,
    output [31:0] IFID_instr, IFID_pcPlus4
    );
    reg [31:0] pcPlus4;
    reg [63:32] instr;

    always @(reset)
    begin
        pcPlus4 = 0;
        instr = 0;
    end

    always @(posedge Clk)
    begin
        if (!stall)
        begin
            pcPlus4 <= PC_PLUS_4;
            instr <= IF_INSTR;
        end
        if (branch)
            instr <= 0;
    end
    
    assign IFID_instr = instr, IFID_pcPlus4 = pcPlus4;
endmodule
