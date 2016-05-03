-------------------------------------------------------------------------------
-- Copyright (c) 2016 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor     : Xilinx
-- \   \   \/     Version    : 14.7
--  \   \         Application: XILINX CORE Generator
--  /   /         Filename   : chipscope_ibert.vhd
-- /___/   /\     Timestamp  : Tue May 03 11:13:14 Romance Daylight Time 2016
-- \   \  /  \
--  \___\/\___\
--
-- Design Name: VHDL Synthesis Wrapper
-------------------------------------------------------------------------------
-- This wrapper is used to integrate with Project Navigator and PlanAhead

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
ENTITY chipscope_ibert IS
  port (
    X0Y16_TX_P_OPAD: out std_logic;
    X0Y16_TX_N_OPAD: out std_logic;
    X0Y17_TX_P_OPAD: out std_logic;
    X0Y17_TX_N_OPAD: out std_logic;
    X0Y18_TX_P_OPAD: out std_logic;
    X0Y18_TX_N_OPAD: out std_logic;
    X0Y19_TX_P_OPAD: out std_logic;
    X0Y19_TX_N_OPAD: out std_logic;
    X0Y16_RXRECCLK_O: out std_logic;
    X1Y24_TX_P_OPAD: out std_logic;
    X1Y24_TX_N_OPAD: out std_logic;
    X1Y25_TX_P_OPAD: out std_logic;
    X1Y25_TX_N_OPAD: out std_logic;
    X1Y26_TX_P_OPAD: out std_logic;
    X1Y26_TX_N_OPAD: out std_logic;
    X1Y27_TX_P_OPAD: out std_logic;
    X1Y27_TX_N_OPAD: out std_logic;
    X1Y28_TX_P_OPAD: out std_logic;
    X1Y28_TX_N_OPAD: out std_logic;
    X1Y29_TX_P_OPAD: out std_logic;
    X1Y29_TX_N_OPAD: out std_logic;
    X1Y30_TX_P_OPAD: out std_logic;
    X1Y30_TX_N_OPAD: out std_logic;
    X1Y31_TX_P_OPAD: out std_logic;
    X1Y31_TX_N_OPAD: out std_logic;
    X1Y32_TX_P_OPAD: out std_logic;
    X1Y32_TX_N_OPAD: out std_logic;
    X1Y33_TX_P_OPAD: out std_logic;
    X1Y33_TX_N_OPAD: out std_logic;
    X1Y34_TX_P_OPAD: out std_logic;
    X1Y34_TX_N_OPAD: out std_logic;
    X1Y35_TX_P_OPAD: out std_logic;
    X1Y35_TX_N_OPAD: out std_logic;
    X1Y24_RXRECCLK_O: out std_logic;
    X1Y25_RXRECCLK_O: out std_logic;
    X1Y26_RXRECCLK_O: out std_logic;
    X1Y27_RXRECCLK_O: out std_logic;
    X1Y28_RXRECCLK_O: out std_logic;
    X1Y29_RXRECCLK_O: out std_logic;
    X1Y30_RXRECCLK_O: out std_logic;
    X1Y31_RXRECCLK_O: out std_logic;
    X1Y32_RXRECCLK_O: out std_logic;
    X1Y33_RXRECCLK_O: out std_logic;
    X1Y34_RXRECCLK_O: out std_logic;
    X1Y35_RXRECCLK_O: out std_logic;
    CONTROL: inout std_logic_vector(35 downto 0);
    X0Y16_RX_P_IPAD: in std_logic;
    X0Y16_RX_N_IPAD: in std_logic;
    X0Y17_RX_P_IPAD: in std_logic;
    X0Y17_RX_N_IPAD: in std_logic;
    X0Y18_RX_P_IPAD: in std_logic;
    X0Y18_RX_N_IPAD: in std_logic;
    X0Y19_RX_P_IPAD: in std_logic;
    X0Y19_RX_N_IPAD: in std_logic;
    X1Y24_RX_P_IPAD: in std_logic;
    X1Y24_RX_N_IPAD: in std_logic;
    X1Y25_RX_P_IPAD: in std_logic;
    X1Y25_RX_N_IPAD: in std_logic;
    X1Y26_RX_P_IPAD: in std_logic;
    X1Y26_RX_N_IPAD: in std_logic;
    X1Y27_RX_P_IPAD: in std_logic;
    X1Y27_RX_N_IPAD: in std_logic;
    X1Y28_RX_P_IPAD: in std_logic;
    X1Y28_RX_N_IPAD: in std_logic;
    X1Y29_RX_P_IPAD: in std_logic;
    X1Y29_RX_N_IPAD: in std_logic;
    X1Y30_RX_P_IPAD: in std_logic;
    X1Y30_RX_N_IPAD: in std_logic;
    X1Y31_RX_P_IPAD: in std_logic;
    X1Y31_RX_N_IPAD: in std_logic;
    X1Y32_RX_P_IPAD: in std_logic;
    X1Y32_RX_N_IPAD: in std_logic;
    X1Y33_RX_P_IPAD: in std_logic;
    X1Y33_RX_N_IPAD: in std_logic;
    X1Y34_RX_P_IPAD: in std_logic;
    X1Y34_RX_N_IPAD: in std_logic;
    X1Y35_RX_P_IPAD: in std_logic;
    X1Y35_RX_N_IPAD: in std_logic;
    Q3_CLK0_MGTREFCLK_I: in std_logic;
    IBERT_SYSCLOCK_I: in std_logic);
END chipscope_ibert;

ARCHITECTURE chipscope_ibert_a OF chipscope_ibert IS
BEGIN

END chipscope_ibert_a;
