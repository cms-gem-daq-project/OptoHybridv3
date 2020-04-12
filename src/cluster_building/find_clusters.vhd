library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.hardware_pkg.all;

entity find_clusters is
  port (
    clock : in std_logic;

    latch_in : in std_logic;            -- this should go high when new vpfs are ready and stay high for just 1 clock

    vpfs_in : in std_logic_vector (MXSBITS*MXVFATS -1 downto 0);
    cnts_in : in std_logic_vector (MXSBITS*MXVFATS*3-1 downto 0);

    clusters_o : out sbit_cluster_array_t (g_NUM_CLUSTERS-1 downto 0);

    latch_out : out std_logic           -- this should go high when new vpfs are ready and stay high for just 1 clock
    );
end find_clusters;

architecture behavioral of find_clusters is

  function correct_address_ge11 (ge11 : boolean; adr : std_logic_vector) return std_logic_vector is
  begin
    if (ge11 and adr > 191) then
      return adr-192;
    else
      return adr;
    end if;
  end correct_address_ge11;

  function correct_partition_ge11 (ge11 : boolean; adr : std_logic_vector) return integer is
  begin
    if (ge11 and adr > 191) then
      return 1;
    else
      return 0;
    end if;
  end correct_partition_ge11;

  function if_then_else (bool : boolean; a : std_logic; b : std_logic) return std_logic is
  begin
    if (bool) then
      return a;
    else
      return b;
    end if;
  end if_then_else;

  constant NUM_ENCODERS : integer := if_then_else (GE11 = 1, 4, 2);
  constant NUM_CYCLES   : integer := 4;  -- number of clocks (4 for 160MHz, 5 for 200MHz)
  constant ENCODER_SIZE : integer := 384;

  signal clusters_buf : sbit_cluster_array_t (NUM_ENCODERS*NUM_CYCLES-1 downto 0);

  -- ------------------------------------------------------------------------------------------------------------------------
  -- -- Signals
  -- ------------------------------------------------------------------------------------------------------------------------
  --
  -- wire [MXSBITS*MXVFATS-1:0] vpfs_truncated;
  --
  -- wire   [MXADRB_ENC-1:0] adr_enc [NUM_ENCODERS-1:0];
  -- wire   [           0:0] vpf_enc [NUM_ENCODERS-1:0];
  -- wire   [MXCNTB -1   :0] cnt_enc [NUM_ENCODERS-1:0];
  --
  -- ------------------------------------------------------------------------------------------------------------------------
  -- -- Encoders
  -- ------------------------------------------------------------------------------------------------------------------------
  --
  -- reg [MXPRTB-1:0] prt_latch [NUM_ENCODERS-1:0][NUM_CYCLES-1:0];
  -- reg [MXADRB-1:0] adr_latch [NUM_ENCODERS-1:0][NUM_CYCLES-1:0];
  -- reg [MXCNTB-1:0] cnt_latch [NUM_ENCODERS-1:0][NUM_CYCLES-1:0];
  -- reg [       0:0] vpf_latch [NUM_ENCODERS-1:0][NUM_CYCLES-1:0];
  --
  -- -- carry along a marker showing the ith cluster which is being processed-- used for sync
  -- wire [MXCNTB-1:0] pass_truncate [NUM_ENCODERS-1:0];
  -- wire [MXCNTB-1:0] pass_encoder  [NUM_ENCODERS-1:0];
  --
  -- reg latch_out_s1=0;
  --
  -- reg    [MXSBITS*MXVFATS*3-1:0] cnts_dly1;
-- reg  [0:0]        vpf_s1 [NUM_ENCODERS*NUM_CYCLES-1:0];
-- reg  [MXADRB-1:0] adr_s1 [NUM_ENCODERS*NUM_CYCLES-1:0];
-- reg  [MXCNTB-1:0] cnt_s1 [NUM_ENCODERS*NUM_CYCLES-1:0];

