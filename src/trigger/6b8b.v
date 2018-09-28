`timescale 1ns / 100 ps

module sixbit_eightbit (

  input l1a,
  input bc0,
  input resync,

  input idle,

  input      [5:0] sixbit,
  output reg [7:0] eightbit
);

`include "6b8b_common.v"

always @(*) begin

  if      (idle)   eightbit <= IDLE_CHAR;
  else if (l1a)    eightbit <= L1A_CHAR;
  else if (bc0)    eightbit <= BC0_CHAR;
  else if (resync) eightbit <= RESYNC_CHAR;
  else begin
    case (sixbit)
        6'b000000: eightbit <= 8'b01011001;
        6'b000001: eightbit <= 8'b01110001;
        6'b000010: eightbit <= 8'b01110010;
        6'b000011: eightbit <= 8'b11000011;
        6'b000100: eightbit <= 8'b01100101;
        6'b000101: eightbit <= 8'b11000101;
        6'b000110: eightbit <= 8'b11000110;
        6'b000111: eightbit <= 8'b10000111;
        6'b001000: eightbit <= 8'b01101001;
        6'b001001: eightbit <= 8'b11001001;
        6'b001010: eightbit <= 8'b11001010;
        6'b001011: eightbit <= 8'b10001011;
        6'b001100: eightbit <= 8'b11001100;
        6'b001101: eightbit <= 8'b10001101;
        6'b001110: eightbit <= 8'b10001110;
        6'b001111: eightbit <= 8'b01001011;
        6'b010000: eightbit <= 8'b01010011;
        6'b010001: eightbit <= 8'b11010001;
        6'b010010: eightbit <= 8'b11010010;
        6'b010011: eightbit <= 8'b10010011;
        6'b010100: eightbit <= 8'b11010100;
        6'b010101: eightbit <= 8'b10010101;
        6'b010110: eightbit <= 8'b10010110;
        6'b010111: eightbit <= 8'b00010111;
        6'b011000: eightbit <= 8'b11011000;
        6'b011001: eightbit <= 8'b10011001;
        6'b011010: eightbit <= 8'b10011010;
        6'b011011: eightbit <= 8'b00011011;
        6'b011100: eightbit <= 8'b10011100;
        6'b011101: eightbit <= 8'b00011101;
        6'b011110: eightbit <= 8'b00011110;
        6'b011111: eightbit <= 8'b01011100;
        6'b100000: eightbit <= 8'b01100011;
        6'b100001: eightbit <= 8'b11100001;
        6'b100010: eightbit <= 8'b11100010;
        6'b100011: eightbit <= 8'b10100011;
        6'b100100: eightbit <= 8'b11100100;
        6'b100101: eightbit <= 8'b10100101;
        6'b100110: eightbit <= 8'b10100110;
        6'b100111: eightbit <= 8'b00100111;
        6'b101000: eightbit <= 8'b11101000;
        6'b101001: eightbit <= 8'b10101001;
        6'b101010: eightbit <= 8'b10101010;
        6'b101011: eightbit <= 8'b00101011;
        6'b101100: eightbit <= 8'b10101100;
        6'b101101: eightbit <= 8'b00101101;
        6'b101110: eightbit <= 8'b00101110;
        6'b101111: eightbit <= 8'b01101100;
        6'b110000: eightbit <= 8'b01110100;
        6'b110001: eightbit <= 8'b10110001;
        6'b110010: eightbit <= 8'b10110010;
        6'b110011: eightbit <= 8'b00110011;
        6'b110100: eightbit <= 8'b10110100;
        6'b110101: eightbit <= 8'b00110101;
        6'b110110: eightbit <= 8'b00110110;
        6'b110111: eightbit <= 8'b01010110;
        6'b111000: eightbit <= 8'b10111000;
        6'b111001: eightbit <= 8'b00111001;
        6'b111010: eightbit <= 8'b00111010;
        6'b111011: eightbit <= 8'b01011010;
        6'b111100: eightbit <= 8'b00111100;
        6'b111101: eightbit <= 8'b01001101;
        6'b111110: eightbit <= 8'b01001110;
        6'b111111: eightbit <= 8'b01100110;
    endcase
  end
end

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
