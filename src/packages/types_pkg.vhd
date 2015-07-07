library ieee;
use ieee.std_logic_1164.all;

package types_pkg is
    
    --== Trigger data ==--
 
    type sbits_array_t is array(integer range <>) of std_logic_vector(7 downto 0);
 
    --== Tracking data ==--
 
    type tk_data_t is record
        bc      : std_logic_vector(11 downto 0);
        ec      : std_logic_vector(7 downto 0);
        flags   : std_logic_vector(3 downto 0);
        chip_id : std_logic_vector(11 downto 0);
        strips  : std_logic_vector(127 downto 0);
        crc     : std_logic_vector(15 downto 0);    
    end record;
    
    type tk_data_array_t is array(integer range <>) of tk_data_t;
    
    --== T1 commands ==--
    
    type t1_t is record
        lv1a        : std_logic;
        calpulse    : std_logic;
        resync      : std_logic;
        bc0         : std_logic;
    end record;
    
    type t1_array_t is array(integer range <>) of t1_t;

    --== GBT data ==--
    
    type gbt_data_t is record
        is_data : std_logic;
        data    : std_logic_vector(83 downto 0);   
    end record;
    
    type gbt_data_array_t is array(integer range <>) of gbt_data_t;

end types_pkg;

package body types_pkg is 
end types_pkg;
