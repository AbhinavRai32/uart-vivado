`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 13.05.2026 13:26:36
// Design Name: 
// Module Name: urat_loopback_tb
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


module urat_loopback_tb(

    );
    reg clk,rst,tx_starttb;
     reg [7:0] datatb;
     wire txtb,rg_readytb;
     wire [7:0] datatbx;
     urat_tx utv(clk,rst,tx_starttb,datatb,txtb);
     urat_rx urv(clk,rst,txtb,datatbx,rg_readytb);
  initial begin
    clk=0; rst=1; tx_starttb=0; 
    #100 rst=0;
    #2 datatb=8'b10110101;
    #10 tx_starttb=1;
    #600000 tx_starttb=0;
    #2000000 rst=1;
end

always #5 clk=~clk;

     
     
     
     
     
     
     
     
     
     
     
     
     
     
endmodule
