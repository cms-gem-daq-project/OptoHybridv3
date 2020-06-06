//-------------------------------------------------------------------------------------
// ATTENTION:
// This file and all of its contents were automatically generated using a python script
// For the love of god DO NOT EDIT it directly but please edit the generator so that
// everything can stay in sync
//-------------------------------------------------------------------------------------

module sorter16 (
    input clock,

    input [MXADRB-1:0] adr_in0,
    input [MXADRB-1:0] adr_in1,
    input [MXADRB-1:0] adr_in2,
    input [MXADRB-1:0] adr_in3,
    input [MXADRB-1:0] adr_in4,
    input [MXADRB-1:0] adr_in5,
    input [MXADRB-1:0] adr_in6,
    input [MXADRB-1:0] adr_in7,
    input [MXADRB-1:0] adr_in8,
    input [MXADRB-1:0] adr_in9,
    input [MXADRB-1:0] adr_in10,
    input [MXADRB-1:0] adr_in11,
    input [MXADRB-1:0] adr_in12,
    input [MXADRB-1:0] adr_in13,
    input [MXADRB-1:0] adr_in14,
    input [MXADRB-1:0] adr_in15,

    input [MXCNTB-1:0] cnt_in0,
    input [MXCNTB-1:0] cnt_in1,
    input [MXCNTB-1:0] cnt_in2,
    input [MXCNTB-1:0] cnt_in3,
    input [MXCNTB-1:0] cnt_in4,
    input [MXCNTB-1:0] cnt_in5,
    input [MXCNTB-1:0] cnt_in6,
    input [MXCNTB-1:0] cnt_in7,
    input [MXCNTB-1:0] cnt_in8,
    input [MXCNTB-1:0] cnt_in9,
    input [MXCNTB-1:0] cnt_in10,
    input [MXCNTB-1:0] cnt_in11,
    input [MXCNTB-1:0] cnt_in12,
    input [MXCNTB-1:0] cnt_in13,
    input [MXCNTB-1:0] cnt_in14,
    input [MXCNTB-1:0] cnt_in15,

    input [MXVPFB-1:0] vpf_in0,
    input [MXVPFB-1:0] vpf_in1,
    input [MXVPFB-1:0] vpf_in2,
    input [MXVPFB-1:0] vpf_in3,
    input [MXVPFB-1:0] vpf_in4,
    input [MXVPFB-1:0] vpf_in5,
    input [MXVPFB-1:0] vpf_in6,
    input [MXVPFB-1:0] vpf_in7,
    input [MXVPFB-1:0] vpf_in8,
    input [MXVPFB-1:0] vpf_in9,
    input [MXVPFB-1:0] vpf_in10,
    input [MXVPFB-1:0] vpf_in11,
    input [MXVPFB-1:0] vpf_in12,
    input [MXVPFB-1:0] vpf_in13,
    input [MXVPFB-1:0] vpf_in14,
    input [MXVPFB-1:0] vpf_in15,

    input [MXPRTB-1:0] prt_in0,
    input [MXPRTB-1:0] prt_in1,
    input [MXPRTB-1:0] prt_in2,
    input [MXPRTB-1:0] prt_in3,
    input [MXPRTB-1:0] prt_in4,
    input [MXPRTB-1:0] prt_in5,
    input [MXPRTB-1:0] prt_in6,
    input [MXPRTB-1:0] prt_in7,
    input [MXPRTB-1:0] prt_in8,
    input [MXPRTB-1:0] prt_in9,
    input [MXPRTB-1:0] prt_in10,
    input [MXPRTB-1:0] prt_in11,
    input [MXPRTB-1:0] prt_in12,
    input [MXPRTB-1:0] prt_in13,
    input [MXPRTB-1:0] prt_in14,
    input [MXPRTB-1:0] prt_in15,


    output [MXADRB-1:0] adr_out0,
    output [MXADRB-1:0] adr_out1,
    output [MXADRB-1:0] adr_out2,
    output [MXADRB-1:0] adr_out3,
    output [MXADRB-1:0] adr_out4,
    output [MXADRB-1:0] adr_out5,
    output [MXADRB-1:0] adr_out6,
    output [MXADRB-1:0] adr_out7,

    output [MXCNTB-1:0] cnt_out0,
    output [MXCNTB-1:0] cnt_out1,
    output [MXCNTB-1:0] cnt_out2,
    output [MXCNTB-1:0] cnt_out3,
    output [MXCNTB-1:0] cnt_out4,
    output [MXCNTB-1:0] cnt_out5,
    output [MXCNTB-1:0] cnt_out6,
    output [MXCNTB-1:0] cnt_out7,

    output [MXVPFB-1:0] vpf_out0,
    output [MXVPFB-1:0] vpf_out1,
    output [MXVPFB-1:0] vpf_out2,
    output [MXVPFB-1:0] vpf_out3,
    output [MXVPFB-1:0] vpf_out4,
    output [MXVPFB-1:0] vpf_out5,
    output [MXVPFB-1:0] vpf_out6,
    output [MXVPFB-1:0] vpf_out7,

    output [MXPRTB-1:0] prt_out0,
    output [MXPRTB-1:0] prt_out1,
    output [MXPRTB-1:0] prt_out2,
    output [MXPRTB-1:0] prt_out3,
    output [MXPRTB-1:0] prt_out4,
    output [MXPRTB-1:0] prt_out5,
    output [MXPRTB-1:0] prt_out6,
    output [MXPRTB-1:0] prt_out7,

    input  pulse_in,
    output pulse_out
);
parameter MXPRTB=0;
parameter MXVPFB=0;
parameter MXADRB=0;
parameter MXCNTB=0;
//----------------------------------------------------------------------------------------------------------------------
// vectorize inputs
//----------------------------------------------------------------------------------------------------------------------
reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s0 [15:0];
reg                    pulse_s0;

