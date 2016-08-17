`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:13:00 07/12/2011 
// Design Name: 
// Module Name:    LFSR_R24 
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
module lfsr_R24(
    input CLK,
    input RST,
    output reg [23:0] LFSR
    );
	 
	 parameter init_fill = 24'h4DB62E;
//
// Linear Feedback Shift Register
// [24,23,22,17] Fibonacci Implementation
//

always @(posedge CLK or posedge RST) begin
	if(RST)
		LFSR <= init_fill;
	else
	   begin
			LFSR[0] <= LFSR[10]^LFSR[17]^LFSR[20]^LFSR[23]^LFSR[0];
			LFSR[1] <= LFSR[11]^LFSR[17]^LFSR[18]^LFSR[21]^LFSR[22]^LFSR[23]^LFSR[0]^LFSR[1];
			LFSR[2] <= LFSR[12]^LFSR[17]^LFSR[18]^LFSR[19]^LFSR[0]^LFSR[1]^LFSR[2];
			LFSR[3] <= LFSR[13]^LFSR[18]^LFSR[19]^LFSR[20]^LFSR[1]^LFSR[2]^LFSR[3];
			LFSR[4] <= LFSR[14]^LFSR[19]^LFSR[20]^LFSR[21]^LFSR[2]^LFSR[3]^LFSR[4];
			LFSR[5] <= LFSR[15]^LFSR[20]^LFSR[21]^LFSR[22]^LFSR[3]^LFSR[4]^LFSR[5];
			LFSR[6] <= LFSR[16]^LFSR[21]^LFSR[22]^LFSR[23]^LFSR[4]^LFSR[5]^LFSR[6];
			LFSR[7] <= LFSR[0]^LFSR[5]^LFSR[6]^LFSR[7];
			LFSR[8] <= LFSR[1]^LFSR[6]^LFSR[7]^LFSR[8];
			LFSR[9] <= LFSR[2]^LFSR[7]^LFSR[8]^LFSR[9];
			LFSR[10] <= LFSR[3]^LFSR[8]^LFSR[9]^LFSR[10];
			LFSR[11] <= LFSR[4]^LFSR[9]^LFSR[10]^LFSR[11];
			LFSR[12] <= LFSR[5]^LFSR[10]^LFSR[11]^LFSR[12];
			LFSR[13] <= LFSR[6]^LFSR[11]^LFSR[12]^LFSR[13];
			LFSR[14] <= LFSR[7]^LFSR[12]^LFSR[13]^LFSR[14];
			LFSR[15] <= LFSR[8]^LFSR[13]^LFSR[14]^LFSR[15];
			LFSR[16] <= LFSR[9]^LFSR[14]^LFSR[15]^LFSR[16];
			LFSR[17] <= LFSR[10]^LFSR[15]^LFSR[16]^LFSR[17];
			LFSR[18] <= LFSR[11]^LFSR[16]^LFSR[17]^LFSR[18];
			LFSR[19] <= LFSR[12]^LFSR[17]^LFSR[18]^LFSR[19];
			LFSR[20] <= LFSR[13]^LFSR[18]^LFSR[19]^LFSR[20];
			LFSR[21] <= LFSR[14]^LFSR[19]^LFSR[20]^LFSR[21];
			LFSR[22] <= LFSR[15]^LFSR[20]^LFSR[21]^LFSR[22];
			LFSR[23] <= LFSR[16]^LFSR[21]^LFSR[22]^LFSR[23];
		end
end


endmodule
