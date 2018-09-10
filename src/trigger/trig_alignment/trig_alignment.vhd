----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Trigger Alignment
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module takes in 192 s-bits and 24 start-of-frame signals and outputs
--   1536 (or x2 at DDR) aligned S-bits
----------------------------------------------------------------------------------
-- 2017/07/24 -- Initial
-- 2017/11/13 -- Port to VHDL
-- 2018/04/18 -- Mods for OH Lite
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.types_pkg.all;
use work.trig_pkg.all;
use work.param_pkg.all;

entity trig_alignment is
port(

    sbit_mask        : in std_logic_vector (MXVFATS-1 downto 0);

    sbits_p          : in std_logic_vector (MXVFATS*8-1 downto 0);
    sbits_n          : in std_logic_vector (MXVFATS*8-1 downto 0);

    reset_i          : in std_logic;

    sot_invert       : in std_logic_vector (MXVFATS-1 downto 0);
    tu_invert        : in std_logic_vector (MXVFATS*8-1 downto 0);
    tu_mask          : in std_logic_vector (MXVFATS*8-1 downto 0);

    start_of_frame_p : in std_logic_vector (MXVFATS-1 downto 0);
    start_of_frame_n : in std_logic_vector (MXVFATS-1 downto 0);

    sot_tap_delay    : in t_std5_array (MXVFATS-1 downto 0);
    trig_tap_delay   : in t_std5_array (MXVFATS*8-1 downto 0);

    sot_is_aligned   : out std_logic_vector (MXVFATS-1 downto 0);
    sot_phase_err    : out std_logic_vector (MXVFATS-1 downto 0);
    sot_unstable     : out std_logic_vector (MXVFATS-1 downto 0);

    sot_frame_offset : in std_logic_vector (3 downto 0);

    err_count_to_shift : in std_logic_vector (7 downto 0);
    stable_count_to_reset : in std_logic_vector (7 downto 0);

    aligned_count_to_ready : in std_logic_vector (11 downto 0);

    fastclk_0        : in std_logic;
    fastclk_90       : in std_logic;
    fastclk_180      : in std_logic;

    delay_refclk     : in std_logic;
    delay_refclk_reset : in std_logic;

    clock            : in std_logic;

    phase_err        : out std_logic_vector (MXVFATS*8-1 downto 0);

    sbits            : out std_logic_vector (( MXSBITS_CHAMBER - 1) downto 0)
);
end trig_alignment;

architecture Behavioral of trig_alignment is

    constant DDR : integer := 0;

    signal reset : std_logic := '0';

    signal d0 : std_logic_vector (MXVFATS*8-1 downto 0); -- rising edge sample
    signal d1 : std_logic_vector (MXVFATS*8-1 downto 0); -- falling edge sample
    signal start_of_frame : std_logic_vector (MXVFATS-1 downto 0);
    signal sot_on_negedge : std_logic_vector (MXVFATS-1 downto 0);
    signal start_of_frame_d0 : std_logic_vector (MXVFATS-1 downto 0);
    signal start_of_frame_d1 : std_logic_vector (MXVFATS-1 downto 0);
    signal vfat_phase_sel  : t_std2_array (MXVFATS-1 downto 0);

    signal serdesstrobe : std_logic;

    signal idly_rdy   : std_logic := '0';
    signal idly_rdy_r : std_logic := '0';

    COMPONENT oversampler
    GENERIC (
        FPGA_TYPE_IS_VIRTEX6  : INTEGER;
        FPGA_TYPE_IS_ARTIX7   : INTEGER;
        DDR                   : INTEGER;
        PHASE_SEL_EXTERNAL    : INTEGER
    );
    PORT(
        rx_p                  : IN std_logic;
        rx_n                  : IN std_logic;
        clock                 : IN std_logic;
        invert                : IN std_logic;
        reset_i               : IN std_logic;
        strobe                : IN std_logic;
        fastclock             : IN std_logic;
        fastclock90           : IN std_logic;
        fastclock180          : IN std_logic;
        phase_sel_in          : IN std_logic_vector(1 downto 0);
        stable_count_to_reset : IN std_logic_vector(7 downto 0);
        err_count_to_shift    : IN std_logic_vector(7 downto 0);
        tap_delay_i           : IN std_logic_vector(4 downto 0);
        phase_sel_out         : OUT std_logic_vector(1 downto 0);
        phase_err             : OUT std_logic;
        d0                    : OUT std_logic;
        d1                    : OUT std_logic
        );
    END COMPONENT;

    attribute IODELAY_GROUP: string;

