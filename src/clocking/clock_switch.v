`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:18:55 08/26/2014 
// Design Name: 
// Module Name:    clock_switch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_switch(
    input start,
	 input c_lock,
    input clk1,
    input clk2,
    input clk3,
	 output clk_edge,
     output  [9:0]   state,
    output reg done,
    output  [10:0]  counter,
    output  clk_condition,
    output  reset
    );

parameter first  = 10'b0000000001;
parameter second = 10'b0000000010;
parameter third  = 10'b0000000100;
parameter fourth = 10'b0000001000;
parameter fifth  = 10'b0000010000;
parameter sixth  = 10'b0000100000;
parameter seventh =10'b0001000000;
parameter eighth = 10'b0010000000;
parameter ninth  = 10'b0100000000;
parameter tenth  = 10'b1000000000;

reg clk_edge1,clk_edge2,clk_condition;
reg [9:0]pState;
reg [10:0]count6;
wire clk_edge;
assign reset=c_lock&start;
assign clk_preedge=clk1^clk2;
always@(posedge clk3) begin
  clk_edge1<=clk_preedge;
  end
always@(negedge clk3) begin
  clk_edge2<=clk_preedge;
  end  
assign clk_edge=clk_edge1|clk_edge2;

always@ (negedge clk1 or posedge clk_edge) begin
if(clk_edge) begin
    pState<=first;
	 count6<=11'b0;
    clk_condition<=1'b0;
	 end
	 else begin
	 case (pState)
	 first:begin
	 pState<=second;
	 clk_condition<=1'b0;
	 end
	 
	 second:begin
	 pState<=third;
	 clk_condition<=1'b0;
	 end
	 
	 third:begin
	 count6<=count6+11'b1;
	 pState<=count6[4]?fourth:third;
	 clk_condition<=1'b0;
	 end
	 
	 fourth:begin
	 pState<=fifth;
	 clk_condition<=1'b0;
	 end
	 
	 fifth:begin
	 pState<=sixth;
	 clk_condition<=1'b0;
	 end
	 
	 sixth:begin
	 pState<=seventh;
	 clk_condition<=1'b0;
	 end
	 
	 seventh:begin
	 pState<=eighth;
	 clk_condition<=1'b0;
	 end
	 
	 eighth:begin
	 pState<=ninth;
	 clk_condition<=1'b0;
	 end
	 
	 ninth:begin
	 pState<=tenth;
	 clk_condition<=1'b0;
	 end
	 
	 tenth:begin
	 pState<=tenth;
	 clk_condition<=1'b1;
	 end
	 endcase
	 end
	 end
	 
     assign state = pState;
     assign counter = count6;
always@ (posedge clk_condition or negedge reset) begin
if (!reset) begin
    done<=1'b0;
	 
	 end
	 else begin
	 done<=1'b1;
	 end
	 end
endmodule
