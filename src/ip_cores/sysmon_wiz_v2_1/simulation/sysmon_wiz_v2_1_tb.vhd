-- file: sysmon_wiz_v2_1_tb.vhd
-- (c) Copyright 2009 - 2010 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
------------------------------------------------------------------------------
-- System Monitor wizard demonstration testbench
------------------------------------------------------------------------------
-- This demonstration testbench instantiates the example design for the 
--   System Monitor wizard. Input clock is generated in this testbench.
------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
use ieee.std_logic_textio.all;
library std;
use std.textio.all;
library work;
use work.all;

-- This testbench does not implement checking averaging and calibration
-- Bipolar signals are applied with Vn = 0

entity sysmon_wiz_v2_1_tb is
end sysmon_wiz_v2_1_tb;
architecture test of sysmon_wiz_v2_1_tb is
  constant PER1        : time := 20 ns;
  -- Declare the input clock signals
  signal DCLK_TB       : std_logic := '1';
  signal DADDR_TB      : std_logic_vector(6 downto 0);
  signal DEN_TB        : std_logic;
  signal DWE_TB        : std_logic;
  signal DI_TB         : std_logic_vector(15 downto 0);
  signal DO_TB         : std_logic_vector(15 downto 0);
  signal DRDY_TB       : std_logic;
  signal RESET_TB      : std_logic;
   signal FLOAT_VCCAUX_ALARM : std_logic;
   signal FLOAT_VCCINT_ALARM : std_logic;
   signal FLOAT_USER_TEMP_ALARM : std_logic;
  signal BUSY_TB       : std_logic;
  signal CHANNEL_TB    : std_logic_vector(4 downto 0);
  signal EOC_TB        : std_logic;
  signal EOS_TB        : std_logic;
component sysmon_wiz_v2_1_exdes
    port (
          DADDR_IN            : in  STD_LOGIC_VECTOR (6 downto 0);
          DCLK_IN             : in  STD_LOGIC;
          DEN_IN              : in  STD_LOGIC;
          DI_IN               : in  STD_LOGIC_VECTOR (15 downto 0);
          DWE_IN              : in  STD_LOGIC;
          RESET_IN            : in  STD_LOGIC;
          VAUXP4              : in  STD_LOGIC;
          VAUXN4              : in  STD_LOGIC;
          VAUXP5              : in  STD_LOGIC;
          VAUXN5              : in  STD_LOGIC;
          BUSY_OUT            : out  STD_LOGIC;
          CHANNEL_OUT         : out  STD_LOGIC_VECTOR (4 downto 0);
          DO_OUT              : out  STD_LOGIC_VECTOR (15 downto 0);
          DRDY_OUT            : out  STD_LOGIC;
          EOC_OUT             : out  STD_LOGIC;
          EOS_OUT             : out  STD_LOGIC;
          VP_IN               : in  STD_LOGIC;
          VN_IN               : in  STD_LOGIC
);
end component;
begin
  -- DCLK clock generation
  --------------------------------------
  process begin
    DCLK_TB <= not DCLK_TB; wait for (PER1/2);
  end process;
  DADDR_TB <= "00" & CHANNEL_TB;
  DI_TB <= "0000000000000000";
  DWE_TB <= '0';
  DEN_TB <= EOC_TB;
  RESET_TB <= '0';
  process begin
   wait until EOS_TB = '1';
   report "EOS asserted, End of Conversion Sequence !!" severity note;
   report "End of averaging !!" severity note;
   report "Simulation stopped !" severity failure;
  end process;
  -- Test Sequence Begin
  -----------------------------------------------------------
  process begin
    report "Averaging is enabled for the core" severity NOTE;
    report "Please edit the simulation script to change the simulation time" severity note;
    wait;
  end process;
  -- Test Sequence End
  -- Instantiation of the example design
  -----------------------------------------------------------
  dut : sysmon_wiz_v2_1_exdes
  port map (
      DADDR_IN(6 downto 0)    => DADDR_TB(6 downto 0),
      DCLK_IN                 => DCLK_TB,
      DEN_IN                  => DEN_TB,
      DI_IN(15 downto 0)      => DI_TB(15 downto 0),
      DWE_IN                  => DWE_TB,
      RESET_IN                => RESET_TB,
      VAUXP4                  => '0', -- Stimulus applied from SIM_MONITOR_FILE
      VAUXN4                  => '0',
      VAUXP5                  => '0', -- Stimulus applied from SIM_MONITOR_FILE
      VAUXN5                  => '0',
      BUSY_OUT                => BUSY_TB,
      CHANNEL_OUT(4 downto 0) => CHANNEL_TB(4 downto 0),
      DO_OUT(15 downto 0)     => DO_TB(15 downto 0),
      DRDY_OUT                => DRDY_TB,
      EOC_OUT                 => EOC_TB,
      EOS_OUT                 => EOS_TB,
      VP_IN                   => '0',   -- Stimulus applied from SIM_MONITOR_FILE
      VN_IN                   => '0'
         );
end test;
