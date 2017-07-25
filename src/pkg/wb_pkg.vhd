library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package wb_pkg is

    --== Wishbone options ==--

    constant WB_TIMEOUT         : integer := 200_000;

    --== Wishbone errors ==--

    constant WB_NO_ERR          : std_logic_vector(3 downto 0) := x"0";

    constant WB_ERR_BUS         : std_logic_vector(3 downto 0) := x"D";
    constant WB_ERR_SLAVE       : std_logic_vector(3 downto 0) := x"E";
    constant WB_ERR_TIMEOUT     : std_logic_vector(3 downto 0) := x"F";

    constant WB_ERR_I2C_CHIPID  : std_logic_vector(3 downto 0) := x"1";
    constant WB_ERR_I2C_REG     : std_logic_vector(3 downto 0) := x"2";
    constant WB_ERR_I2C_ACK     : std_logic_vector(3 downto 0) := x"3";

    --== Wishbone masters ==--

	constant WB_MASTERS         : positive := 1;
    constant WB_MST_GBT         : integer  := 0;

    --== Wishbone slaves ==--

	constant WB_SLAVES          : positive := 3;

    constant WB_SLV_CNT         : integer := 0;

    constant WB_SLV_SYS         : integer := 1;

    constant WB_SLV_STAT        : integer := 2;

    --== Wishbone addresses ==--

    constant WB_ADDR_CNT        : std_logic_vector(7 downto 0) := x"40";
    constant WB_ADDR_SYS        : std_logic_vector(7 downto 0) := x"41";
    constant WB_ADDR_STAT       : std_logic_vector(7 downto 0) := x"42";

    --== Wishbone address selection & generation ==--

	function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer;

end wb_pkg;

package body wb_pkg is

    --== Address decoder ==--

    function wb_addr_sel(signal addr : in std_logic_vector(31 downto 0)) return integer is
        variable sel : integer;
    begin

        -- lowest 8 bits are used by the wishbone splitters as individual register addresses

        -- Counters
        if    (std_match(addr, WB_ADDR_CNT   & "0000000000000000--------")) then sel := WB_SLV_CNT;
        -- System
        elsif (std_match(addr, WB_ADDR_SYS   & "0000000000000000--------")) then sel := WB_SLV_SYS;
        -- Status
        elsif (std_match(addr, WB_ADDR_STAT  & "0000000000000000--------")) then sel := WB_SLV_STAT;
        --
        else sel := 99;
        end if;
        return sel;
    end wb_addr_sel;

end wb_pkg;
