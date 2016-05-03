-------------------------------------------------------------------------------------------------------
--  Copyright (c) 2009 Xilinx, Inc.
--
--   ____  ____
--  /   /\/   /
-- /___/  \  /   This   document  contains  proprietary information  which   is
-- \   \   \/    protected by  copyright. All rights  are reserved. No  part of
--  \   \        this  document may be photocopied, reproduced or translated to
--  /   /        another  program  language  without  prior written  consent of
-- /___/   /\    XILINX Inc., San Jose, CA. 95125                              
-- \   \  /  \ 
--  \___\/\___\
-- 
--  Xilinx Template Revision:
--   $RCSfile: example_prime_top_vhd.ejava,v $
--   $Revision: 1.3 $
--  Modify $Date: 2011/12/08 14:40:47 $
--   Application : Virtex-6 IBERT
--   Version : 1.4
--
--  Description:
--   This file is an example top wrapper for the ibert design with the required
--   clock buffers. User logic can be instatiated in this wrapper along with 
--   the ibert design.
--

--***************************** Entity declaration ****************************
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;
LIBRARY UNISIM;
USE UNISIM.vcomponents.all;
LIBRARY chipscope_ibert_virtex6_gtx_v2_05_a;

ENTITY example_chipscope_ibert IS
  PORT (
    -- Input Declarations

    X0Y16_RX_P_IPAD : IN STD_LOGIC;
    X0Y16_RX_N_IPAD : IN STD_LOGIC;
    X0Y17_RX_P_IPAD : IN STD_LOGIC;
    X0Y17_RX_N_IPAD : IN STD_LOGIC;
    X0Y18_RX_P_IPAD : IN STD_LOGIC;
    X0Y18_RX_N_IPAD : IN STD_LOGIC;
    X0Y19_RX_P_IPAD : IN STD_LOGIC;
    X0Y19_RX_N_IPAD : IN STD_LOGIC;
    Q3_CLK0_MGTREFCLK_P_IPAD : IN STD_LOGIC;
    Q3_CLK0_MGTREFCLK_N_IPAD : IN STD_LOGIC;
    --Output Declarations
    X0Y16_TX_P_OPAD : OUT STD_LOGIC;
    X0Y16_TX_N_OPAD : OUT STD_LOGIC;
    X0Y17_TX_P_OPAD : OUT STD_LOGIC;
    X0Y17_TX_N_OPAD : OUT STD_LOGIC;
    X0Y18_TX_P_OPAD : OUT STD_LOGIC;
    X0Y18_TX_N_OPAD : OUT STD_LOGIC;
    X0Y19_TX_P_OPAD : OUT STD_LOGIC;
    X0Y19_TX_N_OPAD : OUT STD_LOGIC;
  --User Ports
    X0Y16_RXRECCLK_P_OPAD : OUT STD_LOGIC;
    X0Y16_RXRECCLK_N_OPAD : OUT STD_LOGIC
  );
END example_chipscope_ibert;

ARCHITECTURE top_virtex6 OF example_chipscope_ibert IS