always @(*) begin
    adr_cnt_prt_vpf_s0[0 ]  <=  {adr_in0 , cnt_in0 , vpf_in0 };
    adr_cnt_prt_vpf_s0[1 ]  <=  {adr_in1 , cnt_in1 , vpf_in1 };
    adr_cnt_prt_vpf_s0[2 ]  <=  {adr_in2 , cnt_in2 , vpf_in2 };
    adr_cnt_prt_vpf_s0[3 ]  <=  {adr_in3 , cnt_in3 , vpf_in3 };
    adr_cnt_prt_vpf_s0[4 ]  <=  {adr_in4 , cnt_in4 , vpf_in4 };
    adr_cnt_prt_vpf_s0[5 ]  <=  {adr_in5 , cnt_in5 , vpf_in5 };
    adr_cnt_prt_vpf_s0[6 ]  <=  {adr_in6 , cnt_in6 , vpf_in6 };
    adr_cnt_prt_vpf_s0[7 ]  <=  {adr_in7 , cnt_in7 , vpf_in7 };
    adr_cnt_prt_vpf_s0[8 ]  <=  {adr_in8 , cnt_in8 , vpf_in8 };
    adr_cnt_prt_vpf_s0[9 ]  <=  {adr_in9 , cnt_in9 , vpf_in9 };
    adr_cnt_prt_vpf_s0[10]  <=  {adr_in10, cnt_in10, vpf_in10};
    adr_cnt_prt_vpf_s0[11]  <=  {adr_in11, cnt_in11, vpf_in11};
    adr_cnt_prt_vpf_s0[12]  <=  {adr_in12, cnt_in12, vpf_in12};
    adr_cnt_prt_vpf_s0[13]  <=  {adr_in13, cnt_in13, vpf_in13};
    adr_cnt_prt_vpf_s0[14]  <=  {adr_in14, cnt_in14, vpf_in14};
    adr_cnt_prt_vpf_s0[15]  <=  {adr_in15, cnt_in15, vpf_in15};

    pulse_s0 <= pulse_in;
end


//------------------------------------------------------------------------------------------------------------------
// stage 2

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s2 [15:0];
reg                    pulse_s2;

always @(*) begin
    {adr_cnt_prt_vpf_s2[0 ], adr_cnt_prt_vpf_s2 [2 ]} <= (adr_cnt_prt_vpf_s0[2 ][0] > adr_cnt_prt_vpf_s0[0 ][0]) ? {adr_cnt_prt_vpf_s0[2 ], adr_cnt_prt_vpf_s0[0 ]} :{adr_cnt_prt_vpf_s0[0 ], adr_cnt_prt_vpf_s0[2 ]};
    {adr_cnt_prt_vpf_s2[1 ], adr_cnt_prt_vpf_s2 [3 ]} <= (adr_cnt_prt_vpf_s0[3 ][0] > adr_cnt_prt_vpf_s0[1 ][0]) ? {adr_cnt_prt_vpf_s0[3 ], adr_cnt_prt_vpf_s0[1 ]} :{adr_cnt_prt_vpf_s0[1 ], adr_cnt_prt_vpf_s0[3 ]};
    {adr_cnt_prt_vpf_s2[4 ], adr_cnt_prt_vpf_s2 [6 ]} <= (adr_cnt_prt_vpf_s0[6 ][0] > adr_cnt_prt_vpf_s0[4 ][0]) ? {adr_cnt_prt_vpf_s0[6 ], adr_cnt_prt_vpf_s0[4 ]} :{adr_cnt_prt_vpf_s0[4 ], adr_cnt_prt_vpf_s0[6 ]};
    {adr_cnt_prt_vpf_s2[5 ], adr_cnt_prt_vpf_s2 [7 ]} <= (adr_cnt_prt_vpf_s0[7 ][0] > adr_cnt_prt_vpf_s0[5 ][0]) ? {adr_cnt_prt_vpf_s0[7 ], adr_cnt_prt_vpf_s0[5 ]} :{adr_cnt_prt_vpf_s0[5 ], adr_cnt_prt_vpf_s0[7 ]};
    {adr_cnt_prt_vpf_s2[8 ], adr_cnt_prt_vpf_s2 [10]} <= (adr_cnt_prt_vpf_s0[10][0] > adr_cnt_prt_vpf_s0[8 ][0]) ? {adr_cnt_prt_vpf_s0[10], adr_cnt_prt_vpf_s0[8 ]} :{adr_cnt_prt_vpf_s0[8 ], adr_cnt_prt_vpf_s0[10]};
    {adr_cnt_prt_vpf_s2[9 ], adr_cnt_prt_vpf_s2 [11]} <= (adr_cnt_prt_vpf_s0[11][0] > adr_cnt_prt_vpf_s0[9 ][0]) ? {adr_cnt_prt_vpf_s0[11], adr_cnt_prt_vpf_s0[9 ]} :{adr_cnt_prt_vpf_s0[9 ], adr_cnt_prt_vpf_s0[11]};
    {adr_cnt_prt_vpf_s2[12], adr_cnt_prt_vpf_s2 [14]} <= (adr_cnt_prt_vpf_s0[14][0] > adr_cnt_prt_vpf_s0[12][0]) ? {adr_cnt_prt_vpf_s0[14], adr_cnt_prt_vpf_s0[12]} :{adr_cnt_prt_vpf_s0[12], adr_cnt_prt_vpf_s0[14]};
    {adr_cnt_prt_vpf_s2[13], adr_cnt_prt_vpf_s2 [15]} <= (adr_cnt_prt_vpf_s0[15][0] > adr_cnt_prt_vpf_s0[13][0]) ? {adr_cnt_prt_vpf_s0[15], adr_cnt_prt_vpf_s0[13]} :{adr_cnt_prt_vpf_s0[13], adr_cnt_prt_vpf_s0[15]};
    pulse_s2 <= pulse_s0;
