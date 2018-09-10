library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param_pkg is

    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"03";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"01";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"05";

    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2018";
    constant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"09";
    constant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"12";

    constant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"1C";

  --constant FPGA_TYPE     : string (7 downto  1) := "VIRTEX6";
    constant FPGA_TYPE     : string  := "ARTIX7";
    constant FPGA_TYPE_IS_VIRTEX6  : integer := 0;
    constant FPGA_TYPE_IS_ARTIX7   : integer := 1;

    constant MXELINKS : integer := 1;
    constant MXLED    : integer := 1;
    constant MXRESET  : integer := 1;

end param_pkg;

package body param_pkg is

end param_pkg;