component chipscope_ibert
  PORT (
    X0Y16_TX_P_OPAD : OUT STD_LOGIC;
    X0Y16_TX_N_OPAD : OUT STD_LOGIC;
    X0Y17_TX_P_OPAD : OUT STD_LOGIC;
    X0Y17_TX_N_OPAD : OUT STD_LOGIC;
    X0Y18_TX_P_OPAD : OUT STD_LOGIC;
    X0Y18_TX_N_OPAD : OUT STD_LOGIC;
    X0Y19_TX_P_OPAD : OUT STD_LOGIC;
    X0Y19_TX_N_OPAD : OUT STD_LOGIC;
    X0Y16_RXRECCLK_O : OUT STD_LOGIC;
    X1Y24_TX_P_OPAD : OUT STD_LOGIC;
    X1Y24_TX_N_OPAD : OUT STD_LOGIC;
    X1Y25_TX_P_OPAD : OUT STD_LOGIC;
    X1Y25_TX_N_OPAD : OUT STD_LOGIC;
    X1Y26_TX_P_OPAD : OUT STD_LOGIC;
    X1Y26_TX_N_OPAD : OUT STD_LOGIC;
    X1Y27_TX_P_OPAD : OUT STD_LOGIC;
    X1Y27_TX_N_OPAD : OUT STD_LOGIC;
    X1Y28_TX_P_OPAD : OUT STD_LOGIC;
    X1Y28_TX_N_OPAD : OUT STD_LOGIC;
    X1Y29_TX_P_OPAD : OUT STD_LOGIC;
    X1Y29_TX_N_OPAD : OUT STD_LOGIC;
    X1Y30_TX_P_OPAD : OUT STD_LOGIC;
    X1Y30_TX_N_OPAD : OUT STD_LOGIC;
    X1Y31_TX_P_OPAD : OUT STD_LOGIC;
    X1Y31_TX_N_OPAD : OUT STD_LOGIC;
    X1Y32_TX_P_OPAD : OUT STD_LOGIC;
    X1Y32_TX_N_OPAD : OUT STD_LOGIC;
    X1Y33_TX_P_OPAD : OUT STD_LOGIC;
    X1Y33_TX_N_OPAD : OUT STD_LOGIC;
    X1Y34_TX_P_OPAD : OUT STD_LOGIC;
    X1Y34_TX_N_OPAD : OUT STD_LOGIC;
    X1Y35_TX_P_OPAD : OUT STD_LOGIC;
    X1Y35_TX_N_OPAD : OUT STD_LOGIC;
    X1Y24_RXRECCLK_O : OUT STD_LOGIC;
    X1Y25_RXRECCLK_O : OUT STD_LOGIC;
    X1Y26_RXRECCLK_O : OUT STD_LOGIC;
    X1Y27_RXRECCLK_O : OUT STD_LOGIC;
    X1Y28_RXRECCLK_O : OUT STD_LOGIC;
    X1Y29_RXRECCLK_O : OUT STD_LOGIC;
    X1Y30_RXRECCLK_O : OUT STD_LOGIC;
    X1Y31_RXRECCLK_O : OUT STD_LOGIC;
    X1Y32_RXRECCLK_O : OUT STD_LOGIC;
    X1Y33_RXRECCLK_O : OUT STD_LOGIC;
    X1Y34_RXRECCLK_O : OUT STD_LOGIC;
    X1Y35_RXRECCLK_O : OUT STD_LOGIC;
    CONTROL : INOUT STD_LOGIC_VECTOR(35 DOWNTO 0);
    X0Y16_RX_P_IPAD : IN STD_LOGIC;
    X0Y16_RX_N_IPAD : IN STD_LOGIC;
    X0Y17_RX_P_IPAD : IN STD_LOGIC;
    X0Y17_RX_N_IPAD : IN STD_LOGIC;
    X0Y18_RX_P_IPAD : IN STD_LOGIC;
    X0Y18_RX_N_IPAD : IN STD_LOGIC;
    X0Y19_RX_P_IPAD : IN STD_LOGIC;
    X0Y19_RX_N_IPAD : IN STD_LOGIC;
    X1Y24_RX_P_IPAD : IN STD_LOGIC;
    X1Y24_RX_N_IPAD : IN STD_LOGIC;
    X1Y25_RX_P_IPAD : IN STD_LOGIC;
    X1Y25_RX_N_IPAD : IN STD_LOGIC;
    X1Y26_RX_P_IPAD : IN STD_LOGIC;
    X1Y26_RX_N_IPAD : IN STD_LOGIC;
    X1Y27_RX_P_IPAD : IN STD_LOGIC;
    X1Y27_RX_N_IPAD : IN STD_LOGIC;
    X1Y28_RX_P_IPAD : IN STD_LOGIC;
    X1Y28_RX_N_IPAD : IN STD_LOGIC;
    X1Y29_RX_P_IPAD : IN STD_LOGIC;
    X1Y29_RX_N_IPAD : IN STD_LOGIC;
    X1Y30_RX_P_IPAD : IN STD_LOGIC;
    X1Y30_RX_N_IPAD : IN STD_LOGIC;
    X1Y31_RX_P_IPAD : IN STD_LOGIC;
    X1Y31_RX_N_IPAD : IN STD_LOGIC;
    X1Y32_RX_P_IPAD : IN STD_LOGIC;
    X1Y32_RX_N_IPAD : IN STD_LOGIC;
    X1Y33_RX_P_IPAD : IN STD_LOGIC;
    X1Y33_RX_N_IPAD : IN STD_LOGIC;
    X1Y34_RX_P_IPAD : IN STD_LOGIC;
    X1Y34_RX_N_IPAD : IN STD_LOGIC;
    X1Y35_RX_P_IPAD : IN STD_LOGIC;
    X1Y35_RX_N_IPAD : IN STD_LOGIC;
    Q3_CLK0_MGTREFCLK_I : IN STD_LOGIC;
    IBERT_SYSCLOCK_I : IN STD_LOGIC);

end component;
  COMPONENT chipscope_icon_1
    port (
      CONTROL0 : INOUT STD_LOGIC_VECTOR(35 downto 0));
  END COMPONENT;


  -- Local Signal Declarations
  SIGNAL q3_clk0_mgtrefclk : STD_LOGIC;
  SIGNAL ibert_sysclock : STD_LOGIC;
  SIGNAL x0y16_rxrecclk : STD_LOGIC;
  SIGNAL x0y16_rxrecclk_oddr_out : STD_LOGIC;
  SIGNAL CONTROL0 : STD_LOGIC_VECTOR(35 downto 0);

