----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc_readout - Behavioral 
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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity adc_readout is
generic(

    -- Input frequency clock
    IN_FREQ     : integer := 40_000_000;
    -- SCL frequency clock
    OUT_FREQ    : integer := 4_000_000
    
);
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;

    -- Input request
    en_i                : in std_logic;
    data_i              : in std_logic_vector(7 downto 0);
    
    -- Output response
    valid_o             : out std_logic;
    data_o              : out std_logic_vector(15 downto 0);

    -- ADC lines
    adc_chip_select_o   : out std_logic;
    adc_din_i           : in std_logic;
    adc_dout_o          : out std_logic;
    adc_clk_o           : out std_logic;
    adc_eoc_i           : in std_logic
    
);
end adc_readout;

architecture Behavioral of adc_readout is

    --== Clocking signals ==--

    -- Division of the clock
    constant CLK_DIV    : integer := IN_FREQ / OUT_FREQ;
        
    -- Enables the clock output
    signal clk_enable   : std_logic;
    -- Clock divider counter
    signal clk_divider  : integer range 0 to CLK_DIV;
    -- Asserted on rising edge
    signal rising_clk   : std_logic;
    -- Asserted on middle of high clock
    signal high_clk     : std_logic;
    -- Asserted on falling edge
    signal falling_clk  : std_logic;
    -- Asserted on middle of low clock
    signal low_clk      : std_logic;
    
        --== State machine ==--
    
    type state_t is (IDLE, SEND_DATA, WAIT_EOC_LOW, WAIT_EOC_HIGH, READ_RESULT, STOP);
    
    signal state        : state_t;
    
    -- Transaction parameters
    signal din          : std_logic_vector(7 downto 0);
    signal dout         : std_logic_vector(15 downto 0);
    signal data_length  : integer range 0 to 15;
    signal data_order   : std_logic;
    
    -- Helper
    signal data_cnt     : integer range 0 to 15;
    
begin

    --===========--
    --== Clock ==--
    --===========--
    
    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                adc_clk_o <= '0';
                clk_divider <= 0;
                rising_clk <= '0';
                high_clk <= '0';
                falling_clk <= '0';
                low_clk <= '0';
            else
                -- Counting
                if (clk_divider = (CLK_DIV - 1)) then
                    clk_divider <= 0;
                else
                    clk_divider <= clk_divider + 1;
                end if;
                -- SCK generation
                if (clk_divider < (CLK_DIV - 1) / 2) then
                    adc_clk_o <= clk_enable;
                else
                    adc_clk_o <= '0';
                end if;
                -- Rising edge pulse
                if (clk_divider = 0) then
                    rising_clk <= '1';
                else
                    rising_clk <= '0';
                end if;
                -- High clock pulse
                if (clk_divider = (CLK_DIV - 1) / 4) then
                    high_clk <= '1';
                else
                    high_clk <= '0';
                end if;
                -- Falling edge pulse
                if (clk_divider = (CLK_DIV - 1) / 2) then
                    falling_clk <= '1';
                else
                    falling_clk <= '0';
                end if;
                -- Low clock pulse
                if (clk_divider = (CLK_DIV - 1) * 3 / 4) then
                    low_clk <= '1';
                else
                    low_clk <= '0';
                end if;
            end if;
        end if;
    end process;
        
    --=========--
    --== SDA ==--
    --=========--
    
    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                valid_o <= '0';
                data_o <= (others => '0');
                adc_chip_select_o <= '0';
                adc_dout_o <= '0';
                clk_enable <= '0';
                state <= IDLE;
                din <= (others => '0');
                dout <= (others => '0');
                data_length <= 0;
                data_order <= '0';
                data_cnt <= 0;
            else
                case state is                                
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        valid_o <= '0';
                        adc_chip_select_o <= '0';
                        clk_enable <= '0';
                        -- On request
                        if (en_i = '1') then
                            -- Store the request values
                            din <= data_i;
                            case data_i(3 downto 2) is
                                when "01" => data_length <= 7;
                                when "00" | "10" => data_length <= 11;
                                when "11" => data_length <= 15;
                                when others => data_length <= 11;
                            end case;
                            data_order <= data_i(1);
                            -- Set the helpers
                            data_cnt <= 7;
                            -- Change state
                            state <= SEND_DATA;
                        end if;       
                    -- Send the data to start the conversion
                    when SEND_DATA =>
                        -- Write the data on the low clock
                        if (low_clk = '1') then
                            -- Enable the chip
                            adc_chip_select_o <= '0';
                            adc_dout_o <= din(data_cnt);
                            clk_enable <= '1';
                            -- Decrement the counter
                            if (data_cnt = 0) then
                                state <= WAIT_EOC_LOW;
                            else
                                data_cnt <= data_cnt - 1;
                            end if;
                        end if;                         
                    -- Wait for the EOC to go low
                    when WAIT_EOC_LOW =>
                        -- Check the EOC on the low clock
                        if (low_clk = '1') then
                            if (adc_eoc_i = '0') then
                                -- End cycle
                                adc_chip_select_o <= '0';                            
                                clk_enable <= '0';
                                state <= WAIT_EOC_HIGH;
                            end if;
                        end if;
                    -- Wait for the EOC to go high again
                    when WAIT_EOC_HIGH => 
                        -- Check the EOC on the low clock
                        if (low_clk = '1') then
                            if (adc_eoc_i = '1') then
                                adc_chip_select_o <= '0';                                                       
                                clk_enable <= '1';
                                dout <= (others => '0');
                                data_cnt <= 0;
                                state <= READ_RESULT;
                            end if;
                        end if;
                    -- Read out the conversion
                    when READ_RESULT =>
                        -- Read the result on the high clock
                        if (rising_clk = '1') then
                            adc_chip_select_o <= '0';                                                     
                            clk_enable <= '1';
                            -- Get the data in the right order
                            if (data_order = '0') then
                                dout(data_length - data_cnt) <= adc_din_i;
                            else
                                dout(data_cnt) <= adc_din_i; 
                            end if;                            
                            -- Check if data is still available
                            if (data_cnt = data_length) then
                                state <= STOP;
                            else
                                data_cnt <= data_cnt + 1;
                            end if;
                        end if;
                    -- Stop the ADC
                    when STOP =>
                        -- Stop on a low clock
                        if (low_clk = '1') then
                            adc_chip_select_o <= '0';                                                     
                            clk_enable <= '0';
                            -- Set the data
                            valid_o <= '1';
                            data_o <= dout;
                            -- 
                            state <= IDLE;
                        end if;
                    --
                    when others => 
                        valid_o <= '0';
                        data_o <= (others => '0');
                        adc_chip_select_o <= '0';
                        adc_dout_o <= '0';
                        state <= IDLE;
                        din <= (others => '0');
                        dout <= (others => '0');
                        data_length <= 0;
                        data_order <= '0';
                        data_cnt <= 0;
                end case;  
            end if;
        end if;
    end process;
    

end Behavioral;