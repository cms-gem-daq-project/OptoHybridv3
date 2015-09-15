library ieee;
use ieee.std_logic_1164.all;

--! xilinx packages
library unisim;
use unisim.vcomponents.all;

library work;

entity gtp_wrapper is
port(
    
    fpga_clk_i      : in std_logic;
    gtp_clk_o       : out std_logic;
    reset_i         : in std_logic;
    gtp_reset_i     : in std_logic_vector(3 downto 0);
    
    rx_error_o      : out std_logic_vector(3 downto 0);
    rx_kchar_o      : out std_logic_vector(7 downto 0);
    rx_data_o       : out std_logic_vector(63 downto 0);
    
    tx_kchar_i      : in std_logic_vector(7 downto 0);
    tx_data_i       : in std_logic_vector(63 downto 0);
    
    rx_n_i          : in std_logic_vector(3 downto 0);
    rx_p_i          : in std_logic_vector(3 downto 0);
    tx_n_o          : out std_logic_vector(3 downto 0);
    tx_p_o          : out std_logic_vector(3 downto 0);
    
    gtp_refclk_n_i  : in std_logic_vector(3 downto 0);
    gtp_refclk_p_i  : in std_logic_vector(3 downto 0)
    
);
end gtp_wrapper;

architecture Behavioral of gtp_wrapper is

    signal gtp_refclk       : std_logic_vector(3 downto 0) := (others => '0');
    
    signal gtp_pllkdet      : std_logic_vector(3 downto 0) := (others => '1');
    
    signal gtp_clk_out      : std_logic_vector(7 downto 0) := (others => '0');
    signal gtp_clk_div      : std_logic_vector(1 downto 0) := (others => '0');
    signal gtp_pll_reset    : std_logic_vector(1 downto 0) := (others => '0');
    signal gtp_pll_locked   : std_logic_vector(1 downto 0) := (others => '0');
    signal gtp_userclk      : std_logic_vector(1 downto 0) := (others => '0');
    signal gtp_userclk2     : std_logic_vector(1 downto 0) := (others => '0');
    signal gtp_recclk       : std_logic_vector(3 downto 0) := (others => '0');
    
    signal rx_disperr       : std_logic_vector(7 downto 0) := (others => '0'); 
    signal rx_notintable    : std_logic_vector(7 downto 0) := (others => '0'); 
    
    signal local_reset      : std_logic := '0';
    signal rx_isaligned     : std_logic_vector(3 downto 0) := (others => '0'); 
    signal rx_reset         : std_logic_vector(3 downto 0) := (others => '0');  
    signal rx_reset_done    : std_logic_vector(3 downto 0) := (others => '0');  

