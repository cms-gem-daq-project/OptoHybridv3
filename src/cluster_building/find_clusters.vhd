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

    vpfs_in : in std_logic_vector (MXSBITS*c_NUM_VFATS -1 downto 0);
    cnts_in : in std_logic_vector (MXSBITS*c_NUM_VFATS*3-1 downto 0);

    clusters_o : out sbit_cluster_array_t (NUM_FOUND_CLUSTERS_PER_BX-1 downto 0);

    latch_out : out std_logic           -- this should go high when new vpfs are ready and stay high for just 1 clock
    );
end find_clusters;

architecture behavioral of find_clusters is

  function int (vec : std_logic_vector) return integer is
  begin
    return to_integer(unsigned(vec));
  end int;

  function correct_address_ge11 (is_ge11 : boolean; adr : std_logic_vector) return std_logic_vector is
  begin
    if (is_ge11 and int(adr) > 191) then
      return std_logic_vector(
        to_unsigned(
          int(adr)-192,
          adr'length)
        );
    else
      return adr;
    end if;
  end correct_address_ge11;

  function to_partition (is_ge11 : boolean; encoder : integer; adr : std_logic_vector) return std_logic_vector is
    variable odd : integer;
    variable prt : integer;
  begin
    if (not is_ge11) then
      prt := encoder;
    else
      if (is_ge11 and int(adr) > 191) then
        odd := 1;
      else
        odd := 0;
      end if;
      prt := odd + encoder*2;
    end if;
    return std_logic_vector(to_unsigned(prt, MXPRTB));
  end to_partition;


  constant NUM_ENCODERS : integer := if_then_else (GE11 = 1, 4, 2);
  constant NUM_CYCLES   : integer := 4;  -- number of clocks (4 for 160MHz, 5 for 200MHz)
  constant ENCODER_SIZE : integer := 384;

  --------------------------------------------------------------------------------
  -- Signals
  --------------------------------------------------------------------------------

  signal clusters_s1  : sbit_cluster_array_t (NUM_FOUND_CLUSTERS_PER_BX-1 downto 0);
  signal latch_out_s1 : std_logic_vector (1 downto 0);

begin

  -- GE2/1 uses 1 384 bit encoder per partition
  -- 2 partitions total, returning 4 or 5 clusters / clock from each partition
  -- 2 encoders total
  -- 8 or 10 clusters total, depending on 160MHz or 200MHz clock (200M not supported right now but is possible)
  --
  -- GE1/1 uses 1 384 bit encoder per TWO partitions
  -- 8 partitions total, returning 4 or 5 clusters / clock from each di-partition
  -- 4 encoders total
  -- 16 clusters total

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

    signal truncator_cycle : std_logic_vector (2 downto 0);
    signal encoder_cycle   : std_logic_vector (2 downto 0);
    signal clusters_buf    : sbit_cluster_array_t (NUM_CYCLES-1 downto 0);

    signal adr_enc : std_logic_vector(MXADRB-1 downto 0);
    signal cnt_enc : std_logic_vector(MXCNTB-1 downto 0);
    signal vpf_enc : std_logic;

    signal vpfs_truncated : std_logic_vector (ENCODER_SIZE-1 downto 0);

    signal cnts_dly : std_logic_vector (ENCODER_SIZE*3-1 downto 0);

    component truncate_clusters
      generic (
        MXVPF  : integer;
        MXSEGS : integer
        );
      port (
        clock       : in  std_logic;
        latch_pulse : in  std_logic;
        pass_o      : out std_logic_vector;
        vpfs_in     : in  std_logic_vector;
        vpfs_out    : out std_logic_vector
        );
    end component;

    component priority384
      port (
        clock    : in  std_logic;
        pass_in  : in  std_logic_vector;
        vpfs_in  : in  std_logic_vector;
        cnts_in  : in  std_logic_vector;
        pass_out : out std_logic_vector;
        cnt      : out std_logic_vector;
        adr      : out std_logic_vector;
        vpf      : out std_logic
        );
    end component;

  begin

    process (clock)
    begin
      if (rising_edge(clock)) then
        cnts_dly <= cnts_in (ENCODER_SIZE*MXCNTB*(I+1)-1 downto ENCODER_SIZE*MXCNTB*I);
      end if;
    end process;

    -- parameterizable width truncator
    ----------------------------
    truncate_clusters_inst : truncate_clusters
      generic map (
        MXVPF  => ENCODER_SIZE,
        MXSEGS => 12
        )
      port map (
        clock       => clock,
        latch_pulse => latch_in,
        vpfs_in     => vpfs_in (ENCODER_SIZE*(I+1)-1 downto ENCODER_SIZE*I),
        vpfs_out    => vpfs_truncated (ENCODER_SIZE-1 downto 0),
        pass_o      => truncator_cycle
        );

    -- n-bit priority encoder
    ----------------------------
    priority384_inst : priority384
      port map (
        clock    => clock,
        pass_in  => truncator_cycle,
        pass_out => encoder_cycle,
        vpfs_in  => vpfs_truncated,
        cnts_in  => cnts_dly,
        cnt      => cnt_enc,
        adr      => adr_enc,
        vpf      => vpf_enc
        );

    process (clock)
    begin

      -- GE1/1 handles 2 partitions per encoder, need to subtract 192 and add +1 to ienc
      -- if (adr>191) adr = adr-192
      -- if (adr>191) prt = prt + 1
      if (rising_edge(clock)) then
        for cycle in 0 to NUM_CYCLES-1 loop
          if (cycle = int(encoder_cycle)) then
            clusters_buf(cycle).adr <= correct_address_ge11(GE11 = 1, adr_enc);
            clusters_buf(cycle).cnt <= cnt_enc;
            clusters_buf(cycle).vpf <= vpf_enc;
            clusters_buf(cycle).prt <= to_partition (GE11 = 1, I, adr_enc);
          end if;
        end loop;  -- J
      end if;

      -- latch outputs of priority encoder when it produces its results, stable for sorter
      if (rising_edge(clock)) then
        if (int(encoder_cycle) = 0) then
          latch_out_s1(I)                    <= '1';
          clusters_s1 ((I+1)*NUM_CYCLES-1 downto NUM_CYCLES*I) <= clusters_buf(NUM_CYCLES-1 downto 0);
        else
          latch_out_s1(I) <= '0';
        end if;
      end if;
    end process;

  end generate;

  ---------------------------------------------------------------------------------------------------------------------
  -- Cluster Sorter
  --------------------------------------------------------------------------------------------------------------------

  -- we get up to 16 clusters / bx but only get to send a few so we put them in order of priority
  -- (should choose lowest addr first--- highest addr is invalid)

  sort_ge21 : if (GE21 = 1) generate

    component sorter8
      generic (
        MXADRB : integer;
        MXCNTB : integer;
        MXPRTB : integer;
        MXVPFB : integer
        );
      port (
        clock : in std_logic;

        pulse_in  : in  std_logic;
        pulse_out : out std_logic;

        prt_in0 : in std_logic_vector;
        prt_in1 : in std_logic_vector;
        prt_in2 : in std_logic_vector;
        prt_in3 : in std_logic_vector;
        prt_in4 : in std_logic_vector;
        prt_in5 : in std_logic_vector;
        prt_in6 : in std_logic_vector;
        prt_in7 : in std_logic_vector;

        adr_in0 : in std_logic_vector;
        adr_in1 : in std_logic_vector;
        adr_in2 : in std_logic_vector;
        adr_in3 : in std_logic_vector;
        adr_in4 : in std_logic_vector;
        adr_in5 : in std_logic_vector;
        adr_in6 : in std_logic_vector;
        adr_in7 : in std_logic_vector;

        cnt_in0 : in std_logic_vector;
        cnt_in1 : in std_logic_vector;
        cnt_in2 : in std_logic_vector;
        cnt_in3 : in std_logic_vector;
        cnt_in4 : in std_logic_vector;
        cnt_in5 : in std_logic_vector;
        cnt_in6 : in std_logic_vector;
        cnt_in7 : in std_logic_vector;

        vpf_in0 : in std_logic;
        vpf_in1 : in std_logic;
        vpf_in2 : in std_logic;
        vpf_in3 : in std_logic;
        vpf_in4 : in std_logic;
        vpf_in5 : in std_logic;
        vpf_in6 : in std_logic;
        vpf_in7 : in std_logic;

        prt_out0 : out std_logic_vector;
        prt_out1 : out std_logic_vector;
        prt_out2 : out std_logic_vector;
        prt_out3 : out std_logic_vector;
        prt_out4 : out std_logic_vector;
        prt_out5 : out std_logic_vector;
        prt_out6 : out std_logic_vector;
        prt_out7 : out std_logic_vector;

        adr_out0 : out std_logic_vector;
        adr_out1 : out std_logic_vector;
        adr_out2 : out std_logic_vector;
        adr_out3 : out std_logic_vector;
        adr_out4 : out std_logic_vector;
        adr_out5 : out std_logic_vector;
        adr_out6 : out std_logic_vector;
        adr_out7 : out std_logic_vector;

        cnt_out0 : out std_logic_vector;
        cnt_out1 : out std_logic_vector;
        cnt_out2 : out std_logic_vector;
        cnt_out3 : out std_logic_vector;
        cnt_out4 : out std_logic_vector;
        cnt_out5 : out std_logic_vector;
        cnt_out6 : out std_logic_vector;
        cnt_out7 : out std_logic_vector;

        vpf_out0 : out std_logic;
        vpf_out1 : out std_logic;
        vpf_out2 : out std_logic;
        vpf_out3 : out std_logic;
        vpf_out4 : out std_logic;
        vpf_out5 : out std_logic;
        vpf_out6 : out std_logic;
        vpf_out7 : out std_logic
        );
    end component;
  begin

    sorter8_inst : sorter8
      generic map (
        MXADRB => MXADRB,
        MXCNTB => MXCNTB,
        MXPRTB => MXPRTB,
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

        pulse_in  => latch_out_s1(0),
        pulse_out => latch_out
        );
  end generate;

end behavioral;