end

//------------------------------------------------------------------------------------------------------------------
// stage 3

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s3 [15:0];
reg                    pulse_s3;

always @(posedge clock) begin
    {adr_cnt_prt_vpf_s3[0 ], adr_cnt_prt_vpf_s3 [4 ]} <= (adr_cnt_prt_vpf_s2[4 ][0] > adr_cnt_prt_vpf_s2[0 ][0]) ? {adr_cnt_prt_vpf_s2[4 ], adr_cnt_prt_vpf_s2[0 ]} :{adr_cnt_prt_vpf_s2[0 ], adr_cnt_prt_vpf_s2[4 ]};
    {adr_cnt_prt_vpf_s3[1 ], adr_cnt_prt_vpf_s3 [5 ]} <= (adr_cnt_prt_vpf_s2[5 ][0] > adr_cnt_prt_vpf_s2[1 ][0]) ? {adr_cnt_prt_vpf_s2[5 ], adr_cnt_prt_vpf_s2[1 ]} :{adr_cnt_prt_vpf_s2[1 ], adr_cnt_prt_vpf_s2[5 ]};
    {adr_cnt_prt_vpf_s3[2 ], adr_cnt_prt_vpf_s3 [6 ]} <= (adr_cnt_prt_vpf_s2[6 ][0] > adr_cnt_prt_vpf_s2[2 ][0]) ? {adr_cnt_prt_vpf_s2[6 ], adr_cnt_prt_vpf_s2[2 ]} :{adr_cnt_prt_vpf_s2[2 ], adr_cnt_prt_vpf_s2[6 ]};
    {adr_cnt_prt_vpf_s3[3 ], adr_cnt_prt_vpf_s3 [7 ]} <= (adr_cnt_prt_vpf_s2[7 ][0] > adr_cnt_prt_vpf_s2[3 ][0]) ? {adr_cnt_prt_vpf_s2[7 ], adr_cnt_prt_vpf_s2[3 ]} :{adr_cnt_prt_vpf_s2[3 ], adr_cnt_prt_vpf_s2[7 ]};
    {adr_cnt_prt_vpf_s3[8 ], adr_cnt_prt_vpf_s3 [12]} <= (adr_cnt_prt_vpf_s2[12][0] > adr_cnt_prt_vpf_s2[8 ][0]) ? {adr_cnt_prt_vpf_s2[12], adr_cnt_prt_vpf_s2[8 ]} :{adr_cnt_prt_vpf_s2[8 ], adr_cnt_prt_vpf_s2[12]};
    {adr_cnt_prt_vpf_s3[9 ], adr_cnt_prt_vpf_s3 [13]} <= (adr_cnt_prt_vpf_s2[13][0] > adr_cnt_prt_vpf_s2[9 ][0]) ? {adr_cnt_prt_vpf_s2[13], adr_cnt_prt_vpf_s2[9 ]} :{adr_cnt_prt_vpf_s2[9 ], adr_cnt_prt_vpf_s2[13]};
    {adr_cnt_prt_vpf_s3[10], adr_cnt_prt_vpf_s3 [14]} <= (adr_cnt_prt_vpf_s2[14][0] > adr_cnt_prt_vpf_s2[10][0]) ? {adr_cnt_prt_vpf_s2[14], adr_cnt_prt_vpf_s2[10]} :{adr_cnt_prt_vpf_s2[10], adr_cnt_prt_vpf_s2[14]};
    {adr_cnt_prt_vpf_s3[11], adr_cnt_prt_vpf_s3 [15]} <= (adr_cnt_prt_vpf_s2[15][0] > adr_cnt_prt_vpf_s2[11][0]) ? {adr_cnt_prt_vpf_s2[15], adr_cnt_prt_vpf_s2[11]} :{adr_cnt_prt_vpf_s2[11], adr_cnt_prt_vpf_s2[15]};
    pulse_s3 <= pulse_s2;
