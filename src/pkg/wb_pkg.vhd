library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is
    
    --== Wishbone slaves ==--
    
	constant WB_N_SLAVES        : positive := 7;
	constant WB_N_MASTERS       : positive := 2;
    
    constant WB_S_ADC           : integer := 0;
    constant WB_S_CDCE          : integer := 1;
    constant WB_S_CHIPID        : integer := 2;
    constant WB_S_TEMP          : integer := 3;
    
    constant WB_S_VFAT2_I2C_0   : integer := 4;
    constant WB_S_VFAT2_I2C_1   : integer := 5;
    constant WB_S_VFAT2_I2C_2   : integer := 6;
        
    --== Wishbone address selection ==--
    
	function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer;
    
end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--

    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
        variable sel : integer;
    begin
        if    (std_match(addr, "00000000000000000000000000000000")) then 
            sel := WB_S_ADC;
        elsif (std_match(addr, "00000000000000000000000000000001")) then 
            sel := WB_S_ADC;
        elsif (std_match(addr, "00000000000000000000000000000010")) then 
            sel := WB_S_ADC;
        elsif (std_match(addr, "00000000000000000000000000000011")) then 
            sel := WB_S_ADC;
        else 
            sel := 99;
        end if;
        return sel;
    end wb_addr_sel;
 
end wb_pkg;
