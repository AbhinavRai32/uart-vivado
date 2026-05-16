`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 15:48:49
// Design Name: 
// Module Name: urat_rx
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


module urat_rx(input clk,rst,tx,output reg [7:0] datax ,
output reg  rx_ready

    );
    reg [1:0] stater;
    reg [13:0] baud_count;
    reg [2:0] bit_count;
    reg [7:0] data_reg;
    parameter idler = 2'b00;
    parameter startr = 2'b01;
    parameter datar = 2'b10;
    parameter stopr = 2'b11;
     parameter baud_div= 5208;
      parameter baud_half = 2604;
      
    always@(posedge clk)
    // reset condition 
    if (rst)
    begin
    data_reg<=8'b0;
    baud_count<=14'b0;
    bit_count<=3'b0;
    datax<=8'b0;
    rx_ready<=1'b0;
    stater<=2'b00;
    end
    else
    case(stater)
   // idle state 
    idler:
    begin 
    if(tx==0)
    stater<=startr;
    else
   
    stater<=idler;
    rx_ready<=1'b0;
    baud_count<=14'b0;
     end
    // start state 
    startr:
    begin
   
    if(baud_count==baud_half)//sampling starts
    begin
    stater<=datar;
    baud_count<=14'b0;
    end
    else
     baud_count<=baud_count+1'b1;
        
    
    
    end
    // data:
    datar:
    begin
    if(baud_count==baud_div)
  begin
    data_reg[bit_count]<=tx;
    baud_count<=14'b0;
   if(bit_count==3'b111)
   begin
   stater<=stopr;
   data_reg[7]<=tx;
   baud_count<=14'b0;
   bit_count<=3'b0;
  
   end
   else 
   bit_count<=bit_count+1'b1;
    end
    else 
    baud_count<=baud_count+1'b1;
    
    
    
    end
    
    //stop
    stopr:
    begin
    datax<=data_reg;
    rx_ready<=1'b1;
    stater<=idler;
    
    end
    
    
    
    
    
    
    
    
    
    
    
    
    endcase
    
    
endmodule
