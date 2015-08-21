library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is
    
    --== Wishbone options ==--
    
    constant WB_TIMEOUT     : integer := 200_000;
    
    --== Wishbone masters ==--
    
	constant WB_MASTERS     : positive := 5;
    
    constant WB_MST_GTX_0   : integer := 0;
    constant WB_MST_GTX_1   : integer := 1;
    constant WB_MST_GTX_2   : integer := 2;
    
    constant WB_MST_EI2C    : integer := 3;
    
    constant WB_MST_SCAN    : integer := 4;
    
    --== Wishbone slaves ==--
    
	constant WB_SLAVES      : positive := 9;
    
    constant WB_SLV_I2C_0   : integer := 0;
    constant WB_SLV_I2C_1   : integer := 1;
    constant WB_SLV_I2C_2   : integer := 2;
    constant WB_SLV_I2C_3   : integer := 3; 
    constant WB_SLV_I2C_4   : integer := 4; 
    constant WB_SLV_I2C_5   : integer := 5;
    
    constant WB_SLV_EI2C    : integer := 6;
    
    constant WB_SLV_T1      : integer := 7;
    
    constant WB_SLV_SCAN    : integer := 8;
    
    --== Wishbone addresses ==--
    
    constant WB_ADDR_I2C    : std_logic_vector(3 downto 0) := x"0";
    constant WB_ADDR_EI2C   : std_logic_vector(3 downto 0) := x"1";
    constant WB_ADDR_SCAN   : std_logic_vector(3 downto 0) := x"2";
    constant WB_ADDR_T1     : std_logic_vector(3 downto 0) := x"3";
   
    --== Wishbone address selection & generation ==--
    
	function wb_addr_sel(signal addr : std_logic_vector(31 downto 0)) return integer;
    
end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--   
    
    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
        variable sel : integer;
    begin
        -- VFAT2 I2C                                          |ID || REGS |
        if    (std_match(addr, WB_ADDR_I2C  & "000000000000000000----------")) then sel := WB_SLV_I2C_0;
        elsif (std_match(addr, WB_ADDR_I2C  & "000000000000000001----------")) then sel := WB_SLV_I2C_1;
        elsif (std_match(addr, WB_ADDR_I2C  & "000000000000000010----------")) then sel := WB_SLV_I2C_2;
        elsif (std_match(addr, WB_ADDR_I2C  & "000000000000000011----------")) then sel := WB_SLV_I2C_3;
        elsif (std_match(addr, WB_ADDR_I2C  & "000000000000000100----------")) then sel := WB_SLV_I2C_4;
        elsif (std_match(addr, WB_ADDR_I2C  & "000000000000000101----------")) then sel := WB_SLV_I2C_5;
        -- VFAT2 I2C extended                                     | REGS  |
        elsif (std_match(addr, WB_ADDR_EI2C & "0000000000000000000---------")) then sel := WB_SLV_EI2C;
        -- VFAT2 scan                                              | REGS |            
        elsif (std_match(addr, WB_ADDR_SCAN & "0000000000000000000000000---")) then sel := WB_SLV_SCAN;
        -- VFAT2 T1                                                | REGS |      
        elsif (std_match(addr, WB_ADDR_T1   & "000000000000000000000000----")) then sel := WB_SLV_T1;
        
        --
        else sel := 99;
        end if;
        return sel;
    end wb_addr_sel;
 
end wb_pkg;
