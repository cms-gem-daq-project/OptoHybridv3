----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:20:43 08/11/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_splitter - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Splits a Wishbone request in individual signal busses
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
use ieee.math_real.all;

library work;
use work.types_pkg.all;

entity wb_splitter is
generic(
    -- Number of output busses
    SIZE        : integer := 8
);
port(
    -- Wishbone reference clock
    wb_clk_i    : in std_logic;
    -- System reset
    reset_i     : in std_logic;
    -- Wishbone request
    wb_req_i    : in wb_req_t;
    -- Wishbone response
    wb_res_o    : out wb_res_t;
    -- Request strobes
    stb_o       : out std_logic_vector((SIZE - 1) downto 0);
    -- Request write enables
    we_o        : out std_logic;
    -- Request address
    addr_o      : out std_logic_vector(31 downto 0);
    -- Request write data
    data_o      : out std_logic_vector(31 downto 0);
    -- Response acknowledges
    ack_i       : in std_logic_vector((SIZE - 1) downto 0);
    -- Reponse errors
    err_i       : in std_logic_vector((SIZE - 1) downto 0);
    -- Response read data
    data_i      : in std32_array_t((SIZE - 1) downto 0)
);
end wb_splitter;

architecture Behavioral of wb_splitter is

    -- Number of bits to use in the address field in order to cover the size of the bus
    constant NBITS  : integer := integer(ceil(log2(real(SIZE))));
    
begin

    process(wb_clk_i)
        -- Selected data bus
        variable sel_bus    : integer range 0 to (SIZE - 1);
    begin
        if (rising_edge(wb_clk_i)) then
            -- Reset & default values of the signals
            if (reset_i = '1') then
                wb_res_o <= (ack    => '0',
                             stat   => "00",
                             data   => (others => '0'));
                stb_o <= (others => '0');
                we_o <= '0';
                addr_o <= (others => '0');
                data_o <= (others => '0');
                sel_bus := 0;
            else
                -- Handle an input strobe 
                if (wb_req_i.stb = '1') then
                    -- Convert the address to a bus select
                    sel_bus := to_integer(unsigned(wb_req_i.addr((NBITS - 1) downto 0)));
                    -- Forward the data on the bus
                    stb_o(sel_bus) <= '1';
                    we_o <= wb_req_i.we;
                    addr_o <= wb_req_i.addr;
                    data_o <= wb_req_i.data;
                -- or reset the strobes
                else
                    stb_o <= (others => '0');
                end if;
                -- Receive the acknowledgement of the previously selected bus
                if (ack_i(sel_bus) = '1') then
                    -- Forward the data to the master
                    wb_res_o <= (ack    => '1',
                                 stat   => "00",
                                 data   => data_i(sel_bus));
                -- Receive an error of the previously selected bus
                elsif (err_i(sel_bus) = '1') then
                    -- Forward the error to the master
                    wb_res_o <= (ack    => '1',
                                 stat   => "11",
                                 data   => (others => '0'));
                -- or reset the acknowledgment
                else
                    wb_res_o.ack <= '0';
                end if;
            end if;
        end if;
    end process;

end Behavioral;