BEGIN


  -- Ibert Core Wrapper Instance
  U_CHIPSCOPE_IBERT: chipscope_ibert
    PORT MAP (
      X0Y16_TX_P_OPAD => X0Y16_TX_P_OPAD,
      X0Y16_TX_N_OPAD => X0Y16_TX_N_OPAD,
      X0Y17_TX_P_OPAD => X0Y17_TX_P_OPAD,
      X0Y17_TX_N_OPAD => X0Y17_TX_N_OPAD,
      X0Y18_TX_P_OPAD => X0Y18_TX_P_OPAD,
      X0Y18_TX_N_OPAD => X0Y18_TX_N_OPAD,
      X0Y19_TX_P_OPAD => X0Y19_TX_P_OPAD,
      X0Y19_TX_N_OPAD => X0Y19_TX_N_OPAD,
      X0Y16_RXRECCLK_O => x0y16_rxrecclk,
      X0Y16_RX_P_IPAD => X0Y16_RX_P_IPAD,
      X0Y16_RX_N_IPAD => X0Y16_RX_N_IPAD,
      X0Y17_RX_P_IPAD => X0Y17_RX_P_IPAD,
      X0Y17_RX_N_IPAD => X0Y17_RX_N_IPAD,
      X0Y18_RX_P_IPAD => X0Y18_RX_P_IPAD,
      X0Y18_RX_N_IPAD => X0Y18_RX_N_IPAD,
      X0Y19_RX_P_IPAD => X0Y19_RX_P_IPAD,
      X0Y19_RX_N_IPAD => X0Y19_RX_N_IPAD,
      Q3_CLK0_MGTREFCLK_I => q3_clk0_mgtrefclk,
      CONTROL => CONTROL0,
      IBERT_SYSCLOCK_I => ibert_sysclock,
      
      
    X1Y24_TX_P_OPAD => open,
    X1Y24_TX_N_OPAD => open,
    X1Y25_TX_P_OPAD => open,
    X1Y25_TX_N_OPAD => open,
    X1Y26_TX_P_OPAD => open,
    X1Y26_TX_N_OPAD => open,
    X1Y27_TX_P_OPAD => open,
    X1Y27_TX_N_OPAD => open,
    X1Y28_TX_P_OPAD => open,
    X1Y28_TX_N_OPAD => open,
    X1Y29_TX_P_OPAD => open,
    X1Y29_TX_N_OPAD => open,
    X1Y30_TX_P_OPAD => open,
    X1Y30_TX_N_OPAD => open,
    X1Y31_TX_P_OPAD => open,
    X1Y31_TX_N_OPAD => open,
    X1Y32_TX_P_OPAD => open,
    X1Y32_TX_N_OPAD => open,
    X1Y33_TX_P_OPAD => open,
    X1Y33_TX_N_OPAD => open,
    X1Y34_TX_P_OPAD => open,
    X1Y34_TX_N_OPAD => open,
    X1Y35_TX_P_OPAD => open,
    X1Y35_TX_N_OPAD => open,
    X1Y24_RXRECCLK_O => open,
    X1Y25_RXRECCLK_O => open,
    X1Y26_RXRECCLK_O => open,
    X1Y27_RXRECCLK_O => open,
    X1Y28_RXRECCLK_O => open,
    X1Y29_RXRECCLK_O => open,
    X1Y30_RXRECCLK_O => open,
    X1Y31_RXRECCLK_O => open,
    X1Y32_RXRECCLK_O => open,
    X1Y33_RXRECCLK_O => open,
    X1Y34_RXRECCLK_O => open,
    X1Y35_RXRECCLK_O => open,
    X1Y24_RX_P_IPAD => '0',
    X1Y24_RX_N_IPAD => '1',
    X1Y25_RX_P_IPAD => '0',
    X1Y25_RX_N_IPAD => '1',
    X1Y26_RX_P_IPAD => '0',
    X1Y26_RX_N_IPAD => '1',
    X1Y27_RX_P_IPAD => '0',
    X1Y27_RX_N_IPAD => '1',
    X1Y28_RX_P_IPAD => '0',
    X1Y28_RX_N_IPAD => '1',
    X1Y29_RX_P_IPAD => '0',
    X1Y29_RX_N_IPAD => '1',
    X1Y30_RX_P_IPAD => '0',
    X1Y30_RX_N_IPAD => '1',
    X1Y31_RX_P_IPAD => '0',
    X1Y31_RX_N_IPAD => '1',
    X1Y32_RX_P_IPAD => '0',
    X1Y32_RX_N_IPAD => '1',
    X1Y33_RX_P_IPAD => '0',
    X1Y33_RX_N_IPAD => '1',
    X1Y34_RX_P_IPAD => '0',
    X1Y34_RX_N_IPAD => '1',
    X1Y35_RX_P_IPAD => '0',
    X1Y35_RX_N_IPAD => '1'      
    );
  U_ICON : chipscope_icon_1
    PORT MAP (
       CONTROL0 => CONTROL0);
  -- GT Refclock Instances
 ------ Refclk Q3-Refclk0 sources GT(s) X0Y19 X0Y18 X0Y17 X0Y16
  U_Q3_CLK0_MGTREFCLK : IBUFDS_GTXE1
   PORT MAP (
     O => q3_clk0_mgtrefclk,
     ODIV2 => OPEN,
     CEB => '0',
     I => Q3_CLK0_MGTREFCLK_P_IPAD,
     IB => Q3_CLK0_MGTREFCLK_N_IPAD
   );

  -- Sysclock source
  ibert_sysclock <= '0';


END top_virtex6;

