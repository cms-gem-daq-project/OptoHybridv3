----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_data_decoder_test - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:    
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
 
entity vfat2_data_decoder_test is
end vfat2_data_decoder_test;
 
ARCHITECTURE behavior OF vfat2_data_decoder_test IS     

    --Inputs
    signal vfat2_mclk_i         : std_logic;
    signal reset_i              : std_logic;
    signal data_i               : std_logic;

    --Outputs
    signal valid_o              : std_logic;
    signal bc_o                 : std_logic_vector(11 downto 0);
    signal ec_o                 : std_logic_vector(7 downto 0);
    signal flags_o              : std_logic_vector(3 downto 0);
    signal chip_id_o            : std_logic_vector(11 downto 0);
    signal strips_o             : std_logic_vector(127 downto 0);
    signal crc_o                : std_logic_vector(15 downto 0);
    
    -- Testing
    signal vfat2_event_0        : std_logic_vector(195 downto 0) := "0000101010001011100011000001011000001110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000011101101111111";
    signal vfat2_event_1        : std_logic_vector(195 downto 0) := "0000101001001011001111000001010100001110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000110101000100011";
    signal vfat2_event_2        : std_logic_vector(195 downto 0) := "0000101011110000001011000001000000001110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000111011111001";
    signal vfat2_event_3        : std_logic_vector(195 downto 0) := "0000101010010111100011000000100100001110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001000110010011011";
    signal vfat2_event_4        : std_logic_vector(195 downto 0) := "0000101011011111010111000000010000001110111010010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001011101100";

    constant vfat2_mclk_period  : time := 25 ns;
 
begin
 
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.vfat2_data_decoder 
    port map(
        vfat2_mclk_i    => vfat2_mclk_i,
        reset_i         => reset_i,
        data_i          => data_i,
        valid_o         => valid_o,
        bc_o            => bc_o,
        ec_o            => ec_o,
        flags_o         => flags_o,
        chip_id_o       => chip_id_o,
        strips_o        => strips_o,
        crc_o           => crc_o
    );

    -- Clock process definitions
    vfat2_clk_process : process
    begin
        vfat2_mclk_i <= '1';
        wait for vfat2_mclk_period / 2;
        vfat2_mclk_i <= '0';
        wait for vfat2_mclk_period / 2;
    end process;
    
    -- Reset process
    reset_proc : process
    begin		
        reset_i <= '1';
        wait for 100 ns;
        reset_i <= '0';
        wait;
    wait;
    end process;
    
    -- Data process
    data_proc : process
    begin
        -- Event 0
        for I in 195 downto 0 loop
            data_i <= vfat2_event_0(I);
            wait for vfat2_mclk_period;
        end loop;
        -- Event 1
        for I in 195 downto 0 loop
            data_i <= vfat2_event_1(I);
            wait for vfat2_mclk_period;
        end loop;
        -- Event 2
        for I in 195 downto 0 loop
            data_i <= vfat2_event_2(I);
            wait for vfat2_mclk_period;
        end loop;
        -- Event 3
        for I in 195 downto 0 loop
            data_i <= vfat2_event_3(I);
            wait for vfat2_mclk_period;
        end loop;
        -- Event 4
        for I in 195 downto 0 loop
            data_i <= vfat2_event_4(I);
            wait for vfat2_mclk_period;
        end loop;
    end process;

end;
