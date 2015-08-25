----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    i2c - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles basic I2C communications
--
-- 
-- Stable & tested
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity i2c is
generic(

    -- Input frequency clock
    IN_FREQ     : integer := 40_000_000;
    -- SCL frequency clock
    OUT_FREQ    : integer := 100_000
    
);
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    -- Request
    en_i        : in std_logic;
    address_i   : in std_logic_vector(6 downto 0);
    rw_i        : in std_logic;
    data_i      : in std_logic_vector(7 downto 0);
    
    -- Response
    valid_o     : out std_logic;
    error_o     : out std_logic;
    data_o      : out std_logic_vector(7 downto 0);
    
    -- I2C lines
    scl_o       : out std_logic;
    sda_miso_i  : in std_logic;
    sda_mosi_o  : out std_logic;
    sda_tri_o   : out std_logic
    
);
end i2c;

architecture Behavioral of i2c is

    --== Clocking signals ==--

    -- Division of the clock
    constant CLK_DIV    : integer := IN_FREQ / OUT_FREQ;
    
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
    
    type state_t is (IDLE, START, ADDR, RW, WAIT_0, ACK_0, RD, ACK_1, RST_1, ENDING_RD, WR, RST_2, ACK_2, ENDING_WR, STOP, ERROR);
    
    signal state        : state_t;
    
    -- Transaction parameters
    signal address      : std_logic_vector(6 downto 0);
    signal rw_n         : std_logic;
    signal din          : std_logic_vector(7 downto 0);
    signal dout         : std_logic_vector(7 downto 0);
    
    -- Address and data counters
    signal address_cnt  : integer range 0 to 6;
    signal data_cnt     : integer range 0 to 7;

