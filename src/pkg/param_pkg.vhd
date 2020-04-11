library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param_pkg is

    -- START: PARAM_PKG DO NOT EDIT --
    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"03";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"02";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"09";

    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2020";
    constant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"04";
    constant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"11";

    constant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"2A";

    constant FPGA_TYPE     : string  := "ARTIX7";
    constant FPGA_TYPE_IS_VIRTEX6  : integer := 0;
    constant FPGA_TYPE_IS_ARTIX7   : integer := 1;

    constant MXELINKS : integer := 1;
    constant MXLED    : integer := 1;
    constant MXRESET  : integer := 1;
    constant MXREADY  : integer := 2;
  -- END: PARAM_PKG DO NOT EDIT --

end param_pkg;

package body param_pkg is

end param_pkg;
