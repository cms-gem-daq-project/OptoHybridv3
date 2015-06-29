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

entity vfat2_data_decoder is
port(

    vfat2_mclk_i    : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic;
    
    valid_o         : out std_logic;
    bc_o            : out std_logic_vector(11 downto 0);
    ec_o            : out std_logic_vector(7 downto 0);
    flags_o         : out std_logic_vector(3 downto 0);
    chip_id_o       : out std_logic_vector(11 downto 0);
    strips_o        : out std_logic_vector(127 downto 0);
    crc_o           : out std_logic_vector(15 downto 0)
    
);
end vfat2_data_decoder;

architecture Behavioral of vfat2_data_decoder is

    signal data     : std_logic_vector(196 downto 0); -- The data packet is 192 bits wide but we include the two IDLE bits in front of each packet 
                                                      -- and the computation time for the algorithm (the data will be shifted while computing)
                    
    alias data_0    : std_logic_vector(193 downto 0) is data(193 downto 0); -- Data in the first computation cycle  
    alias data_1    : std_logic_vector(193 downto 0) is data(194 downto 1); -- Data in the second computation cycle  
    alias data_2    : std_logic_vector(193 downto 0) is data(195 downto 2); -- Data in the third computation cycle  
    alias data_3    : std_logic_vector(193 downto 0) is data(196 downto 3); -- Data in the fourth computation cycle  

    signal tests_0  : std_logic_vector(2 downto 0);
    signal crc_0    : std_logic_vector(15 downto 0);
    signal tests_1  : std_logic_vector(2 downto 0);
    signal crc_1    : std_logic_vector(15 downto 0);
    signal tests_2  : std_logic_vector(3 downto 0);

begin

    --== Data deserializer ==--

    process(vfat2_mclk_i)    
    begin
        if (rising_edge(vfat2_mclk_i)) then
            if (reset_i = '1') then
                data <= (others => '0');
            else
                data(196 downto 1) <= data(195 downto 0);
                data(0) <= data_i;
            end if;
        end if;
    end process;
    
    --== Validation 0 : fixed bits and first CRC computation ==--
    
    process(vfat2_mclk_i)
    begin
        if (rising_edge(vfat2_mclk_i)) then
            if (reset_i = '1') then
                tests_0 <= (others => '0');
                crc_0 <= (others => '0');
            else
                -- 6 fixed bits 
                case data_0(193 downto 188) is
                    when "001010" => tests_0(0) <= '1';
                    when others => tests_0(0) <= '0';
                end case;
                -- 4 next fixed bits
                case data_0(175 downto 172) is
                    when "1100" => tests_0(1) <= '1';
                    when others => tests_0(1) <= '0';
                end case;
                -- 4 next fixed bits
                case data_0(159 downto 156) is
                    when "1110" => tests_0(2) <= '1';
                    when others => tests_0(2) <= '0';
                end case;
                -- Compute the first part of the CRC
                crc_0 <= data_0(191 downto 176) xor 
                         data_0(175 downto 160) xor 
                         data_0(159 downto 144) xor 
                         data_0(143 downto 128) xor
                         data_0(127 downto 112) xor
                         data_0(111 downto 96);
            end if;
        end if;
    end process;
    
    --== Validation 1 : second CRC computation ==--
    
    process(vfat2_mclk_i)
    begin
        if (rising_edge(vfat2_mclk_i)) then
            if (reset_i = '1') then
                tests_1 <= (others => '0');
                crc_1 <= (others => '0');
            else           
                -- Propagate test results
                tests_1 <= tests_0;
                -- Compute the next part of the CRC
                crc_1 <= crc_0 xor
                         data_1(95 downto 80) xor
                         data_1(79 downto 64) xor
                         data_1(63 downto 48) xor
                         data_1(47 downto 32) xor
                         data_1(31 downto 16);
            end if;
        end if;
    end process;    
    
    --== Validation 2 : compare the CRC ==--
    
    process(vfat2_mclk_i)
    begin
        if (rising_edge(vfat2_mclk_i)) then
            if (reset_i = '1') then
                tests_2 <= (others => '0');
            else           
                -- Propagate test results
                tests_2(2 downto 0) <= tests_1;
                -- Compute the next part of the CRC
                if (crc_1 = data_2(15 downto 0)) then
                    tests_2(3) <= '1';
                else
                    tests_2(3) <= '0';
                end if;
            end if;
        end if;
    end process;
    
    --== Validation 3 : regroup tests ==--
    
    process(vfat2_mclk_i)
    begin
        if (rising_edge(vfat2_mclk_i)) then
            if (reset_i = '1') then
                valid_o <= '0';                    
                bc_o <= (others => '0');
                ec_o <= (others => '0');
                flags_o <= (others => '0');
                chip_id_o <= (others => '0');
                strips_o <= (others => '0');
                crc_o <= (others => '0');
            else
                case tests_2(2 downto 0) is
                    when "111" => 
                        valid_o <= '1';       
                        bc_o <= data_3(187 downto 176);
                        ec_o <= data_3(171 downto 164);
                        flags_o <= data_3(163 downto 160);
                        chip_id_o <= data_3(155 downto 144);
                        strips_o <= data_3(143 downto 16);
                        crc_o <= data_3(15 downto 0);
                    when others => 
                        valid_o <= '0';          
                        bc_o <= (others => '0');
                        ec_o <= (others => '0');
                        flags_o <= (others => '0');
                        chip_id_o <= (others => '0');
                        strips_o <= (others => '0');
                        crc_o <= (others => '0');
                end case;
            end if;
        end if;        
    end process;                
    
end Behavioral;