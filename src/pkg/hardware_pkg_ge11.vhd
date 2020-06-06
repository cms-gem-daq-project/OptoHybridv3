library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

package hardware_pkg is

  constant GE11            : boolean := true;
  constant FPGA_TYPE       : string  := "V6";
  constant FPGA_TYPE_IS_V6 : integer := 1;
  constant FPGA_TYPE_IS_A7 : integer := 0;

  constant MXELINKS : integer := 0;
  constant MXLED    : integer := 16;
  constant MXRESET  : integer := 12;
  constant MXREADY  : integer := 1;
  constant MXEXT    : integer := 8;
  constant MXADC    : integer := 1;

  constant REMAP_STRIPS       : boolean                        := false;
  constant REVERSE_VFAT_SBITS : std_logic_vector (23 downto 0) := x"000000";
  constant MXSBITS            : integer                        := 64;

  constant c_PARTITION_SIZE   : integer                        := 3;
  constant c_NUM_PARTITIONS   : integer                        := 8;
  constant c_NUM_VFATS        : integer                        := c_PARTITION_SIZE * c_NUM_PARTITIONS;

  constant MXSBITS_CHAMBER    : integer                        := c_NUM_VFATS*MXSBITS;

  constant INVERT_PARTITIONS : boolean := true;

  constant MXADRB : integer := 11;
  constant MXCNTB : integer := 3;

  constant MXCLUSTERS : integer := 8;

  constant INVALID_SBIT_ADR : std_logic_vector (MXADRB-1 downto 0) := "111" & x"FE";

  constant cluster_pad : std_logic := '0';

  constant MXCLUSTERS                 : integer := 16;
  constant NUM_OUTPUT_CLUSTERS_PER_BX : integer := 10;
  constant NUM_OVERFLOW_CLUSTERS      : integer := 10;
  constant NUM_OPTICAL_PACKETS        : integer := 2;

end hardware_pkg;