end

//------------------------------------------------------------------------------------------------------------------
// stage 4

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s4 [15:0];
reg                    pulse_s4;

always @(*) begin
    {adr_cnt_prt_vpf_s4[0 ], adr_cnt_prt_vpf_s4 [8 ]} <= (adr_cnt_prt_vpf_s3[8 ][0] > adr_cnt_prt_vpf_s3[0 ][0]) ? {adr_cnt_prt_vpf_s3[8 ], adr_cnt_prt_vpf_s3[0 ]} :{adr_cnt_prt_vpf_s3[0 ], adr_cnt_prt_vpf_s3[8 ]};
    {adr_cnt_prt_vpf_s4[1 ], adr_cnt_prt_vpf_s4 [9 ]} <= (adr_cnt_prt_vpf_s3[9 ][0] > adr_cnt_prt_vpf_s3[1 ][0]) ? {adr_cnt_prt_vpf_s3[9 ], adr_cnt_prt_vpf_s3[1 ]} :{adr_cnt_prt_vpf_s3[1 ], adr_cnt_prt_vpf_s3[9 ]};
    {adr_cnt_prt_vpf_s4[2 ], adr_cnt_prt_vpf_s4 [10]} <= (adr_cnt_prt_vpf_s3[10][0] > adr_cnt_prt_vpf_s3[2 ][0]) ? {adr_cnt_prt_vpf_s3[10], adr_cnt_prt_vpf_s3[2 ]} :{adr_cnt_prt_vpf_s3[2 ], adr_cnt_prt_vpf_s3[10]};
    {adr_cnt_prt_vpf_s4[3 ], adr_cnt_prt_vpf_s4 [11]} <= (adr_cnt_prt_vpf_s3[11][0] > adr_cnt_prt_vpf_s3[3 ][0]) ? {adr_cnt_prt_vpf_s3[11], adr_cnt_prt_vpf_s3[3 ]} :{adr_cnt_prt_vpf_s3[3 ], adr_cnt_prt_vpf_s3[11]};
    {adr_cnt_prt_vpf_s4[4 ], adr_cnt_prt_vpf_s4 [12]} <= (adr_cnt_prt_vpf_s3[12][0] > adr_cnt_prt_vpf_s3[4 ][0]) ? {adr_cnt_prt_vpf_s3[12], adr_cnt_prt_vpf_s3[4 ]} :{adr_cnt_prt_vpf_s3[4 ], adr_cnt_prt_vpf_s3[12]};
    {adr_cnt_prt_vpf_s4[5 ], adr_cnt_prt_vpf_s4 [13]} <= (adr_cnt_prt_vpf_s3[13][0] > adr_cnt_prt_vpf_s3[5 ][0]) ? {adr_cnt_prt_vpf_s3[13], adr_cnt_prt_vpf_s3[5 ]} :{adr_cnt_prt_vpf_s3[5 ], adr_cnt_prt_vpf_s3[13]};
    {adr_cnt_prt_vpf_s4[6 ], adr_cnt_prt_vpf_s4 [14]} <= (adr_cnt_prt_vpf_s3[14][0] > adr_cnt_prt_vpf_s3[6 ][0]) ? {adr_cnt_prt_vpf_s3[14], adr_cnt_prt_vpf_s3[6 ]} :{adr_cnt_prt_vpf_s3[6 ], adr_cnt_prt_vpf_s3[14]};
    {adr_cnt_prt_vpf_s4[7 ], adr_cnt_prt_vpf_s4 [15]} <= (adr_cnt_prt_vpf_s3[15][0] > adr_cnt_prt_vpf_s3[7 ][0]) ? {adr_cnt_prt_vpf_s3[15], adr_cnt_prt_vpf_s3[7 ]} :{adr_cnt_prt_vpf_s3[7 ], adr_cnt_prt_vpf_s3[15]};
    pulse_s4 <= pulse_s3;
end

//------------------------------------------------------------------------------------------------------------------
// stage 5

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s5 [15:0];
reg                    pulse_s5;

