`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.05.2026 14:54:31
// Design Name: 
// Module Name: urat_tx
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


module urat_tx(input clk,rst,tx_start,
input [7:0] datain ,output reg tx

    );
    reg [1:0] state ;
    reg[2:0] m;
        reg [13:0] baud_countt;
    parameter idlet = 2'b00;
    parameter startt = 2'b01;
    parameter datat = 2'b10;
    parameter stopt = 2'b11;
      parameter baud_divt= 5208;
      parameter baud_halft = 2604;
    
    always@(posedge clk)
      //reset condition
    if (rst)
    begin
    tx<=1'b1;
    state <= idlet;
    m<=3'b000;
    baud_countt<=14'b0;
    end
    else 
    case(state)
    // idle condition
    idlet: begin
    tx <= 1;
    if (tx_start)
        state <= startt;
    else
        state <= idlet;
end
    startt:begin
    tx <= 0;
    if(baud_countt==baud_halft)
    begin
    
        state <= datat;
        baud_countt<=14'b0;
        end
        else
        baud_countt<=baud_countt+1'b1;
    
end
    datat:
  
    begin 


 
  

  if(baud_countt==baud_divt)
 begin
  tx<=datain[m];
    baud_countt<=14'b0;
  if(m==3'b111)
  begin
  state<=stopt;
  m<=3'b000;
  baud_countt<=14'b0;
  end
  else 
  m<=m+1'b1;
  
  
 end
 else baud_countt<=baud_countt+1'b1;
 
  
  
    
    end
    
    stopt:
    begin
    tx<=1;
    state<=idlet ;
    end 
    
    
    endcase
    
endmodule
