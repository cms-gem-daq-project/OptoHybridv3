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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package trig_pkg is

  constant DDR : integer := 0;
  constant MXSBITS : integer := 64 * (DDR+1);
  constant MXSBITS_CHAMBER : integer := 24*MXSBITS;
  constant REVERSE_VFAT_SBITS : std_logic_vector (23 downto 0) := x"000000";

end package;
