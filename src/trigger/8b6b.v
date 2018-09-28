`timescale 1ns / 100 ps

module eightbit_sixbit (

  input      [7:0] eightbit,

  output reg [5:0] sixbit,

  output reg       not_in_table,

  output reg       char_is_data,

  output reg       l1a,
  output reg       bc0,
  output reg       resync,
  output reg       idle
);

`include "6b8b_common.v"

always @(eightbit) begin

  char_is_data <= 0;

  // fast commands
  l1a    <= (eightbit==L1A_CHAR);
  bc0    <= (eightbit==BC0_CHAR);
  resync <= (eightbit==RESYNC_CHAR);
  idle   <= (eightbit==IDLE_CHAR);

  case (eightbit)

    // fast commands
    L1A_CHAR:    begin sixbit <= 6'b000000; not_in_table <= 1'b0; end
    BC0_CHAR:    begin sixbit <= 6'b000000; not_in_table <= 1'b0; end
    RESYNC_CHAR: begin sixbit <= 6'b000000; not_in_table <= 1'b0; end
    IDLE_CHAR:   begin sixbit <= 6'b000000; not_in_table <= 1'b0; end

    // data words
    8'b01011001: begin sixbit <= 6'b000000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01110001: begin sixbit <= 6'b000001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01110010: begin sixbit <= 6'b000010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11000011: begin sixbit <= 6'b000011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01100101: begin sixbit <= 6'b000100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11000101: begin sixbit <= 6'b000101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11000110: begin sixbit <= 6'b000110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10000111: begin sixbit <= 6'b000111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01101001: begin sixbit <= 6'b001000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11001001: begin sixbit <= 6'b001001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11001010: begin sixbit <= 6'b001010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10001011: begin sixbit <= 6'b001011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11001100: begin sixbit <= 6'b001100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10001101: begin sixbit <= 6'b001101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10001110: begin sixbit <= 6'b001110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01001011: begin sixbit <= 6'b001111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01010011: begin sixbit <= 6'b010000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11010001: begin sixbit <= 6'b010001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11010010: begin sixbit <= 6'b010010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10010011: begin sixbit <= 6'b010011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11010100: begin sixbit <= 6'b010100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10010101: begin sixbit <= 6'b010101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10010110: begin sixbit <= 6'b010110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00010111: begin sixbit <= 6'b010111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11011000: begin sixbit <= 6'b011000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10011001: begin sixbit <= 6'b011001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10011010: begin sixbit <= 6'b011010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00011011: begin sixbit <= 6'b011011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10011100: begin sixbit <= 6'b011100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00011101: begin sixbit <= 6'b011101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00011110: begin sixbit <= 6'b011110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01011100: begin sixbit <= 6'b011111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01100011: begin sixbit <= 6'b100000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11100001: begin sixbit <= 6'b100001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11100010: begin sixbit <= 6'b100010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10100011: begin sixbit <= 6'b100011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11100100: begin sixbit <= 6'b100100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10100101: begin sixbit <= 6'b100101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10100110: begin sixbit <= 6'b100110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00100111: begin sixbit <= 6'b100111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b11101000: begin sixbit <= 6'b101000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10101001: begin sixbit <= 6'b101001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10101010: begin sixbit <= 6'b101010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00101011: begin sixbit <= 6'b101011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10101100: begin sixbit <= 6'b101100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00101101: begin sixbit <= 6'b101101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00101110: begin sixbit <= 6'b101110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01101100: begin sixbit <= 6'b101111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01110100: begin sixbit <= 6'b110000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10110001: begin sixbit <= 6'b110001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10110010: begin sixbit <= 6'b110010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00110011: begin sixbit <= 6'b110011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10110100: begin sixbit <= 6'b110100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00110101: begin sixbit <= 6'b110101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00110110: begin sixbit <= 6'b110110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01010110: begin sixbit <= 6'b110111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b10111000: begin sixbit <= 6'b111000; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00111001: begin sixbit <= 6'b111001; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00111010: begin sixbit <= 6'b111010; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01011010: begin sixbit <= 6'b111011; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b00111100: begin sixbit <= 6'b111100; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01001101: begin sixbit <= 6'b111101; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01001110: begin sixbit <= 6'b111110; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01100110: begin sixbit <= 6'b111111; not_in_table <= 1'b0; char_is_data <= 1'b1; end
    8'b01100110: begin sixbit <= 6'b111111; not_in_table <= 1'b0; char_is_data <= 1'b1; end

    // default = not-in-table
    default:     begin sixbit <= 6'b111111; not_in_table <= 1'b1; end
endcase
end

//----------------------------------------------------------------------------------------------------------------------
endmodule
//----------------------------------------------------------------------------------------------------------------------
