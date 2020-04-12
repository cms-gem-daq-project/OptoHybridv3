library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

package hardware_pkg is

  constant GE11                 : boolean := true;
  constant FPGA_TYPE            : string  := "V6";
  constant FPGA_TYPE_IS_V6 : integer := 1;
  constant FPGA_TYPE_IS_A7  : integer := 0;

  constant MXELINKS : integer := 0;
  constant MXLED    : integer := 16;
  constant MXRESET  : integer := 12;
  constant MXREADY  : integer := 1;
  constant MXEXT    : integer := 8;
  constant MXADC    : integer := 1;

  constant REMAP_STRIPS       : boolean                        := false;
  constant REVERSE_VFAT_SBITS : std_logic_vector (23 downto 0) := x"000000";
  constant MXVFATS            : integer                        := 24;
  constant MXSBITS            : integer                        := 64;
  constant MXSBITS_CHAMBER    : integer                        := MXVFATS*MXSBITS;

  constant INVERT_PARTITIONS : boolean := true;

  constant MXADRB : integer := 11;
  constant MXCNTB : integer := 3;

  constant MXCLUSTERS : integer := 8;

  constant INVALID_SBIT_ADR : std_logic_vector (MXADRB-1 downto 0) := "111" & x"FE";

  constant cluster_pad : std_logic := '0';

end hardware_pkg;
