----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_data_decoder - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- This module deserializes the tracking data coming from a single VFAT2 and checks the CRC.
-- Data is constantly checked in order to make abstraction of the data_valid line. 
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

entity vfat2_data_decoder is
port(
    -- VFAT2 reference clock
    vfat2_mclk_i        : in std_logic;
    -- System reset
    reset_i             : in std_logic;
    -- VFAT2 data out
    vfat2_data_out_i    : in std_logic;
    -- Output packet
    tk_data_o           : out tk_data_t
);
end vfat2_data_decoder;

architecture Behavioral of vfat2_data_decoder is

    -- The data packet is 192 bits wide but we include the two IDLE bits in front of each packet 
    -- and the computation time for the algorithm (the data will be shifted while computing)
    signal data : std_logic_vector(194 downto 0); 
    
begin

    --=======================--
    --== Data deserializer ==--
    --=======================--

    process(vfat2_mclk_i)    
    begin
        if (rising_edge(vfat2_mclk_i)) then
            -- Reset & default value
            if (reset_i = '1') then
                data <= (others => '0');
            else
                -- Shift the data in the register
                data(194 downto 1) <= data(193 downto 0);
                data(0) <= vfat2_data_out_i;
            end if;
        end if;
    end process;
    
    --================--
    --== Validation ==--
    --================--
    
    process(vfat2_mclk_i)
        -- Holds the results of the tests
        variable tests  : std_logic_vector(2 downto 0);
    begin
        if (rising_edge(vfat2_mclk_i)) then
            -- Reset & default value 
            if (reset_i = '1') then
                tk_data_o <= (valid     => '0',
                              bc        => (others => '0'),
                              ec        => (others => '0'),
                              flags     => (others => '0'),
                              chip_id   => (others => '0'),
                              strips    => (others => '0'),
                              crc       => (others => '0'));
                tests := (others => '0');
            else
                -- Check the 6 fixed bits 
                case data(193 downto 188) is
                    when "001010" => tests(0) := '1';
                    when others => tests(0) := '0';
                end case;
                -- Check the 4 next fixed bits
                case data(175 downto 172) is
                    when "1100" => tests(1) := '1';
                    when others => tests(1) := '0';
                end case;
                -- Check the 4 next fixed bits
                case data(159 downto 156) is
                    when "1110" => tests(2) := '1';
                    when others => tests(2) := '0';
                end case;
                -- Combine the tests and assert the packet if it is valid
                case tests is
                    when "111" =>      
                        tk_data_o <= (valid     => '1',
                                      bc        => data(187 downto 176),
                                      ec        => data(171 downto 164),
                                      flags     => data(163 downto 160), 
                                      chip_id   => data(155 downto 144),
                                      strips    => data(143 downto 16),
                                      crc       => data(15 downto 0));
                    when others => 
                        tk_data_o.valid <= '0';
                end case;                
            end if;
        end if;
    end process;
   
end Behavioral;