always @(*) begin
    {adr_cnt_prt_vpf_s5[4 ], adr_cnt_prt_vpf_s5 [8 ]} <= (adr_cnt_prt_vpf_s4[8 ][0] > adr_cnt_prt_vpf_s4[4 ][0]) ? {adr_cnt_prt_vpf_s4[8 ], adr_cnt_prt_vpf_s4[4 ]} :{adr_cnt_prt_vpf_s4[4 ], adr_cnt_prt_vpf_s4[8 ]};
    {adr_cnt_prt_vpf_s5[5 ], adr_cnt_prt_vpf_s5 [9 ]} <= (adr_cnt_prt_vpf_s4[9 ][0] > adr_cnt_prt_vpf_s4[5 ][0]) ? {adr_cnt_prt_vpf_s4[9 ], adr_cnt_prt_vpf_s4[5 ]} :{adr_cnt_prt_vpf_s4[5 ], adr_cnt_prt_vpf_s4[9 ]};
    {adr_cnt_prt_vpf_s5[6 ], adr_cnt_prt_vpf_s5 [10]} <= (adr_cnt_prt_vpf_s4[10][0] > adr_cnt_prt_vpf_s4[6 ][0]) ? {adr_cnt_prt_vpf_s4[10], adr_cnt_prt_vpf_s4[6 ]} :{adr_cnt_prt_vpf_s4[6 ], adr_cnt_prt_vpf_s4[10]};
    {adr_cnt_prt_vpf_s5[7 ], adr_cnt_prt_vpf_s5 [11]} <= (adr_cnt_prt_vpf_s4[11][0] > adr_cnt_prt_vpf_s4[7 ][0]) ? {adr_cnt_prt_vpf_s4[11], adr_cnt_prt_vpf_s4[7 ]} :{adr_cnt_prt_vpf_s4[7 ], adr_cnt_prt_vpf_s4[11]};
    adr_cnt_prt_vpf_s5[0 ] <= adr_cnt_prt_vpf_s4[0 ];
    adr_cnt_prt_vpf_s5[1 ] <= adr_cnt_prt_vpf_s4[1 ];
    adr_cnt_prt_vpf_s5[2 ] <= adr_cnt_prt_vpf_s4[2 ];
    adr_cnt_prt_vpf_s5[3 ] <= adr_cnt_prt_vpf_s4[3 ];
    adr_cnt_prt_vpf_s5[12] <= adr_cnt_prt_vpf_s4[12];
    adr_cnt_prt_vpf_s5[13] <= adr_cnt_prt_vpf_s4[13];
    adr_cnt_prt_vpf_s5[14] <= adr_cnt_prt_vpf_s4[14];
    adr_cnt_prt_vpf_s5[15] <= adr_cnt_prt_vpf_s4[15];
    pulse_s5 <= pulse_s4;
end

//------------------------------------------------------------------------------------------------------------------
// stage 6

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s6 [15:0];
reg                    pulse_s6;

always @(posedge clock) begin
    {adr_cnt_prt_vpf_s6[2 ], adr_cnt_prt_vpf_s6 [8 ]} <= (adr_cnt_prt_vpf_s5[8 ][0] > adr_cnt_prt_vpf_s5[2 ][0]) ? {adr_cnt_prt_vpf_s5[8 ], adr_cnt_prt_vpf_s5[2 ]} :{adr_cnt_prt_vpf_s5[2 ], adr_cnt_prt_vpf_s5[8 ]};
    {adr_cnt_prt_vpf_s6[3 ], adr_cnt_prt_vpf_s6 [9 ]} <= (adr_cnt_prt_vpf_s5[9 ][0] > adr_cnt_prt_vpf_s5[3 ][0]) ? {adr_cnt_prt_vpf_s5[9 ], adr_cnt_prt_vpf_s5[3 ]} :{adr_cnt_prt_vpf_s5[3 ], adr_cnt_prt_vpf_s5[9 ]};
    {adr_cnt_prt_vpf_s6[6 ], adr_cnt_prt_vpf_s6 [12]} <= (adr_cnt_prt_vpf_s5[12][0] > adr_cnt_prt_vpf_s5[6 ][0]) ? {adr_cnt_prt_vpf_s5[12], adr_cnt_prt_vpf_s5[6 ]} :{adr_cnt_prt_vpf_s5[6 ], adr_cnt_prt_vpf_s5[12]};
    {adr_cnt_prt_vpf_s6[7 ], adr_cnt_prt_vpf_s6 [13]} <= (adr_cnt_prt_vpf_s5[13][0] > adr_cnt_prt_vpf_s5[7 ][0]) ? {adr_cnt_prt_vpf_s5[13], adr_cnt_prt_vpf_s5[7 ]} :{adr_cnt_prt_vpf_s5[7 ], adr_cnt_prt_vpf_s5[13]};
    adr_cnt_prt_vpf_s6[0 ] <= adr_cnt_prt_vpf_s5[0 ];
    adr_cnt_prt_vpf_s6[1 ] <= adr_cnt_prt_vpf_s5[1 ];
    adr_cnt_prt_vpf_s6[4 ] <= adr_cnt_prt_vpf_s5[4 ];
    adr_cnt_prt_vpf_s6[5 ] <= adr_cnt_prt_vpf_s5[5 ];
    adr_cnt_prt_vpf_s6[10] <= adr_cnt_prt_vpf_s5[10];
    adr_cnt_prt_vpf_s6[11] <= adr_cnt_prt_vpf_s5[11];
    adr_cnt_prt_vpf_s6[14] <= adr_cnt_prt_vpf_s5[14];
    adr_cnt_prt_vpf_s6[15] <= adr_cnt_prt_vpf_s5[15];
    pulse_s6 <= pulse_s5;