begin

  -- GE2/1 uses 1 384 bit encoder per partition
  -- 2 partitions total, returning 4 or 5 clusters / clock from each partition
  -- 2 encoders total
  -- (8 or 10 clusters total)
  --
  -- GE2/1 uses 1 384 bit encoder per TWO partitions
  -- 8 partitions total, returning 4 or 5 clusters / clock from each di-partition
  -- 4 encoders total
  -- (16 clusters total)

  process (clock)
  begin
    if (rising_edge(clock)) then
      if (pass_encoder(ienc) = i) then
        cnts_dly1 <= cnts_in;
      end if;
    end if;
  end process;

  --                _____   _____   _____   _____   _____   _____   _____   _____
  -- clk_in      ___|   |___|   |___|   |___|   |___|   |___|   |___|   |___|   |
  --                 _______________________________
  -- data_in     ___/                               \____________________________
  --                _________
  -- valid_in    ___|       |____________________________________________________
  --                         _______________________________
  -- data_trunc  ___________/                               \____________________
  --                        _________
  -- valid_trunc ___________|       |____________________________________________
  --
  -- cycle_trunc            |  Zero | One   | Two   | Three |
  --                                                              _________
  -- valid_prior            ----priority encoder pipline stages-->|       |_______
  --
  -- cycle_prior                                                  |  Zero | One

  encoder_gen : for I in 0 to (NUM_ENCODERS-1) generate

    -- 384-bit truncator
    ----------------------------
    truncate_clusters_inst : entity work.truncate_clusters
      generic map (
        MXVPF  => ENCODER_SIZE,
        MXSEGS => 12
        )
      port map (
        clock       => clock,
        latch_pulse => latch_in,
        vpfs_in     => vpfs_in (384*(I+1)-1 downto 384*I),
        vpfs_out    => vpfs_truncated(384*(I+1)-1 downto 384*I),
        pass        => pass_truncated(I)
        );

    -- 384-bit priority encoder
    ----------------------------
    priority384_inst : entity work.priority384
      port map (
        pass_in  => pass_truncate(I),
        pass_out => pass_encoder(I),
        clock    => clock,
        vpfs_in  => vpfs_truncated(384 *(I+1)-1 downto 384 *I),
        cnts_in  => cnts_dly1 (384*3*(I+1)-1 downto 384*3*I),
        cnt      => cnt_enc(I),
        adr      => adr_enc(I),
        vpf      => vpf_enc(I)
        );

    -- GE1/1 handles 2 partitions per encoder, need to subtract 192 and add +1 to ienc
    -- if (adr>191) adr = adr-192
    -- if (adr>191) prt = prt + 1
    process (clock)
    begin
      if (rising_edge(clock)) then
        clusters_buf(I)(ienc*NUM_CYCLES + pass_encoder(I)).adr <= correct_address_ge11(GE11 = 1, adr_enc(ienc));
        clusters_buf(I)(ienc*NUM_CYCLES + pass_encoder(I)).cnt <= cnt_enc(ienc);
        clusters_buf(I)(ienc*NUM_CYCLES + pass_encoder(I)).vpf <= vpf_enc(ienc);
        clusters_buf(I)(ienc*NUM_CYCLES + pass_encoder(I)).prt <= std_logic_vector(to_unsigned(ienc + correct_partition_ge11 (GE11 = 1, adr_enc(ienc)), MXPRTB));
      end if;
    end process;
  end generate;

  -- latch outputs of priority encoder when it produces its results, stable for sorter
  process (clock)
  begin
    if (rising_edge(clock)) then
      if (pass_encoder(0) = 0) then
        latch_out_s1 <= '1';
        clusters_s1  <= clusters_buf;
      else
        latch_out_s1 <= '0';
      end if;
    end if;
  end process;

  ---------------------------------------------------------------------------------------------------------------------
  -- Cluster Sorter
  --------------------------------------------------------------------------------------------------------------------

  -- we get up to 16 clusters / bx but only get to send a few so we put them in order

  ge21 : if (GE21 = 1) generate
    sorter8 : entity work.sorter8
      generic map (
        MXADRB => MXADRB,
        MXCNTB => MXCNTB,
        MXVPFB => 1
        )
      port map (
        clock => clock,

        -- inputs

        adr_in0 => clusters_s1(0).adr,
        adr_in1 => clusters_s1(0).adr,
        adr_in2 => clusters_s1(0).adr,
        adr_in3 => clusters_s1(0).adr,
        adr_in4 => clusters_s1(0).adr,
        adr_in5 => clusters_s1(0).adr,
        adr_in6 => clusters_s1(0).adr,
        adr_in7 => clusters_s1(0).adr,

        cnt_in0 => clusters_s1(0).cnt,
        cnt_in1 => clusters_s1(0).cnt,
        cnt_in2 => clusters_s1(0).cnt,
        cnt_in3 => clusters_s1(0).cnt,
        cnt_in4 => clusters_s1(0).cnt,
        cnt_in5 => clusters_s1(0).cnt,
        cnt_in6 => clusters_s1(0).cnt,
        cnt_in7 => clusters_s1(0).cnt,

        vpf_in0 => clusters_s1(0).vpf,
        vpf_in1 => clusters_s1(0).vpf,
        vpf_in2 => clusters_s1(0).vpf,
        vpf_in3 => clusters_s1(0).vpf,
        vpf_in4 => clusters_s1(0).vpf,
        vpf_in5 => clusters_s1(0).vpf,
        vpf_in6 => clusters_s1(0).vpf,
        vpf_in7 => clusters_s1(0).vpf,

        prt_in0 => clusters_s1(0).prt,
        prt_in1 => clusters_s1(0).prt,
        prt_in2 => clusters_s1(0).prt,
        prt_in3 => clusters_s1(0).prt,
        prt_in4 => clusters_s1(0).prt,
        prt_in5 => clusters_s1(0).prt,
        prt_in6 => clusters_s1(0).prt,
        prt_in7 => clusters_s1(0).prt,

        -- outputs
        adr_out0 => clusters_o(0).adr,
        adr_out1 => clusters_o(1).adr,
        adr_out2 => clusters_o(2).adr,
        adr_out3 => clusters_o(3).adr,
        adr_out4 => clusters_o(4).adr,
        adr_out5 => clusters_o(5).adr,
        adr_out6 => clusters_o(6).adr,
        adr_out7 => clusters_o(7).adr,

        prt_out0 => clusters_o(0).prt,
        prt_out1 => clusters_o(1).prt,
        prt_out2 => clusters_o(2).prt,
        prt_out3 => clusters_o(3).prt,
        prt_out4 => clusters_o(4).prt,
        prt_out5 => clusters_o(5).prt,
        prt_out6 => clusters_o(6).prt,
        prt_out7 => clusters_o(7).prt,

        vpf_out0 => clusters_o(0).vpf,
        vpf_out1 => clusters_o(1).vpf,
        vpf_out2 => clusters_o(2).vpf,
        vpf_out3 => clusters_o(3).vpf,
        vpf_out4 => clusters_o(4).vpf,
        vpf_out5 => clusters_o(5).vpf,
        vpf_out6 => clusters_o(6).vpf,
        vpf_out7 => clusters_o(7).vpf,

        cnt_out0 => clusters_o(0).cnt,
        cnt_out1 => clusters_o(1).cnt,
        cnt_out2 => clusters_o(2).cnt,
        cnt_out3 => clusters_o(3).cnt,
        cnt_out4 => clusters_o(4).cnt,
        cnt_out5 => clusters_o(5).cnt,
        cnt_out6 => clusters_o(6).cnt,
        cnt_out7 => clusters_o(7).cnt,

        pulse_in  => latch_out_s1,
        pulse_out => latch_out_s2
        );
  end generate;

