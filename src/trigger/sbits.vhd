----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- S-Bits
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module wraps up all the functionality for deserializing 320 MHz S-bits
--   as well as the cluster packer
----------------------------------------------------------------------------------
-- 2017/11/01 -- Add description / comments
-- 2018/04/17 -- Add options for "light" oh firmware
-- 2018/09/18 -- Add module for S-bit remapping in firmware
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;


library work;
use work.types_pkg.all;
use work.trig_pkg.all;

entity sbits is
generic (oh_lite : integer := OH_LITE);
port(

    clk80_i                : in std_logic;
    clk160_i               : in std_logic;
    clk200_i               : in std_logic;
    clk160_90_i            : in std_logic;
    clk40_i                : in std_logic;

    reset_i                : in std_logic;

    trig_stop_i            : in std_logic;

    vfat_sbit_clusters_o   : out sbit_cluster_array_t(7 downto 0);

    vfat_mask_i            : in std_logic_vector (MXVFATS-1 downto 0);

    sbits_mux_sel_i        : in  std_logic_vector (4 downto 0);
    sbits_mux_o            : out  std_logic_vector (63 downto 0);

    sot_invert_i           : in std_logic_vector (MXVFATS-1 downto 0); -- 24 or 12
    tu_invert_i            : in std_logic_vector (MXVFATS*8-1 downto 0); -- 192 or 96
    tu_mask_i              : in std_logic_vector (MXVFATS*8-1 downto 0); -- 192 or 96

    aligned_count_to_ready : in std_logic_vector (11 downto 0);

    cluster_count_o        : out std_logic_vector (10 downto 0);

    trigger_deadtime_i     : in  std_logic_vector (3 downto 0);

    sbits_p                : in std_logic_vector (MXVFATS*8-1 downto 0);
    sbits_n                : in std_logic_vector (MXVFATS*8-1 downto 0);

    start_of_frame_p       : in std_logic_vector (MXVFATS-1 downto 0);
    start_of_frame_n       : in std_logic_vector (MXVFATS-1 downto 0);


    active_vfats_o         : out std_logic_vector (MXVFATS-1 downto 0);

    overflow_o             : out std_logic;

    sot_is_aligned_o       : out std_logic_vector (MXVFATS-1 downto 0);
    sot_unstable_o         : out std_logic_vector (MXVFATS-1 downto 0);

    sot_tap_delay          : in t_std5_array (MXVFATS-1 downto 0);
    trig_tap_delay         : in t_std5_array (MXVFATS*8-1 downto 0)

);
end sbits;

