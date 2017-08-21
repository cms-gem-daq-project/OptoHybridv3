library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is

    --== Wishbone options ==--

    constant WB_TIMEOUT         : integer := 200_000;

    constant WB_REQ_BITS        : integer := 49;

    --== Wishbone errors ==--

    constant WB_NO_ERR          : std_logic_vector(3 downto 0) := x"0";

    constant WB_ERR_BUS         : std_logic_vector(3 downto 0) := x"D";
    constant WB_ERR_SLAVE       : std_logic_vector(3 downto 0) := x"E";
    constant WB_ERR_TIMEOUT     : std_logic_vector(3 downto 0) := x"F";

    constant WB_ERR_I2C_CHIPID  : std_logic_vector(3 downto 0) := x"1";
    constant WB_ERR_I2C_REG     : std_logic_vector(3 downto 0) := x"2";
    constant WB_ERR_I2C_ACK     : std_logic_vector(3 downto 0) := x"3";

    --== Wishbone masters ==--

    constant WB_ADDR_SIZE       : integer  := 16;

	constant WB_MASTERS         : positive := 1;
    constant WB_MST_GBT         : integer  := 0;

    --== Wishbone slaves ==--

	constant WB_SLAVES          : positive := 5;

    constant WB_SLV_LOOP        : integer := 0;

    constant WB_SLV_CNT         : integer := 1;

    constant WB_SLV_SYS         : integer := 2;

    constant WB_SLV_STAT        : integer := 3;

    constant WB_SLV_ADC         : integer := 4;

    --== Wishbone addresses ==--

    constant WB_ADDR_LOOP       : std_logic_vector(4 downto 0) := x"0" & '0' ;
    constant WB_ADDR_CNT        : std_logic_vector(4 downto 0) := x"1" & '0' ;
    constant WB_ADDR_SYS        : std_logic_vector(4 downto 0) := x"2" & '0' ;
    constant WB_ADDR_STAT       : std_logic_vector(4 downto 0) := x"3" & '0' ;
    constant WB_ADDR_ADC        : std_logic_vector(4 downto 0) := x"4" & '0' ;

    --== Wishbone address selection & generation ==--

    function wb_addr_sel(signal addr : in std_logic_vector(WB_ADDR_SIZE-1 downto 0)) return integer;

end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--

    function wb_addr_sel(signal addr : in std_logic_vector(WB_ADDR_SIZE-1 downto 0)) return integer is
        variable sel : integer;
    begin

        -- lowest 8 bits are used by the wishbone splitters as individual register addresses

        -- Loopback
        if    (std_match(addr, WB_ADDR_LOOP  & "00000000000")) then sel := WB_SLV_LOOP;
        -- Counters
        elsif (std_match(addr, WB_ADDR_CNT   & "000--------")) then sel := WB_SLV_CNT;
        -- System
        elsif (std_match(addr, WB_ADDR_SYS   & "000--------")) then sel := WB_SLV_SYS;
        -- Status
        elsif (std_match(addr, WB_ADDR_STAT  & "000--------")) then sel := WB_SLV_STAT;
        -- ADC
        elsif (std_match(addr, WB_ADDR_ADC   & "000--------")) then sel := WB_SLV_ADC;
        --
        else sel := 99;
        end if;
        return sel;
    end wb_addr_sel;

end wb_pkg;