end

//------------------------------------------------------------------------------------------------------------------
// stage 7

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s7 [15:0];
reg                    pulse_s7;

always @(*) begin
    {adr_cnt_prt_vpf_s7[2 ], adr_cnt_prt_vpf_s7 [4 ]} <= (adr_cnt_prt_vpf_s6[4 ][0] > adr_cnt_prt_vpf_s6[2 ][0]) ? {adr_cnt_prt_vpf_s6[4 ], adr_cnt_prt_vpf_s6[2 ]} :{adr_cnt_prt_vpf_s6[2 ], adr_cnt_prt_vpf_s6[4 ]};
    {adr_cnt_prt_vpf_s7[3 ], adr_cnt_prt_vpf_s7 [5 ]} <= (adr_cnt_prt_vpf_s6[5 ][0] > adr_cnt_prt_vpf_s6[3 ][0]) ? {adr_cnt_prt_vpf_s6[5 ], adr_cnt_prt_vpf_s6[3 ]} :{adr_cnt_prt_vpf_s6[3 ], adr_cnt_prt_vpf_s6[5 ]};
    {adr_cnt_prt_vpf_s7[6 ], adr_cnt_prt_vpf_s7 [8 ]} <= (adr_cnt_prt_vpf_s6[8 ][0] > adr_cnt_prt_vpf_s6[6 ][0]) ? {adr_cnt_prt_vpf_s6[8 ], adr_cnt_prt_vpf_s6[6 ]} :{adr_cnt_prt_vpf_s6[6 ], adr_cnt_prt_vpf_s6[8 ]};
    {adr_cnt_prt_vpf_s7[7 ], adr_cnt_prt_vpf_s7 [9 ]} <= (adr_cnt_prt_vpf_s6[9 ][0] > adr_cnt_prt_vpf_s6[7 ][0]) ? {adr_cnt_prt_vpf_s6[9 ], adr_cnt_prt_vpf_s6[7 ]} :{adr_cnt_prt_vpf_s6[7 ], adr_cnt_prt_vpf_s6[9 ]};
    {adr_cnt_prt_vpf_s7[10], adr_cnt_prt_vpf_s7 [12]} <= (adr_cnt_prt_vpf_s6[12][0] > adr_cnt_prt_vpf_s6[10][0]) ? {adr_cnt_prt_vpf_s6[12], adr_cnt_prt_vpf_s6[10]} :{adr_cnt_prt_vpf_s6[10], adr_cnt_prt_vpf_s6[12]};
    {adr_cnt_prt_vpf_s7[13], adr_cnt_prt_vpf_s7 [15]} <= (adr_cnt_prt_vpf_s6[15][0] > adr_cnt_prt_vpf_s6[13][0]) ? {adr_cnt_prt_vpf_s6[15], adr_cnt_prt_vpf_s6[13]} :{adr_cnt_prt_vpf_s6[13], adr_cnt_prt_vpf_s6[15]};
    adr_cnt_prt_vpf_s7[0 ] <= adr_cnt_prt_vpf_s6[0 ];
    adr_cnt_prt_vpf_s7[1 ] <= adr_cnt_prt_vpf_s6[1 ];
    adr_cnt_prt_vpf_s7[11] <= adr_cnt_prt_vpf_s6[11];
    adr_cnt_prt_vpf_s7[14] <= adr_cnt_prt_vpf_s6[14];
    pulse_s7 <= pulse_s6;
end

//------------------------------------------------------------------------------------------------------------------
// stage 8

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s8 [15:0];
reg                    pulse_s8;