architecture Behavioral of sbits is

    signal vfat_sbits_strip_mapped  : sbits_array_t(MXVFATS-1 downto 0);
    signal vfat_sbits               : sbits_array_t(MXVFATS-1 downto 0);

    constant empty_vfat             : std_logic_vector (63 downto 0) := x"0000000000000000";

    signal active_vfats             : std_logic_vector (MXVFATS-1 downto 0);

    signal clk160_180               : std_logic;

    signal sbits                    : std_logic_vector (MXSBITS_CHAMBER-1 downto 0);

    signal active_vfats_s1          : std_logic_vector (MXVFATS*8-1 downto 0);

    signal sbits_mux_s0             : std_logic_vector (63 downto 0);
    signal sbits_mux_s1             : std_logic_vector (63 downto 0);
    signal sbits_mux                : std_logic_vector (63 downto 0);
    signal aff_mux                  : std_logic;

    signal sbits_mux_sel            : std_logic_vector (4 downto 0);

    -- multiplex together the 1536 s-bits into a single chip-scope accessible register
    -- don't want to affect timing, so do it through a couple of flip-flop stages

    attribute mark_debug : string;
    attribute mark_debug of sbits_mux : signal is "TRUE";
    attribute mark_debug of aff_mux   : signal is "TRUE";

    signal reset : std_logic;

    attribute EQUIVALENT_REGISTER_REMOVAL : string;
    attribute EQUIVALENT_REGISTER_REMOVAL of reset : signal is "NO";

    function reverse_vector (a: in std_logic_vector)
    return std_logic_vector is
    variable result: std_logic_vector(a'RANGE);
    alias aa: std_logic_vector(a'REVERSE_RANGE) is a;
    begin
    for i in aa'RANGE loop
        result(i) := aa(i);
    end loop;
    return result;
    end; -- function reverse_vector

begin

    -- reset fanout

    process (clk40_i) begin
        if (rising_edge(clk40_i)) then
            reset <= reset_i;
        end if;
    end process;

    process (clk40_i) begin
        if (rising_edge(clk40_i)) then
            if (unsigned(sbits_mux_sel_i) > to_unsigned(MXVFATS,sbits_mux_sel_i'length)-1) then
                sbits_mux_sel <= (others => '0');
            else
                sbits_mux_sel <= sbits_mux_sel_i;
            end if;
        end if;
    end process;

    -- don't need to do a 180 on the clock-- use local inverters for deserialization to save 1 global clock
    clk160_180 <= not clk160_i;
    active_vfats_o <= active_vfats;

    --------------------------------------------------------------------------------------------------------------------
    -- S-bit Deserialization and Alignment
    --------------------------------------------------------------------------------------------------------------------

    -- deserializes and aligns the 192 320 MHz s-bits into 1536 40MHz s-bits

    trig_alignment : entity work.trig_alignment
    port map (

        vfat_mask_i            => vfat_mask_i,

        reset_i                => reset,

        sbits_p                => sbits_p,
        sbits_n                => sbits_n,

        sot_invert_i           => sot_invert_i,
        tu_invert_i            => tu_invert_i,
        tu_mask_i              => tu_mask_i,

        aligned_count_to_ready => aligned_count_to_ready,

        start_of_frame_p       => start_of_frame_p,
        start_of_frame_n       => start_of_frame_n,

        clk80_0                => clk80_i,
        clk160_0               => clk160_i,
        clk160_90              => clk160_90_i,
        clk160_180             => clk160_180,
        clock                  => clk40_i,

        sot_is_aligned         => sot_is_aligned_o,
        sot_unstable           => sot_unstable_o,

        sot_tap_delay          => sot_tap_delay,
        trig_tap_delay         => trig_tap_delay,

        sbits                  => sbits
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Channel to Strip Mapping
    --------------------------------------------------------------------------------------------------------------------

    sbit_reverse : for I in 0 to (MXVFATS-1) generate
    begin
        vfat_sbits (I)  <= sbits ((I+1)*MXSBITS-1 downto (I)*MXSBITS) when REVERSE_VFAT_SBITS(0)='0' else reverse_vector(sbits ((I+1)*MXSBITS-1 downto (I)*MXSBITS));
    end generate;

    channel_to_strip_inst : entity work.channel_to_strip
    port map (
        channels_in => vfat_sbits,
        strips_out  => vfat_sbits_strip_mapped
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Active VFAT Flags
    --------------------------------------------------------------------------------------------------------------------

    -- want to generate 24 bits as active VFAT flags, indicating that at least one s-bit on that VFAT
    -- was active in this 40MHz cycle

    -- I don't want to do 64 bit reduction in 1 clock... split it over 2 to add slack to PAR and timing

    active_vfats_inst : entity work.active_vfats
    port map (
        clock          => clk40_i,
        sbits_i        => sbits,
        active_vfats_o => active_vfats
    );

    --------------------------------------------------------------------------------------------------------------------
    -- Sbits Monitor Multiplexer
    --------------------------------------------------------------------------------------------------------------------

    process (clk40_i) begin
        if (rising_edge(clk40_i)) then
            sbits_mux_s0 <= vfat_sbits_strip_mapped(to_integer(unsigned(sbits_mux_sel)));
            sbits_mux_s1 <= sbits_mux_s0;
            sbits_mux    <= sbits_mux_s1;
            sbits_mux_o  <= sbits_mux;

            aff_mux      <= active_vfats(to_integer(unsigned(sbits_mux_sel)));

        end if;
    end process;

    --------------------------------------------------------------------------------------------------------------------
    -- Cluster Packer
    --------------------------------------------------------------------------------------------------------------------

    --====================================--
    --== Light (12 VFAT) Cluster Packer ==--
    --====================================--

    OH_LITE_GEN : if (oh_lite=1) GENERATE

    cluster_packer_inst : entity work.cluster_packer

        port map(
            trig_stop_i         => trig_stop_i,
            clock5x             => clk200_i,
            clock4x             => clk160_i,
            clock1x             => clk40_i,
            reset_i             => reset,
            cluster_count       => cluster_count_o,
            deadtime_i          => trigger_deadtime_i,

            vfat0               => vfat_sbits_strip_mapped(0),
            vfat1               => vfat_sbits_strip_mapped(1),
            vfat2               => vfat_sbits_strip_mapped(2),
            vfat3               => vfat_sbits_strip_mapped(3),
            vfat4               => vfat_sbits_strip_mapped(4),
            vfat5               => vfat_sbits_strip_mapped(5),
            vfat6               => vfat_sbits_strip_mapped(6),
            vfat7               => vfat_sbits_strip_mapped(7),
            vfat8               => vfat_sbits_strip_mapped(8),
            vfat9               => vfat_sbits_strip_mapped(9),
            vfat10              => vfat_sbits_strip_mapped(10),
            vfat11              => vfat_sbits_strip_mapped(11),
            vfat12              => empty_vfat,
            vfat13              => empty_vfat,
            vfat14              => empty_vfat,
            vfat15              => empty_vfat,
            vfat16              => empty_vfat,
            vfat17              => empty_vfat,
            vfat18              => empty_vfat,
            vfat19              => empty_vfat,
            vfat20              => empty_vfat,
            vfat21              => empty_vfat,
            vfat22              => empty_vfat,
            vfat23              => empty_vfat,

            cluster0            => vfat_sbit_clusters_o(0),
            cluster1            => vfat_sbit_clusters_o(1),
            cluster2            => vfat_sbit_clusters_o(2),
            cluster3            => vfat_sbit_clusters_o(3),
            cluster4            => vfat_sbit_clusters_o(4),
            cluster5            => vfat_sbit_clusters_o(5),
            cluster6            => vfat_sbit_clusters_o(6),
            cluster7            => vfat_sbit_clusters_o(7),

            overflow            => overflow_o
        );

    end generate;

    --====================================--
    --== Heavy (24 VFAT) Cluster Packer ==--
    --====================================--

    OH_FULL_GEN : if (oh_lite=0) GENERATE

    cluster_packer_inst : entity work.cluster_packer

        port map(
            trig_stop_i         => trig_stop_i,
            clock5x             => clk200_i,
            clock4x             => clk160_i,
            clock1x             => clk40_i,
            reset_i             => reset,
            cluster_count       => cluster_count_o,
            deadtime_i          => trigger_deadtime_i,
            vfat0               => vfat_sbits_strip_mapped(0),
            vfat1               => vfat_sbits_strip_mapped(1),
            vfat2               => vfat_sbits_strip_mapped(2),
            vfat3               => vfat_sbits_strip_mapped(3),
            vfat4               => vfat_sbits_strip_mapped(4),
            vfat5               => vfat_sbits_strip_mapped(5),
            vfat6               => vfat_sbits_strip_mapped(6),
            vfat7               => vfat_sbits_strip_mapped(7),
            vfat8               => vfat_sbits_strip_mapped(8),
            vfat9               => vfat_sbits_strip_mapped(9),
            vfat10              => vfat_sbits_strip_mapped(10),
            vfat11              => vfat_sbits_strip_mapped(11),
            vfat12              => vfat_sbits_strip_mapped(12),
            vfat13              => vfat_sbits_strip_mapped(13),
            vfat14              => vfat_sbits_strip_mapped(14),
            vfat15              => vfat_sbits_strip_mapped(15),
            vfat16              => vfat_sbits_strip_mapped(16),
            vfat17              => vfat_sbits_strip_mapped(17),
            vfat18              => vfat_sbits_strip_mapped(18),
            vfat19              => vfat_sbits_strip_mapped(19),
            vfat20              => vfat_sbits_strip_mapped(20),
            vfat21              => vfat_sbits_strip_mapped(21),
            vfat22              => vfat_sbits_strip_mapped(22),
            vfat23              => vfat_sbits_strip_mapped(23),
            cluster0            => vfat_sbit_clusters_o(0),
            cluster1            => vfat_sbit_clusters_o(1),
            cluster2            => vfat_sbit_clusters_o(2),
            cluster3            => vfat_sbit_clusters_o(3),
            cluster4            => vfat_sbit_clusters_o(4),
            cluster5            => vfat_sbit_clusters_o(5),
            cluster6            => vfat_sbit_clusters_o(6),
            cluster7            => vfat_sbit_clusters_o(7),
            overflow            => overflow_o
        );

    end generate;

end Behavioral;
