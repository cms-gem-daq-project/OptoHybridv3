library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package version_pkg is

    -- START: VERSION_PKG DO NOT EDIT --
    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"03";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"02";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"09";

    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2020";
    constant RELEASE_MONTH          : std_logic_vector(7 downto  0) := x"04";
    constant RELEASE_DAY            : std_logic_vector(7 downto  0) := x"11";

    constant RELEASE_HARDWARE       : std_logic_vector(7 downto  0) := x"2A";

  -- END: VERSION_PKG DO NOT EDIT --

end version_pkg;
