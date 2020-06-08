`timescale 1ns / 100 ps
module priority384 (
    input clock,

    input      [2:0] pass_in,
    output reg [2:0] pass_out,

    input   [MXKEYS       -1:0] vpfs_in,
    input   [MXKEYS*MXCNTB-1:0] cnts_in,

    output reg  [MXKEYBITS-1:0] adr,
    output reg                  vpf,
    output reg  [MXCNTB-1:0]    cnt
);
parameter MXKEYS    = 384;
parameter MXKEYBITS = 9;
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
reg [2:0] pass_s7;
always @* pass_s0 <= pass_in;

reg [383:0] vpf_s0;
reg [191:0] vpf_s1;
reg [95:0] vpf_s2;
reg [47:0] vpf_s3;
reg [23:0] vpf_s4;
reg [11:0] vpf_s5;
reg [5:0] vpf_s6;
reg [2:0] vpf_s7;
always @* vpf_s0 <= vpfs_in;

reg [0:0] key_s1 [191:0];
reg [1:0] key_s2 [95:0];
reg [2:0] key_s3 [47:0];
reg [3:0] key_s4 [23:0];
reg [4:0] key_s5 [11:0];
reg [5:0] key_s6 [5:0];
reg [6:0] key_s7 [2:0];

reg [2:0] cnt_s0 [383:0];
reg [2:0] cnt_s1 [191:0];
reg [2:0] cnt_s2 [95:0];
reg [2:0] cnt_s3 [47:0];
reg [2:0] cnt_s4 [23:0];
reg [2:0] cnt_s5 [11:0];
reg [2:0] cnt_s6 [5:0];
reg [2:0] cnt_s7 [2:0];

//Remap flattened count bits into a 2D vector
genvar ipad;
generate
for (ipad=0; ipad<384; ipad=ipad+1) begin: padloop
    always @(*) cnt_s0 [ipad] <= cnts_in [ipad*3+2:ipad*3];
end
endgenerate

//----------------------------------------------------------------------------------------------------------------------
// Comparators
//----------------------------------------------------------------------------------------------------------------------

genvar icmp;

// Stage 1 : 192 of 384
generate
for (icmp=0; icmp<192; icmp=icmp+1) begin: s1
always @(posedge clock)
    {vpf_s1[icmp], cnt_s1[icmp], key_s1[icmp]} = vpf_s0[icmp*2] ?  {vpf_s0[icmp*2  ], cnt_s0[icmp*2], 1'b0} : {vpf_s0[icmp*2+1], cnt_s0[icmp*2+1], 1'b1};
end
endgenerate

always @(posedge clock)
    pass_s1 <= pass_s0;

// Stage 2 : 96 of 192
generate
for (icmp=0; icmp<96; icmp=icmp+1) begin: s2
always @(*)
    {vpf_s2[icmp], cnt_s2[icmp], key_s2[icmp]} = vpf_s1[icmp*2] ?  {vpf_s1[icmp*2  ], cnt_s1[icmp*2], {1'b0,key_s1[icmp*2  ]}} : {vpf_s1[icmp*2+1], cnt_s1[icmp*2+1], {1'b1,key_s1[icmp*2+1]}};
end
endgenerate

always @(*)
    pass_s2 <= pass_s1;

// Stage 3 : 48 of 96
generate
for (icmp=0; icmp<48; icmp=icmp+1) begin: s3
always @(*)
    {vpf_s3[icmp], cnt_s3[icmp], key_s3[icmp]} = vpf_s2[icmp*2] ?  {vpf_s2[icmp*2  ], cnt_s2[icmp*2], {1'b0,key_s2[icmp*2  ]}} : {vpf_s2[icmp*2+1], cnt_s2[icmp*2+1], {1'b1,key_s2[icmp*2+1]}};
end
endgenerate

always @(*)
    pass_s3 <= pass_s2;

// Stage 4 : 24 of 48
generate
for (icmp=0; icmp<24; icmp=icmp+1) begin: s4
always @(*)
    {vpf_s4[icmp], cnt_s4[icmp], key_s4[icmp]} = vpf_s3[icmp*2] ?  {vpf_s3[icmp*2  ], cnt_s3[icmp*2], {1'b0,key_s3[icmp*2  ]}} : {vpf_s3[icmp*2+1], cnt_s3[icmp*2+1], {1'b1,key_s3[icmp*2+1]}};
end
endgenerate

always @(*)
    pass_s4 <= pass_s3;

// Stage 5 : 12 of 24
generate
for (icmp=0; icmp<12; icmp=icmp+1) begin: s5
always @(posedge clock)
    {vpf_s5[icmp], cnt_s5[icmp], key_s5[icmp]} = vpf_s4[icmp*2] ?  {vpf_s4[icmp*2  ], cnt_s4[icmp*2], {1'b0,key_s4[icmp*2  ]}} : {vpf_s4[icmp*2+1], cnt_s4[icmp*2+1], {1'b1,key_s4[icmp*2+1]}};
end
endgenerate

always @(posedge clock)
    pass_s5 <= pass_s4;

// Stage 6 : 6 of 12
generate
for (icmp=0; icmp<6; icmp=icmp+1) begin: s6
always @(*)
    {vpf_s6[icmp], cnt_s6[icmp], key_s6[icmp]} = vpf_s5[icmp*2] ?  {vpf_s5[icmp*2  ], cnt_s5[icmp*2], {1'b0,key_s5[icmp*2  ]}} : {vpf_s5[icmp*2+1], cnt_s5[icmp*2+1], {1'b1,key_s5[icmp*2+1]}};
end
endgenerate

always @(*)
    pass_s6 <= pass_s5;

// Stage 7 : 3 of 6
generate
for (icmp=0; icmp<3; icmp=icmp+1) begin: s7
always @(*)
    {vpf_s7[icmp], cnt_s7[icmp], key_s7[icmp]} = vpf_s6[icmp*2] ?  {vpf_s6[icmp*2  ], cnt_s6[icmp*2], {1'b0,key_s6[icmp*2  ]}} : {vpf_s6[icmp*2+1], cnt_s6[icmp*2+1], {1'b1,key_s6[icmp*2+1]}};
end
endgenerate

always @(*)
    pass_s7 <= pass_s6;

// Stage 8: 1 of 3 Parallel Encoder
always @(*) begin

    if      (vpf_s7[0]) {vpf, cnt, adr} = {vpf_s7[0], cnt_s7[0], {2'b00, key_s7[0]}};
    else if (vpf_s7[1]) {vpf, cnt, adr} = {vpf_s7[1], cnt_s7[1], {2'b01, key_s7[1]}};
    else if (vpf_s7[2]) {vpf, cnt, adr} = {vpf_s7[2], cnt_s7[2], {2'b10, key_s7[2]}};
    else   begin
       vpf <=  0;
       cnt <=  0;
       adr <= ~0;
    end

    pass_out <= pass_s7;

end
//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
