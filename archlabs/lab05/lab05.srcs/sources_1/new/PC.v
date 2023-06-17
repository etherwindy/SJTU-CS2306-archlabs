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
    input reset,
    input Clk,
    input [31:0] Input,
    output [31:0] PC
    );
    reg [31:0] pc;
    reg change;
    initial begin
        pc = 0;
        change = 0;
    end
    
    always @(reset)
    begin
        change = 1;
    end 

    always @(posedge Clk)
    begin
        if (change)
        begin
            pc <= 32'h00000000;
            change = 0;
        end 
        else
        begin
            pc <= Input;
        end
    end
    assign PC = pc;
endmodule
