library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param_pkg is

    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"03";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"00";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"06";

    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2017";
    constant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"12";
    constant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"08";

    constant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"0A";

end param_pkg;

package body param_pkg is

end param_pkg;
