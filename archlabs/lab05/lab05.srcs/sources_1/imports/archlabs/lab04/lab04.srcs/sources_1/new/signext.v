`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/06 12:44:09
// Design Name: 
// Module Name: signext
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


module signext(
    input [15:0] inst,
    output [31:0] data
    );
    assign data = {{16{inst[15]}}, inst[15:0]};
endmodule
