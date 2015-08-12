----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_controller_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the T1 commands
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

entity vfat2_t1_controller_req is
port(
    -- System reference clock
    ref_clk_i       : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Enable signal
    req_en_i        : in std_logic;
    -- Operation mode
    req_op_mode_i   : in std_logic_vector(1 downto 0);
    -- Command type
    req_type_i      : in std_logic_vector(1 downto 0);
    -- Number of events
    req_events_i    : in std_logic_vector(31 downto 0);
    -- Interval
    req_interval_i  : in std_logic_vector(31 downto 0);
    -- Delay
    req_delay_i     : in std_logic_vector(31 downto 0);
    -- Sequences
    req_lv1a_seq_i  : in std_logic_vector(63 downto 0);
    req_cal_seq_i   : in std_logic_vector(63 downto 0);
    req_sync_seq_i  : in std_logic_vector(63 downto 0);
    req_bc0_seq_i   : in std_logic_vector(63 downto 0);
    -- Output T1 commands
    vfat2_t1_0      : out t1_t
);
end vfat2_t1_controller_req;

architecture Behavioral of vfat2_t1_controller_req is
 
    type state_t is (IDLE, MODE_0, END_0, MODE_1, MODE_2);
    
    signal state            : state_t;
      
    -- Saved values of the entries to ensure stability
    signal t1_type          : std_logic_vector(1 downto 0);
    signal events_limit     : std_logic_vector(31 downto 0);
    signal interval         : std_logic_vector(31 downto 0);
    signal delay            : std_logic_vector(31 downto 0);
    signal lv1a_sequence    : std_logic_vector(63 downto 0);
    signal cal_sequence     : std_logic_vector(63 downto 0);
    signal sync_sequence    : std_logic_vector(63 downto 0);
    signal bc0_sequence     : std_logic_vector(63 downto 0);
    
    -- Counter
    signal event_counter    : unsigned(31 downto 0);
    signal interval_counter : unsigned(31 downto 0);
    
begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & Default 
            if (reset_i = '1') then
                vfat2_t1_0 <= (lv1a     => '0',
                               calpulse => '0',
                               resync   => '0',
                               bc0      => '0');
                state <= IDLE;
                t1_type <= (others => '0');
                events_limit <= (others => '0');
                interval <= (others => '0');
                delay <= (others => '0');
                lv1a_sequence <= (others => '0');
                cal_sequence <= (others => '0');
                sync_sequence <= (others => '0');
                bc0_sequence <= (others => '0');
                event_counter <= (others => '0');
                interval_counter <= (others => '0');
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        -- Reset the T1 signal
                        vfat2_t1_0 <= (lv1a     => '0',
                                       calpulse => '0',
                                       resync   => '0',
                                       bc0      => '0');          
                        -- Wait for a request
                        if (req_en_i = '1') then
                            -- Register the parameters
                            t1_type <= req_type_i;
                            events_limit <= req_events_i;
                            interval <= req_interval_i;
                            delay <= req_delay_i;
                            lv1a_sequence <= req_lv1a_seq_i;
                            cal_sequence <= req_cal_seq_i;
                            sync_sequence <= req_sync_seq_i;
                            bc0_sequence <= req_bc0_seq_i;
                            event_counter <= (others => '0');
                            interval_counter <= (others => '0');
                            -- Select the mode
                            case req_op_mode_i is
                                when "00" => state <= MODE_0;
                                when "01" => state <= MODE_1;
                                when "10" => state <= MODE_2;
                                when others => state <= IDLE;
                            end case;
                        end if;
                    -- MODE_0 send simple pulses
                    when MODE_0 =>
                        -- Reset the module if the enable signal went low
                        if (req_en_i = '0') then
                            -- Reset the T1 signals
                            vfat2_t1_0 <= (lv1a     => '0', 
                                           calpulse => '0', 
                                           resync   => '0', 
                                           bc0      => '0');
                            -- Go back to IDLE
                            state <= IDLE;
                        -- or run the module
                        else
                            -- When we reached the interval between pulse
                            if (interval_counter = unsigned(interval) - 1) then
                                -- Reset the interval counter
                                interval_counter <= (others => '0');
                                -- No limit on events, just pulse
                                if (unsigned(events_limit) = 0) then
                                    -- Send pulse
                                    case t1_type is
                                        when "00" => vfat2_t1_0 <= (lv1a     => '1', 
                                                                    calpulse => '0', 
                                                                    resync   => '0', 
                                                                    bc0      => '0');
                                        when "01" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '1', 
                                                                    resync   => '0', 
                                                                    bc0      => '0');
                                        when "10" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '0', 
                                                                    resync   => '1', 
                                                                    bc0      => '0');
                                        when "11" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '0', 
                                                                    resync   => '0', 
                                                                    bc0      => '1');
                                        when others => vfat2_t1_0 <= (lv1a     => '0', 
                                                                      calpulse => '0', 
                                                                      resync   => '0', 
                                                                      bc0      => '0');
                                    end case;
                                -- Above the limit on events   
                                elsif (event_counter = unsigned(events_limit)) then
                                    -- Reset the T1 signals
                                    vfat2_t1_0 <= (lv1a     => '0', 
                                                   calpulse => '0', 
                                                   resync   => '0', 
                                                   bc0      => '0');
                                    -- Go wait for disable signal
                                    state <= END_0;
                                -- Limit on events but under it
                                else
                                    case t1_type is
                                        when "00" => vfat2_t1_0 <= (lv1a     => '1', 
                                                                    calpulse => '0', 
                                                                    resync   => '0', 
                                                                    bc0      => '0');
                                        when "01" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '1', 
                                                                    resync   => '0', 
                                                                    bc0      => '0');
                                        when "10" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '0', 
                                                                    resync   => '1', 
                                                                    bc0      => '0');
                                        when "11" => vfat2_t1_0 <= (lv1a     => '0', 
                                                                    calpulse => '0', 
                                                                    resync   => '0', 
                                                                    bc0      => '1');
                                        when others => vfat2_t1_0 <= (lv1a     => '0', 
                                                                      calpulse => '0', 
                                                                      resync   => '0', 
                                                                      bc0      => '0');
                                    end case;
                                    -- Increment the event counter
                                    event_counter <= event_counter + 1;
                                end if;  
                            -- or wait for the correct interval
                            else
                                -- Reset the T1 signals
                                vfat2_t1_0 <= (lv1a     => '0', 
                                               calpulse => '0', 
                                               resync   => '0', 
                                               bc0      => '0');
                                 -- Increment the counter
                                interval_counter <= interval_counter + 1;
                            end if;
                        end if;
                    -- END_0 wait for disable signal
                    when END_0 =>
                        -- Reset the T1 signals
                        vfat2_t1_0 <= (lv1a     => '0', 
                                       calpulse => '0', 
                                       resync   => '0', 
                                       bc0      => '0');
                        -- Reset the module if the enable signal went low
                        if (req_en_i = '0') then
                            -- Go back to IDLE
                            state <= IDLE;
                        end if;
                    --
                    when others =>
                        vfat2_t1_0 <= (lv1a     => '0',
                                       calpulse => '0',
                                       resync   => '0',
                                       bc0      => '0');
                        state <= IDLE;
                        t1_type <= (others => '0');
                        events_limit <= (others => '0');
                        interval <= (others => '0');
                        delay <= (others => '0');
                        lv1a_sequence <= (others => '0');
                        cal_sequence <= (others => '0');
                        sync_sequence <= (others => '0');
                        bc0_sequence <= (others => '0');
                        event_counter <= (others => '0');
                        interval_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;