-- https://gitlab.cern.ch/tdr/notes/DN-20-016/blob/master/temp/DN-20-016_temp.pdf
--
-- TODO: Only empty clusters are sent for 4 orbits following a resync signal, thus guaranteeing that the comma/bc0
--       symbols will not be replaced by CL WORD4 during this time
--
-- TODO: Whenever the number of clusters reaches the limit of the bandwidth provided by CL WORD0
--       CL WORD3 (8 clusters in 2 link OHs, and 4 cluster in 1 link OHs), the CL WORD4 is used,
--       and replaces the ECC8 + Comma/bc0 word, however a maximum delay of 100 BXs is guaran-
--       teed between consecutive comma characters (the number 100 can be tuned later)
--
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;

entity trigger_data_formatter is
  port(

    clocks : in clocks_t;

    reset_i : in std_logic;

    clusters_i : in sbit_cluster_array_t (NUM_FOUND_CLUSTERS-1 downto 0);
    --clusters_strobe_i : in std_logic;

    ttc_i : in ttc_t;

    overflow_i : in std_logic;          -- 1 bit gem has more than 8 clusters

    bxn_counter_i : in std_logic_vector (11 downto 0);  -- 12 bit bxn counter

    error_i : in std_logic;             -- 1  bit error flag

    fiber_kchars_o  : out t_std10_array (NUM_OPTICAL_PACKETS-1 downto 0);
    fiber_packets_o : out t_fiber_packet_array (NUM_OPTICAL_PACKETS-1 downto 0);
    elink_packets_o : out t_elink_packet_array (NUM_ELINK_PACKETS-1 downto 0)

    );
end trigger_data_formatter;

