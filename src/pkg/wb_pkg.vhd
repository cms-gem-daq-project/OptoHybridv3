library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is
    
    --== Wishbone masters ==--
    
	constant WB_MASTERS             : positive := 15;
    
    constant WB_MST_GTX_0           : integer := 0;
    constant WB_MST_GTX_1           : integer := 1;
    constant WB_MST_GTX_2           : integer := 2;
    
    constant WB_MST_THR_0           : integer := 3;
    constant WB_MST_THR_1           : integer := 4;
    constant WB_MST_THR_2           : integer := 5;
    constant WB_MST_THR_3           : integer := 6;
    constant WB_MST_THR_4           : integer := 7;
    constant WB_MST_THR_5           : integer := 8;
    
    constant WB_MST_LAT_0           : integer := 9;
    constant WB_MST_LAT_1           : integer := 10;
    constant WB_MST_LAT_2           : integer := 11;
    constant WB_MST_LAT_3           : integer := 12;
    constant WB_MST_LAT_4           : integer := 13;
    constant WB_MST_LAT_5           : integer := 14;
    
    --== Wishbone slaves ==--
    
	constant WB_SLAVES              : positive := 18;
    
    constant WB_SLV_I2C_0           : integer := 0;
    constant WB_SLV_I2C_1           : integer := 1;
    constant WB_SLV_I2C_2           : integer := 2;
    constant WB_SLV_I2C_3           : integer := 3;
    constant WB_SLV_I2C_4           : integer := 4;
    constant WB_SLV_I2C_5           : integer := 5;
    
    constant WB_SLV_THRESHOLD_0     : integer := 6;
    constant WB_SLV_THRESHOLD_1     : integer := 7;
    constant WB_SLV_THRESHOLD_2     : integer := 8;
    constant WB_SLV_THRESHOLD_3     : integer := 9;
    constant WB_SLV_THRESHOLD_4     : integer := 10;
    constant WB_SLV_THRESHOLD_5     : integer := 11;
    
    constant WB_SLV_LATENCY_0       : integer := 12;
    constant WB_SLV_LATENCY_1       : integer := 13;
    constant WB_SLV_LATENCY_2       : integer := 14;
    constant WB_SLV_LATENCY_3       : integer := 15;
    constant WB_SLV_LATENCY_4       : integer := 16;
    constant WB_SLV_LATENCY_5       : integer := 17;
   
    --== Wishbone address selection & generation ==--
    
	function wb_addr_sel(signal addr : std_logic_vector(31 downto 0)) return integer;
    
end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--   
    
    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
        variable sel : integer;
    begin
        -- VFAT2 I2C                               |ID || REGS |
        if    (std_match(addr, "0000000000000000000000----------")) then sel := WB_SLV_I2C_0;
        elsif (std_match(addr, "0000000000000000000001----------")) then sel := WB_SLV_I2C_1;
        elsif (std_match(addr, "0000000000000000000010----------")) then sel := WB_SLV_I2C_2;
        elsif (std_match(addr, "0000000000000000000011----------")) then sel := WB_SLV_I2C_3;
        elsif (std_match(addr, "0000000000000000000100----------")) then sel := WB_SLV_I2C_4;
        elsif (std_match(addr, "0000000000000000000101----------")) then sel := WB_SLV_I2C_5;
        -- VFAT2 Threshold                         |ID || REGS |            
        elsif (std_match(addr, "0001000000000000000000--00000---")) then sel := WB_SLV_THRESHOLD_0;
        elsif (std_match(addr, "0001000000000000000001--00000---")) then sel := WB_SLV_THRESHOLD_1;
        elsif (std_match(addr, "0001000000000000000010--00000---")) then sel := WB_SLV_THRESHOLD_2;
        elsif (std_match(addr, "0001000000000000000011--00000---")) then sel := WB_SLV_THRESHOLD_3;
        elsif (std_match(addr, "0001000000000000000100--00000---")) then sel := WB_SLV_THRESHOLD_4;
        elsif (std_match(addr, "0001000000000000000101--00000---")) then sel := WB_SLV_THRESHOLD_5;
        -- VFAT2 Latency                           |ID || REGS |      
        elsif (std_match(addr, "0010000000000000000000--00000---")) then sel := WB_SLV_LATENCY_0;
        elsif (std_match(addr, "0010000000000000000001--00000---")) then sel := WB_SLV_LATENCY_1;
        elsif (std_match(addr, "0010000000000000000010--00000---")) then sel := WB_SLV_LATENCY_2;
        elsif (std_match(addr, "0010000000000000000011--00000---")) then sel := WB_SLV_LATENCY_3;
        elsif (std_match(addr, "0010000000000000000100--00000---")) then sel := WB_SLV_LATENCY_4;
        elsif (std_match(addr, "0010000000000000000101--00000---")) then sel := WB_SLV_LATENCY_5;
        --
        else sel := 99;
        end if;
        return sel;
    end wb_addr_sel;
 
end wb_pkg;
