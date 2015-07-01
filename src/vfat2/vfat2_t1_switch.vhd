----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Selects the source of the T1 signals
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_t1_switch is
generic(
    ASYNC           : boolean := false
);
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    t1_0_i          : in t1_t;
    t1_1_i          : in t1_t;
    t1_2_i          : in t1_t;
    t1_3_i          : in t1_t;
    
    src_select_i    : in std_logic_vector(1 downto 0);
    
    t1_o            : out t1_t
    
);
end vfat2_t1_switch;

architecture Behavioral of vfat2_t1_switch is
begin

    --== Asynchronous switch ==--
    
    async_gen : if ASYNC = true generate
    begin
        with src_select_i select t1_o <= 
            t1_0_i when "00",
            t1_1_i when "01",
            t1_2_i when "10",
            t1_3_i when "11",
            (others => '0') when others;
    end generate;
    
    --== Synchronous switch ==--
    
    sync_gen : if ASYNC = false generate
    begin
        process(ref_clk_i)
        begin
            if (rising_edge(ref_clk_i)) then
                if (reset_i = '1') then
                    t1_o <= (others => '0');
                else
                    case src_select_i is
                        when "00" => t1_o <= t1_0_i;
                        when "01" => t1_o <= t1_1_i;
                        when "10" => t1_o <= t1_2_i;
                        when "11" => t1_o <= t1_3_i;
                        when others => t1_o <= (others => '0');
                    end case;            
                end if;
            end if;
        end process;
    end generate;
    
end Behavioral;