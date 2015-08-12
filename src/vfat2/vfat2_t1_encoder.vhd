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
    -- VFAT2 reference clock
    vfat2_mclk_i    : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Input T1 commands
    vfat2_t1_i      : in t1_t;
    -- VFAT2 T1 line
    vfat2_t1_o      : out std_logic
);
end vfat2_t1_encoder;

architecture Behavioral of vfat2_t1_encoder is
   
    type state_t is (IDLE, BIT_2, BIT_1, BIT_0);
    
    signal state    : state_t;
    
    -- Data to send
    signal t1_data  : std_logic_vector(2 downto 0);

begin

    process(vfat2_mclk_i)
    begin    
        if (rising_edge(vfat2_mclk_i)) then
            -- Reset & default signals
            if (reset_i = '1') then
                vfat2_t1_o <= '0';
                state <= IDLE;
                t1_data <= (others => '0');
            else
                case state is
                    -- IDLE wait for strobe
                    when IDLE =>
                        -- Set the line to 0
                        vfat2_t1_o <= '0';
                        -- LV1A
                        if (vfat2_t1_i.lv1a = '1') then
                            state <= BIT_2;
                            t1_data <= "100";
                        -- Calibration pulse
                        elsif (vfat2_t1_i.calpulse = '1') then 
                            state <= BIT_2;
                            t1_data <= "111";
                        -- Resync signal
                        elsif (vfat2_t1_i.resync = '1') then  
                            state <= BIT_2;
                            t1_data <= "110";
                        -- BC0 reset
                        elsif (vfat2_t1_i.bc0 = '1') then 
                            state <= BIT_2;
                            t1_data <= "101";
                        end if;  
                    -- BIT_2 send bit 2
                    when BIT_2 =>
                        vfat2_t1_o <= t1_data(2);
                        state <= BIT_1;
                    -- BIT_1 send bit 1
                    when BIT_1 =>
                        vfat2_t1_o <= t1_data(1);
                        state <= BIT_0;
                    -- BIT_0 send bit 0
                    -- BIT_0 send bit 0
                    when BIT_0 =>
                        vfat2_t1_o <= t1_data(0);
                        state <= IDLE;
                    --
                    when others => 
                        vfat2_t1_o <= '0';
                        state <= IDLE;
                        t1_data <= (others => '0');
                end case;  
            end if;
        end if;
    end process;
    
end Behavioral;