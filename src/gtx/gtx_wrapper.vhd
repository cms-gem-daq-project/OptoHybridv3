----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_wrapper - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gtx_wrapper is
generic(
    USE_CDCE        : boolean := true
);
port(

    mgt_refclk_n_i  : in std_logic;
    mgt_refclk_p_i  : in std_logic;
    alt_gtx_clk_i   : in std_logic;
    
    reset_i         : in std_logic;
    
    tx_kchar_i      : in std_logic_vector(3 downto 0);
    tx_data_i       : in std_logic_vector(31 downto 0);
    
    rx_kchar_o      : out std_logic_vector(3 downto 0);
    rx_data_o       : out std_logic_vector(31 downto 0);
    rx_error_o      : out std_logic_vector(1 downto 0);
 
    usr_clk_o       : out std_logic;
    rec_clk_o       : out std_logic;
   
    rx_n_i          : in std_logic_vector(1 downto 0);
    rx_p_i          : in std_logic_vector(1 downto 0);
    tx_n_o          : out std_logic_vector(1 downto 0);
    tx_p_o          : out std_logic_vector(1 downto 0)
    
);
end gtx_wrapper;

architecture Behavioral of gtx_wrapper is

    signal mgt_refclk       : std_logic;
   
    signal rx_disperr       : std_logic_vector(3 downto 0); 
    signal rx_notintable    : std_logic_vector(3 downto 0);
    
    signal usr_clk          : std_logic;
    signal usr_clk2         : std_logic;
    
begin    

    --== When using the CDCE ==--
    
    use_cdce_gen : if USE_CDCE = true generate
    begin
    
        ibufds_gtxe1_inst : ibufds_gtxe1
        port map(
            o       => mgt_refclk,
            odiv2   => open,
            ceb     => '0',
            i       => mgt_refclk_p_i,
            ib      => mgt_refclk_n_i
        );
    
    end generate;
    
    --== When NOT using the CDCE ==--
    
    not_use_cdce_gen : if USE_CDCE = false generate
    begin
    
        ibufds_gtxe1_inst : ibufds_gtxe1
        port map(
            o       => open,
            odiv2   => open,
            ceb     => '0',
            i       => mgt_refclk_p_i,
            ib      => mgt_refclk_n_i
        );

        mgt_refclk <= alt_gtx_clk_i;
    
    end generate;
    
    --    

    usr_clk_bufg : bufg 
    port map(
        i   => usr_clk, 
        o   => usr_clk2
    );
    
    usr_clk_o <= usr_clk2;
    
    
    rx_error_o(0) <= rx_disperr(0) or rx_disperr(1) or rx_notintable(0) or rx_notintable(1);
    rx_error_o(1) <= rx_disperr(2) or rx_disperr(3) or rx_notintable(2) or rx_notintable(3);
    
    
    sfp_gtx_inst : entity work.sfp_gtx
    port map(
        GTX0_RXCHARISK_OUT          => rx_kchar_o(1 downto 0),
        GTX0_RXDISPERR_OUT          => rx_disperr(1 downto 0),
        GTX0_RXNOTINTABLE_OUT       => rx_notintable(1 downto 0),
        GTX0_RXBYTEISALIGNED_OUT    => open,
        GTX0_RXCOMMADET_OUT         => open,
        GTX0_RXENMCOMMAALIGN_IN     => '1',
        GTX0_RXENPCOMMAALIGN_IN     => '1',
        GTX0_RXDATA_OUT             => rx_data_o(15 downto 0),
        GTX0_RXRECCLK_OUT           => rec_clk_o,
        GTX0_RXUSRCLK2_IN           => usr_clk2,
        GTX0_RXN_IN                 => rx_n_i(0),
        GTX0_RXP_IN                 => rx_p_i(0),
        GTX0_GTXRXRESET_IN          => reset_i,
        GTX0_MGTREFCLKRX_IN         => mgt_refclk,
        GTX0_PLLRXRESET_IN          => reset_i,
        GTX0_RXPLLLKDET_OUT         => open,
        GTX0_RXRESETDONE_OUT        => open,
        GTX0_TXCHARISK_IN           => tx_kchar_i(1 downto 0),
        GTX0_TXDATA_IN              => tx_data_i(15 downto 0),
        GTX0_TXOUTCLK_OUT           => usr_clk,
        GTX0_TXUSRCLK2_IN           => usr_clk2,
        GTX0_TXN_OUT                => tx_n_o(0),
        GTX0_TXP_OUT                => tx_p_o(0),
        GTX0_GTXTXRESET_IN          => reset_i,
        GTX0_TXRESETDONE_OUT        => open,
        --        
        GTX1_RXCHARISK_OUT          => rx_kchar_o(3 downto 2),
        GTX1_RXDISPERR_OUT          => rx_disperr(3 downto 2),
        GTX1_RXNOTINTABLE_OUT       => rx_notintable(3 downto 2),
        GTX1_RXBYTEISALIGNED_OUT    => open,
        GTX1_RXCOMMADET_OUT         => open,
        GTX1_RXENMCOMMAALIGN_IN     => '1',
        GTX1_RXENPCOMMAALIGN_IN     => '1',
        GTX1_RXDATA_OUT             => rx_data_o(31 downto 16),
        GTX1_RXRECCLK_OUT           => open,
        GTX1_RXUSRCLK2_IN           => usr_clk2,
        GTX1_RXN_IN                 => rx_n_i(1),
        GTX1_RXP_IN                 => rx_p_i(1),
        GTX1_GTXRXRESET_IN          => reset_i,
        GTX1_MGTREFCLKRX_IN         => mgt_refclk,
        GTX1_PLLRXRESET_IN          => reset_i,
        GTX1_RXPLLLKDET_OUT         => open,
        GTX1_RXRESETDONE_OUT        => open,
        GTX1_TXCHARISK_IN           => tx_kchar_i(3 downto 2),
        GTX1_TXDATA_IN              => tx_data_i(31 downto 16),
        GTX1_TXOUTCLK_OUT           => open,
        GTX1_TXUSRCLK2_IN           => usr_clk2,
        GTX1_TXN_OUT                => tx_n_o(1),
        GTX1_TXP_OUT                => tx_p_o(1),
        GTX1_GTXTXRESET_IN          => reset_i,
        GTX1_TXRESETDONE_OUT        => open
    );
    
end Behavioral;