begin

    --================================--
    -- Output signals
    --================================--
    
    gtp_clk_o <= gtp_userclk2(0);
    
    rx_error_o(0) <= rx_disperr(0) or rx_disperr(1) or rx_notintable(0) or rx_notintable(1);
    rx_error_o(1) <= rx_disperr(2) or rx_disperr(3) or rx_notintable(2) or rx_notintable(3);
    rx_error_o(2) <= rx_disperr(4) or rx_disperr(5) or rx_notintable(4) or rx_notintable(5);
    rx_error_o(3) <= rx_disperr(6) or rx_disperr(7) or rx_notintable(6) or rx_notintable(7);
    
    --================================--
    -- Resets
    --================================--
    
    rx_reset(0) <= gtp_reset_i(0) or reset_i or local_reset;
    rx_reset(1) <= gtp_reset_i(1) or reset_i or local_reset;
    rx_reset(2) <= gtp_reset_i(2) or reset_i or local_reset;
    rx_reset(3) <= gtp_reset_i(3) or reset_i or local_reset;
    
    gtp_link_reset_inst : entity work.gtp_link_reset port map(fpga_clk_i => fpga_clk_i, reset_o => local_reset);
    
    --================================--
    -- Clocking
    --================================--

    gtp_refclk_0_ibufds : ibufds port map(O => gtp_refclk(0), I => gtp_refclk_p_i(0), IB => gtp_refclk_n_i(0));
    gtp_refclk_1_ibufds : ibufds port map(O => gtp_refclk(1), I => gtp_refclk_p_i(1), IB => gtp_refclk_n_i(1));
    gtp_refclk_2_ibufds : ibufds port map(O => gtp_refclk(2), I => gtp_refclk_p_i(2), IB => gtp_refclk_n_i(2));
    gtp_refclk_3_ibufds : ibufds port map(O => gtp_refclk(3), I => gtp_refclk_p_i(3), IB => gtp_refclk_n_i(3));

    gtp_clk_out_tile_0_bufio2 : bufio2
    generic map(
        DIVIDE          => 1,
        DIVIDE_BYPASS   => true
    )
    port map(
        I               => gtp_clk_out(2), -- Use link 1
        DIVCLK          => gtp_clk_div(0),
        IOCLK           => open,
        SERDESSTROBE    => open
    );
    
    gtp_clk_out_tile_1_bufio2 : bufio2
    generic map(
        DIVIDE          => 1,
        DIVIDE_BYPASS   => true
    )
    port map(
        I               => gtp_clk_out(4),
        DIVCLK          => gtp_clk_div(1),
        IOCLK           => open,
        SERDESSTROBE    => open
    );
    
    gtp_clk_pll_tile_0_inst : entity work.gtp_clk_pll
    port map(
        clk160MHz_i => gtp_clk_div(0),
        reset_i     => gtp_pll_reset(0),
        locked_o    => gtp_pll_locked(0),
        clk160MHz_o => gtp_userclk2(0),
        clk320MHz_o => gtp_userclk(0)
    ); 
    
    gtp_pll_reset(0) <= not gtp_pllkdet(0);
    
    gtp_clk_pll_tile_1_inst : entity work.gtp_clk_pll
    port map(
        clk160MHz_i => gtp_clk_div(1),
        reset_i     => gtp_pll_reset(1),
        locked_o    => gtp_pll_locked(1),
        clk160MHz_o => gtp_userclk2(1),
        clk320MHz_o => gtp_userclk(1)
    ); 
    
    gtp_pll_reset(1) <= not gtp_pllkdet(1);
   
    --================================--
    -- GTP
    --================================--
    
    gtp_inst : entity work.gtp
    generic map(
        WRAPPER_SIM_GTPRESET_SPEEDUP    => 0,
        WRAPPER_CLK25_DIVIDER_0         => 10,
        WRAPPER_CLK25_DIVIDER_1         => 10,
        WRAPPER_PLL_DIVSEL_FB_0         => 2,
        WRAPPER_PLL_DIVSEL_FB_1         => 2,
        WRAPPER_PLL_DIVSEL_REF_0        => 1,
        WRAPPER_PLL_DIVSEL_REF_1        => 1,
        WRAPPER_SIMULATION              => 0
    )
    port map(
        TILE0_CLK00_IN                  => gtp_refclk(0),
        TILE0_CLK01_IN                  => gtp_refclk(1),
        TILE0_GTPRESET0_IN              => rx_reset(0),
        TILE0_GTPRESET1_IN              => rx_reset(1),
        TILE0_PLLLKDET0_OUT             => gtp_pllkdet(0),
        TILE0_PLLLKDET1_OUT             => gtp_pllkdet(1),
        TILE0_RESETDONE0_OUT            => rx_reset_done(0),
        TILE0_RESETDONE1_OUT            => rx_reset_done(1),
        TILE0_RXCHARISK0_OUT            => rx_kchar_o(1 downto 0),
        TILE0_RXCHARISK1_OUT            => rx_kchar_o(3 downto 2),
        TILE0_RXDISPERR0_OUT            => rx_disperr(1 downto 0),
        TILE0_RXDISPERR1_OUT            => rx_disperr(3 downto 2),
        TILE0_RXNOTINTABLE0_OUT         => rx_notintable(1 downto 0),
        TILE0_RXNOTINTABLE1_OUT         => rx_notintable(3 downto 2),
        TILE0_RXBYTEISALIGNED0_OUT      => rx_isaligned(0),
        TILE0_RXBYTEISALIGNED1_OUT      => rx_isaligned(1),
        TILE0_RXENMCOMMAALIGN0_IN       => '1',
        TILE0_RXENMCOMMAALIGN1_IN       => '1',
        TILE0_RXENPCOMMAALIGN0_IN       => '1',
        TILE0_RXENPCOMMAALIGN1_IN       => '1',
        TILE0_RXDATA0_OUT               => rx_data_o(15 downto 0),
        TILE0_RXDATA1_OUT               => rx_data_o(31 downto 16),
        TILE0_RXRECCLK0_OUT             => gtp_recclk(0),
        TILE0_RXRECCLK1_OUT             => gtp_recclk(1),
        TILE0_RXUSRCLK0_IN              => gtp_userclk(0),
        TILE0_RXUSRCLK1_IN              => gtp_userclk(0),
        TILE0_RXUSRCLK20_IN             => gtp_userclk2(0),
        TILE0_RXUSRCLK21_IN             => gtp_userclk2(0),
        TILE0_RXN0_IN                   => rx_n_i(0),
        TILE0_RXN1_IN                   => rx_n_i(1),
        TILE0_RXP0_IN                   => rx_p_i(0),
        TILE0_RXP1_IN                   => rx_p_i(1),
        TILE0_RXLOSSOFSYNC0_OUT         => open,
        TILE0_RXLOSSOFSYNC1_OUT         => open,
        TILE0_GTPCLKOUT0_OUT            => gtp_clk_out(1 downto 0),
        TILE0_GTPCLKOUT1_OUT            => gtp_clk_out(3 downto 2),
        TILE0_TXCHARISK0_IN             => tx_kchar_i(1 downto 0),
        TILE0_TXCHARISK1_IN             => tx_kchar_i(3 downto 2),
        TILE0_TXDATA0_IN                => tx_data_i(15 downto 0),
        TILE0_TXDATA1_IN                => tx_data_i(31 downto 16),
        TILE0_TXUSRCLK0_IN              => gtp_userclk(0),
        TILE0_TXUSRCLK1_IN              => gtp_userclk(0),
        TILE0_TXUSRCLK20_IN             => gtp_userclk2(0),
        TILE0_TXUSRCLK21_IN             => gtp_userclk2(0),
        TILE0_TXN0_OUT                  => tx_n_o(0),
        TILE0_TXN1_OUT                  => tx_n_o(1),
        TILE0_TXP0_OUT                  => tx_p_o(0),
        TILE0_TXP1_OUT                  => tx_p_o(1),

        TILE1_CLK00_IN                  => gtp_refclk(2),
        TILE1_CLK01_IN                  => gtp_refclk(3),
        TILE1_GTPRESET0_IN              => rx_reset(2),
        TILE1_GTPRESET1_IN              => rx_reset(3),
        TILE1_PLLLKDET0_OUT             => gtp_pllkdet(2),
        TILE1_PLLLKDET1_OUT             => gtp_pllkdet(3),
        TILE1_RESETDONE0_OUT            => rx_reset_done(2),
        TILE1_RESETDONE1_OUT            => rx_reset_done(3),
        TILE1_RXCHARISK0_OUT            => rx_kchar_o(5 downto 4),
        TILE1_RXCHARISK1_OUT            => rx_kchar_o(7 downto 6),
        TILE1_RXDISPERR0_OUT            => rx_disperr(5 downto 4),
        TILE1_RXDISPERR1_OUT            => rx_disperr(7 downto 6),
        TILE1_RXNOTINTABLE0_OUT         => rx_notintable(5 downto 4),
        TILE1_RXNOTINTABLE1_OUT         => rx_notintable(7 downto 6),
        TILE1_RXBYTEISALIGNED0_OUT      => rx_isaligned(2),
        TILE1_RXBYTEISALIGNED1_OUT      => rx_isaligned(3),
        TILE1_RXENMCOMMAALIGN0_IN       => '1',
        TILE1_RXENMCOMMAALIGN1_IN       => '1',
        TILE1_RXENPCOMMAALIGN0_IN       => '1',
        TILE1_RXENPCOMMAALIGN1_IN       => '1',
        TILE1_RXDATA0_OUT               => rx_data_o(47 downto 32),
        TILE1_RXDATA1_OUT               => rx_data_o(63 downto 48),
        TILE1_RXRECCLK0_OUT             => gtp_recclk(2),
        TILE1_RXRECCLK1_OUT             => gtp_recclk(3),
        TILE1_RXUSRCLK0_IN              => gtp_userclk(1),
        TILE1_RXUSRCLK1_IN              => gtp_userclk(1),
        TILE1_RXUSRCLK20_IN             => gtp_userclk2(1),
        TILE1_RXUSRCLK21_IN             => gtp_userclk2(1),
        TILE1_RXN0_IN                   => rx_n_i(2),
        TILE1_RXN1_IN                   => rx_n_i(3),
        TILE1_RXP0_IN                   => rx_p_i(2),
        TILE1_RXP1_IN                   => rx_p_i(3),
        TILE1_RXLOSSOFSYNC0_OUT         => open,
        TILE1_RXLOSSOFSYNC1_OUT         => open,
        TILE1_GTPCLKOUT0_OUT            => gtp_clk_out(5 downto 4),
        TILE1_GTPCLKOUT1_OUT            => gtp_clk_out(7 downto 6),
        TILE1_TXCHARISK0_IN             => tx_kchar_i(5 downto 4),
        TILE1_TXCHARISK1_IN             => tx_kchar_i(7 downto 6),
        TILE1_TXDATA0_IN                => tx_data_i(47 downto 32),
        TILE1_TXDATA1_IN                => tx_data_i(63 downto 48),
        TILE1_TXUSRCLK0_IN              => gtp_userclk(1),
        TILE1_TXUSRCLK1_IN              => gtp_userclk(1),
        TILE1_TXUSRCLK20_IN             => gtp_userclk2(1),
        TILE1_TXUSRCLK21_IN             => gtp_userclk2(1),
        TILE1_TXN0_OUT                  => tx_n_o(2),
        TILE1_TXN1_OUT                  => tx_n_o(3),
        TILE1_TXP0_OUT                  => tx_p_o(2),
        TILE1_TXP1_OUT                  => tx_p_o(3)
    );
    
end Behavioral;
