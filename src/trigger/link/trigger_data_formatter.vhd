-- https://gitlab.cern.ch/tdr/notes/DN-20-016/blob/master/temp/DN-20-016_temp.pdf
-- TODO: Only empty clusters are sent for 4 orbits following a resync signal, thus guaranteeing that the comma/bc0
--       symbols will not be replaced by CL WORD4 during this time
-- TODO: Whenever the number of clusters reaches the limit of the bandwidth provided by CL WORD0
--       CL WORD3 (8 clusters in 2 link OHs, and 4 cluster in 1 link OHs), the CL WORD4 is used,
--       and replaces the ECC8 + Comma/bc0 word, however a maximum delay of 100 BXs is guaran-
--       teed between consecutive comma characters (the number 100 can be tuned later)
-- TODO:

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
--  generic (
--    NUM_CLUSTERS        : integer := 5;
--    NUM_OVERFLOW_MAX    : integer := 5;
--    MXELINKS          : integer := 11;
--    USE_TMR_MGT_CONTROL : integer := 1;
--    USE_TMR_MGT_DATA    : integer := 1;
--    FPGA_TYPE_IS_V6     : integer := 0;
--    FPGA_TYPE_IS_A7     : integer := 0;
--    ALLOW_TTC_CHARS     : integer := 1;
--    ALLOW_RETRY         : integer := 1;
--    FRAME_CTRL_TTC      : integer := 1
--    );
  port(

    clocks : in clocks_t;

    reset_i : in std_logic;

    clusters_i : in sbit_cluster_array_t (NUM_FOUND_CLUSTERS_PER_BX-1 downto 0);
    --clusters_strobe_i : in std_logic;

    ttc_i : in ttc_t;

    overflow_i : in std_logic;          -- 1 bit gem has more than 8 clusters

    bxn_counter_i : in std_logic_vector (11 downto 0);  -- 12 bit bxn counter

    error_i : in std_logic              -- 1  bit error flag

    );
end trigger_data_formatter;

architecture Behavioral of trigger_data_formatter is

  -- NUM_FOUND_CLUSTERS_PER_BX = # clusters found per bx
  -- NUM_OUTPUT_CLUSTERS_PER_BX = # clusters we can send on the output link

  signal overflow_clusters : sbit_cluster_array_t (NUM_FOUND_CLUSTERS_PER_BX-NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0);

  signal clusters        : sbit_cluster_array_t (NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0);
  signal cluster_bx_flag : std_logic_vector (NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0) := (others => '0');
  signal vpf_mask : std_logic_vector (NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0) := (others => '0');

  signal ecc8     : std_logic_vector (7 downto 0);
  signal ecc8_2nd : std_logic_vector (7 downto 0);
  signal comma    : std_logic_vector (7 downto 0);

  signal special_bits : std_logic_vector (NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0) := (others => '0');

  signal cluster_output : t_std16_array (NUM_OUTPUT_CLUSTERS_PER_BX-1 downto 0);

begin

  -- make a copy of the clusters that couldn't be sent out this bx, to let them be send out the next bx instead
  -- TODO: use srl16 to avoid additional domain crossings
  process (clocks.clk40)
  begin
    if (rising_edge(clocks.clk40)) then
      -- FIXME: this formula won't work for ge11
      overflow_clusters <= clusters_i (NUM_FOUND_CLUSTERS_PER_BX-1 downto NUM_OUTPUT_CLUSTERS_PER_BX);
    end if;
  end process;

