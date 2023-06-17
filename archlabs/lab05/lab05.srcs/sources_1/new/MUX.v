`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/10 09:59:10
// Design Name: 
// Module Name: MUX_5bits
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


module MUX_5bits(
    input [5:0] Input1,
    input [5:0] Input2,
    input sel,
    output [5:0] Out
    );
    assign Out = sel ? Input1 : Input2;
endmodule
