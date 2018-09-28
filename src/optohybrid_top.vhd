---------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Top Logic
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- 2017/07/21 -- Initial port to version 3 electronics
-- 2017/07/22 -- Additional MMCM added to monitor and dejitter the eport clock
-- 2017/07/25 -- Restructure top level module to improve organization
-- 2018/04/18 -- Mods for for OH lite compatibility
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;
use work.trig_pkg.all;
use work.param_pkg.all;

entity optohybrid_top is
port(

    --== Memory ==--

--  multiboot_rs_o          : out std_logic_vector(1 downto 0);

--  flash_address_o         : out std_logic_vector(22 downto 0);
--  flash_data_io           : inout std_logic_vector(15 downto 0);
--  flash_chip_enable_b_o   : out std_logic;
--  flash_out_enable_b_o    : out std_logic;
--  flash_write_enable_b_o  : out std_logic;
--  flash_latch_enable_b_o  : out std_logic;

    --== Clocking ==--

  --gbt_eclk_p  : in std_logic_vector (1 downto 0) ;
  --gbt_eclk_n  : in std_logic_vector (1 downto 0) ;

    gbt_dclk_p : in std_logic_vector (1 downto 0) ;
    gbt_dclk_n : in std_logic_vector (1 downto 0) ;

    --== Miscellaneous ==--

    elink_i_p : in  std_logic_vector (1 downto 0) ;
    elink_i_n : in  std_logic_vector (1 downto 0) ;

    elink_o_p : out std_logic_vector (1 downto 0) ;
    elink_o_n : out std_logic_vector (1 downto 0) ;

    gbt_txready_i : in std_logic;

    gbt_rxvalid_i : in std_logic;
    gbt_rxready_i : in std_logic;

    -- only 1 connected in GE11, 2 in GE21
    gbt_txready_i : in std_logic_vector (MXREADY-1 downto 0);
    gbt_rxvalid_i : in std_logic_vector (MXREADY-1 downto 0);
    gbt_rxready_i : in std_logic_vector (MXREADY-1 downto 0);

    --== GE21 only ==--
    -- START: Station Specific Ports DO NOT EDIT --
    sca_io  : in  std_logic_vector (3 downto 0); -- set as input for now
    sca_ctl     : in   std_logic_vector (2 downto 0);

    ext_sbits_o : out  std_logic_vector (7 downto 0);

    ext_reset_o : out std_logic_vector (MXRESET-1 downto 0);

    adc_vp         : in  std_logic;
    adc_vn         : in  std_logic;
    -- END: Station Specific Ports DO NOT EDIT --

    --== VFAT Mezzanine ==--

    --== SCA Control ==--

    sca_ctl : in std_logic_vector (2 downto 0);

    --== GTX ==--

    mgt_clk_p_i : in std_logic_vector(1 downto 0);
    mgt_clk_n_i : in std_logic_vector(1 downto 0);

    mgt_tx_p_o : out std_logic_vector(3 downto 0);
    mgt_tx_n_o : out std_logic_vector(3 downto 0);

    --== VFAT Trigger Data ==--

    vfat_sot_p : in std_logic_vector (MXVFATS-1 downto 0);
    vfat_sot_n : in std_logic_vector (MXVFATS-1 downto 0);

    vfat_sbits_p : in std_logic_vector ((MXVFATS*8)-1 downto 0);
    vfat_sbits_n : in std_logic_vector ((MXVFATS*8)-1 downto 0)

);
end optohybrid_top;