begin

    --=========--
    --== SCK ==--
    --=========--
    
    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                scl_o <= '0';
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
                    scl_o <= '1';
                else
                    scl_o <= '0';
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
                error_o <= '0';
                data_o <= (others => '0');
                sda_mosi_o <= '1';
                sda_tri_o <= '1';
                state <= IDLE;
                address <= (others => '0');
                rw_n <= '0';
                din <= (others => '0');
                dout <= (others => '0');
                address_cnt <= 0;
                data_cnt <= 0;
            else
                case state is
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        valid_o <= '0';
                        error_o <= '0';
                        sda_mosi_o <= '1';
                        sda_tri_o <= '0';
                        -- On request
                        if (en_i = '1') then
                            -- Store the request values
                            address <= address_i;
                            rw_n <= rw_i;
                            din <= data_i;
                            -- Change state
                            state <= START;
                        end if;                        
                    -- Create a start condition
                    when START =>
                        -- On a high clock, put data low
                        if (high_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            -- Set the counter for the address
                            address_cnt <= 6;
                            state <= ADDR;
                        end if;                       
                    -- Transmit the address signal
                    when ADDR => 
                        -- Write data on a low clock
                        if (low_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= address(address_cnt);
                            sda_tri_o <= '0';
                            -- If the address is sent, got to rw bit
                            if (address_cnt = 0) then
                                state <= RW;
                            -- or decrement counter
                            else
                                address_cnt <= address_cnt - 1;
                            end if;
                        end if;
                    -- Send the rw bit
                    when RW => 
                        -- Write data on a low clock
                        if (low_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= rw_n;
                            sda_tri_o <= '0';
                            state <= WAIT_0;
                        end if;
                    -- Free the bus for slave to write
                    when WAIT_0 =>
                        -- On the falling edge of the RW bit, free the line
                        if (falling_clk = '1') then
                            -- Slave controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            state <= ACK_0;
                        end if;
                    -- Read the address acknowledgment
                    when ACK_0 =>
                        -- On high clock, read data
                        if (high_clk = '1') then
                            -- Slave controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            -- If the slave acknowledged
                            if (sda_miso_i = '0') then
                                -- Set the data counter
                                data_cnt <= 7;
                                -- Go to read or write states
                                case rw_n is
                                    when '1' => state <= RD;
                                    when others => state <= WR;
                                end case;
                            -- or set an error
                            else
                                state <= ERROR;
                            end if;
                        end if;
                    -- Read the data line
                    when RD => 
                        -- On high clock, read data
                        if (high_clk = '1') then
                            -- Slave controls the line
                            dout(data_cnt) <= sda_miso_i;
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            -- If all the data has been read, send acknowledgment
                            if (data_cnt = 0) then
                                state <= ACK_1;
                            -- otherwise continue
                            else
                                data_cnt <= data_cnt - 1;
                            end if;
                        end if;
                    -- Send the read ackownledgment 
                    when ACK_1 => 
                        -- On the falling clock, take back control
                        if (falling_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= RST_1;
                        end if;                        
                    -- Wait for the clock to go low before sending the STOP signals, otherwise
                    -- the signal would be sent to soon
                    when RST_1 => 
                        -- Wait for a low clock
                        if (low_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= ENDING_RD;
                        end if;                        
                    -- Wait for the clock to go low before sending the STOP signals, otherwise
                    -- the signal would be sent to soon
                    when ENDING_RD => 
                        if (low_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= STOP;
                        end if;                        
                    -- Write data on the line
                    when WR => 
                        -- On the falling clock, change the data
                        if (falling_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= din(data_cnt);
                            sda_tri_o <= '0';
                            -- When no more data has to be sent, go for acknowledgment
                            if (data_cnt = 0) then
                                state <= RST_2;
                            -- or continue
                            else
                                data_cnt <= data_cnt - 1;
                            end if;
                        end if;                        
                    -- Give control of the line to the slave
                    when RST_2 => 
                        -- Wait for the falling clock
                        if (falling_clk = '1') then
                            -- Slave controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            state <= ACK_2;
                        end if;                        
                    -- Read the write ackownledgment
                    when ACK_2 => 
                        -- On the high clock
                        if (high_clk = '1') then
                            -- Slave controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            -- If the slave acknowledged, go for end of transaction
                            if (sda_miso_i = '0') then
                                state <= ENDING_WR;
                            -- or error
                            else
                                state <= ERROR;
                            end if;
                        end if;                        
                    -- Wait for the clock to go low before sending the STOP signals, otherwise
                    -- the signal would be sent to soon
                    when ENDING_WR => 
                        -- On the falling clock
                        if (falling_clk = '1') then
                            -- Master controls the line
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= STOP;
                        end if;                        
                    -- Send the stop signal
                    when STOP => 
                        -- On a high clock
                        if (high_clk = '1') then
                            -- Set the output busses
                            valid_o <= '1';
                            error_o <= '0';
                            case rw_n is
                                when '1' => data_o <= dout;
                                when others => data_o <= (others => '0');
                            end case;
                            -- Master controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '0';
                            -- Go back to IDLE state
                            state <= IDLE;
                        end if;                        
                    -- Set an error
                    when ERROR => 
                        -- Wait for high clock
                        if (high_clk = '1') then
                            -- Set the output busses
                            valid_o <= '0';
                            error_o <= '1';
                            data_o <= (others => '0');
                            -- Master controls the line
                            sda_mosi_o <= '1';
                            sda_tri_o <= '0';
                            -- Go back to IDLE state
                            state <= IDLE;
                        end if;                        
                    --
                    when others => 
                        valid_o <= '0';
                        error_o <= '0';
                        data_o <= (others => '0');
                        sda_mosi_o <= '1';
                        sda_tri_o <= '1';
                        state <= IDLE;
                        address <= (others => '0');
                        rw_n <= '0';
                        din <= (others => '0');
                        dout <= (others => '0');
                        address_cnt <= 0;
                        data_cnt <= 0;                        
                end case;  
            end if;
        end if;
    end process;
    
end Behavioral;