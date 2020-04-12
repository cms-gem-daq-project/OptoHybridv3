module count_clusters (
    input clock4x,

    input  [767:0] vpfs_i,

    output reg [10:0] cnt_o,

    output reg overflow_o
);

  reg [2 : 0] cnt_s1  [127 : 0]; // count to 6
  reg [3 : 0] cnt_s2  [63 : 0];  // count to 12
  reg [4 : 0] cnt_s3  [31 : 0];  // count to 24
  reg [5 : 0] cnt_s4  [15 : 0];  // count to 48
  reg [6 : 0] cnt_s5  [ 7 : 0];  // count to 96
  reg [8 : 0] cnt_s6  [ 3 : 0];  // count to 192
  reg [9 : 0] cnt_s7  [ 1 : 0];  // count to 768

  reg [10:0] cnt; // count to 1536

  // register inputs
  // make sure Xilinx doesn't merge these with copies in the cluster finding
  (*EQUIVALENT_REGISTER_REMOVAL="NO"*)
  reg  [767:0] vpfs_s0;
  (*EQUIVALENT_REGISTER_REMOVAL="NO"*)
  reg  [767:0] vpfs;
  always @(posedge clock4x) begin
    vpfs_s0 <= vpfs_i;
    vpfs    <= vpfs_s0;
  end


  genvar icnt;

  generate
  for (icnt=0; icnt<(128); icnt=icnt+1) begin: cnt_s1_loop
    always @(posedge clock4x)
      cnt_s1[icnt] <= count1s(vpfs[(icnt+1)*6-1:icnt*6]);
  end
  endgenerate

  generate
  for (icnt=0; icnt<(64); icnt=icnt+1) begin: cnt_s2_loop
    always @(posedge clock4x)
        cnt_s2[icnt] <= cnt_s1[(icnt+1)*2-1] + cnt_s1[icnt*2];
  end
  endgenerate

  generate
  for (icnt=0; icnt<(32); icnt=icnt+1) begin: cnt_s3_loop
    always @(posedge clock4x)
      cnt_s3[icnt] <= cnt_s2[(icnt+1)*2-1] + cnt_s2[icnt*2];
  end
  endgenerate

  generate
  for (icnt=0; icnt<(16); icnt=icnt+1) begin: cnt_s4_loop
    always @(posedge clock4x)
      cnt_s4[icnt] <= cnt_s3[(icnt+1)*2-1] + cnt_s3[icnt*2];
  end
  endgenerate

  generate
  for (icnt=0; icnt<(8); icnt=icnt+1) begin: cnt_s5_loop
    always @(posedge clock4x)
      cnt_s5[icnt] <= cnt_s4[(icnt+1)*2-1] + cnt_s4[icnt*2];
  end
  endgenerate

  generate
  for (icnt=0; icnt<(4); icnt=icnt+1) begin: cnt_s6_loop
    always @(posedge clock4x)
      cnt_s6[icnt] <= cnt_s5[(icnt+1)*2-1] + cnt_s5[icnt*2];
  end
  endgenerate

  always @(posedge clock4x) begin
    cnt_s7[0] <= cnt_s6[0]  + cnt_s6[1]  + cnt_s6[2]  + cnt_s6[3];
    cnt_s7[1] <= 0;
 // cnt_s7[1] <= cnt_s6[4]  + cnt_s6[5]  + cnt_s6[6]  + cnt_s6[7];
  end

  // delay count by bx to align with overflow
  always @(posedge clock4x) begin
    cnt <= cnt_s7[0] + cnt_s7[1];
    cnt_o <= cnt;
    overflow_o <= (cnt > 8);
  end

//------------------------------------------------------------------------------------------------------------------------
//  prodcedural function to sum number of layers hit into a binary value - rom version
//  returns   count1s = (inp[5]+inp[4]+inp[3])+(inp[2]+inp[1]+inp[0]);
//------------------------------------------------------------------------------------------------------------------------

  function  [2:0] count1s;
  input     [5:0] inp;
  reg       [2:0] rom;

  begin
  case(inp[5:0])
  6'b000000: rom = 0;
  6'b000001: rom = 1;
  6'b000010: rom = 1;
  6'b000011: rom = 2;
  6'b000100: rom = 1;
  6'b000101: rom = 2;
  6'b000110: rom = 2;
  6'b000111: rom = 3;
  6'b001000: rom = 1;
  6'b001001: rom = 2;
  6'b001010: rom = 2;
  6'b001011: rom = 3;
  6'b001100: rom = 2;
  6'b001101: rom = 3;
  6'b001110: rom = 3;
  6'b001111: rom = 4;
  6'b010000: rom = 1;
  6'b010001: rom = 2;
  6'b010010: rom = 2;
  6'b010011: rom = 3;
  6'b010100: rom = 2;
  6'b010101: rom = 3;
  6'b010110: rom = 3;
  6'b010111: rom = 4;
  6'b011000: rom = 2;
  6'b011001: rom = 3;
  6'b011010: rom = 3;
  6'b011011: rom = 4;
  6'b011100: rom = 3;
  6'b011101: rom = 4;
  6'b011110: rom = 4;
  6'b011111: rom = 5;
  6'b100000: rom = 1;
  6'b100001: rom = 2;
  6'b100010: rom = 2;
  6'b100011: rom = 3;
  6'b100100: rom = 2;
  6'b100101: rom = 3;
  6'b100110: rom = 3;
  6'b100111: rom = 4;
  6'b101000: rom = 2;
  6'b101001: rom = 3;
  6'b101010: rom = 3;
  6'b101011: rom = 4;
  6'b101100: rom = 3;
  6'b101101: rom = 4;
  6'b101110: rom = 4;
  6'b101111: rom = 5;
  6'b110000: rom = 2;
  6'b110001: rom = 3;
  6'b110010: rom = 3;
  6'b110011: rom = 4;
  6'b110100: rom = 3;
  6'b110101: rom = 4;
  6'b110110: rom = 4;
  6'b110111: rom = 5;
  6'b111000: rom = 3;
  6'b111001: rom = 4;
  6'b111010: rom = 4;
  6'b111011: rom = 5;
  6'b111100: rom = 4;
  6'b111101: rom = 5;
  6'b111110: rom = 5;
  6'b111111: rom = 6;
  endcase

  count1s = rom;

  end
  endfunction

endmodule
