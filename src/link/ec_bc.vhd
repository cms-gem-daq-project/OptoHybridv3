----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    15:17:59 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    ec_bc - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity ec_bc is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    vfat2_t1_i  : in t1_t;
    
    rd_i        : in std_logic;
    valid_o     : out std_logic;
    error_o     : out std_logic;
    data_o      : out std_logic_vector(31 downto 0)
    
);
end ec_bc;

architecture Behavioral of ec_bc is

    signal bc : unsigned(11 downto 0);
    signal ec : unsigned(19 downto 0);
    
    signal wr : std_logic;

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                bc <= (others => '0');
                ec <= (others => '0');
                wr <= '0';
            elsif (vfat2_t1_i.resync = '1' or vfat2_t1_i.bc0 = '1') then
                bc <= (others => '0');
                ec <= (others => '0');
                wr <= '0';
            else
                bc <= bc + 1;
                if (vfat2_t1_i.lv1a = '1') then
                    ec <= ec + 1;
                    wr <= '1';
                else 
                    wr <= '0';
                end if;
            end if;
        end if;
    end process;
    
    fifo_inst : entity work.fifo_bx
    port map(
        clk         => ref_clk_i,
        rst         => reset_i,
        wr_en       => wr,
        din         => std_logic_vector(bc) & std_logic_vector(ec),
        rd_en       => rd_i,
        valid       => valid_o,
        dout        => data_o,
        underflow   => error_o,
        full        => open,
        empty       => open
    );    

end Behavioral;