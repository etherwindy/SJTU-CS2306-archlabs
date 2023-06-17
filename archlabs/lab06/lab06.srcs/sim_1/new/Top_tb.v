`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/25 21:31:52
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
    reg clk, reset;
    always #5 clk = !clk;
    
    Top top(.clk(clk), .reset(reset));
    
    initial begin
        $readmemb("Instruction", top.instrMem.InstMemFile);
        $readmemh("Data", top.dataMem.memFile);
        clk = 1;
        reset = 1;
        #25 reset = 0;
    end
endmodule
