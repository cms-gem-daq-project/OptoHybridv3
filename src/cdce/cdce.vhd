----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    cdce - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity cdce is
port(

    ref_clk_i               : in std_logic;
     
    cdce_clk_i              : in std_logic;
    
    cdce_clk_pri_o          : out std_logic;

    cdce_aux_out_o          : out std_logic;
    cdce_aux_in_i           : in std_logic;
    cdce_ref_o              : out std_logic;
    cdce_pwrdown_o          : out std_logic;
    cdce_sync_o             : out std_logic;
    cdce_locked_i           : in std_logic;
    
    cdce_sck_o              : out std_logic;
    cdce_mosi_o             : out std_logic;
    cdce_le_o               : out std_logic;
    cdce_miso_i             : in std_logic
    
);
end cdce;

architecture Behavioral of cdce is
begin 
   
    cdce_clk_pri_o <= ref_clk_i;

    cdce_ref_o <= '1';
    cdce_sync_o <= '1';
    cdce_le_o <= '1';   
    
    --== Control PowerDown signal ==--

    process(ref_clk_i)
        variable delay  : integer range 0 to 31 := 0;
    begin
        if (rising_edge(ref_clk_i)) then
            if (delay < 20) then
                cdce_pwrdown_o <= '0';
                delay := delay + 1;
            else
                cdce_pwrdown_o <= '1';
                delay := 20;
            end if;
        end if;
    end process;    

end Behavioral;