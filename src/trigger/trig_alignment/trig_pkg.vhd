----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Tap Delays
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module holds trig polarity swaps derived from the Optohybrid PCB
----------------------------------------------------------------------------------
-- 2017/11/06 -- Initial
-- 2017/11/13 -- Port to vhdl
-- 2018/04/17 -- Add lite mode
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package trig_pkg is

  -- START: TRIG_PKG DO NOT EDIT --

    constant OH_LITE : integer := 1; -- lite oh only has 12 VFATs

    constant MXVFATS : integer := 12;

    constant REVERSE_VFAT_SBITS : std_logic_vector (11 downto 0) := x"000";

  -- END: TRIG_PKG DO NOT EDIT --

  constant DDR : integer := 0;
  constant MXSBITS : integer := 64 * (DDR+1);

  constant MXSBITS_CHAMBER : integer := MXVFATS*MXSBITS;


end package;
