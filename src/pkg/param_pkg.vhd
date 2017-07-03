library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package param_pkg is

    constant USE_DEFAULT_GBT_CLK    : boolean := TRUE;
    
    constant MAJOR_VERSION          : std_logic_vector(7 downto 0) := x"02";
    constant MINOR_VERSION          : std_logic_vector(7 downto 0) := x"02";
    constant RELEASE_VERSION        : std_logic_vector(7 downto 0) := x"0F";
    
    constant RELEASE_YEAR           : std_logic_vector(15 downto 0) := x"2017";
    constant RELEASE_MONTH          : std_logic_vector(7 downto 0) := x"07";
    constant RELEASE_DAY            : std_logic_vector(7 downto 0) := x"03";
        
end param_pkg;

package body param_pkg is 

  
end param_pkg;