architecture Behavioral of trigger_data_formatter is

  -- NUM_FOUND_CLUSTERS = # clusters found per bx
  -- NUM_OUTPUT_CLUSTERS = # clusters we can send on the output link

  -- We can transmit N clusters per bunch crossing
  -- for each of the N clusters we need to select whether it is a primary cluster (from this BX), or a
  -- late cluster (from the prior bx)
  --
  -- The logic for this ends up being reasonably complicated...
  --
  -- Consider the 0th cluster...
  --    If:  the 0th cluster of this bx is valid, we transmit it,
  --    else:  transmit the 0th overflow cluster from last bx
  --
  -- Consider the 1st cluster...
  --    If: the 1st cluster of this bx is valid, we transmit it,
  --    Else:
  --       -   If: the 0th cluster is valid, we send the 0th overflow cluster in this slot
  --       - ElIf: the 0th cluster is invalid, we send the 1st overflow cluster in this slot
  --
  -- Consider the 2nd cluster (cluster[2])...
  --    If: the 2nd cluster of this bx is valid, we transmit it,
  --    Else:
  --       -   If: the 1st cluster is valid, we send the 0th overflow cluster in this slot
  --       - ElIf: the 0th cluster is valid, we send the 1st overflow cluster in this slot
  --       - Else:                           we send the 2nd overflow cluster in this slot
  --
  -- Consider the 3rd cluster (cluster[3])...
  --    If: the 3rd cluster of this bx is valid, we transmit it,
  --    Else:
  --       -   If: the 2nd cluster is valid, we send the 0th overflow cluster in this slot
  --       - ElIf: the 1st cluster is valid, we send the 1st overflow cluster in this slot
  --       - ElIf: the 0th cluster is valid, we send the 2nd overflow cluster in this slot
  --       - Else:                           we send the 3rd overflow cluster in this slot
  --
  --  And so on...
  --
  --  at the same time we need to make sure we don't try to select overflow clusters that don't exist
  --
  -- For example, if there are 10 clusters transmittable per bunch crossing but only 16 clusters found,
  -- there are only 6 overflow clusters / bx
  --
  -- So we need to modify the logic to be
  --
  -- Consider the nth cluster (cluster[n])...
  --    If: the nth cluster of this bx is valid, OR n > # overflow clusters, we transmit it
  --    Else:
  --       .....
  --
  -- This logic is accomplished via a function. It takes advantage of the trick that
  -- (ignoring the max # of overflow caveat for now) if you look at an example psuedocode
  -- switch case for this logic,
  --
  -- If there is a 1 in the most significant valid cluster flag, we choose that cluster of course.
  --
  -- Otherwise, the index of the cluster we use is the # of zeroes in the mask given by mask(n-1 downto 0)
  --
  --    case vpf_mask(2 downto 0) is
  --      when "1XX"  => clusters(2) <= clusters_i(2);
  --      when "011"  => clusters(2) <= overflow_clusters(0);
  --      when "001"  => clusters(2) <= overflow_clusters(1);
  --      when "000"  => clusters(2) <= overflow_clusters(2);
  --    end case;

  function count_zeros(slv : std_logic_vector) return natural is
    variable n_zeros : natural := 0;
  begin
    for i in slv'range loop
      if slv(i) = '0' then
        n_zeros := n_zeros + 1;
      end if;
    end loop;
    return n_zeros;
  end function count_zeros;

  function cluster_ovf_selector (
    max  : integer;                     -- maximum number of overflow clusters per bx
    clst : sbit_cluster_array_t;        -- array of primary clusters
    ovfl : sbit_cluster_array_t         -- array of late clusters
    )
    return sbit_cluster_array_t is
    variable num_clst : integer := NUM_OUTPUT_CLUSTERS;
    variable num_ovfl : integer := ovfl'length;
    variable mask     : std_logic_vector (clst'length-1 downto 0);
    variable ret      : sbit_cluster_array_t (NUM_OUTPUT_CLUSTERS-1 downto 0);
  begin

    for I in 0 to num_clst-1 loop
      mask(I) := clst(I).vpf;
    end loop;  -- I

    for I in 0 to num_clst-1 loop
      if (I > max or '1' = and_reduce(mask(I downto 0))) then
        ret (I) := clst (I);
      else
        ret (I) := ovfl (count_zeros(mask(I-1 downto 0)));
      end if;
    end loop;

    return ret;
  end function;

  constant c_NUM_OVERFLOW : integer := NUM_FOUND_CLUSTERS-NUM_OUTPUT_CLUSTERS;

  signal overflow_clusters : sbit_cluster_array_t (c_NUM_OVERFLOW - 1 downto 0);

  signal clusters          : sbit_cluster_array_t (NUM_OUTPUT_CLUSTERS-1 downto 0);
  signal late_cluster_flag : std_logic_vector (NUM_OUTPUT_CLUSTERS-1 downto 0) := (others => '0');

  signal comma : std_logic_vector (7 downto 0);

  signal special_bits : std_logic_vector (NUM_OUTPUT_CLUSTERS-1 downto 0) := (others => '0');

  signal cluster_words : t_std16_array (NUM_OUTPUT_CLUSTERS-1 downto 0);

begin

  --------------------------------------------------------------------------------
  -- Cluster assignment
  --------------------------------------------------------------------------------

  -- Make a copy of the clusters that couldn't be sent out this bx, to let them be send out the next bx instead
  process (clocks.clk160_0)
  begin
    if (rising_edge(clocks.clk160_0)) then
      overflow_clusters <= clusters_i (NUM_FOUND_CLUSTERS-1 downto NUM_OUTPUT_CLUSTERS);
    end if;
  end process;

  --- cluster assignment, primary or overflow?
  process (clocks.clk160_0)
  begin
    if (rising_edge(clocks.clk160_0)) then
      clusters <= cluster_ovf_selector (c_NUM_OVERFLOW, clusters_i, overflow_clusters);
    end if;
  end process;

  clusterloop : for I in 0 to NUM_OUTPUT_CLUSTERS-1 generate  -- 5 clusters in GE2/1, 5 + 5 in GE1/1
  begin

    -- 0 = cluster from this bx
    -- 1 = late clusters
    --
    -- any valid cluster from this bx is sent... for the others they are either overflow or
    -- invalid so we can just make this simple and set them all to 1

    late_cluster_flag(I) <= not clusters(I).vpf;

    -- create cluster words for ge1/1 or ge2/1
    ge21_gen : if (GE21 = 1) generate
      cluster_words (I) <= late_cluster_flag(I) & special_bits(I) & '0'
                           & clusters(I).cnt & clusters(I).prt & clusters(I).adr;
    end generate;

    ge11_gen : if (GE21 = 0) generate
      cluster_words (I) <= late_cluster_flag(I) & special_bits(I)
                           & clusters(I).cnt & clusters(I).prt & clusters(I).adr;
    end generate;
  end generate;

  --------------------------------------------------------------------------------
  -- Special bit allocation
  --------------------------------------------------------------------------------

  -- 3'h0 BXN[1:0]==2'h0
  -- 3'h1 BXN[1:0]==2'h1
  -- 3'h2 BXN[1:0]==2'h2
  -- 3'h3 BXN[1:0]==2'h3
  -- 3'h4 Overflow
  -- 3'h5 Resync
  -- 3'h6 Reserved
  -- 3'h7 Error

  process (clocks.clk160_0)
  begin
    -- clock once to align with cluster selector
    if (rising_edge(clocks.clk160_0)) then

      special_bits(0) <= ttc_i.bc0;

      if (error_i = '1') then
        special_bits (3 downto 1) <= "111";  -- 7
      elsif (ttc_i.resync = '1') then
        special_bits (3 downto 1) <= "101";  --5
      elsif (overflow_i = '1') then
        special_bits (3 downto 1) <= "011";  -- 3
      else
        special_bits (3 downto 1) <= '0' & bxn_counter_i(1 downto 0);
      end if;

    end if;
  end process;

  --------------------------------------------------------------------------------
  -- Optical Data Packet
  --------------------------------------------------------------------------------
  -- GE1/1 sends clusters on two
  -- On the 8b10b link we will transmit the 16 bit data words at 200 MHz in the following order:
  -- CL WORD0 -> CL WORD1 -> CL WORD2 -> CL WORD3 -> CL WORD4 / ECC8 [7:0] + -- Comma/BC0 [15:8].
  -- The 16bit words are sent from LSB to MSB.
  --
  -- <---WORD0----- ><---WORD1------><--WORD2-------><--WORD3-------><-ECC8-><COM/BC>
  -- <---WORD0----- ><---WORD1------><--WORD2-------><--WORD3-------><--CL_WORD4---->

  comma <= x"DC" when ttc_i.bc0 = '1' else x"BC";

  elink_outputs : for I in 0 to (NUM_OPTICAL_PACKETS-1) generate
    signal ecc8               : std_logic_vector (7 downto 0);
    signal vpf_r            : std_logic;
    signal vpf_r2           : std_logic;
    signal comma_r            : std_logic_vector (7 downto 0);
    signal comma_r2           : std_logic_vector (7 downto 0);
    signal cluster4_r         : std_logic_vector (15 downto 0);
    signal cluster4_r2        : std_logic_vector (15 downto 0);
    signal word4              : std_logic_vector (15 downto 0);
    signal fiber_kchars_r     : std_logic_vector (9 downto 0);
    signal fiber_kchars_r2    : std_logic_vector (9 downto 0);
    signal frame              : std_logic_vector (79 downto 0);
    signal packet_i, packet_o : std_logic_vector (5*16-1 downto 0);
  begin

    -- word 4 is a special case since it holds the comma / ecc... the others are simple
    -- put the when else in a separate assignment since it is not allowed in a process until VHDL2008... uhg..
    process (clocks.clk160_0)
    begin
      if (rising_edge(clocks.clk160_0)) then
        comma_r         <= comma;
        cluster4_r      <= cluster_words(4+5*I);
        vpf_r           <= clusters(4+5*I).vpf;
        fiber_kchars_r  <= "0000000000" when (clusters(4+5*I).vpf = '1') else "0100000000";

        comma_r2        <= comma_r;
        cluster4_r2     <= cluster4_r;
        vpf_r2          <= vpf_r;
        fiber_kchars_r2 <= fiber_kchars_r;
      end if;
    end process;

    process (clocks.clk160_0)
    begin
      if (rising_edge(clocks.clk160_0)) then
        packet_i(15 downto 0)  <= cluster_words(0+5*I);
        packet_i(31 downto 16) <= cluster_words(1+5*I);
        packet_i(47 downto 32) <= cluster_words(2+5*I);
        packet_i(63 downto 48) <= cluster_words(3+5*I);
      end if;
    end process;

    word4 <= cluster4_r2 when (vpf_r2 = '1') else (comma & ecc8);

    -- copy onto 40MHz clock so it can be copied onto the 200MHz clock easily
    -- (160 --> 200 MHz transfer requires proper CDC)
    process (clocks.clk40)
    begin
      if (rising_edge(clocks.clk40)) then
        fiber_packets_o(I) <= word4 & packet_o;
        fiber_kchars_o(I)  <= fiber_kchars_r2;
      end if;
    end process;

    noecc_gen : if (ENABLE_ECC = 0) generate
      ecc8     <= x"00";
      process (clocks.clk160_0)
      begin
        if (rising_edge(clocks.clk160_0)) then
          packet_o <= packet_i;
        end if;
      end process;
    end generate;

    ecc_gen : if (ENABLE_ECC = 1) generate

      yahamm_enc_1 : entity work.yahamm_enc
        generic map (
          MESSAGE_LENGTH   => packet_i'length,
          EXTRA_PARITY_BIT => 1,
          ONE_PARITY_BIT   => false
          )
        port map (
          clk_i        => clocks.clk160_0,
          rst_i        => reset_i,
          en_i         => not reset_i,
          data_i       => packet_i,
          data_o       => packet_o,
          data_valid_o => open,
          parity_o     => ecc8
          );
    end generate;

  end generate;

  --------------------------------------------------------------------------------
  -- Copper Data Packet
  --------------------------------------------------------------------------------

  ge21_elink_gen : if (GE21 = 1) and HAS_ELINK_OUTPUTS generate
    signal ecc8               : std_logic_vector (7 downto 0);
    signal packet_i, packet_o : std_logic_vector (5*16-1 downto 0);
  begin

    elink_packets_o(0) <= ecc8 & packet_o;

    process (clocks.clk160_0)
    begin
      if (rising_edge(clocks.clk160_0)) then
        packet_i <= cluster_words(4) & cluster_words(3) & cluster_words(2) & cluster_words(1) & cluster_words(0);
      end if;
    end process;

    noecc_gen : if (ENABLE_ECC = 0) generate
      ecc8     <= x"00";
      packet_o <= packet_i;
    end generate;

    ecc_gen : if (ENABLE_ECC = 1) generate
      yahamm_enc_1 : entity work.yahamm_enc
        generic map (
          MESSAGE_LENGTH   => packet_i'length,
          EXTRA_PARITY_BIT => 1,
          ONE_PARITY_BIT   => false
          )
        port map (
          clk_i        => clocks.clk160_0,
          rst_i        => reset_i,
          en_i         => not reset_i,
          data_i       => packet_i,
          data_o       => packet_o,
          data_valid_o => open,
          parity_o     => ecc8
          );
    end generate;

  end generate;

  --------------------------------------------------------------------------------
  -- ECC
  --------------------------------------------------------------------------------


  --  ecc64_inst : entity work.ecc64
  --    port map (
  --      enc_in     => (cluster_words(3) & cluster_output(2) & cluster_output(1) & cluster_output(0)),
  --      parity_out => ecc8
  --      );
  --
  --  ge11_ecc8_2nd : if (GE11 = 1) generate
  --    ecc64_inst : entity work.ecc64
  --      port map (
  --        enc_in     => (cluster_words(7) & cluster_output(6) & cluster_output(5) & cluster_output(4)),
  --        parity_out => ecc8_2nd
  --        );
  --  end generate;

end Behavioral;
