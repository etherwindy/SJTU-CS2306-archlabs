`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/29 23:44:09
// Design Name: 
// Module Name: Top_tb
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


module Top_tb(

    );
    reg clk;
    reg reset;
    
    always #5 clk = !clk;
    
    Top top(.CLK(clk), .RESET(reset));
    
    initial begin
        $readmemb("Instruction", top.mainInstMemory.InstMemFile);
        $readmemh("Data", top.mainDataMemory.memFile);
        clk = 1;
        reset = 1;
        #25 reset = 0;
    end
    
    
endmodule
