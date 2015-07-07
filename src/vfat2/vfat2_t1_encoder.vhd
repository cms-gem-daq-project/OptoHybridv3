----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_encoder - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Encodes the T1 commands for the VFAT2s
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

entity vfat2_t1_encoder is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    t1_i        : in t1_t;
    
    t1_o        : out std_logic
    
);
end vfat2_t1_encoder;

architecture Behavioral of vfat2_t1_encoder is
   
    type states is (IDLE, LV1A_0, LV1A_1, CALPULSE_0, CALPULSE_1, RESYNC_0, RESYNC_1, BC0_0, BC0_1);
    
    signal state : states;

begin

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                state <= IDLE;
                t1_o <= '0';
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        if (t1_i.lv1a = '1') then
                            state <= LV1A_0;
                            t1_o <= '1';
                        elsif (t1_i.calpulse = '1') then 
                            state <= CALPULSE_0;
                            t1_o <= '1';
                        elsif (t1_i.resync = '1') then  
                            state <= RESYNC_0;
                            t1_o <= '1';
                        elsif (t1_i.bc0 = '1') then 
                            state <= BC0_0;
                            t1_o <= '1';
                        else
                            state <= IDLE;
                            t1_o <= '0';
                        end if;  
                    -- LV1A
                    when LV1A_0 =>
                        state <= LV1A_1;
                        t1_o <= '0';
                    when LV1A_1 =>
                        state <= IDLE;
                        t1_o <= '0';
                    -- CALPULSE
                    when CALPULSE_0 =>
                        state <= CALPULSE_1;
                        t1_o <= '1';
                    when CALPULSE_1 =>
                        state <= IDLE;
                        t1_o <= '1';
                    -- RESYNC
                    when RESYNC_0 =>
                        state <= RESYNC_1;
                        t1_o <= '1';
                    when RESYNC_1 =>
                        state <= IDLE;
                        t1_o <= '0';
                    -- BC0
                    when BC0_0 =>
                        state <= BC0_1;
                        t1_o <= '0';
                    when BC0_1 =>
                        state <= IDLE;
                        t1_o <= '1';
                    --
                    when others => 
                        state <= IDLE;
                        t1_o <= '0';
                end case;  
            end if;
        end if;
    end process;
    
end Behavioral;