architecture Behavioral of optohybrid_top is

    --== SBit cluster packer ==--

    signal sbit_overflow : std_logic;
    signal cluster_count : std_logic_vector     (7  downto 0);
    signal active_vfats  : std_logic_vector     (MXVFATS-1 downto 0);

    --== Global signals ==--

    signal mmcms_locked     : std_logic;
    signal dskw_mmcm_locked : std_logic;
    signal eprt_mmcm_locked : std_logic;

    signal clock            : std_logic;

    signal gbt_rx_clk_div   : std_logic;
    signal gbt_rx_clk       : std_logic;

    signal gbt_tx_clk_div   : std_logic_vector (1 downto 0);
    signal gbt_tx_clk       : std_logic_vector (1 downto 0);

    signal clk_1x           : std_logic;
    signal clk_2x           : std_logic;
    signal clk_4x           : std_logic;
    signal clk_4x_90        : std_logic;

    signal delay_refclk     : std_logic;
    signal delay_refclk_reset : std_logic;
    signal cluster_clk      : std_logic;

    signal gbt_txready      : std_logic;
    signal gbt_rxvalid      : std_logic;
    signal gbt_rxready      : std_logic;

    signal gbt_link_ready        : std_logic;
    signal gbt_link_error       : std_logic;
    signal gbt_rx_data          : std_logic_vector (15 downto 0);
    signal gbt_request_received : std_logic;

    signal tx_sync_mode_sca      : std_logic;
    signal gbt_loopback_mode_sca : std_logic;

    signal reset            : std_logic;
    signal cnt_snap         : std_logic;

    signal clock_source     : std_logic;

    signal ctrl_reset_vfats       : std_logic_vector (11 downto 0);
    signal ttc_reset_vfats        : std_logic;
    signal ttc_reset_vfats_vector : std_logic_vector (11 downto 0);
    signal ttc_resync             : std_logic;
    signal ttc_l1a                : std_logic;
    signal ttc_bc0                : std_logic;

    --== Wishbone ==--

    -- Master
    signal ipb_mosi_gbt : ipb_wbus;
    signal ipb_miso_gbt : ipb_rbus;

    -- Master
    signal ipb_mosi_masters : ipb_wbus_array (WB_MASTERS-1 downto 0);
    signal ipb_miso_masters : ipb_rbus_array (WB_MASTERS-1 downto 0);

    -- Slaves
    signal ipb_mosi_slaves  : ipb_wbus_array (WB_SLAVES-1 downto 0);
    signal ipb_miso_slaves  : ipb_rbus_array (WB_SLAVES-1 downto 0);

    --== TTC ==--

    signal bxn_counter  : std_logic_vector(11 downto 0);
    signal trig_stop    : std_logic;

    --== IOB Constraints for Outputs ==--

    attribute IOB : string;
    attribute KEEP : string;

    signal ext_sbits : std_logic_vector (7 downto 0);
    signal soft_reset : std_logic;

    signal led : std_logic_vector (15 downto 0);

    -- don't remove duplicates for fanout, needed to pack into iob
    signal ext_reset : std_logic_vector (11 downto 0);

    -- START: Station Specific Signals DO NOT EDIT --

    -- END: Station Specific Signals DO NOT EDIT --

