`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2026 18:21:14
// Design Name: 
// Module Name: urat_tb
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


module urat_tb(

    );
    reg clk,rst,tx_start;
    reg [7:0] datai;
    wire tx;
    urat_tx ut(clk,rst,tx_start,datai,tx);
    initial
    begin
    {clk,rst,tx_start}=0;
    
    end
    always #5 clk=~clk;
    initial 
    
    begin
    
    
    rst=1;
    tx_start=0;
    #10 rst=0;
    tx_start=0;
     #2
    datai=8'b10110101;
    #10 tx_start =1;
   
    #100
    rst=1;
    tx_start=0;
    #10 $finish;
    end
   
    
endmodule
