`timescale 1ns / 100 ps

module priority_n (
    input clock,

    input      [2:0] pass_in,
    output reg [2:0] pass_out,

    input   [MXKEYS  -1:0] vpfs_in,
    input   [MXKEYS*3-1:0] cnts_in,

    output reg  [MXKEYBITS-1:0] adr,
    output reg        vpf,
    output reg  [2:0] cnt
);

parameter MXKEYS    = 192;
parameter MXKEYBITS = 8;
parameter MXCNTB    = 3;

//----------------------------------------------------------------------------------------------------------------------
// Wires
//----------------------------------------------------------------------------------------------------------------------

reg [2:0] pass_s0;
reg [2:0] pass_s1;
reg [2:0] pass_s2;
reg [2:0] pass_s3;
reg [2:0] pass_s4;
reg [2:0] pass_s5;
reg [2:0] pass_s6;

reg [191:0] vpf_s0;
reg [95:0]  vpf_s1;
reg [47:0]  vpf_s2;
reg [23:0]  vpf_s3;
reg [11:0]  vpf_s4;
reg [5:0]   vpf_s5;
reg [2:0]   vpf_s6;

reg [0:0] key_s1 [95:0];
reg [1:0] key_s2 [47:0];
reg [2:0] key_s3 [23:0];
reg [3:0] key_s3 [11:0];
reg [4:0] key_s5 [5:0];
reg [5:0] key_s6 [2:0];

reg [2:0] cnt_s0 [191:0];
reg [2:0] cnt_s1 [95:0];
reg [2:0] cnt_s2 [47:0];
reg [2:0] cnt_s3 [23:0];
reg [2:0] cnt_s4 [11:0];
reg [2:0] cnt_s5 [5:0];
reg [2:0] cnt_s6 [2:0];

// choose here to specify pipeline register stages
`define always_in  always @(*)
`define always_s0  always @(*)
`define always_s1  always @(posedge clock)
`define always_s2  always @(*)
`define always_s3  always @(*)
`define always_s4  always @(*)
`define always_s5  always @(posedge clock)
`define always_s6  always @(*)
`define always_out always @(*)

`always_s1  pass_s1 <= pass_s0;
`always_s2  pass_s2 <= pass_s1;
`always_s3  pass_s3 <= pass_s2;
`always_s4  pass_s4 <= pass_s3;
`always_s5  pass_s5 <= pass_s4;
`always_s6  pass_s6 <= pass_s5;
`always_out pass_out <= pass_s7;

`always_in pass_s0 <= pass_in;
`always_in vpf_s0 <= vpfs_in;

//Remap flattened count bits into a 2D vector
genvar ipad;
generate
for (ipad=0; ipad<192; ipad=ipad+1) begin: padloop
`always_in
          cnt_s0 [ipad] <= cnts_in [ipad*3+2:ipad*3];
end
endgenerate

//----------------------------------------------------------------------------------------------------------------------
// Comparators
//----------------------------------------------------------------------------------------------------------------------

genvar icmp;

// Stage 1 : 96 of 192
generate
for (icmp=0; icmp<96; icmp=icmp+1) begin: s1
`always_s1
    {vpf_s1[icmp], cnt_s1[icmp], key_s1[icmp]} = vpf_s0[icmp*2] ?  {vpf_s0[icmp*2  ], cnt_s0[icmp*2], 1'b0} : {vpf_s0[icmp*2+1], cnt_s0[icmp*2+1], 1'b1};
end
endgenerate

// Stage 2 : 48 of 96
generate
for (icmp=0; icmp<48; icmp=icmp+1) begin: s2
`always_s2
    {vpf_s2[icmp], cnt_s2[icmp], key_s2[icmp]} = vpf_s1[icmp*2] ?  {vpf_s1[icmp*2  ], cnt_s1[icmp*2], {1'b0,key_s1[icmp*2  ]}} : {vpf_s1[icmp*2+1], cnt_s1[icmp*2+1], {1'b1,key_s1[icmp*2+1]}};
end
endgenerate

// Stage 3 : 24 of 48
generate
for (icmp=0; icmp<24; icmp=icmp+1) begin: s3
always @(*) begin
`always_s3
    {vpf_s3[icmp], cnt_s3[icmp], key_s3[icmp]} = vpf_s2[icmp*2] ?  {vpf_s2[icmp*2  ], cnt_s2[icmp*2], {1'b0,key_s2[icmp*2  ]}} : {vpf_s2[icmp*2+1], cnt_s2[icmp*2+1], {1'b1,key_s2[icmp*2+1]}};
end
endgenerate

// Stage 4 : 12 of 24
generate
for (icmp=0; icmp<12; icmp=icmp+1) begin: s4
`always_s4
    {vpf_s4[icmp], cnt_s4[icmp], key_s4[icmp]} = vpf_s3[icmp*2] ?  {vpf_s3[icmp*2  ], cnt_s3[icmp*2], {1'b0,key_s3[icmp*2  ]}} : {vpf_s3[icmp*2+1], cnt_s3[icmp*2+1], {1'b1,key_s3[icmp*2+1]}};
end
endgenerate

// Stage 5 : 6 of 12
generate
for (icmp=0; icmp<6; icmp=icmp+1) begin: s5
`always_s5
    {vpf_s5[icmp], cnt_s5[icmp], key_s5[icmp]} = vpf_s4[icmp*2] ?  {vpf_s4[icmp*2  ], cnt_s4[icmp*2], {1'b0,key_s4[icmp*2  ]}} : {vpf_s4[icmp*2+1], cnt_s4[icmp*2+1], {1'b1,key_s4[icmp*2+1]}};
end
endgenerate

// Stage 6 : 3 of 6
generate
for (icmp=0; icmp<6; icmp=icmp+1) begin: s6
`always_s6
    {vpf_s6[icmp], cnt_s6[icmp], key_s6[icmp]} = vpf_s5[icmp*2] ?  {vpf_s5[icmp*2  ], cnt_s5[icmp*2], {1'b0,key_s5[icmp*2  ]}} : {vpf_s5[icmp*2+1], cnt_s5[icmp*2+1], {1'b1,key_s5[icmp*2+1]}};
end
endgenerate

// Stage 7: 1 of 3 Parallel Encoder
always @(*) begin

    if      (vpf_s6[0]) {vpf, cnt, adr} = {vpf_s6[0], cnt_s6[0], {2'b00, key_s6[0]}};
    else if (vpf_s6[1]) {vpf, cnt, adr} = {vpf_s6[1], cnt_s6[1], {2'b01, key_s6[1]}};
    else if (vpf_s6[2]) {vpf, cnt, adr} = {vpf_s6[2], cnt_s6[2], {2'b10, key_s6[2]}};
    else   begin
       vpf <=  0;
       cnt <=  0;
       adr <= ~0;
    end

end
//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