begin

    -- internal wiring

    clock  <= clk_1x;
    gbt_request_received <= ipb_mosi_gbt.ipb_strobe;

    -- buffers to copy into IOBs

    ttc_reset_vfats_vector <= (others => ttc_reset_vfats);

    process(clock)
    begin
    if (rising_edge(clock)) then

        gbt_rxready   <= gbt_rxready_i;
        gbt_rxvalid   <= gbt_rxvalid_i;
        gbt_txready   <= gbt_txready_i;

        ext_reset   <= (ttc_reset_vfats_vector or ctrl_reset_vfats);

        led_o (MXLED-1 downto 0) <= led (MXLED-1 downto 0);

        ext_reset_o (MXRESET-1 downto 0) <= ext_reset (MXRESET-1 downto 0);
        ext_sbits_o  <= ext_sbits;

    end if;
    end process;

    --==============--
    --== Clocking ==--
    --==============--

    clocking : entity work.clocking
    port map(

        gbt_dclk_p         => gbt_dclk_p, -- phase shiftable 40MHz ttc clocks
        gbt_dclk_n         => gbt_dclk_n, --

     -- gbt_eclk_p         => gbt_eclk_p, -- 320 MHz fixed clocks
     -- gbt_eclk_n         => gbt_eclk_n, -- do not use

        ipb_mosi_i      => ipb_mosi_slaves (IPB_SLAVE.CLOCKING),
        ipb_miso_o      => ipb_miso_slaves (IPB_SLAVE.CLOCKING),
        ipb_reset_i     => reset,

        cnt_snap => cnt_snap,

        mmcms_locked_o     => mmcms_locked,

        eprt_mmcm_locked_o => eprt_mmcm_locked,
        dskw_mmcm_locked_o => dskw_mmcm_locked,

        gbt_rx_clk_div_o   => gbt_rx_clk_div, -- 40  MHz e-port aligned GBT clock
        gbt_rx_clk_o       => gbt_rx_clk,     -- 320 MHz e-port aligned GBT clock

        gbt_tx_clk_div_o   => gbt_tx_clk_div, -- 40  MHz e-port aligned GBT clock
        gbt_tx_clk_o       => gbt_tx_clk,     -- 320 MHz e-port aligned GBT clock

        clk_1x_o           => clk_1x, -- phase shiftable logic clocks
        clk_2x_o           => clk_2x,
        clk_4x_o           => clk_4x,
        clk_4x_90_o        => clk_4x_90,

        cluster_clk_o      => cluster_clk,
        delay_refclk_reset_o => delay_refclk_reset,
        delay_refclk_o     => delay_refclk
    );

    reset_ctl : entity work.reset
    port map (
        clock_i        => clock,
        soft_reset     => soft_reset,
        mmcms_locked_i => mmcms_locked,
        gbt_rxready_i  => gbt_rxready,
        gbt_rxvalid_i  => gbt_rxvalid,
        gbt_txready_i  => gbt_txready,
        reset_o        => reset
    );

    --=========--
    --== GBT ==--
    --=========--

    gbt : entity work.gbt
    port map(

        -- reset
        reset_i => reset,

        -- GBT

        gbt_rxready_i => gbt_rxready,
        gbt_rxvalid_i => gbt_rxvalid,
        gbt_txready_i => gbt_txready,


        -- input clocks

        gbt_rx_clk_div_i  => gbt_rx_clk_div, -- 40 MHz frame clock
        gbt_rx_clk_i      => gbt_rx_clk,     -- 320 MHz sampling clock

        gbt_tx_clk_div_i  => gbt_tx_clk_div, -- 40 MHz frame clock
        gbt_tx_clk_i      => gbt_tx_clk,     -- 320 MHz sampling clock

        clock_i => clock,         -- 320 MHz sampling clock

        delay_refclk => delay_refclk,
        delay_refclk_reset => delay_refclk_reset,

        -- elinks
        elink_i_p  =>  elink_i_p,
        elink_i_n  =>  elink_i_n,

        elink_o_p  =>  elink_o_p,
        elink_o_n  =>  elink_o_n,

        -- status

        gbt_rx_data_o => gbt_rx_data,

        gbt_link_error_o => gbt_link_error,
        gbt_link_ready_o => gbt_link_ready,

        -- sca control
        tx_sync_mode_sca       => tx_sync_mode_sca,
        gbt_loopback_mode_sca  => gbt_loopback_mode_sca,

        -- wishbone master
        ipb_mosi_o    => ipb_mosi_gbt,
        ipb_miso_i    => ipb_miso_gbt,

        -- wishbone slave

        ipb_mosi_i      => ipb_mosi_slaves (IPB_SLAVE.GBT),
        ipb_miso_o      => ipb_miso_slaves (IPB_SLAVE.GBT),
        ipb_reset_i     => reset,

        cnt_snap => cnt_snap,

        -- decoded TTC
        reset_vfats_o   => ttc_reset_vfats,
        resync_o        => ttc_resync,
        l1a_o           => ttc_l1a,
        bc0_o           => ttc_bc0

    );

    --=====================--
    --== Wishbone switch ==--
    --=====================--

    -- This module is the Wishbone switch which redirects requests from the masters to the slaves.

    ipb_mosi_masters(0) <= ipb_mosi_gbt;
    ipb_miso_gbt <= ipb_miso_masters(0);

    ipb_switch_inst : entity work.ipb_switch
    port map(
        clock_i => clock,
        reset_i => reset,

        -- connect to master
        mosi_masters => ipb_mosi_masters,
        miso_masters => ipb_miso_masters,

        -- connect to slaves
        mosi_slaves => ipb_mosi_slaves,
        miso_slaves => ipb_miso_slaves
    );

    --====================--
    --== System Monitor ==--
    --====================--

    xadc_gen : IF (FPGA_TYPE="VIRTEX6") GENERATE

    adc_inst : entity work.adc port map(
        clock_i         => clock,
        reset_i         => reset,

        cnt_snap => cnt_snap,

        ipb_mosi_i      => ipb_mosi_slaves (IPB_SLAVE.ADC),
        ipb_miso_o      => ipb_miso_slaves (IPB_SLAVE.ADC),
        ipb_reset_i     => reset,
        ipb_clk_i       => clock,

        adc_vp          => adc_vp,
        adc_vn          => adc_vn
    );

    END GENERATE xadc_gen;

    --=============--
    --== Control ==--
    --=============--

    control : entity work.control
    port map (

        --== TTC ==--

        clock_i                =>   clock,
        gbt_clock_i            =>   gbt_rx_clk_div,
        reset_i                =>   reset,

        ttc_l1a                =>   ttc_l1a,
        ttc_bc0                =>   ttc_bc0,
        ttc_resync             =>   ttc_resync,

        ipb_mosi_i             =>   ipb_mosi_slaves (IPB_SLAVE.CONTROL),
        ipb_miso_o             =>   ipb_miso_slaves (IPB_SLAVE.CONTROL),

        -------------------
        -- status inputs --
        -------------------

        -- MMCM
        mmcms_locked_i     => mmcms_locked,
        dskw_mmcm_locked_i => dskw_mmcm_locked,
        eprt_mmcm_locked_i => eprt_mmcm_locked,

        -- SCA Control

        sca_ctl => sca_ctl,

        tx_sync_mode_sca_o       => tx_sync_mode_sca,
        gbt_loopback_mode_sca_o  => gbt_loopback_mode_sca,

        -- GBT

        gbt_link_ready_i => gbt_link_ready,

        gbt_rxready_i => gbt_rxready,
        gbt_rxvalid_i => gbt_rxvalid,
        gbt_txready_i => gbt_txready,

        gbt_rx_data_i => gbt_rx_data,

        gbt_request_received_i => gbt_request_received,

        -- Trigger

        active_vfats_i  => active_vfats,
        sbit_overflow_i => sbit_overflow,
        cluster_count_i => cluster_count,

        -- GBT
        gbt_link_error_i => gbt_link_error,

        -- Analog input
        adc_vp          => adc_vp,
        adc_vn          => adc_vn,

        ---------
        -- TTC --
        ---------

        bxn_counter_o => bxn_counter,

        trig_stop_o   => trig_stop,

        --------------------
        -- config outputs --
        --------------------

        -- VFAT
        vfat_reset_o       => ctrl_reset_vfats,
        ext_sbits_o        => ext_sbits,

        -- LEDs
        led_o => led,

        soft_reset_o           =>   soft_reset,

        cnt_snap_o => cnt_snap

    );

    --==================--
    --== Trigger Data ==--
    --==================--

    trigger : entity work.trigger
    port map (

        -- wishbone

        ipb_mosi_i => ipb_mosi_slaves(IPB_SLAVE.TRIG),
        ipb_miso_o => ipb_miso_slaves(IPB_SLAVE.TRIG),

        -- reset
        reset_i  => reset,
        cnt_snap => cnt_snap,
        ttc_resync => ttc_resync,

        -- clocks
        mgt_clk_p => mgt_clk_p_i,
        mgt_clk_n => mgt_clk_n_i,

        clk_40     => clk_1x,
        clk_80     => clk_2x,
        clk_160    => clk_4x,
        clk_160_90 => clk_4x_90,

        delay_refclk_i => delay_refclk,
        delay_refclk_reset_i => delay_refclk_reset,

        cluster_clk => cluster_clk,

        -- mgt pairs
        mgt_tx_p => mgt_tx_p_o,
        mgt_tx_n => mgt_tx_n_o,

        -- config
        cluster_count_o    => cluster_count,
        overflow_o         => sbit_overflow,
        bxn_counter_i      => bxn_counter,
        ttc_bx0_i          => ttc_bc0,

        -- sbit_ors

        active_vfats_o   => active_vfats,

        -- trig stop from fmm

        trig_stop_i     => trig_stop,

        -- sbits follow

        vfat_sbits_p    => vfat_sbits_p,
        vfat_sbits_n    => vfat_sbits_n,

        vfat_sot_p    => vfat_sot_p,
        vfat_sot_n    => vfat_sot_n

    );

end Behavioral;
