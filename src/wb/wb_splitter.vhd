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
-- Splits a Wishbone request in individual signal busses or forwards the request
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity wb_splitter is
generic(
    
    -- Parameters of the split
    SIZE        : integer := 8;    
    OFFSET      : integer := 0
    
);
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    -- Wishbone slave
    wb_req_i    : in wb_req_t;
    wb_res_o    : out wb_res_t;
    
    -- Request
    stb_o       : out std_logic_vector((SIZE - 1) downto 0);
    we_o        : out std_logic;
    addr_o      : out std_logic_vector(31 downto 0);
    data_o      : out std_logic_vector(31 downto 0);
    
    -- Response 
    ack_i       : in std_logic_vector((SIZE - 1) downto 0);
    err_i       : in std_logic_vector((SIZE - 1) downto 0);
    data_i      : in std32_array_t((SIZE - 1) downto 0)
    
);
end wb_splitter;

architecture Behavioral of wb_splitter is

    -- Number of bits to use in the address field in order to cover the size of the bus
    constant NBITS  : integer := integer(ceil(log2(real(SIZE))));

    type state_t is (IDLE, ACK);
    
    signal state    : state_t;
    
    signal timeout  : unsigned(31 downto 0);
    
begin

    process(ref_clk_i)    
        -- Selected data bus
        variable sel_bus    : integer range 0 to (SIZE - 1);        
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                wb_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                stb_o <= (others => '0');
                we_o <= '0';
                addr_o <= (others => '0');
                data_o <= (others => '0');
                sel_bus := 0;
                state <= IDLE;
                timeout <= (others => '0');
            else
                case state is
                    -- Wait for a strobe
                    when IDLE =>
                        -- Reset the acknowledgment
                        wb_res_o.ack <= '0';
                        -- Handle an input strobe 
                        if (wb_req_i.stb = '1') then
                            -- Set timeout
                            timeout <= to_unsigned(WB_TIMEOUT - 4, 32);
                            -- Convert the address to a bus select
                            sel_bus := to_integer(unsigned(wb_req_i.addr((NBITS - 1 + OFFSET) downto OFFSET)));
                            -- Forward the data on the bus
                            stb_o(sel_bus) <= '1';
                            we_o <= wb_req_i.we;
                            addr_o <= wb_req_i.addr;
                            data_o <= wb_req_i.data;
                            -- Acknowledgment 
                            state <= ACK;
                        end if;
                    -- wait for the acknowledgment
                    when ACK =>
                        -- Reset the strobes
                        stb_o <= (others => '0');
                        -- Check the timeout
                        if (timeout = 0) then
                            -- Send an error
                            wb_res_o <= (ack => '1', stat => WB_ERR_TIMEOUT, data => (others => '0'));
                            state <= IDLE;
                        else
                            -- Decrement timeout
                            timeout <= timeout - 1;
                            -- Receive the acknowledgement of the previously selected bus
                            if (ack_i(sel_bus) = '1') then
                                wb_res_o <= (ack => '1', stat => WB_NO_ERR, data => data_i(sel_bus));
                                state <= IDLE;
                            -- Receive an error of the previously selected bus
                            elsif (err_i(sel_bus) = '1') then
                                wb_res_o <= (ack => '1', stat => WB_ERR_BUS, data => (others => '0'));
                                state <= IDLE;
                            end if;
                        end if;
                    --
                    when others =>
                        wb_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                        stb_o <= (others => '0');
                        we_o <= '0';
                        addr_o <= (others => '0');
                        data_o <= (others => '0');
                        sel_bus := 0;
                        state <= IDLE;
                        timeout <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;