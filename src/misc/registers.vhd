----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    15:17:59 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    registers - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Generates N read/write registers
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
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity registers is
generic(

    -- Number of registers
    SIZE        : integer := 4
    
);
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    -- Request 
    stb_i       : in std_logic_vector((SIZE - 1) downto 0);
    we_i        : in std_logic;
    data_i      : in std_logic_vector(31 downto 0);
    
    -- Response
    ack_o       : out std_logic_vector((SIZE - 1) downto 0);
    err_o       : out std_logic_vector((SIZE - 1) downto 0);
    data_o      : out std32_array_t((SIZE - 1) downto 0)
    
);
end registers;

architecture Behavioral of registers is

    -- Hold the value of the registers in memory
    signal registers    : std32_array_t((SIZE - 1) downto 0);

begin

    -- Each register in independant, so we can generate a loop
    registers_gen : for I in 0 to (SIZE - 1) generate
    begin
    
        process(ref_clk_i)
        begin
            if (rising_edge(ref_clk_i)) then
                -- Reset the signals to their defautl value
                if (reset_i = '1') then
                    ack_o(I) <= '0';
                    err_o(I) <= '0';
                    data_o(I) <= (others => '0');
                    registers(I) <= (others => '0');
                else
                    -- When receiving an request strobe
                    if (stb_i(I) = '1') then
                        -- Register the value if it is a write request
                        if (we_i = '1') then
                            registers(I) <= data_i;
                        end if;
                        -- Acknowledge the transaction
                        ack_o(I) <= '1';
                    -- or reset the acknowledgment
                    else
                        ack_o(I) <= '0';
                    end if;
                    -- The read data is always the current data in memory
                    data_o(I) <= registers(I);
                end if;
            end if;
        end process;
    
    end generate;

end Behavioral;