always @(*) begin
    {adr_cnt_prt_vpf_s8[1 ], adr_cnt_prt_vpf_s8 [8 ]} <= (adr_cnt_prt_vpf_s7[8 ][0] > adr_cnt_prt_vpf_s7[1 ][0]) ? {adr_cnt_prt_vpf_s7[8 ], adr_cnt_prt_vpf_s7[1 ]} :{adr_cnt_prt_vpf_s7[1 ], adr_cnt_prt_vpf_s7[8 ]};
    {adr_cnt_prt_vpf_s8[3 ], adr_cnt_prt_vpf_s8 [10]} <= (adr_cnt_prt_vpf_s7[10][0] > adr_cnt_prt_vpf_s7[3 ][0]) ? {adr_cnt_prt_vpf_s7[10], adr_cnt_prt_vpf_s7[3 ]} :{adr_cnt_prt_vpf_s7[3 ], adr_cnt_prt_vpf_s7[10]};
    {adr_cnt_prt_vpf_s8[5 ], adr_cnt_prt_vpf_s8 [12]} <= (adr_cnt_prt_vpf_s7[12][0] > adr_cnt_prt_vpf_s7[5 ][0]) ? {adr_cnt_prt_vpf_s7[12], adr_cnt_prt_vpf_s7[5 ]} :{adr_cnt_prt_vpf_s7[5 ], adr_cnt_prt_vpf_s7[12]};
    {adr_cnt_prt_vpf_s8[7 ], adr_cnt_prt_vpf_s8 [14]} <= (adr_cnt_prt_vpf_s7[14][0] > adr_cnt_prt_vpf_s7[7 ][0]) ? {adr_cnt_prt_vpf_s7[14], adr_cnt_prt_vpf_s7[7 ]} :{adr_cnt_prt_vpf_s7[7 ], adr_cnt_prt_vpf_s7[14]};
    adr_cnt_prt_vpf_s8[0 ] <= adr_cnt_prt_vpf_s7[0 ];
    adr_cnt_prt_vpf_s8[2 ] <= adr_cnt_prt_vpf_s7[2 ];
    adr_cnt_prt_vpf_s8[4 ] <= adr_cnt_prt_vpf_s7[4 ];
    adr_cnt_prt_vpf_s8[6 ] <= adr_cnt_prt_vpf_s7[6 ];
    adr_cnt_prt_vpf_s8[9 ] <= adr_cnt_prt_vpf_s7[9 ];
    adr_cnt_prt_vpf_s8[11] <= adr_cnt_prt_vpf_s7[11];
    adr_cnt_prt_vpf_s8[13] <= adr_cnt_prt_vpf_s7[13];
    adr_cnt_prt_vpf_s8[15] <= adr_cnt_prt_vpf_s7[15];
    pulse_s8 <= pulse_s7;
end

//------------------------------------------------------------------------------------------------------------------
// stage 9

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s9 [15:0];
reg                    pulse_s9;

always @(*) begin
    {adr_cnt_prt_vpf_s9[1 ], adr_cnt_prt_vpf_s9 [4 ]} <= (adr_cnt_prt_vpf_s8[4 ][0] > adr_cnt_prt_vpf_s8[1 ][0]) ? {adr_cnt_prt_vpf_s8[4 ], adr_cnt_prt_vpf_s8[1 ]} :{adr_cnt_prt_vpf_s8[1 ], adr_cnt_prt_vpf_s8[4 ]};
    {adr_cnt_prt_vpf_s9[3 ], adr_cnt_prt_vpf_s9 [6 ]} <= (adr_cnt_prt_vpf_s8[6 ][0] > adr_cnt_prt_vpf_s8[3 ][0]) ? {adr_cnt_prt_vpf_s8[6 ], adr_cnt_prt_vpf_s8[3 ]} :{adr_cnt_prt_vpf_s8[3 ], adr_cnt_prt_vpf_s8[6 ]};
    {adr_cnt_prt_vpf_s9[5 ], adr_cnt_prt_vpf_s9 [8 ]} <= (adr_cnt_prt_vpf_s8[8 ][0] > adr_cnt_prt_vpf_s8[5 ][0]) ? {adr_cnt_prt_vpf_s8[8 ], adr_cnt_prt_vpf_s8[5 ]} :{adr_cnt_prt_vpf_s8[5 ], adr_cnt_prt_vpf_s8[8 ]};
    {adr_cnt_prt_vpf_s9[7 ], adr_cnt_prt_vpf_s9 [10]} <= (adr_cnt_prt_vpf_s8[10][0] > adr_cnt_prt_vpf_s8[7 ][0]) ? {adr_cnt_prt_vpf_s8[10], adr_cnt_prt_vpf_s8[7 ]} :{adr_cnt_prt_vpf_s8[7 ], adr_cnt_prt_vpf_s8[10]};
    {adr_cnt_prt_vpf_s9[9 ], adr_cnt_prt_vpf_s9 [12]} <= (adr_cnt_prt_vpf_s8[12][0] > adr_cnt_prt_vpf_s8[9 ][0]) ? {adr_cnt_prt_vpf_s8[12], adr_cnt_prt_vpf_s8[9 ]} :{adr_cnt_prt_vpf_s8[9 ], adr_cnt_prt_vpf_s8[12]};
    {adr_cnt_prt_vpf_s9[11], adr_cnt_prt_vpf_s9 [14]} <= (adr_cnt_prt_vpf_s8[14][0] > adr_cnt_prt_vpf_s8[11][0]) ? {adr_cnt_prt_vpf_s8[14], adr_cnt_prt_vpf_s8[11]} :{adr_cnt_prt_vpf_s8[11], adr_cnt_prt_vpf_s8[14]};
    adr_cnt_prt_vpf_s9[0 ] <= adr_cnt_prt_vpf_s8[0 ];
    adr_cnt_prt_vpf_s9[2 ] <= adr_cnt_prt_vpf_s8[2 ];
    adr_cnt_prt_vpf_s9[13] <= adr_cnt_prt_vpf_s8[13];
    adr_cnt_prt_vpf_s9[15] <= adr_cnt_prt_vpf_s8[15];
    pulse_s9 <= pulse_s8;
