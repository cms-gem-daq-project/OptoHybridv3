----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:46:42 08/05/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_threshold_scan - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the Threshold Scan
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
use work.wb_pkg.all;

entity vfat2_threshold_scan_req is
port(
    -- System reference clock
    ref_clk_i       : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Request a threshold scan
    req_stb_i        : in std_logic;
    -- of a given VFAT2
    req_vfat2_i     : in std_logic_vector(4 downto 0);
    -- starting a this threshold
    req_min_thr_i   : in std_logic_vector(7 downto 0);
    -- until this threshold
    req_max_thr_i   : in std_logic_vector(7 downto 0);
    -- with N events per threshold
    req_events_i    : in std_logic_vector(23 downto 0);
    -- Request to the I2C slave to change the threshold
    wb_mst_req_o    : out wb_req_t;
    -- Response from the I2C slave
    wb_mst_res_i    : in wb_res_t;
    -- SBits of the VFAT2s
    vfat2_sbits_i   : in sbits_array_t(3 downto 0);
    -- FIFO reset
    fifo_rst_o      : out std_logic;
    -- FIFO write enable to store the data
    fifo_we_o       : out std_logic;
    -- FIFO write data
    fifo_din_o      : out std_logic_vector(31 downto 0)
);
end vfat2_threshold_scan_req;

architecture Behavioral of vfat2_threshold_scan_req is

    type state_t is (IDLE, REQ_CURRENT_THRESHOLD, ACK_CURRENT_THRESHOLD, ERR_CURRENT_THRESHOLD, REQ_I2C, ACK_I2C, COUNT, STORE_RESULT, REQ_RESTORE_THRESHOLD, ACK_RESTORE_THRESHOLD);
    
    signal state            : state_t;
    
    -- Selected VFAT2
    signal sel_vfat2        : std_logic_vector(4 downto 0);
    signal sel_sbits        : integer range 0 to 3;
    -- Saved values of the entries to ensure stability
    signal threshold_limit  : std_logic_vector(7 downto 0);
    signal events_limit     : std_logic_vector(23 downto 0);
    -- Value of the threshold before the scan
    signal saved_threshold  : std_logic_vector(7 downto 0);
    -- Counter for the scan
    signal threshold        : unsigned(7 downto 0);
    signal event_counter    : unsigned(23 downto 0);
    signal hit_counter      : unsigned(23 downto 0);

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset and default values
            if (reset_i = '1') then
                wb_mst_req_o <= (stb    => '0',
                                 we     => '0',
                                 addr   => (others => '0'),
                                 data   => (others => '0'));
                fifo_rst_o <= '0';
                fifo_we_o <= '0';
                fifo_din_o <= (others => '0');
                state <= IDLE;
                sel_vfat2 <= (others => '0');
                sel_sbits <= 0;
                threshold_limit <= (others => '0');
                events_limit <= (others => '0');
                saved_threshold <= (others => '0');
                threshold <= (others => '0');
                event_counter <= (others => '0');
                hit_counter <= (others => '0');
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        -- Unset the write enable signal
                        fifo_we_o <= '0';
                        -- On a request strobe
                        if (req_stb_i = '1') then
                            -- Select the VFAT2
                            sel_vfat2 <= req_vfat2_i(4 downto 0);
                            sel_sbits <= to_integer(unsigned(req_vfat2_i(1 downto 0)));
                            -- Store the limits
                            threshold_limit <= req_max_thr_i;
                            events_limit <= req_events_i;
                            -- Set the current threshold to the minimum
                            threshold <= unsigned(req_min_thr_i);
                            -- Reset the FIFO
                            fifo_rst_o <= '1';
                            -- Change state
                            state <= REQ_CURRENT_THRESHOLD;
                        else
                            fifo_rst_o <= '0';
                        end if;
                    -- REQ_CURRENT_THRESHOLD read the current value of the threshold
                    when REQ_CURRENT_THRESHOLD => 
                        -- Reactivate the FIFO
                        fifo_rst_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '0',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"92",
                                         data   => (others => '0'));
                        state <= ACK_CURRENT_THRESHOLD;
                    -- ACK_CURRENT_THRESHOLD wait for the response
                    when ACK_CURRENT_THRESHOLD => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid
                            if (wb_mst_res_i.stat = "00") then
                                -- Store it in memory
                                saved_threshold <= wb_mst_res_i.data(7 downto 0);
                                -- and change state
                                state <= REQ_I2C;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- and go back to the IDLE state
                                state <= IDLE;
                            end if;
                        end if;
                    -- REQ_I2C send an I2C request to change the threshold
                    when REQ_I2C =>
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '1',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"92",
                                         data   => x"000000" & std_logic_vector(threshold));
                        state <= ACK_I2C;
                    -- ACK_I2C wait for the acknowledgment
                    when ACK_I2C => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the request was done successfully
                            if (wb_mst_res_i.stat = "00") then
                                -- Go for counting
                                event_counter <= (others => '0');
                                hit_counter <= (others => '0');
                                state <= COUNT;
                            -- or store an error
                            else
                                event_counter <= (others => '1');
                                hit_counter <= (others => '1');
                                state <= STORE_RESULT;
                            end if;
                        end if;
                    -- COUNT the hit sbits
                    when COUNT =>
                        -- Change state when the counter reached its limit
                        if (event_counter = unsigned(events_limit)) then
                            state <= STORE_RESULT;
                        else
                            -- Increment the event counter
                            event_counter <= event_counter + 1;
                            -- Increment the hit counter
                            if (vfat2_sbits_i(sel_sbits) /= "00000000") then
                                hit_counter <= hit_counter + 1;
                            end if;
                        end if;
                    -- STORE_RESULT store the results in the FIFO
                    when STORE_RESULT =>
                        -- Write in the FIFO
                        fifo_we_o <= '1';
                        fifo_din_o <= std_logic_vector(threshold) & std_logic_vector(hit_counter);
                        -- Check the threshold for its limit
                        if (threshold < unsigned(threshold_limit)) then
                            -- Increment the threshold
                            threshold <= threshold + 1;
                            -- and repeat the procedure
                            state <= REQ_I2C;
                        -- Or restore the threshold value
                        else
                            state <= REQ_RESTORE_THRESHOLD;
                        end if;
                    -- REQ_RESTORE_THRESHOLD restore the threshold value
                    when REQ_RESTORE_THRESHOLD => 
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '1',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"92",
                                         data   => x"000000" & std_logic_vector(saved_threshold));
                        state <= ACK_RESTORE_THRESHOLD;
                    -- ACK_RESTORE_THRESHOLD wait for the acknowledgment
                    when ACK_RESTORE_THRESHOLD => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            state <= IDLE;
                        end if;
                    --
                    when others =>
                        wb_mst_req_o <= (stb    => '0',
                                         we     => '0',
                                         addr   => (others => '0'),
                                         data   => (others => '0'));
                        fifo_rst_o <= '0';
                        fifo_we_o <= '0';
                        fifo_din_o <= (others => '0');
                        state <= IDLE;
                        sel_vfat2 <= (others => '0');
                        sel_sbits <= 0;
                        threshold_limit <= (others => '0');
                        events_limit <= (others => '0');
                        saved_threshold <= (others => '0');
                        threshold <= (others => '0');
                        event_counter <= (others => '0');
                        hit_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;




