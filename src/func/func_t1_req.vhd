----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    func_t1_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Generates T1 commands according to the user inputs
--
-- 
-- Stable & tested
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity func_t1_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Request
    req_en_i        : in std_logic;
    req_op_mode_i   : in std_logic_vector(1 downto 0);
    req_type_i      : in std_logic_vector(1 downto 0);
    req_events_i    : in std_logic_vector(31 downto 0);
    req_interval_i  : in std_logic_vector(31 downto 0);
    req_delay_i     : in std_logic_vector(31 downto 0);
    req_lv1a_seq_i  : in std_logic_vector(63 downto 0);
    req_cal_seq_i   : in std_logic_vector(63 downto 0);
    req_sync_seq_i  : in std_logic_vector(63 downto 0);
    req_bc0_seq_i   : in std_logic_vector(63 downto 0);
    
    req_ack_o       : out std_logic;
    req_err_o       : out std_logic;
    
    -- Output T1 commands
    vfat2_t1_0      : out t1_t;
    
    -- Running mode
    t1_running_o  : out std_logic_vector(1 downto 0)
    
);
end func_t1_req;

architecture Behavioral of func_t1_req is
 
    type state_t is (IDLE, CHECKS, MODE_0, MODE_1, MODE_2);
    
    signal state            : state_t;
      
    -- Saved values of the entries to ensure stability
    signal req_mode         : std_logic_vector(1 downto 0);
    signal t1_type          : std_logic_vector(1 downto 0);
    signal events_limit     : std_logic_vector(33 downto 0);
    signal interval         : std_logic_vector(31 downto 0);
    signal delay            : std_logic_vector(31 downto 0);
    signal lv1a_sequence    : std_logic_vector(63 downto 0);
    signal cal_sequence     : std_logic_vector(63 downto 0);
    signal sync_sequence    : std_logic_vector(63 downto 0);
    signal bc0_sequence     : std_logic_vector(63 downto 0);
    
    -- Counter
    signal event_counter    : unsigned(31 downto 0);
    signal time_counter     : unsigned(31 downto 0);
    
begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values 
            if (reset_i = '1') then
                req_ack_o <= '0';
                req_err_o <= '0';
                vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                t1_running_o <= (others => '0');
                state <= IDLE;
                req_mode <= (others => '0');
                t1_type <= (others => '0');
                events_limit <= (others => '0');
                interval <= (others => '0');
                delay <= (others => '0');
                lv1a_sequence <= (others => '0');
                cal_sequence <= (others => '0');
                sync_sequence <= (others => '0');
                bc0_sequence <= (others => '0');
                event_counter <= (others => '0');
                time_counter <= (others => '0');
            else
                case state is
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');          
                        t1_running_o <= (others => '0');
                        -- On request
                        if (req_en_i = '1') then
                            -- Store the request values    
                            req_mode <= req_op_mode_i;
                            t1_type <= req_type_i;
                            case req_events_i is
                                when x"00000000" => events_limit <= "11" & x"00000000";
                                when others => events_limit <= "00" & req_events_i;
                            end case;
                            interval <= req_interval_i;
                            delay <= req_delay_i;
                            lv1a_sequence <= req_lv1a_seq_i;
                            cal_sequence <= req_cal_seq_i;
                            sync_sequence <= req_sync_seq_i;
                            bc0_sequence <= req_bc0_seq_i;
                            event_counter <= (others => '0');
                            time_counter <= (others => '0');
                            -- Set the flags
                            case req_op_mode_i is
                                when "00" => t1_running_o <= "01";
                                when "01" => t1_running_o <= "10";
                                when "10" | "11" => t1_running_o <= "11";
                                when others => t1_running_o <= "00";
                            end case;
                            -- Change state
                            state <= CHECKS;
                        end if;
                    -- Check the parameters
                    when CHECKS => 
                        -- interval >= 3
                        if (req_mode(1) = '0' and unsigned(interval) < 3) then                            
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;
                        -- 3 < delay < interval + 3
                        elsif (req_mode = "01" and (unsigned(delay) < 3 or unsigned(delay) > unsigned(interval) - 3)) then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;
                        -- Move on
                        else
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            -- Select the mode
                            case req_mode is
                                when "00" => state <= MODE_0;
                                when "01" => state <= MODE_1;
                                when "10" => state <= MODE_2;
                                when others => state <= IDLE;
                            end case;
                        end if;
                    -- MODE_0 send simple pulses
                    when MODE_0 =>
                        -- Reset the acknowlegdment
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- Reset the module on toggle signal
                        if (req_en_i = '1') then
                            -- Acknwoledge
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            -- Reset the T1 signals
                            vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');       
                            -- Go back to IDLE
                            state <= IDLE;
                        -- or run the module
                        else
                            -- Increment the counter and check the number of packets sent
                            if (time_counter = unsigned(interval) - 1) then                                
                                time_counter <= (others => '0');
                                -- Check event counter
                                if (event_counter = unsigned(events_limit) - 1) then
                                    state <= IDLE;
                                else
                                    -- Increment the event counter
                                    event_counter <= event_counter + 1;
                                end if;
                            else
                                time_counter <= time_counter + 1;
                            end if;
                            -- Pulse on first tick
                            if (time_counter = 0) then
                                -- Send pulse
                                case t1_type is
                                    when "00" => vfat2_t1_0 <= (lv1a => '1', calpulse => '0', resync => '0', bc0 => '0');       
                                    when "01" => vfat2_t1_0 <= (lv1a => '0', calpulse => '1', resync => '0', bc0 => '0');  
                                    when "10" => vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '1', bc0 => '0');  
                                    when "11" => vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '1');  
                                    when others => vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                                end case;
                            -- or wait for the correct interval
                            else
                                -- Reset the T1 signals
                                vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                            end if;
                        end if;
                    -- MODE_1 send a calpulse followed by a trigger pulses
                    when MODE_1 =>
                        -- Reset the acknowlegdment
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- Reset the module on toggle signal
                        if (req_en_i = '1') then
                            -- Acknwoledge
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            -- Reset the T1 signals
                            vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');       
                            -- Go back to IDLE
                            state <= IDLE;
                        -- or run the module
                        else
                            -- Increment the counter and check the number of packets sent
                            if (time_counter = unsigned(interval) - 1) then                                
                                time_counter <= (others => '0');
                                -- Check event counter
                                if (event_counter = unsigned(events_limit) - 1) then
                                    state <= IDLE;
                                else
                                    -- Increment the event counter
                                    event_counter <= event_counter + 1;
                                end if;
                            else
                                time_counter <= time_counter + 1;
                            end if;
                            -- Calpulse on first tick
                            if (time_counter = 0) then
                                -- Send calibration pulse
                                vfat2_t1_0 <= (lv1a => '0', calpulse => '1', resync => '0', bc0 => '0');
                            -- LV1A on next tick
                            elsif (time_counter = unsigned(delay)) then
                                vfat2_t1_0 <= (lv1a => '1', calpulse => '0', resync => '0', bc0 => '0');  
                            -- or wait for the correct interval
                            else
                                -- Reset the T1 signals
                                vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                            end if;
                        end if;   
                    -- MODE_2 send a sequence of pulses
                    when MODE_2 =>
                        -- Reset the acknowlegdment
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- Reset the module on toggle signal
                        if (req_en_i = '1') then
                            -- Acknwoledge
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            -- Reset the T1 signals
                            vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');       
                            -- Go back to IDLE
                            state <= IDLE;
                        -- or run the module
                        else
                            -- Increment the counter and check the number of packets sent
                            if (time_counter = 255) then                                
                                time_counter <= (others => '0');
                                -- Check event counter
                                if (event_counter = unsigned(events_limit) - 1) then
                                    state <= IDLE;
                                else
                                    -- Increment the event counter
                                    event_counter <= event_counter + 1;
                                end if;
                            else
                                time_counter <= time_counter + 1;
                            end if;
                            -- Send bit
                            if (time_counter(1 downto 0) = "00") then
                                vfat2_t1_0 <= (lv1a => lv1a_sequence(to_integer(time_counter(31 downto 2))), calpulse => cal_sequence(to_integer(time_counter(31 downto 2))), resync => sync_sequence(to_integer(time_counter(31 downto 2))), bc0 => bc0_sequence(to_integer(time_counter(31 downto 2))));  
                            -- or wait for the correct interval
                            else
                                -- Reset the T1 signals
                                vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                            end if;
                        end if;   
                    --
                    when others =>
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        vfat2_t1_0 <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');  
                        state <= IDLE;
                        req_mode <= (others => '0');
                        t1_type <= (others => '0');
                        events_limit <= (others => '0');
                        interval <= (others => '0');
                        delay <= (others => '0');
                        lv1a_sequence <= (others => '0');
                        cal_sequence <= (others => '0');
                        sync_sequence <= (others => '0');
                        bc0_sequence <= (others => '0');
                        event_counter <= (others => '0');
                        time_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;