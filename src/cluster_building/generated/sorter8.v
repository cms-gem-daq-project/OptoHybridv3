//-------------------------------------------------------------------------------------
// ATTENTION:
// This file and all of its contents were automatically generated using a python script
// For the love of god DO NOT EDIT it directly but please edit the generator so that
// everything can stay in sync
//-------------------------------------------------------------------------------------

module sorter8 (
    input clock,

    input [MXADRB-1:0] adr_in0,
    input [MXADRB-1:0] adr_in1,
    input [MXADRB-1:0] adr_in2,
    input [MXADRB-1:0] adr_in3,
    input [MXADRB-1:0] adr_in4,
    input [MXADRB-1:0] adr_in5,
    input [MXADRB-1:0] adr_in6,
    input [MXADRB-1:0] adr_in7,

    input [MXCNTB-1:0] cnt_in0,
    input [MXCNTB-1:0] cnt_in1,
    input [MXCNTB-1:0] cnt_in2,
    input [MXCNTB-1:0] cnt_in3,
    input [MXCNTB-1:0] cnt_in4,
    input [MXCNTB-1:0] cnt_in5,
    input [MXCNTB-1:0] cnt_in6,
    input [MXCNTB-1:0] cnt_in7,

    input [MXVPFB-1:0] vpf_in0,
    input [MXVPFB-1:0] vpf_in1,
    input [MXVPFB-1:0] vpf_in2,
    input [MXVPFB-1:0] vpf_in3,
    input [MXVPFB-1:0] vpf_in4,
    input [MXVPFB-1:0] vpf_in5,
    input [MXVPFB-1:0] vpf_in6,
    input [MXVPFB-1:0] vpf_in7,

    input [MXPRTB-1:0] prt_in0,
    input [MXPRTB-1:0] prt_in1,
    input [MXPRTB-1:0] prt_in2,
    input [MXPRTB-1:0] prt_in3,
    input [MXPRTB-1:0] prt_in4,
    input [MXPRTB-1:0] prt_in5,
    input [MXPRTB-1:0] prt_in6,
    input [MXPRTB-1:0] prt_in7,


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
parameter MXVPFB=1;
parameter MXADRB=11;
parameter MXCNTB=3;
//----------------------------------------------------------------------------------------------------------------------
// vectorize inputs
//----------------------------------------------------------------------------------------------------------------------
reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s0 [7:0];
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

    pulse_s0 <= pulse_in;
end


//------------------------------------------------------------------------------------------------------------------
// stage 3

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s3 [7:0];
reg                    pulse_s3;

always @(*) begin
    {adr_cnt_prt_vpf_s3[1 ], adr_cnt_prt_vpf_s3 [2 ]} <= (adr_cnt_prt_vpf_s0[2 ][0] > adr_cnt_prt_vpf_s0[1 ][0]) ? {adr_cnt_prt_vpf_s0[2 ], adr_cnt_prt_vpf_s0[1 ]} :{adr_cnt_prt_vpf_s0[1 ], adr_cnt_prt_vpf_s0[2 ]};
    {adr_cnt_prt_vpf_s3[5 ], adr_cnt_prt_vpf_s3 [6 ]} <= (adr_cnt_prt_vpf_s0[6 ][0] > adr_cnt_prt_vpf_s0[5 ][0]) ? {adr_cnt_prt_vpf_s0[6 ], adr_cnt_prt_vpf_s0[5 ]} :{adr_cnt_prt_vpf_s0[5 ], adr_cnt_prt_vpf_s0[6 ]};
    adr_cnt_prt_vpf_s3[0 ] <= adr_cnt_prt_vpf_s0[0 ];
    adr_cnt_prt_vpf_s3[3 ] <= adr_cnt_prt_vpf_s0[3 ];
    adr_cnt_prt_vpf_s3[4 ] <= adr_cnt_prt_vpf_s0[4 ];
    adr_cnt_prt_vpf_s3[7 ] <= adr_cnt_prt_vpf_s0[7 ];
    pulse_s3 <= pulse_s0;
end

//------------------------------------------------------------------------------------------------------------------
// stage 4

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s4 [7:0];
reg                    pulse_s4;

always @(posedge clock) begin
    {adr_cnt_prt_vpf_s4[0 ], adr_cnt_prt_vpf_s4 [4 ]} <= (adr_cnt_prt_vpf_s3[4 ][0] > adr_cnt_prt_vpf_s3[0 ][0]) ? {adr_cnt_prt_vpf_s3[4 ], adr_cnt_prt_vpf_s3[0 ]} :{adr_cnt_prt_vpf_s3[0 ], adr_cnt_prt_vpf_s3[4 ]};
    {adr_cnt_prt_vpf_s4[1 ], adr_cnt_prt_vpf_s4 [5 ]} <= (adr_cnt_prt_vpf_s3[5 ][0] > adr_cnt_prt_vpf_s3[1 ][0]) ? {adr_cnt_prt_vpf_s3[5 ], adr_cnt_prt_vpf_s3[1 ]} :{adr_cnt_prt_vpf_s3[1 ], adr_cnt_prt_vpf_s3[5 ]};
    {adr_cnt_prt_vpf_s4[2 ], adr_cnt_prt_vpf_s4 [6 ]} <= (adr_cnt_prt_vpf_s3[6 ][0] > adr_cnt_prt_vpf_s3[2 ][0]) ? {adr_cnt_prt_vpf_s3[6 ], adr_cnt_prt_vpf_s3[2 ]} :{adr_cnt_prt_vpf_s3[2 ], adr_cnt_prt_vpf_s3[6 ]};
    {adr_cnt_prt_vpf_s4[3 ], adr_cnt_prt_vpf_s4 [7 ]} <= (adr_cnt_prt_vpf_s3[7 ][0] > adr_cnt_prt_vpf_s3[3 ][0]) ? {adr_cnt_prt_vpf_s3[7 ], adr_cnt_prt_vpf_s3[3 ]} :{adr_cnt_prt_vpf_s3[3 ], adr_cnt_prt_vpf_s3[7 ]};
    pulse_s4 <= pulse_s3;
end

//------------------------------------------------------------------------------------------------------------------
// stage 5

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s5 [7:0];
reg                    pulse_s5;

always @(*) begin
    {adr_cnt_prt_vpf_s5[2 ], adr_cnt_prt_vpf_s5 [4 ]} <= (adr_cnt_prt_vpf_s4[4 ][0] > adr_cnt_prt_vpf_s4[2 ][0]) ? {adr_cnt_prt_vpf_s4[4 ], adr_cnt_prt_vpf_s4[2 ]} :{adr_cnt_prt_vpf_s4[2 ], adr_cnt_prt_vpf_s4[4 ]};
    {adr_cnt_prt_vpf_s5[3 ], adr_cnt_prt_vpf_s5 [5 ]} <= (adr_cnt_prt_vpf_s4[5 ][0] > adr_cnt_prt_vpf_s4[3 ][0]) ? {adr_cnt_prt_vpf_s4[5 ], adr_cnt_prt_vpf_s4[3 ]} :{adr_cnt_prt_vpf_s4[3 ], adr_cnt_prt_vpf_s4[5 ]};
    adr_cnt_prt_vpf_s5[0 ] <= adr_cnt_prt_vpf_s4[0 ];
    adr_cnt_prt_vpf_s5[1 ] <= adr_cnt_prt_vpf_s4[1 ];
    adr_cnt_prt_vpf_s5[6 ] <= adr_cnt_prt_vpf_s4[6 ];
    adr_cnt_prt_vpf_s5[7 ] <= adr_cnt_prt_vpf_s4[7 ];
    pulse_s5 <= pulse_s4;
end

//------------------------------------------------------------------------------------------------------------------
// stage 6

reg  [MXCNTB+MXADRB:0] adr_cnt_prt_vpf_s6 [7:0];
reg                    pulse_s6;

always @(*) begin
    {adr_cnt_prt_vpf_s6[1 ], adr_cnt_prt_vpf_s6 [2 ]} <= (adr_cnt_prt_vpf_s5[2 ][0] > adr_cnt_prt_vpf_s5[1 ][0]) ? {adr_cnt_prt_vpf_s5[2 ], adr_cnt_prt_vpf_s5[1 ]} :{adr_cnt_prt_vpf_s5[1 ], adr_cnt_prt_vpf_s5[2 ]};
    {adr_cnt_prt_vpf_s6[3 ], adr_cnt_prt_vpf_s6 [4 ]} <= (adr_cnt_prt_vpf_s5[4 ][0] > adr_cnt_prt_vpf_s5[3 ][0]) ? {adr_cnt_prt_vpf_s5[4 ], adr_cnt_prt_vpf_s5[3 ]} :{adr_cnt_prt_vpf_s5[3 ], adr_cnt_prt_vpf_s5[4 ]};
    {adr_cnt_prt_vpf_s6[5 ], adr_cnt_prt_vpf_s6 [6 ]} <= (adr_cnt_prt_vpf_s5[6 ][0] > adr_cnt_prt_vpf_s5[5 ][0]) ? {adr_cnt_prt_vpf_s5[6 ], adr_cnt_prt_vpf_s5[5 ]} :{adr_cnt_prt_vpf_s5[5 ], adr_cnt_prt_vpf_s5[6 ]};
    adr_cnt_prt_vpf_s6[0 ] <= adr_cnt_prt_vpf_s5[0 ];
    adr_cnt_prt_vpf_s6[7 ] <= adr_cnt_prt_vpf_s5[7 ];
    pulse_s6 <= pulse_s5;
end

//----------------------------------------------------------------------------------------------------------------------
// Latch Results for Output
//----------------------------------------------------------------------------------------------------------------------
    assign {adr_out0,cnt_out0,prt_out0,vpf_out0} = adr_cnt_prt_vpf_s6[0];
    assign {adr_out1,cnt_out1,prt_out1,vpf_out1} = adr_cnt_prt_vpf_s6[1];
    assign {adr_out2,cnt_out2,prt_out2,vpf_out2} = adr_cnt_prt_vpf_s6[2];
    assign {adr_out3,cnt_out3,prt_out3,vpf_out3} = adr_cnt_prt_vpf_s6[3];
    assign {adr_out4,cnt_out4,prt_out4,vpf_out4} = adr_cnt_prt_vpf_s6[4];
    assign {adr_out5,cnt_out5,prt_out5,vpf_out5} = adr_cnt_prt_vpf_s6[5];
    assign {adr_out6,cnt_out6,prt_out6,vpf_out6} = adr_cnt_prt_vpf_s6[6];
    assign {adr_out7,cnt_out7,prt_out7,vpf_out7} = adr_cnt_prt_vpf_s6[7];
    assign pulse_out = pulse_s6;
//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
