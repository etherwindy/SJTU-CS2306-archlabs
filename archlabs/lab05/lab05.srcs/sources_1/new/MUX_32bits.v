`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 10:05:16
// Design Name: 
// Module Name: MUX_32bits
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


module MUX_32bits(
    input [31:0] Input1,
    input [31:0] Input2,
    input sel,
    output [31:0] Out
    );
    assign Out = sel ? Input1 : Input2;
endmodule
