`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    16:17:11 07/08/2011
// Design Name:
// Module Name:    PRBS_tx
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
module PRBS_tx(
    input OUT_CLK_ENA,
    input GEN_CLK,
    input RST,
	  input INJ_ERR,
    output reg [47:0] PRBS,
	  output reg STRT_LTNCY
);

parameter start_pattern = 48'hFFFFFF000000;

wire [23:0] lfsr;
reg  [23:0] lfsr_a;
reg  [23:0] lfsr_b;

reg rst1 = 1'b1;
reg rst2 = 1'b1;
reg rst_f = 1'b1;

wire rst_lfsr;
wire start_pat;

assign rst_lfsr = RST | rst_f;
assign start_pat = RST | rst2;

always @(posedge GEN_CLK) begin
	if(OUT_CLK_ENA) begin
		rst1 <= RST;
		rst2 <= rst1;
		STRT_LTNCY <= ~start_pat;
		lfsr_a <= lfsr;
		if(start_pat)
			PRBS <= start_pattern;
		else
			if(INJ_ERR)
				PRBS <= {lfsr_a,lfsr_b}^48'h608000400100;
			else
				PRBS <= {lfsr_a,lfsr_b};
	end
end

always @(posedge GEN_CLK) begin
	if(!OUT_CLK_ENA) begin
		rst_f <= rst1;
		lfsr_b <= lfsr;
	end
end

//
// Linear Feedback Shift Register
// [24,23,22,17] Fibonacci Implementation
//
   lfsr_R24 #(.init_fill(24'h83B62E))
   tx_lfsr1(
       .CLK(GEN_CLK),
       .RST(rst_lfsr),
       .LFSR(lfsr)
   );

endmodule
