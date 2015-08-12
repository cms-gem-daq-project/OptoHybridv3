----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:46:42 08/05/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_latency_scan_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the Latency Scan
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

entity vfat2_latency_scan_req is
port(
    -- System reference clock
    ref_clk_i       : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Request a latency scan
    req_stb_i        : in std_logic;
    -- of a given VFAT2
    req_vfat2_i     : in std_logic_vector(4 downto 0);
    -- starting a this latency
    req_min_lat_i   : in std_logic_vector(7 downto 0);
    -- until this latency
    req_max_lat_i   : in std_logic_vector(7 downto 0);
    -- by steps of
    req_lat_step_i  : in std_logic_vector(7 downto 0);
    -- with N events per latency
    req_events_i    : in std_logic_vector(23 downto 0);
    -- Request to the I2C slave to change the latency
    wb_mst_req_o    : out wb_req_t;
    -- Response from the I2C slave
    wb_mst_res_i    : in wb_res_t;
    -- Tracking data of the VFAT2s in the sector
    vfat2_tk_data_i : in tk_data_array_t(3 downto 0);
    -- FIFO reset
    fifo_rst_o      : out std_logic;
    -- FIFO write enable to store the data
    fifo_we_o       : out std_logic;
    -- FIFO write data
    fifo_din_o      : out std_logic_vector(31 downto 0);
    -- Is the scan running 
    scan_running_o  : out std_logic
);
end vfat2_latency_scan_req;

architecture Behavioral of vfat2_latency_scan_req is

    type state_t is (IDLE, REQ_RUNNING, ACK_RUNNING, REQ_CURRENT_LATENCY, ACK_CURRENT_LATENCY, ERR_CURRENT_LATENCY, REQ_I2C, ACK_I2C, COUNT, STORE_RESULT, REQ_RESTORE_LATENCY, ACK_RESTORE_LATENCY);
    
    signal state            : state_t;
    
    -- Selected VFAT2
    signal sel_vfat2        : std_logic_vector(4 downto 0);
    signal sel_tkdata       : integer range 0 to 3;
    -- Saved values of the entries to ensure stability
    signal latency_limit    : std_logic_vector(7 downto 0);
    signal latency_step     : std_logic_vector(7 downto 0);
    signal events_limit     : std_logic_vector(23 downto 0);
    -- Value of the latency before the scan
    signal saved_latency    : std_logic_vector(7 downto 0);
    -- Counter for the scan
    signal latency          : unsigned(7 downto 0);
    signal event_counter    : unsigned(23 downto 0);
    signal hit_counter      : unsigned(23 downto 0);
    -- Utility
    signal empty_128bits    : std_logic_vector(127 downto 0);

begin

    -- All 0 to compare to empty tracking data
    empty_128bits <= (others => '0');

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
                scan_running_o <= '0';
                state <= IDLE;
                sel_vfat2 <= (others => '0');
                sel_tkdata <= 0;
                latency_limit <= (others => '0');
                latency_step <= (others => '0');
                events_limit <= (others => '0');
                saved_latency <= (others => '0');
                latency <= (others => '0');
                event_counter <= (others => '0');
                hit_counter <= (others => '0');
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        -- Unset the write enable signal
                        fifo_we_o <= '0';
                        -- Scan is not running
                        scan_running_o <= '0';
                        -- On a request strobe
                        if (req_stb_i = '1') then
                            -- Select the VFAT2
                            sel_vfat2 <= req_vfat2_i(4 downto 0);
                            sel_tkdata <= to_integer(unsigned(req_vfat2_i(1 downto 0)));
                            -- Store the limits and the stepping
                            latency_limit <= req_max_lat_i;
                            latency_step <= req_lat_step_i;
                            events_limit <= req_events_i;
                            -- Set the current latency to the minimum
                            latency <= unsigned(req_min_lat_i);
                            -- Reset the FIFO
                            fifo_rst_o <= '1';
                            -- Change state
                            state <= REQ_RUNNING;
                        else
                            fifo_rst_o <= '0';
                        end if;
                    -- REQ_RUNNING check if the VFAT2 is running
                    when REQ_RUNNING => 
                        -- Reactivate the FIFO
                        fifo_rst_o <= '0';
                        -- Scan is running
                        scan_running_o <= '1';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '0',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"00",
                                         data   => (others => '0'));
                        state <= ACK_RUNNING;
                    -- ACK_RUNNING wait for the response
                    when ACK_RUNNING => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid
                            if (wb_mst_res_i.stat = "00" and wb_mst_res_i.data(0) = '1') then
                                -- change state
                                state <= REQ_CURRENT_LATENCY;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- and go back to the IDLE state
                                state <= IDLE;
                            end if;
                        end if;
                    -- REQ_CURRENT_LATENCY read the current value of the latency
                    when REQ_CURRENT_LATENCY => 
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '0',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"10",
                                         data   => (others => '0'));
                        state <= ACK_CURRENT_LATENCY;
                    -- ACK_CURRENT_LATENCY wait for the response
                    when ACK_CURRENT_LATENCY => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid
                            if (wb_mst_res_i.stat = "00") then
                                -- Store it in memory
                                saved_latency <= wb_mst_res_i.data(7 downto 0);
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
                    -- REQ_I2C send an I2C request to change the latency
                    when REQ_I2C =>
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '1',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"10",
                                         data   => x"000000" & std_logic_vector(latency));
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
                            -- Wait for tracking data
                            if (vfat2_tk_data_i(sel_tkdata).valid = '1') then
                                -- Increment the event counter
                                event_counter <= event_counter + 1;
                                -- Increment the hit counter
                                if (vfat2_tk_data_i(sel_tkdata).strips /= empty_128bits) then
                                    hit_counter <= hit_counter + 1;
                                end if;
                            end if;
                        end if;
                    -- STORE_RESULT store the results in the FIFO
                    when STORE_RESULT =>
                        -- Write in the FIFO
                        fifo_we_o <= '1';
                        fifo_din_o <= std_logic_vector(latency) & std_logic_vector(hit_counter);
                        -- Check the latency for its limit
                        if (latency + unsigned(latency_step) <= unsigned(latency_limit)) then
                            -- Increment the latency
                            if (unsigned(latency_step) = 0) then
                                latency <= latency + 1;
                            else
                                latency <= latency + unsigned(latency_step);
                            end if;
                            -- and repeat the procedure
                            state <= REQ_I2C;
                        -- Or restore the latency value
                        else
                            state <= REQ_RESTORE_LATENCY;
                        end if;
                    -- REQ_RESTORE_LATENCY restore the latency value
                    when REQ_RESTORE_LATENCY => 
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb    => '1',
                                         we     => '1',
                                         addr   => "0000000000000000000" & sel_vfat2 & x"10",
                                         data   => x"000000" & std_logic_vector(saved_latency));
                        state <= ACK_RESTORE_LATENCY;
                    -- ACK_RESTORE_LATENCY wait for the acknowledgment
                    when ACK_RESTORE_LATENCY => 
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
                        sel_tkdata <= 0;
                        latency_limit <= (others => '0');
                        events_limit <= (others => '0');
                        saved_latency <= (others => '0');
                        latency <= (others => '0');
                        event_counter <= (others => '0');
                        hit_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;