begin

    assert_fpga_type :
    IF ( FPGA_TYPE/="VIRTEX6" and FPGA_TYPE/="ARTIX7") GENERATE
        assert false report "Unknown FPGA TYPE" severity error;
    end GENERATE assert_fpga_type;

    --===================--
    --==  Reset Fanout ==--
    --===================--

    process (clock) is begin
        if (rising_edge(clock)) then
            reset <= reset_i or (not idly_rdy_r);
        end if;
    end process;

    --==========================--
    --== Virtex-6 IDELAYCTRL  ==--
    --==========================--

    alignment_idelayctrl_gen_v6a7 :
    IF (FPGA_TYPE="VIRTEX6" or FPGA_TYPE="ARTIX7") GENERATE
        attribute IODELAY_GROUP of IDELAYCTRL_inst : label is "IODLY_GROUP";
    begin

        IDELAYCTRL_inst : IDELAYCTRL
        port map (

            -- The ready (RDY) signal indicates when the IDELAYE2 and
            -- ODELAYE2 modules in the specific region are calibrated. The RDY
            -- signal is deasserted if REFCLK is held High or Low for one clock
            -- period or more. If RDY is deasserted Low, the IDELAYCTRL module
            -- must be reset. If not needed, RDY to be unconnected/ignored.
            RDY    => idly_rdy,

            -- Time reference to IDELAYCTRL to calibrate all IDELAYE2 and
            -- ODELAYE2 modules in the same region. REFCLK can be supplied
            -- directly from a user-supplied source or the MMCME2/PLLE2 and
            -- must be routed on a global clock buffer
            REFCLK => delay_refclk,

            -- Active-High asynchronous reset. To ensure proper IDELAYE2
            -- and ODELAYE2 operation, IDELAYCTRL must be reset after
            -- configuration and the REFCLK signal is stable. A reset pulse width
            -- Tidelayctrl_rpw is required
            RST    => delay_refclk_reset
        );

        process (clock) is begin
            if (rising_edge(clock)) then
                idly_rdy_r <= idly_rdy;
            end if;
        end process;

    END GENERATE alignment_idelayctrl_gen_v6a7;

    --======================--
    --== SOT Oversampler  ==--
    --======================--

    sot_loop: for ifat in 0 to MXVFATS-1 generate begin

        -- initial $display("Compiling SOT sampler %d with INVERT=%d, TAPS=%d",ifat,SOT_INVERT[ifat],SOT_OFFSET[ifat*5+:4]);

        -- sample the start of frame signals
        sot_oversampler : oversampler
        generic map (
            FPGA_TYPE_IS_VIRTEX6  => (FPGA_TYPE_IS_VIRTEX6),
            FPGA_TYPE_IS_ARTIX7   => (FPGA_TYPE_IS_ARTIX7),
            DDR                   => DDR,
            PHASE_SEL_EXTERNAL    => 0 -- automatic control
        )
        port map (

            tap_delay_i => sot_tap_delay(ifat),

            invert => sot_invert (ifat),

            rx_p => start_of_frame_p(ifat),
            rx_n => start_of_frame_n(ifat),

            clock       =>  clock,
            reset_i     =>  reset,

            -- keep all clocks inverted here, so that they are centered w/r/t the rising edge when doing frame alignment
            fastclock        => fastclk_0,
            fastclock90      => fastclk_90,
            fastclock180     => fastclk_180,

            strobe           => serdesstrobe,

            phase_sel_in     => (others=> std_logic ' ('0')),
            phase_sel_out    => vfat_phase_sel(ifat),

            err_count_to_shift => err_count_to_shift,
            stable_count_to_reset => stable_count_to_reset,

            phase_err        => sot_phase_err(ifat),

            d0               => start_of_frame_d0(ifat),
            d1               => start_of_frame_d1(ifat)
        );

        process (fastclk_0) is begin
        if (rising_edge(fastclk_0)) then
            if (start_of_frame_d1(ifat)='1') then
                sot_on_negedge(ifat) <= '1';
            elsif (start_of_frame_d0(ifat)='1') then
                sot_on_negedge(ifat) <= '0';
            end if;
        end if;
        end process;

        start_of_frame (ifat) <= start_of_frame_d1(ifat) when sot_on_negedge(ifat) = '1' else
                                 start_of_frame_d0(ifat);

    end generate;

    trig_loop: for ipin in 0 to (MXVFATS*8-1) generate begin

        -- initial $display("Compiling SBIT sampler %d with INVERT=%d, TAPS=%d",ipin,TU_INVERT[ipin],TU_OFFSET[ipin*5+:4]);

        sbit_oversampler : oversampler
        generic map (
            FPGA_TYPE_IS_VIRTEX6  => (FPGA_TYPE_IS_VIRTEX6),
            FPGA_TYPE_IS_ARTIX7   => (FPGA_TYPE_IS_ARTIX7),
            DDR                => DDR,
            PHASE_SEL_EXTERNAL => 1 -- manual control
        )
        port map (

            tap_delay_i => trig_tap_delay(ipin),

            invert => tu_invert (ipin),

            rx_p =>sbits_p(ipin),
            rx_n =>sbits_n(ipin),

            clock        => clock,
            reset_i     =>  reset or (tu_mask(ipin)),

            fastclock    => fastclk_0,
            fastclock90  => fastclk_90,
            fastclock180 => fastclk_180,

            strobe           => serdesstrobe,

            err_count_to_shift => err_count_to_shift,
            stable_count_to_reset => stable_count_to_reset,

            phase_sel_in     => vfat_phase_sel(ipin/8),
            phase_sel_out    => open,
            phase_err        => phase_err(ipin),

            d0 => d0(ipin),
            d1 => d1(ipin)
        );

    end generate;

    aligner_loop: for ifat in 0 to MXVFATS-1 generate begin

        frame_aligner_inst : entity frame_aligner
        generic map (
            DDR => DDR
        )
        port map (
            d0 => d0((ifat+1)*8-1 downto ifat*8),
            d1 => d1((ifat+1)*8-1 downto ifat*8),

            mask    => sbit_mask(ifat),
            reset_i => reset,

            -- keep all clocks inverted here, so that they are centered w/r/t the rising edge when doing frame alignment
            start_of_frame => start_of_frame(ifat),
            clock          => clock,
            fastclock      => fastclk_0,

            sot_on_negedge => sot_on_negedge(ifat),
            sot_frame_offset => sot_frame_offset,
            aligned_count_to_ready => aligned_count_to_ready,

            sot_is_aligned => sot_is_aligned(ifat),

            sot_unstable   => sot_unstable(ifat),
            sbits => sbits((ifat+1)*MXSBITS - 1 downto ifat*MXSBITS)
        );

    end generate;

end Behavioral;