end

//------------------------------------------------------------------------------------------------------------------
// stage 10

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s10 [15:0];
reg                    pulse_s10;

always @(posedge clock) begin
    {adr_cnt_prt_vpf_s10[1 ], adr_cnt_prt_vpf_s10[2 ]} <= (adr_cnt_prt_vpf_s9[2 ][0] > adr_cnt_prt_vpf_s9[1 ][0]) ? {adr_cnt_prt_vpf_s9[2 ], adr_cnt_prt_vpf_s9[1 ]} :{adr_cnt_prt_vpf_s9[1 ], adr_cnt_prt_vpf_s9[2 ]};
    {adr_cnt_prt_vpf_s10[3 ], adr_cnt_prt_vpf_s10[4 ]} <= (adr_cnt_prt_vpf_s9[4 ][0] > adr_cnt_prt_vpf_s9[3 ][0]) ? {adr_cnt_prt_vpf_s9[4 ], adr_cnt_prt_vpf_s9[3 ]} :{adr_cnt_prt_vpf_s9[3 ], adr_cnt_prt_vpf_s9[4 ]};
    {adr_cnt_prt_vpf_s10[5 ], adr_cnt_prt_vpf_s10[6 ]} <= (adr_cnt_prt_vpf_s9[6 ][0] > adr_cnt_prt_vpf_s9[5 ][0]) ? {adr_cnt_prt_vpf_s9[6 ], adr_cnt_prt_vpf_s9[5 ]} :{adr_cnt_prt_vpf_s9[5 ], adr_cnt_prt_vpf_s9[6 ]};
    {adr_cnt_prt_vpf_s10[7 ], adr_cnt_prt_vpf_s10[8 ]} <= (adr_cnt_prt_vpf_s9[8 ][0] > adr_cnt_prt_vpf_s9[7 ][0]) ? {adr_cnt_prt_vpf_s9[8 ], adr_cnt_prt_vpf_s9[7 ]} :{adr_cnt_prt_vpf_s9[7 ], adr_cnt_prt_vpf_s9[8 ]};
    {adr_cnt_prt_vpf_s10[9 ], adr_cnt_prt_vpf_s10[10]} <= (adr_cnt_prt_vpf_s9[10][0] > adr_cnt_prt_vpf_s9[9 ][0]) ? {adr_cnt_prt_vpf_s9[10], adr_cnt_prt_vpf_s9[9 ]} :{adr_cnt_prt_vpf_s9[9 ], adr_cnt_prt_vpf_s9[10]};
    {adr_cnt_prt_vpf_s10[11], adr_cnt_prt_vpf_s10[12]} <= (adr_cnt_prt_vpf_s9[12][0] > adr_cnt_prt_vpf_s9[11][0]) ? {adr_cnt_prt_vpf_s9[12], adr_cnt_prt_vpf_s9[11]} :{adr_cnt_prt_vpf_s9[11], adr_cnt_prt_vpf_s9[12]};
    {adr_cnt_prt_vpf_s10[13], adr_cnt_prt_vpf_s10[14]} <= (adr_cnt_prt_vpf_s9[14][0] > adr_cnt_prt_vpf_s9[13][0]) ? {adr_cnt_prt_vpf_s9[14], adr_cnt_prt_vpf_s9[13]} :{adr_cnt_prt_vpf_s9[13], adr_cnt_prt_vpf_s9[14]};
    adr_cnt_prt_vpf_s10[0 ] <= adr_cnt_prt_vpf_s9[0 ];
    adr_cnt_prt_vpf_s10[15] <= adr_cnt_prt_vpf_s9[15];
    pulse_s10 <= pulse_s9;
end

//----------------------------------------------------------------------------------------------------------------------
// Latch Results for Output
//----------------------------------------------------------------------------------------------------------------------
    assign {adr_out0,cnt_out0,prt_out0,vpf_out0} = adr_cnt_prt_vpf_s10[0];
    assign {adr_out1,cnt_out1,prt_out1,vpf_out1} = adr_cnt_prt_vpf_s10[1];
    assign {adr_out2,cnt_out2,prt_out2,vpf_out2} = adr_cnt_prt_vpf_s10[2];
    assign {adr_out3,cnt_out3,prt_out3,vpf_out3} = adr_cnt_prt_vpf_s10[3];
    assign {adr_out4,cnt_out4,prt_out4,vpf_out4} = adr_cnt_prt_vpf_s10[4];
    assign {adr_out5,cnt_out5,prt_out5,vpf_out5} = adr_cnt_prt_vpf_s10[5];
    assign {adr_out6,cnt_out6,prt_out6,vpf_out6} = adr_cnt_prt_vpf_s10[6];
    assign {adr_out7,cnt_out7,prt_out7,vpf_out7} = adr_cnt_prt_vpf_s10[7];
    assign pulse_out = pulse_s10;
//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