--  overflow_dly : entity work.srl16e_bbl
--    port map
--    (
--      clock => clocks.clk160_0,
--      ce => '1',
--      adr => 4,
--      d =
--
--
--);
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

  special_bits(0) <= ttc_i.bc0;
  process (error_i, ttc_i, overflow_i, bxn_counter_i)
  begin
    if (error_i = '1') then
      special_bits (3 downto 1) <= "111";  -- 7
    elsif (ttc_i.resync = '1') then
      special_bits (3 downto 1) <= "101";  --5
    elsif (overflow_i = '1') then
      special_bits (3 downto 1) <= "011";  -- 3
    else
      special_bits (3 downto 1) <= '0' & bxn_counter_i(1 downto 0);
    end if;
  end process;

  --------------------------------------------------------------------------------
  -- Cluster assignment
  --------------------------------------------------------------------------------

  -- TODO: create a function that will do this in a nicer way...

  -- cluster 0
  c0 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 0) generate
    process (clocks.clk160_0)
    begin
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(0 downto 0) is
          when "0"    => clusters(0) <= overflow_clusters(0);
          when others => clusters(0) <= clusters_i(0);
        end case;
      end if;
    end process;
  end generate;

  c1 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 1) generate
    process (clocks.clk160_0)
    begin
      -- cluster 1
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(1 downto 0) is
          when "01"   => clusters(1) <= overflow_clusters(1);
          when "00"   => clusters(1) <= overflow_clusters(2);
          when others => clusters(1) <= clusters_i(1);
        end case;
      end if;
    end process;
  end generate;

  c2 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 2) generate
    process (clocks.clk160_0)
    begin
      -- cluster 2
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(2 downto 0) is
          when "011"  => clusters(2) <= overflow_clusters(0);
          when "001"  => clusters(2) <= overflow_clusters(1);
          when "000"  => clusters(2) <= overflow_clusters(2);
          when others => clusters(2) <= clusters_i(2);
        end case;
      end if;
    end process;
  end generate;

  c3 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 3) generate
    process (clocks.clk160_0)
    begin
      -- cluster 3
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(3 downto 0) is
          when "0111" => clusters(3) <= overflow_clusters(0);
          when "0011" => clusters(3) <= overflow_clusters(1);
          when "0001" => clusters(3) <= overflow_clusters(2);
          when "0000" => clusters(3) <= clusters_i(3);  --overflow_clusters(3);
          when others => clusters(3) <= clusters_i(3);
        end case;
      end if;
    end process;
  end generate;

  c4 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 4) generate
    process (clocks.clk160_0)
    begin
      -- cluster 4
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(4 downto 0) is
          when "01111" => clusters(4) <= overflow_clusters(0);
          when "00111" => clusters(4) <= overflow_clusters(1);
          when "00011" => clusters(4) <= overflow_clusters(2);
          when "00001" => clusters(4) <= clusters_i(4); --overflow_clusters(3);
          when "00000" => clusters(4) <= clusters_i(4); --overflow_clusters(4);
          when others  => clusters(4) <= clusters_i(4);
        end case;
      end if;
    end process;
  end generate;

  c5 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 5) generate
    process (clocks.clk160_0)
    begin
      -- cluster 5
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(5 downto 0) is
          when "011111" => clusters(5) <= overflow_clusters(0);
          when "001111" => clusters(5) <= overflow_clusters(1);
          when "000111" => clusters(5) <= overflow_clusters(2);
          when "000011" => clusters(5) <= overflow_clusters(3);
          when "000001" => clusters(5) <= overflow_clusters(4);
          when "000000" => clusters(5) <= overflow_clusters(5);
          when others   => clusters(5) <= clusters_i(5);
        end case;
      end if;
    end process;
  end generate;

  c6 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 6) generate
    process (clocks.clk160_0)
    begin
      -- cluster 6
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(6 downto 0) is
          when "0111111" => clusters(6) <= overflow_clusters(0);
          when "0011111" => clusters(6) <= overflow_clusters(1);
          when "0001111" => clusters(6) <= overflow_clusters(2);
          when "0000111" => clusters(6) <= overflow_clusters(3);
          when "0000011" => clusters(6) <= overflow_clusters(4);
          when "0000001" => clusters(6) <= overflow_clusters(5);
          when "0000000" => clusters(6) <= overflow_clusters(6);
          when others    => clusters(6) <= clusters_i(6);
        end case;
      end if;
    end process;
  end generate;

  c7 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 7) generate
    process (clocks.clk160_0)
    begin
      -- cluster 7
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(7 downto 0) is
          when "01111111" => clusters(7) <= overflow_clusters(0);
          when "00111111" => clusters(7) <= overflow_clusters(1);
          when "00011111" => clusters(7) <= overflow_clusters(2);
          when "00001111" => clusters(7) <= overflow_clusters(3);
          when "00000111" => clusters(7) <= overflow_clusters(4);
          when "00000011" => clusters(7) <= overflow_clusters(5);
          when "00000001" => clusters(7) <= overflow_clusters(6);
          when "00000000" => clusters(7) <= overflow_clusters(7);
          when others     => clusters(7) <= clusters_i(7);
        end case;
      end if;
    end process;
  end generate;

  c8 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 8) generate
    process (clocks.clk160_0)
    begin
      -- cluster 8
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(8 downto 0) is
          when "011111111" => clusters(8) <= overflow_clusters(0);
          when "001111111" => clusters(8) <= overflow_clusters(1);
          when "000111111" => clusters(8) <= overflow_clusters(2);
          when "000011111" => clusters(8) <= overflow_clusters(3);
          when "000001111" => clusters(8) <= overflow_clusters(4);
          when "000000111" => clusters(8) <= overflow_clusters(5);
          when "000000011" => clusters(8) <= overflow_clusters(6);
          when "000000001" => clusters(8) <= overflow_clusters(7);
          when "000000000" => clusters(8) <= overflow_clusters(8);
          when others      => clusters(8) <= clusters_i(8);
        end case;
      end if;
    end process;
  end generate;

  c9 : if (NUM_OUTPUT_CLUSTERS_PER_BX > 9) generate
    process (clocks.clk160_0)
    begin
      -- cluster 9
      if (rising_edge(clocks.clk160_0)) then
        case vpf_mask(9 downto 0) is
          when "0111111111" => clusters(9) <= overflow_clusters(0);
          when "0011111111" => clusters(9) <= overflow_clusters(1);
          when "0001111111" => clusters(9) <= overflow_clusters(2);
          when "0000111111" => clusters(9) <= overflow_clusters(3);
          when "0000011111" => clusters(9) <= overflow_clusters(4);
          when "0000001111" => clusters(9) <= overflow_clusters(5);
          when "0000000111" => clusters(9) <= overflow_clusters(6);
          when "0000000011" => clusters(9) <= overflow_clusters(7);
          when "0000000001" => clusters(9) <= overflow_clusters(8);
          when "0000000000" => clusters(9) <= overflow_clusters(9);
          when others       => clusters(9) <= clusters_i(9);
        end case;
      end if;
    end process;
  end generate;

  clusterloop : for I in 0 to NUM_OUTPUT_CLUSTERS_PER_BX-1 generate  -- 5 clusters in GE2/1, 5 + 5 in GE1/1
  begin

    -- concat together the valid flags from all clusters into a single std_logic_vector
    vpf_mask(I) <= clusters(I).vpf;

    -- for clusters from THIS bx, set the bx flag to zero
    -- for any other clusters might as well just set them to 1
    cluster_bx_flag(I) <= not clusters(I).vpf;

    -- create cluster words for ge1/1 or ge2/1
    ge21_gen : if (GE21 = 1) generate
      cluster_output (I) <= cluster_bx_flag(I) & special_bits(I) & '0'
                            & clusters(I).cnt & clusters(I).prt & clusters(I).adr;
    end generate;

    ge11_gen : if (GE21 = 0) generate
      cluster_output (I) <= cluster_bx_flag(I) & special_bits(I)
                            & clusters(I).cnt & clusters(I).prt & clusters(I).adr;
    end generate;
  end generate;

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
    signal word4 : std_logic_vector (15 downto 0);
    signal frame : std_logic_vector (79 downto 0);
  begin

    word4 <= cluster_output(4+5*I) when (clusters(4+5*I).vpf = '1') else (comma & ecc8);

    process (clocks.clk200)
    begin
      if (rising_edge(clocks.clk200)) then
        frame <= word4 & cluster_output(3+5*I) & cluster_output(2+5*I) & cluster_output(1+5*I) & cluster_output(0+5*I);
      end if;
    end process;
  end generate;

  --------------------------------------------------------------------------------
  -- ECC
  --------------------------------------------------------------------------------

  --  ecc64_inst : entity work.ecc64
  --    port map (
  --      enc_in     => (cluster_output(3) & cluster_output(2) & cluster_output(1) & cluster_output(0)),
  --      parity_out => ecc8
  --      );
  --
  --  ge11_ecc8_2nd : if (GE11 = 1) generate
  --    ecc64_inst : entity work.ecc64
  --      port map (
  --        enc_in     => (cluster_output(7) & cluster_output(6) & cluster_output(5) & cluster_output(4)),
  --        parity_out => ecc8_2nd
  --        );
  --  end generate;

end Behavioral;
