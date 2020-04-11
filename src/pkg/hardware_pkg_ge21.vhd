library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package hardware_pkg is

  constant GE21              : integer := 1;
  constant GE11              : integer := 0;
  constant HAS_ELINK_OUTPUTS : boolean := true;
  constant FPGA_TYPE         : string  := "ARTIX7";

  constant MXELINKS : integer := 1;
  constant MXLED    : integer := 1;
  constant MXRESET  : integer := 1;
  constant MXREADY  : integer := 2;

  constant REMAP_STRIPS       : boolean                        := false;
  constant REVERSE_VFAT_SBITS : std_logic_vector (11 downto 0) := x"000";
  constant MXSBITS            : integer                        := 64;
  constant MXVFATS            : integer                        := 12;
  constant MXSBITS_CHAMBER    : integer                        := MXVFATS*MXSBITS;

  constant MXADRB : integer := 9;       -- bits for addr in partition
  constant MXCNTB : integer := 3;       --
  constant MXPRTB : integer := 1;       --

  constant MXCLUSTERS : integer := 8;

  constant INVALID_SBIT_ADR : std_logic_vector (MXADRB-1 downto 0) := "11" & x"FE";

  constant cluster_pad : std_logic_vector (1 downto 0) := "00";

  -- TMR Enables
  constant USE_TMR_RESET              : integer := 1;
  constant USE_TMR_TTC                : integer := 1;
  constant USE_TMR_MGT_CONTROL        : integer := 1;
  constant USE_TMR_MGT_DATA           : integer := 1;
  constant USE_TMR_GBT_LINK           : integer := 1;
  constant USE_TMR_IPB_SWITCH         : integer := 1;
  constant USE_TMR_IPB_SLAVE_TRIGGER  : integer := 1;
  constant USE_TMR_IPB_SLAVE_CONTROL  : integer := 1;
  constant USE_TMR_IPB_SLAVE_GBT      : integer := 1;
  constant USE_TMR_IPB_SLAVE_ADC      : integer := 1;
  constant USE_TMR_IPB_SLAVE_CLOCKING : integer := 1;

end hardware_pkg;
