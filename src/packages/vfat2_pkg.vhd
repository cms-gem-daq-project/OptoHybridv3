library ieee;
use ieee.std_logic_1164.all;

package vfat2_pkg is

    type vfat2_data_t is record
        sbits       : std_logic_vector(7 downto 0);
        data_out    : std_logic;
    end record;
    
    type vfat2s_data_t is array (integer range <>) of vfat2_data_t;

end vfat2_pkg;

package body vfat2_pkg is 
end vfat2_pkg;
