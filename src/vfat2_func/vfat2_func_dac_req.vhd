----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:46:42 08/05/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_func_dac_req - Behavioral 
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

entity vfat2_func_dac_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Request data
    req_stb_i       : in std_logic;
    req_dac_i       : in std_logic_vector(3 downto 0);
    req_vfat2_i     : in std_logic_vector(4 downto 0);
    req_min_i       : in std_logic_vector(7 downto 0);
    req_max_i       : in std_logic_vector(7 downto 0);
    req_step_i      : in std_logic_vector(7 downto 0);
    req_events_i    : in std_logic_vector(3 downto 0);
    
    req_ack_o       : out std_logic;
    req_err_o       : out std_logic;
       
    -- Wishbone master
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in wb_res_t;
    
    -- FIFO control
    fifo_rst_o      : out std_logic;
    fifo_we_o       : out std_logic;
    fifo_din_o      : out std_logic_vector(31 downto 0);
    
    -- Running mode
    dac_running_o   : out std_logic
    
);
end vfat2_func_dac_req;

architecture Behavioral of vfat2_func_dac_req is

    type state_t is (IDLE, CHECKS, REQ_RUNNING, ACK_RUNNING, REQ_SHUTDOWN, ACK_SHUTDOWN, REQ_SAVE, ACK_SAVE, REQ_SET_DAC, ACK_SET_DAC, REQ_I2C, ACK_I2C, REQ_SCAN_DAC, ACK_SCAN_DAC, AVERAGE, STORE_RESULT, REQ_RESTORE, ACK_RESTORE);
        
    signal state            : state_t;
    
    -- Scan parameters
    signal req_dac          : std_logic_vector(3 downto 0);
    signal req_vfat2        : std_logic_vector(4 downto 0);    
    signal req_min          : std_logic_vector(7 downto 0);
    signal req_max          : std_logic_vector(7 downto 0);
    signal req_step         : std_logic_vector(7 downto 0);
    signal req_events       : std_logic_vector(15 downto 0);
    
    -- Helpers
    signal adc_channel      : std_logic_vector(3 downto 0);
    signal dac_code         : std_logic_vector(3 downto 0);
    signal register_id      : std_logic_vector(7 downto 0);
    signal average_shift    : integer range 0 to 15;
    
    -- Value of the register before the scan
    signal saved_value      : std_logic_vector(7 downto 0);
    
    -- Counter for the scan
    signal value_counter    : unsigned(8 downto 0);
    signal event_counter    : unsigned(15 downto 0);
    signal dac_counter      : unsigned(32 downto 0);

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset and default values
            if (reset_i = '1') then
                req_ack_o <= '0';
                req_err_o <= '0';
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                fifo_rst_o <= '0';
                fifo_we_o <= '0';
                fifo_din_o <= (others => '0');
                dac_running_o <= '0';
                state <= IDLE;
                req_dac <= (others => '0');
                req_vfat2 <= (others => '0');
                req_min <= (others => '0');
                req_max <= (others => '0');
                req_step <= (others => '0');
                req_events <= (others => '0');
                adc_channel <= (others => '0');
                dac_code <= (others => '0');
                register_id <= (others => '0');
                average_shift <= 0;
                saved_value <= (others => '0');
                value_counter <= (others => '0');
                event_counter <= (others => '0');
                dac_counter <= (others => '0');
            else
                case state is                
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        fifo_we_o <= '0';
                        dac_running_o <= '0';
                        -- On request
                        if (req_stb_i = '1') then
                            -- Store the request values                              
                            req_dac <= req_dac_i;
                            req_vfat2 <= req_vfat2_i;
                            req_min <= req_min_i;
                            case req_max_i is
                                when x"00" => req_max <= x"FF";
                                when others => req_max <= req_max_i;
                            end case;
                            case req_max_i is
                                when x"00" => req_max <= x"FF";
                                when others => req_max <= req_max_i;
                            end case;
                            case req_step_i is
                                when x"00" => req_step <= x"01";
                                when others => req_step <= req_step_i;
                            end case;
                            case req_events_i is
                                when x"0" => req_events <= x"0001";
                                when x"1" => req_events <= x"0002";
                                when x"2" => req_events <= x"0004";
                                when x"3" => req_events <= x"0008";
                                when x"4" => req_events <= x"000F";
                                when x"5" => req_events <= x"0010";
                                when x"6" => req_events <= x"0020";
                                when x"7" => req_events <= x"0040";
                                when x"8" => req_events <= x"0080";
                                when x"9" => req_events <= x"00F0";
                                when x"A" => req_events <= x"0100";
                                when x"B" => req_events <= x"0200";
                                when x"C" => req_events <= x"0400";
                                when x"D" => req_events <= x"0800";
                                when x"E" => req_events <= x"0F00";
                                when x"F" => req_events <= x"1000";
                                when others => req_events <= x"0001";
                            end case;
                            -- Set the helpers
                            if (req_vfat2_i(4 downto 3) = "00") then
                                case req_dac_i is
                                    when x"0" | x"1" | x"2" | x"3" | x"4" | x"5" => adc_channel <= x"0";
                                    when x"6" | x"7" | x"8" | x"9" => adc_channel <= x"1";
                                    when others => adc_channel <= x"0";
                                end case;
                            elsif (req_vfat2_i(4 downto 3) = "01") then
                                case req_dac_i is
                                    when x"0" | x"1" | x"2" | x"3" | x"4" | x"5" => adc_channel <= x"8";
                                    when x"6" | x"7" | x"8" | x"9" => adc_channel <= x"5";
                                    when others => adc_channel <= x"0";
                                end case;                            
                            else
                                case req_dac_i is
                                    when x"0" | x"1" | x"2" | x"3" | x"4" | x"5" => adc_channel <= x"7";
                                    when x"6" | x"7" | x"8" | x"9" => adc_channel <= x"6";
                                    when others => adc_channel <= x"0";
                                end case;                            
                            end if;                            
                            case req_dac_i is
                                when x"0" =>
                                    dac_code <= x"1";
                                    register_id <= x"02";
                                when x"1" =>
                                    dac_code <= x"2";
                                    register_id <= x"03";
                                when x"2" =>
                                    dac_code <= x"3";
                                    register_id <= x"04";
                                when x"3" =>
                                    dac_code <= x"4";
                                    register_id <= x"05";
                                when x"4" =>
                                    dac_code <= x"5";
                                    register_id <= x"06";
                                when x"5" =>
                                    dac_code <= x"6";
                                    register_id <= x"07";
                                when x"6" =>
                                    dac_code <= x"7";
                                    register_id <= x"92";
                                when x"7" =>
                                    dac_code <= x"8";
                                    register_id <= x"93";
                                when x"8" =>
                                    dac_code <= x"9";
                                    register_id <= x"91";
                                when x"9" =>
                                    dac_code <= x"B";
                                    register_id <= x"00";
                                when others => 
                                    dac_code <= x"0";
                                    register_id <= x"00";
                            end case;
                            average_shift <= to_integer(unsigned(req_events_i));
                            value_counter <= '0' & unsigned(req_min_i);
                            -- Set the flags
                            fifo_rst_o <= '1';
                            dac_running_o <= '1';
                            -- Change state
                            state <= CHECKS;
                        end if;       
                    -- Check the parameters
                    when CHECKS =>
                        -- Enable the FIFO
                        fifo_rst_o <= '0';
                        -- Check VFAT2
                        if (unsigned(req_vfat2) > 23) then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;                        
                        -- Check if the min < max
                        elsif (unsigned(req_min) > unsigned(req_max)) then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;   
                        -- Check the DAC code and register ID
                        elsif (dac_code = x"0" and register_id = x"00") then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;   
                        else
                            req_ack_o <= '1';
                            req_err_o <= '0';
                            state <= REQ_RUNNING;   
                        end if;         
                    -- Prepare the scan
                    when REQ_RUNNING =>
                        -- Reset the acknowledmgents
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- Ask if VFAT2 is running
                        wb_mst_req_o <= (stb => '1', we => '0', addr => WB_ADDR_I2C & "00000000000" & req_vfat2 & x"00", data => (others => '0'));
                        state <= ACK_RUNNING;      
                    -- Wait for the response
                    when ACK_RUNNING => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid and the VFAT2 is on
                            if (wb_mst_res_i.stat = WB_NO_ERR and wb_mst_res_i.data(0) = '1') then
                                -- change state
                                state <= REQ_SHUTDOWN;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- end the scan
                                state <= IDLE;
                            end if;
                        end if;                        
                    -- Ask for all VFAT2s to shutdown their DAC
                    when REQ_SHUTDOWN => 
                        -- Send an I2C request
                        wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_EI2C & x"0000" & x"01", data => (others => '0'));
                        state <= ACK_SHUTDOWN;                        
                    -- Wait for the response
                    when ACK_SHUTDOWN => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid
                            if (wb_mst_res_i.stat = WB_NO_ERR) then
                                -- change state
                                state <= REQ_SAVE;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- end the scan
                                state <= IDLE;
                            end if;
                        end if;     
                    -- Save the current value
                    when REQ_SAVE =>
                        -- Reset the acknowledmgents
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        -- Ask if VFAT2 is running
                        wb_mst_req_o <= (stb => '1', we => '0', addr => WB_ADDR_I2C & "00000000000" & req_vfat2 & x"01", data => x"0000000" & dac_code);
                        state <= ACK_SAVE;      
                    -- Wait for the response
                    when ACK_SAVE => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid and the VFAT2 is on
                            if (wb_mst_res_i.stat = WB_NO_ERR and wb_mst_res_i.data(0) = '1') then
                                -- Store it in memory
                                saved_value <= wb_mst_res_i.data(7 downto 0);
                                -- change state
                                state <= REQ_SET_DAC;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- end the scan
                                state <= IDLE;
                            end if;
                        end if;        
                    -- Set the DAC select
                    when REQ_SET_DAC =>
                        -- Select the correct DAC
                        wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_I2C & "00000000000" & req_vfat2 & x"01", data => x"0000000" & dac_code);
                        state <= ACK_SET_DAC;      
                    -- Wait for the response
                    when ACK_SET_DAC => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the data is valid and the VFAT2 is on
                            if (wb_mst_res_i.stat = WB_NO_ERR and wb_mst_res_i.data(0) = '1') then
                                -- change state
                                state <= REQ_I2C;
                            -- Or
                            else
                                -- Store an error in the FIFO
                                fifo_we_o <= '1';
                                fifo_din_o <= x"FF000000";
                                -- end the scan
                                state <= IDLE;
                            end if;
                        end if;                         
                    -- Send an I2C request to change the value
                    when REQ_I2C =>
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_I2C & "00000000000" & req_vfat2 & register_id, data => x"000000" & std_logic_vector(value_counter(7 downto 0)));
                        state <= ACK_I2C;                        
                    -- Wait for the acknowledgment
                    when ACK_I2C => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the request was done successfully
                            if (wb_mst_res_i.stat = WB_NO_ERR) then
                                -- Go for counting
                                event_counter <= (others => '0');
                                dac_counter <= (others => '0');
                                -- Change state
                                state <= REQ_SCAN_DAC;
                            -- or store an error
                            else
                                event_counter <= (others => '1');
                                dac_counter <= (others => '1');
                                state <= STORE_RESULT;
                            end if;
                        end if;               
                    -- Perform the DAC scan
                    when REQ_SCAN_DAC =>
                        -- Change state when the counter reached its limit
                        if (event_counter = unsigned(req_events)) then
                            state <= AVERAGE;
                        else
                            -- Request the ADC value
                            wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_ADC & x"00000" & adc_channel, data => (others => '0'));
                            state <= ACK_SCAN_DAC;  
                        end if;                
                    -- Wait for the acknowledgment
                    when ACK_SCAN_DAC => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- If the request was done successfully
                            if (wb_mst_res_i.stat = WB_NO_ERR) then
                                -- Increment the event counter
                                event_counter <= event_counter + 1;
                                -- Increment the DAC counter
                                dac_counter <= dac_counter + unsigned(wb_mst_res_i.data(15 downto 0));
                                -- Change state
                                state <= REQ_SCAN_DAC;
                            end if;
                            -- 
                            state <= REQ_SCAN_DAC;
                        end if;        
                    -- Perform the average of the results
                    when AVERAGE => 
                        dac_counter <= dac_counter srl average_shift;
                        state <= STORE_RESULT;
                    -- Store the results in the FIFO
                    when STORE_RESULT =>
                        -- Write in the FIFO
                        fifo_we_o <= '1';
                        fifo_din_o <= std_logic_vector(value_counter(7 downto 0)) & std_logic_vector(dac_counter(23 downto 0));
                        -- Check the value for its limit
                        if (value_counter + unsigned(req_step) <= unsigned(req_max)) then
                            -- Increment the value counter
                            value_counter <= value_counter + unsigned(req_step);
                            -- and repeat the procedure
                            state <= REQ_I2C;
                        -- Or restore the latency value
                        else
                            state <= REQ_RESTORE;
                        end if;                        
                    -- Restore the value
                    when REQ_RESTORE => 
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Send an I2C request
                        wb_mst_req_o <= (stb => '1', we => '1', addr => WB_ADDR_I2C & "00000000000" & req_vfat2 & register_id, data => x"000000" & std_logic_vector(saved_value));
                        state <= ACK_RESTORE;                        
                    -- Wait for the acknowledgment
                    when ACK_RESTORE => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            state <= IDLE;
                        end if;                    
                    --
                    when others =>
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                        fifo_rst_o <= '0';
                        fifo_we_o <= '0';
                        fifo_din_o <= (others => '0');
                        dac_running_o <= '0';
                        state <= IDLE;
                        req_dac <= (others => '0');
                        req_vfat2 <= (others => '0');
                        req_min <= (others => '0');
                        req_max <= (others => '0');
                        req_step <= (others => '0');
                        req_events <= (others => '0');
                        adc_channel <= (others => '0');
                        dac_code <= (others => '0');
                        register_id <= (others => '0');
                        average_shift <= 0;
                        saved_value <= (others => '0');
                        value_counter <= (others => '0');
                        event_counter <= (others => '0');
                        dac_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;
    
end Behavioral;




