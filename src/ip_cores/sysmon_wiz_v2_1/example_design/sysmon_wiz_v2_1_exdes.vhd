-- file: sysmon_wiz_v2_1_exdes.vhd
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
-- Clocking wizard example design
------------------------------------------------------------------------------
-- This example design instantiates the generated VHDL file containing the
-- System Monitor instantiation.
------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
Library UNISIM;
use UNISIM.VCOMPONENTS.ALL;

entity sysmon_wiz_v2_1_exdes is
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
end sysmon_wiz_v2_1_exdes;

architecture xilinx of sysmon_wiz_v2_1_exdes is

component sysmon_wiz_v2_1
    port (
          DADDR_IN            : in  STD_LOGIC_VECTOR (6 downto 0);     -- Address bus for the dynamic reconfiguration port
          DCLK_IN             : in  STD_LOGIC;                         -- Clock input for the dynamic reconfiguration port
          DEN_IN              : in  STD_LOGIC;                         -- Enable Signal for the dynamic reconfiguration port
          DI_IN               : in  STD_LOGIC_VECTOR (15 downto 0);    -- Input data bus for the dynamic reconfiguration port
          DWE_IN              : in  STD_LOGIC;                         -- Write Enable for the dynamic reconfiguration port
          RESET_IN            : in  STD_LOGIC;                         -- Reset signal for the System Monitor control logic
          VAUXP4              : in  STD_LOGIC;                         -- Auxiliary Channel 4
          VAUXN4              : in  STD_LOGIC;
          VAUXP5              : in  STD_LOGIC;                         -- Auxiliary Channel 5
          VAUXN5              : in  STD_LOGIC;
          BUSY_OUT            : out  STD_LOGIC;                        -- ADC Busy signal
          CHANNEL_OUT         : out  STD_LOGIC_VECTOR (4 downto 0);    -- Channel Selection Outputs
          DO_OUT              : out  STD_LOGIC_VECTOR (15 downto 0);   -- Output data bus for dynamic reconfiguration port
          DRDY_OUT            : out  STD_LOGIC;                        -- Data ready signal for the dynamic reconfiguration port
          EOC_OUT             : out  STD_LOGIC;                        -- End of Conversion Signal
          EOS_OUT             : out  STD_LOGIC;                        -- End of Sequence Signal
          VP_IN               : in  STD_LOGIC;                         -- Dedicated Analog Input Pair
          VN_IN               : in  STD_LOGIC
);
end component;

begin

 sysmon_wiz_inst : sysmon_wiz_v2_1
port map (
      DADDR_IN(6 downto 0)    => DADDR_IN(6 downto 0),
      DCLK_IN                 => DCLK_IN,
      DEN_IN                  => DEN_IN,
      DI_IN(15 downto 0)      => DI_IN(15 downto 0),
      DWE_IN                  => DWE_IN,
      RESET_IN                => RESET_IN,
      VAUXP4              => VAUXP4,
      VAUXN4              => VAUXN4,
      VAUXP5              => VAUXP5,
      VAUXN5              => VAUXN5,
      BUSY_OUT                => BUSY_OUT,
      CHANNEL_OUT(4 downto 0) => CHANNEL_OUT(4 downto 0),
      DO_OUT(15 downto 0)     => DO_OUT(15 downto 0),
      DRDY_OUT                => DRDY_OUT,
      EOC_OUT                 => EOC_OUT,
      EOS_OUT                 => EOS_OUT,
      VP_IN                   => VP_IN,
      VN_IN                   => VN_IN
         );
end xilinx;
