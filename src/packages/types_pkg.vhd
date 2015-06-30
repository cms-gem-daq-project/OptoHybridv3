library ieee;
use ieee.std_logic_1164.all;

package types_pkg is
    
    -- For VFAT2 packing
    type array24x8 is array(23 downto 0) of std_logic_vector(7 downto 0);
 
end types_pkg;

package body types_pkg is 
end types_pkg;
