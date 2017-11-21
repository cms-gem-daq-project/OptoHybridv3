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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Library UNISIM;
use UNISIM.vcomponents.all;

library work;
use work.types_pkg.all;
use work.trig_pkg.all;

entity trig_alignment is
port(

    sbit_mask        : in std_logic_vector (23 downto 0);

    sbits_p          : in std_logic_vector (191 downto 0);
    sbits_n          : in std_logic_vector (191 downto 0);

    reset_i          : in std_logic;

    start_of_frame_p : in std_logic_vector (23 downto 0);
    start_of_frame_n : in std_logic_vector (23 downto 0);

    sot_tap_delay    : in t_std5_array (23 downto 0);
    trig_tap_delay   : in t_std5_array (191 downto 0);

    sof_is_aligned   : out std_logic_vector (23 downto 0);
    sot_phase_err    : out std_logic_vector (23 downto 0);
    sof_unstable     : out std_logic_vector (23 downto 0);

    sof_frame_offset : in std_logic_vector (3 downto 0);

    err_count_to_shift : in std_logic_vector (7 downto 0);
    stable_count_to_reset : in std_logic_vector (7 downto 0);

    aligned_count_to_ready : in std_logic_vector (11 downto 0);

    fastclk_0        : in std_logic;
    fastclk_90       : in std_logic;
    fastclk_180      : in std_logic;

    delay_refclk     : in std_logic;

    clock            : in std_logic;

    phase_err        : out std_logic_vector (191 downto 0);

    sbits            : out std_logic_vector (( MXSBITS_CHAMBER - 1) downto 0)
);
end trig_alignment;

architecture Behavioral of trig_alignment is

    constant DDR : integer := 0;

    signal reset : std_logic := '0';

    signal not_fastclk_0    : std_logic;
    signal not_fastclk_90   : std_logic;
    signal not_fastclk_180  : std_logic;

    signal d0 : std_logic_vector (191 downto 0); -- rising edge sample
    signal d1 : std_logic_vector (191 downto 0); -- falling edge sample
    signal start_of_frame_d0 : std_logic_vector (23 downto 0);
    signal start_of_frame_d1 : std_logic_vector (23 downto 0);
    signal vfat_phase_sel  : t_std2_array (23 downto 0);

    signal vfat_sel_pos_edge           : std_logic_vector (23 downto 0);
    signal vfat_sel_pos_edge_posneged  : std_logic_vector (23 downto 0);

    signal sof_dly : std_logic_vector (23 downto 0);

    signal idly_rdy   : std_logic := '0';
    signal idly_rdy_r : std_logic := '0';

    attribute IODELAY_GROUP: string;
    attribute IODELAY_GROUP of IDELAYCTRL_inst : label is "IODLY_GROUP";


begin

    not_fastclk_0    <= fastclk_0;
    not_fastclk_90   <= fastclk_90;
    not_fastclk_180  <= fastclk_180;

    vfat_sel_pos_edge_posneged <= vfat_sel_pos_edge xor "000000000000010000000000";

    process (clock) is begin
        if (rising_edge(clock)) then
            reset <= reset_i or (not idly_rdy_r);
        end if;
    end process;

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
        RST    => reset_i
    );

    process (clock) is begin
        if (rising_edge(clock)) then
            idly_rdy_r <= idly_rdy;
        end if;
    end process;

    sot_loop: for ifat in 0 to 23 generate begin

        -- initial $display("Compiling SOF sampler %d with INVERT=%d, TAPS=%d",ifat,SOF_INVERT[ifat],SOF_OFFSET[ifat*5+:4]);

        -- sample the start of frame signals
        sot_oversampler : entity work.oversampler
        generic map (
            DDR                => DDR,
            INVERT             => to_integer(unsigned(sot_invert (ifat downto ifat))),
            POSNEG             => 0,
            PHASE_SEL_EXTERNAL => 0 -- automatic control
        )
        port map (

            tap_delay_i => sot_tap_delay(ifat),

            rx_p => start_of_frame_p(ifat),
            rx_n => start_of_frame_n(ifat),

            clock       =>  clock,

            -- keep all clocks inverted here, so that they are centered w/r/t the rising edge when doing frame alignment
            fastclock        => not_fastclk_0,
            fastclock90      => not_fastclk_90,
            fastclock180     => not_fastclk_180,

            phase_sel_in     => "00",
            phase_sel_out    => vfat_phase_sel(ifat),

            sel_pos_edge_in  => '0',
            sel_pos_edge_out => vfat_sel_pos_edge(ifat),

            err_count_to_shift => err_count_to_shift,
            stable_count_to_reset => stable_count_to_reset,

            phase_err        => sot_phase_err(ifat),

            d0               => start_of_frame_d0(ifat),
            d1               => start_of_frame_d1(ifat)
        );

    end generate;

    trig_loop: for ipin in 0 to 191 generate begin

        -- initial $display("Compiling SBIT sampler %d with INVERT=%d, TAPS=%d",ipin,TU_INVERT[ipin],TU_OFFSET[ipin*5+:4]);

        sbit_oversampler : entity work.oversampler
        generic map (
            DDR                => DDR,
            POSNEG             => 0,
            INVERT             => to_integer(unsigned(TU_INVERT (ipin downto ipin))),
            PHASE_SEL_EXTERNAL => 1 -- manual control
        )
        port map (

            tap_delay_i => trig_tap_delay(ipin),

            rx_p =>sbits_p(ipin),
            rx_n =>sbits_n(ipin),

            clock        => clock,
            fastclock    => not_fastclk_0,
            fastclock90  => not_fastclk_90,
            fastclock180 => not_fastclk_180,

            sel_pos_edge_in     => vfat_sel_pos_edge_posneged(ipin/8),
            sel_pos_edge_out    => open,

            err_count_to_shift => err_count_to_shift,
            stable_count_to_reset => stable_count_to_reset,

            phase_sel_in     => vfat_phase_sel(ipin/8),
            phase_sel_out    => open,
            phase_err        => phase_err(ipin),

            d0 => d0(ipin),
            d1 => d1(ipin)
        );

    end generate;

    aligner_loop: for ifat in 0 to 23 generate begin

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
            start_of_frame => start_of_frame_d0(ifat),
            clock          => clock,
            fastclock      =>  not_fastclk_0,

            sof_frame_offset => sof_frame_offset,
            aligned_count_to_ready => aligned_count_to_ready,

            sof_delayed    => sof_dly(ifat),

            sof_is_aligned => sof_is_aligned(ifat),

            sof_unstable   => sof_unstable(ifat),
            sbits => sbits((ifat+1)*MXSBITS - 1 downto ifat*MXSBITS)
        );

    end generate;

end Behavioral;
