library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is
    
    --== Wishbone slaves ==--
    
    constant WB_N_SLAVES    : positive := 4;
    constant WB_N_MASTERS   : positive := 2;
    
    constant WB_S_REGISTER  : integer := 0;
    constant WB_S_I2C       : integer := 1;
    constant WB_S_LATENCY   : integer := 2;
    constant WB_S_THRESHOLD : integer := 3;
        
    --== Wishbone address selection ==--
    
    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer;
    
end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--

    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
        variable sel : integer;
    begin
        if    (std_match(addr, "00000000000000000000000000000000")) then 
            sel := WB_S_REGISTER;
        elsif (std_match(addr, "00000000000000000000000000000001")) then 
            sel := WB_S_I2C;
        elsif (std_match(addr, "00000000000000000000000000000010")) then 
            sel := WB_S_LATENCY;
        elsif (std_match(addr, "00000000000000000000000000000011")) then 
            sel := WB_S_THRESHOLD;
        else 
            sel := 99;
        end if;
        return sel;
    end wb_addr_sel;
 
end wb_pkg;
