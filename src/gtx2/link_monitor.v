`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:07:39 09/09/2015 
// Design Name: 
// Module Name:    link_monitor 
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
module link_monitor(
input local_clk_lock,  
input rx_reset_done,
input sync_fsm, 
input [15:0] rxdata, 
input [1:0]rxk,
input rxusrclk2, 
output reg link_initial,
output reg rxslide,
output reg prealigned,
output reg link_fixed,
output reg comma_found,
output recclk,
output [9:0] status


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


  reg sync;
  reg reset;
 
  reg [9:0] nState;
  reg [9:0] counter;
  
  reg [9:0] sState;
  reg [15:0]rdata;
  
 
  reg [5:0] counter1;
  
  always@(posedge rxusrclk2) begin
  rdata<=rxdata;
  sync<=sync_fsm;
  reset<=!rx_reset_done;
  end
  
  always@(posedge rxusrclk2 or negedge local_clk_lock) begin
  if(!local_clk_lock) begin
  link_initial<=1'b0;
  counter<=10'b0;
  nState<=first;
  end
  
  else begin
  case (nState)
  first:begin
  nState<=(reset|sync)?second:first;
  end
  
  second:begin
  link_initial<=1'b1;
 // counter<=counter+10'b1;
  nState<=prealigned?third:second;//counter[9]
  end
  
  third:begin
  link_initial<=1'b0;
  counter<=10'b0;
  nState<=first;
  end
  
  endcase
  end
  end
  
  
  
  



always@(posedge rxusrclk2 or negedge link_initial) begin
 if (!link_initial) begin
      
		
		prealigned<=1'b0;
		sState<=first;
		rxslide<=1'b0;
		counter1<=6'b0;
		end
		else begin
		case (sState)
		first:begin
		counter1<=6'b0;
		prealigned<=1'b0;
		sState<=(rxdata[7:0]==8'hBC)?second:tenth;
      end
      
      second:begin
		prealigned<=1'b0;
      sState<=(rxdata[7:0]==8'hBC)?third:tenth;	
      end

      third:begin
		prealigned<=1'b0;
      sState<=(rxdata[7:0]==8'hBC)?fourth:tenth;
		end

      fourth:begin
		prealigned<=1'b0;
      sState<=(rxdata[7:0]==8'hBC)?fifth:tenth;
      end

      fifth:begin
      
		prealigned<=1'b1;
      end
		
		sixth:begin
      sState<=(rxdata[7:0]==8'hBC)?seventh:tenth;
		end
		
		seventh:begin
		sState<=(rxdata[7:0]==8'hBC)?eighth:tenth;
		end
		
		eighth:begin
		prealigned<=1'b1;
		
		end
		
		ninth:begin
		rxslide<=1'b0;
		counter1<=counter1+6'b1;
		sState<=(counter1[4]&counter1[3])?first:ninth;
		end
		
		tenth:begin
		rxslide<=1'b1;
		prealigned<=1'b0;
		sState<=ninth;
		end
		
		endcase
		end
		end
  
  
  
  always@(posedge link_initial or posedge prealigned) begin
if (prealigned) begin
 link_fixed<=1'b1;
 end
 else begin
 link_fixed<=1'b0;
 end
 end

always@(posedge rxk[0] or negedge link_fixed) begin
 if (!link_fixed) begin
     comma_found<=1'b0;
	  end
	  else begin
	  comma_found<=1'b1;
	  end
	  end
	  
reg [2:0]counter_recclk;
 always @(posedge rxusrclk2 or negedge comma_found) begin
 if (!comma_found) begin
 counter_recclk<=3'b0;
 end
 else begin
 counter_recclk<=counter_recclk+3'b1;
 end
 end
 
 assign recclk= counter_recclk[1];
 assign status=sState;
 
endmodule
