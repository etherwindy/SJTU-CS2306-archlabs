`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/05 23:11:53
// Design Name: 
// Module Name: dataMemory
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


module dataMemory(
    input Clk,
    input [31:0] address,
    input [31:0] writeData,
    input memWrite,
    input memRead,
    output [31:0] readData
    );
    
    reg [31:0] memFile[0:63];
    reg [31:0] readdata;
    integer i;
    
    initial begin
        for (i = 0; i < 64; i = i + 1)
            memFile[i] = 0;
    end
    
    always@ (memRead or memWrite or address)
        begin
            if (memWrite ==1)
                readdata = 0;
            else if (memRead == 1)
                readdata = memFile[address];
            else readdata = 0;
        end
    always@ (negedge Clk)
        begin
            if (memWrite == 1)
                memFile[address] = writeData;
        end
    assign readData = readdata;
endmodule
