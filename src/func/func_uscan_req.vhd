----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    13:46:42 08/05/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    func_scan_req - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity func_uscan_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;

    -- Request data
    req_stb_i       : in std_logic;
    req_mode_i      : in std_logic_vector(2 downto 0);
    req_mask_i      : in std_logic_vector(23 downto 0);
    req_channel_i   : in std_logic_vector(6 downto 0);
    req_min_i       : in std_logic_vector(7 downto 0);
    req_max_i       : in std_logic_vector(7 downto 0);
    req_step_i      : in std_logic_vector(7 downto 0);
    req_events_i    : in std_logic_vector(23 downto 0);
    req_dir_i       : in std_logic;

    req_ack_o       : out std_logic;
    req_err_o       : out std_logic;

    -- Wishbone master
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in wb_res_t;

    -- VFAT2 data
    vfat2_sbits_i   : in sbits_array_t(23 downto 0);
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);

    -- FIFO control
    fifo_we_o       : out std_logic_vector(23 downto 0);
    fifo_din_o      : out std32_array_t(23 downto 0);

    -- Running mode
    scan_running_o  : out std_logic_vector(2 downto 0);
    scan_error_o    : out std_logic;
    scan_mask_o     : out std_logic_vector(23 downto 0)

);
end func_uscan_req;

architecture Behavioral of func_uscan_req is

    type state_global_t is (IDLE, CHECKS, REQ_RUNNING, ACK_RUNNING, REQ_CURRENT, ACK_CURRENT, REQ_I2C, ACK_I2C, WAIT_DELAY, VFAT2_BUSY, REQ_RESTORE, ACK_RESTORE);
    type state_vfat2_t is (IDLE, SCAN_THRESHOLD, SCAN_THRESHOLD_DELAY, SCAN_THRESHOLD2, SCAN_LATENCY, SCAN_SCURVE, SCAN_TK, STORE_RESULT, VFAT2_WAIT);

    type state_vfat2_array_t is array(integer range <>) of state_vfat2_t;

    signal state_global     : state_global_t;
    signal state_vfat       : state_vfat2_array_t(23 downto 0);

    -- Scan parameters
    signal req_mode         : std_logic_vector(2 downto 0);
    signal req_mask         : std_logic_vector(23 downto 0);
    signal req_channel      : std_logic_vector(6 downto 0);
    signal req_min          : std_logic_vector(8 downto 0);
    signal req_max          : std_logic_vector(8 downto 0);
    signal req_step         : std_logic_vector(8 downto 0);
    signal req_events       : std_logic_vector(23 downto 0);
    signal req_dir          : std_logic;

    -- Helpers
    signal vfat2_int0       : integer range 0 to 31;
    signal vfat2_int1       : integer range 0 to 31;
    signal vfat2_int2       : integer range 0 to 31;
    signal vfat2_int3       : integer range 0 to 31;
    signal channel_int      : integer range 0 to 127;
    signal register_id      : std_logic_vector(7 downto 0);

    -- Value of the register before the scan
    signal saved_value      : std8_array_t(23 downto 0);

    -- Counter for the scan
    signal value_counter    : unsigned(8 downto 0);
    signal event_counter    : u24_array_t(23 downto 0);
    signal hit_counter      : u24_array_t(23 downto 0);
    signal vfat2_delay      : u24_array_t(23 downto 0);
    signal delay            : unsigned(15 downto 0);
    
    -- VFAT2 statuses
    signal vfat2_done       : std_logic_vector(23 downto 0);

    -- Utility
    signal empty_8bits      : std_logic_vector(7 downto 0);

