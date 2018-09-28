module device_dna (
  input clock,
  input reset,
  output reg [56:0] dna
);

   wire DOUT, CLK, DIN; 
	reg  READ, SHIFT;

   reg [56:0] dna_sr;
   reg  [5:0] read_cnt;
	
   always @(posedge clock) begin

     if      (reset)         begin read_cnt <= 0;               SHIFT <= 1'b0; READ <= 1'b1; end
     else if (read_cnt < 56) begin read_cnt <= read_cnt + 1'b1; SHIFT <= 1'b1; READ <= 1'b0; end
     else                    begin read_cnt <= read_cnt;        SHIFT <= 1'b0; READ <= 1'b0; end

     dna_sr <= {dna_sr[55:0], DOUT};

     if (read_cnt==56)
        dna <= dna_sr;

   end

   assign CLK  = clock;
   assign DIN  = DOUT;

   DNA_PORT #(
      .SIM_DNA_VALUE(57'h123456789abcdef)  // Specifies the Pre-programmed factory ID value for simulation
   )
   DNA_PORT_inst (
      .DOUT      (DOUT), // 1-bit output: DNA output data
      .CLK       (CLK),  // 1-bit input: Clock input
      .DIN       (DIN),  // 1-bit input: User data input pin
      .READ      (READ), // 1-bit input: Active high load DNA, active low read input
      .SHIFT     (SHIFT) // 1-bit input: Active high SHIFT enable input
   );

   // End of DNA_PORT_inst instantiation

 endmodule
