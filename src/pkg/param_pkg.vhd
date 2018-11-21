library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param_pkg is

    -- START: PARAM_PKG DO NOT EDIT --
    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"03";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"02";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"00";

    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2018";
    constant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"11";
    constant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"21";

    constant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"1C";

    constant FPGA_TYPE     : string  := "VIRTEX6";
    constant FPGA_TYPE_IS_VIRTEX6  : integer := 1;
    constant FPGA_TYPE_IS_ARTIX7   : integer := 0;

    constant MXELINKS : integer := 2;
    constant MXLED    : integer := 16;
    constant MXRESET  : integer := 12;
    constant MXREADY  : integer := 1;
  -- END: PARAM_PKG DO NOT EDIT --

end param_pkg;

package body param_pkg is

end param_pkg;