---------------------------------------------------------------------------------------------------------------------
-- Outputs
-- ------------------------------------------------------------------------------------------------------------------

--    `ifdef output_latch
--    always @(posedge clock)
--  begin
--    `else
--    always @(*)
--      begin
--        `endif
--
--        adr0 <= adr_s2[0];
--        adr1 <= adr_s2[1];
--        adr2 <= adr_s2[2];
--        adr3 <= adr_s2[3];
--        adr4 <= adr_s2[4];
--        adr5 <= adr_s2[5];
--        adr6 <= adr_s2[6];
--        adr7 <= adr_s2[7];
--
--        prt0 <= prt_s2[0];
--        prt1 <= prt_s2[1];
--        prt2 <= prt_s2[2];
--        prt3 <= prt_s2[3];
--        prt4 <= prt_s2[4];
--        prt5 <= prt_s2[5];
--        prt6 <= prt_s2[6];
--        prt7 <= prt_s2[7];
--
--        cnt0 <= cnt_s2[0];
--        cnt1 <= cnt_s2[1];
--        cnt2 <= cnt_s2[2];
--        cnt3 <= cnt_s2[3];
--        cnt4 <= cnt_s2[4];
--        cnt5 <= cnt_s2[5];
--        cnt6 <= cnt_s2[6];
--        cnt7 <= cnt_s2[7];
--
--        vpf0 <= vpf_s2[0];
--        vpf1 <= vpf_s2[1];
--        vpf2 <= vpf_s2[2];
--        vpf3 <= vpf_s2[3];
--        vpf4 <= vpf_s2[4];
--        vpf5 <= vpf_s2[5];
--        vpf6 <= vpf_s2[6];
--        vpf7 <= vpf_s2[7];
--
--        latch_out <= latch_out_s2;
--      end

end behavioral;

end behavioral;