begin

    -- All 0 to compare to
    empty_8bits <= (others => '0');

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset and default values
            if (reset_i = '1') then
                req_ack_o <= '0';
                req_err_o <= '0';
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                scan_running_o <= (others => '0');
                scan_error_o <= '0';                
                scan_mask_o <= (others => '0');
                state_global <= IDLE;
                req_mode <= (others => '0');
                req_mask <= (others => '0');
                req_channel <= (others => '0');
                req_min <= (others => '0');
                req_max <= (others => '0');
                req_step <= (others => '0');
                req_events <= (others => '0');
                req_dir <= '0';
                vfat2_int0 <= 0;
                vfat2_int1 <= 0;
                vfat2_int2 <= 0;
                vfat2_int3 <= 0;
                channel_int <= 0;
                register_id <= (others => '0');
                value_counter <= (others => '0');
                delay <= (others => '0');
            else
                case state_global is
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        scan_running_o <= (others => '0');
                        -- On request
                        if (req_stb_i = '1') then
                            -- Store the request values
                            req_mode <= req_mode_i;
                            req_mask <= req_mask_i;
                            req_channel <= req_channel_i;
                            req_min <= '0' & req_min_i;
                            case req_max_i is
                                when x"00" => req_max <= '0' & x"FF";
                                when others => req_max <= '0' & req_max_i;
                            end case;
                            case req_step_i is
                                when x"00" => req_step <= '0' & x"01";
                                when others => req_step <= '0' & req_step_i;
                            end case;
                            case req_events_i is
                                when x"000000" => req_events <= x"FFFFFF";
                                when others => req_events <= req_events_i;
                            end case;
                            req_dir <= req_dir_i;
                            -- Set the helpers
                            vfat2_int0 <= 0;
                            vfat2_int1 <= 0;
                            vfat2_int2 <= 0;
                            vfat2_int3 <= 0;
                            channel_int <= to_integer(unsigned(req_channel_i));
                            case req_mode_i is
                                when "000" | "001" | "100" => register_id <= x"92";
                                when "010" => register_id <= x"10";
                                when "011" => register_id <= x"91";
                                when others => register_id <= x"10";
                            end case;
                            if (req_dir_i = '0') then
                                value_counter <= '0' & unsigned(req_min_i);
                            else
                                value_counter <= '0' & unsigned(req_max_i);                          
                            end if;
                            -- Set the flags
                            case req_mode_i is
                                when "000" => scan_running_o <= "001";
                                when "001" => scan_running_o <= "010";
                                when "010" => scan_running_o <= "011";
                                when "011" => scan_running_o <= "100";
                                when "100" => scan_running_o <= "101";
                                when others => scan_running_o <= "000";
                            end case;
                            -- Change state
                            state_global <= CHECKS;
                        end if;
                    -- Check the parameters
                    when CHECKS =>
                        -- Check if the min < max
                        if (unsigned(req_min) > unsigned(req_max)) then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            scan_error_o <= '1';
                            state_global <= IDLE;
                        -- Check if at least one VFAT2 is unmasked
                        elsif (req_mask = x"FFFFFF") then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            scan_error_o <= '1';
                            state_global <= IDLE;                            
                        else
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            scan_error_o <= '0';
                            vfat2_int0 <= 0;
                            state_global <= REQ_RUNNING;
                        end if;                               
                    -- Prepare the scan
                    when REQ_RUNNING =>
                        -- Reset the acknowledmgents
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- If we talked to all VFAT2s, go to next step
                        if (vfat2_int0 > 23) then
                            vfat2_int1 <= 0;
                            state_global <= REQ_CURRENT;
                        -- Otherwise, if the VFAT2 is masked, skip it
                        elsif (req_mask(vfat2_int0) = '1') then
                            vfat2_int0 <= vfat2_int0 + 1;
                            state_global <= REQ_RUNNING;                            
                        -- Ask if VFAT2 is running
                        else
                            wb_mst_req_o <= (stb => '1', we => '0', addr => WB_ADDR_I2C & "00000000000" & std_logic_vector(to_unsigned(vfat2_int0, 5)) & x"00", data => (others => '0'));
                            state_global <= ACK_RUNNING;     
                        end if;      
                    -- Wait for the response
                    when ACK_RUNNING => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is invalid or the VFAT2 is not running
                            if (wb_mst_res_i.stat /= WB_NO_ERR or wb_mst_res_i.data(0) = '0') then
                                -- Disable the VFAT2
                                req_mask(vfat2_int0) <= '1';
                            end if;
                            vfat2_int0 <= vfat2_int0 + 1;
                            state_global <= REQ_RUNNING;
                        end if;              
                    -- Read the current value of the register
                    when REQ_CURRENT => 
                        -- If we talked to all VFAT2s, go to next step
                        if (vfat2_int1 > 23) then
                            vfat2_int2 <= 0;
                            state_global <= REQ_I2C;
                        -- Otherwise, if the VFAT2 is masked, skip it
                        elsif (req_mask(vfat2_int1) = '1') then
                            vfat2_int1 <= vfat2_int1 + 1;
                            state_global <= REQ_CURRENT;                            
                        -- Ask if VFAT2 is running
                        else
                            wb_mst_req_o <= (stb => '1', we => '0', addr => WB_ADDR_I2C & "00000000000" & std_logic_vector(to_unsigned(vfat2_int1, 5)) & register_id, data => (others => '0'));
                            state_global <= ACK_CURRENT;     
                        end if;                              
                    -- Wait for the response
                    when ACK_CURRENT => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid
                            if (wb_mst_res_i.stat = WB_NO_ERR) then
                                saved_value(vfat2_int1) <= wb_mst_res_i.data(7 downto 0);
                            -- Or
                            else
                                -- Disable the VFAT2
                                req_mask(vfat2_int1) <= '1';
                            end if;
                            vfat2_int1 <= vfat2_int1 + 1;
                            state_global <= REQ_CURRENT;
                        end if;              
                    -- Change the value to the minimum
                    when REQ_I2C => 
                        -- If we talked to all VFAT2s, go to next step
                        if (vfat2_int2 > 23) then
                            delay <= (others => '0');
                            state_global <= WAIT_DELAY;
                        -- Otherwise, if the VFAT2 is masked, skip it
                        elsif (req_mask(vfat2_int2) = '1') then
                            vfat2_int2 <= vfat2_int2 + 1;
                            state_global <= REQ_I2C;                            
                        -- Ask if VFAT2 is running
                        else
                            wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_I2C & "00000000000" & std_logic_vector(to_unsigned(vfat2_int2, 5)) & register_id, data => x"000000" & std_logic_vector(value_counter(7 downto 0)));
                            state_global <= ACK_I2C;     
                        end if;                       
                    -- Wait for the response
                    when ACK_I2C => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            vfat2_int2 <= vfat2_int2 + 1;
                            state_global <= REQ_I2C;
                        end if;     
                    -- Wait a bit
                    when WAIT_DELAY =>
                        if (delay = 50_000) then
                            state_global <= VFAT2_BUSY;
                        else
                            delay <= delay + 1;
                        end if; 
                    -- Wait for all VFAT2s to be done
                    when VFAT2_BUSY =>
                        -- If all VFAT2s are done (add mask for masked VFAT2s)
                        if ((vfat2_done or req_mask) = x"FFFFFF") then     
                            -- Check the value for its limit
                            if ((req_dir = '0') and (value_counter + unsigned(req_step) <= unsigned(req_max))) then 
                                -- Increment the value counter
                                value_counter <= value_counter + unsigned(req_step);
                                -- and repeat the procedure
                                vfat2_int2 <= 0;
                                state_global <= REQ_I2C;
                            elsif ((req_dir = '1') and (value_counter - unsigned(req_step) >= unsigned(req_min))) then 
                                -- Increment the value counter
                                value_counter <= value_counter - unsigned(req_step);
                                -- and repeat the procedure
                                vfat2_int2 <= 0;
                                state_global <= REQ_I2C;
                            -- Or restore the latency value
                            else
                                vfat2_int3 <= 0;
                                scan_mask_o <= req_mask;
                                state_global <= REQ_RESTORE;  
                            end if;                       
                        end if;  
                    -- Change the value to the minimum
                    when REQ_RESTORE => 
                        -- If we talked to all VFAT2s, go to next step
                        if (vfat2_int3 > 23) then
                            state_global <= IDLE;
                        -- Otherwise, if the VFAT2 is masked, skip it
                        elsif (req_mask(vfat2_int3) = '1') then
                            vfat2_int3 <= vfat2_int3 + 1;
                            state_global <= REQ_RESTORE;                            
                        -- Ask if VFAT2 is running
                        else
                            wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_I2C & "00000000000" & std_logic_vector(to_unsigned(vfat2_int3, 5)) & register_id, data => x"000000" & std_logic_vector(saved_value(vfat2_int3)));
                            state_global <= ACK_RESTORE;     
                        end if;                       
                    -- Wait for the response
                    when ACK_RESTORE => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            vfat2_int3 <= vfat2_int3 + 1;
                            state_global <= REQ_RESTORE;
                        end if;          
                    -- Others
                    when others =>
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                        scan_running_o <= (others => '0');
                        scan_error_o <= '0';                              
                         scan_mask_o <= (others => '0');
                        state_global <= IDLE;
                        req_mode <= (others => '0');
                        req_mask <= (others => '0');
                        req_channel <= (others => '0');
                        req_min <= (others => '0');
                        req_max <= (others => '0');
                        req_step <= (others => '0');
                        req_events <= (others => '0');
                        req_dir <= '0';
                        vfat2_int0 <= 0;
                        vfat2_int1 <= 0;
                        vfat2_int2 <= 0;
                        vfat2_int3 <= 0;
                        channel_int <= 0;
                        register_id <= (others => '0');
                        value_counter <= (others => '0');
                        delay <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
    -- Counters for all VFAT2s --

    vfat2_loop: for I in 0 to 23 generate
    begin

        process(ref_clk_i)
        begin
            if (rising_edge(ref_clk_i)) then
                -- Reset and default values
                if (reset_i = '1') then
                    fifo_we_o(I) <= '0';
                    fifo_din_o(I) <= (others => '0');
                    state_vfat(I) <= IDLE;               
                    event_counter(I) <= (others => '0');
                    hit_counter(I) <= (others => '0');                   
                    vfat2_done(I) <= '0';                    
                else
                    case state_vfat(I) is
                        -- Wait for request
                        when IDLE =>     
                            if (req_mask(I) = '1') then
                                vfat2_done(I) <= '1';                            
                            elsif (state_global = VFAT2_BUSY) then
                                vfat2_done(I) <= '0';
                                -- Go for counting
                                event_counter(I) <= (others => '0');
                                hit_counter(I) <= (others => '0');
                                -- Change state
                                case req_mode is
                                    when "000" => state_vfat(I) <= SCAN_THRESHOLD;
                                    when "001" => state_vfat(I) <= SCAN_THRESHOLD2;
                                    when "010" => state_vfat(I) <= SCAN_LATENCY;
                                    when "011" => state_vfat(I) <= SCAN_SCURVE;
                                    when "100" => state_vfat(I) <= SCAN_TK;
                                    when others => state_vfat(I) <= VFAT2_WAIT;
                                end case;
                            else                            
                                vfat2_done(I) <= '0';
                            end if;
                        -- Perform a threshold scan
                        when SCAN_THRESHOLD =>
                            -- Change state when the counter reached its limit
                            if (event_counter(I) = unsigned(req_events)) then
                                state_vfat(I) <= STORE_RESULT;
                            else
                                vfat2_delay(I) <= (others => '0');
                                state_vfat(I) <= SCAN_THRESHOLD_DELAY;
                                -- Increment the event counter
                                event_counter(I) <= event_counter(I) + 1;
                                -- Increment the hit counter
                                if (vfat2_sbits_i(I) /= empty_8bits) then
                                    hit_counter(I) <= hit_counter(I) + 1;
                                end if;
                            end if;
                        -- Wait for MSP duration
                        when SCAN_THRESHOLD_DELAY => 
                            if (vfat2_delay(I) = 9) then 
                                state_vfat(I) <= SCAN_THRESHOLD;
                            else
                                vfat2_delay(I) <= vfat2_delay(I) + 1;
                            end if;
                        -- Perform a latency scan or threshold scan using tracking data
                        when SCAN_LATENCY | SCAN_TK =>
                            -- Change state when the counter reached its limit
                            if (event_counter(I) = unsigned(req_events)) then
                                state_vfat(I) <= STORE_RESULT;
                            else
                                -- Wait for tracking data
                                if (vfat2_tk_data_i(I).valid = '1' and vfat2_tk_data_i(I).crc_ok = '1') then
                                    -- Increment the event counter
                                    event_counter(I) <= event_counter(I) + 1;
                                    -- Increment the hit counter
                                    if (vfat2_tk_data_i(I).hit = '1') then
                                        hit_counter(I) <= hit_counter(I) + 1;
                                    end if;
                                end if;
                            end if;
                        -- Perform a threshold scan or scurve on a signel channel
                        when SCAN_THRESHOLD2 | SCAN_SCURVE =>
                            -- Change state when the counter reached its limit
                            if (event_counter(I) = unsigned(req_events)) then
                                state_vfat(I) <= STORE_RESULT;
                            else
                                -- Wait for tracking data
                                if (vfat2_tk_data_i(I).valid = '1' and vfat2_tk_data_i(I).crc_ok = '1') then
                                    -- Increment the event counter
                                    event_counter(I) <= event_counter(I) + 1;
                                    -- Increment the hit counter
                                    if (vfat2_tk_data_i(I).strips(channel_int) = '1') then
                                        hit_counter(I) <= hit_counter(I) + 1;
                                    end if;
                                end if;
                            end if;
                        -- Store the results in the FIFO
                        when STORE_RESULT =>
                            -- Write in the FIFO
                            fifo_we_o(I) <= '1';
                            fifo_din_o(I) <= std_logic_vector(value_counter(7 downto 0)) & std_logic_vector(hit_counter(I));
                            -- This VFAT2 is done
                             state_vfat(I) <= VFAT2_WAIT;
                        -- This VFAT2 is done
                        when VFAT2_WAIT =>
                            fifo_we_o(I) <= '0';
                            vfat2_done(I) <= '1';
                            if (state_global /= VFAT2_BUSY) then
                                state_vfat(I) <= IDLE;
                            end if;
                        --
                        when others =>
                            fifo_we_o(I) <= '0';
                            fifo_din_o(I) <= (others => '0');
                            state_vfat(I) <= IDLE;                    
                            event_counter(I) <= (others => '0');
                            hit_counter(I) <= (others => '0');                         
                            vfat2_done(I) <= '0';                           
                    end case;
                end if;
            end if;
        end process;    
    
    end generate;

end Behavioral;
