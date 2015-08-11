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
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity i2c is
generic(

    CLK_DIV     : integer := 400

);
port(

    clk_i       : in std_logic;
    reset_i     : in std_logic;
    
    en_i        : in std_logic;
    address_i   : in std_logic_vector(6 downto 0);
    rw_i        : in std_logic;
    data_i      : in std_logic_vector(7 downto 0);
    
    valid_o     : out std_logic;
    error_o     : out std_logic;
    data_o      : out std_logic_vector(7 downto 0);
    
    scl_o       : out std_logic;
    sda_miso_i  : in std_logic;
    sda_mosi_o  : out std_logic;
    sda_tri_o   : out std_logic
    
);
end i2c;

architecture Behavioral of i2c is
    
    type state_t is (IDLE, START, ADDR, RW, WAIT_0, ACK_0, RD, ACK_1, RST_1, ENDING_RD, WR, RST_2, ACK_2, ENDING_WR, STOP, ERROR);
    
    signal state        : state_t;
    
    signal clk_divider  : integer range 0 to CLK_DIV;
    signal rising_clk   : std_logic;
    signal high_clk     : std_logic;
    signal falling_clk  : std_logic;
    signal low_clk      : std_logic;
    
    signal address      : std_logic_vector(6 downto 0);
    signal rw_n         : std_logic;
    signal din          : std_logic_vector(7 downto 0);
    signal dout         : std_logic_vector(7 downto 0);
    
    signal address_cnt  : integer range 0 to 6;
    signal data_cnt     : integer range 0 to 7;

begin

    --=========--
    --== SCK ==--
    --=========--
    
    process(clk_i)
    begin
        if (rising_edge(clk_i)) then
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
    
    process(clk_i)
    begin    
        if (rising_edge(clk_i)) then
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
                    -- IDLE
                    when IDLE =>
                        valid_o <= '0';
                        error_o <= '0';
                        sda_mosi_o <= '1';
                        sda_tri_o <= '0';
                        if (en_i = '1') then
                            state <= START;
                            address <= address_i;
                            rw_n <= rw_i;
                            din <= data_i;
                        end if;
                    -- Start
                    when START =>
                        if (high_clk = '1') then
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= ADDR;
                            address_cnt <= 6;
                        end if;
                    -- Address
                    when ADDR => 
                        if (low_clk = '1') then
                            sda_mosi_o <= address(address_cnt);
                            sda_tri_o <= '0';
                            if (address_cnt = 0) then
                                state <= RW;
                            else
                                address_cnt <= address_cnt - 1;
                            end if;
                        end if;
                    -- RW bit
                    when RW => 
                        if (low_clk = '1') then
                            sda_mosi_o <= rw_n;
                            sda_tri_o <= '0';
                            state <= WAIT_0;
                        end if;
                    -- Wait (free the bus for slave to write)
                    when WAIT_0 => 
                        if (falling_clk = '1') then -- low_clk
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            state <= ACK_0;
                        end if;
                    -- Ackownledgment (to be read)
                    when ACK_0 =>
                        if (high_clk = '1') then
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            data_cnt <= 7;
                            if (sda_miso_i = '0') then
                                case rw_n is
                                    when '1' => state <= RD;
                                    when others => state <= WR;
                                end case;
                            else
                                state <= ERROR;
                            end if;
                        end if;
                    -- Read
                    when RD => 
                        if (high_clk = '1') then
                            dout(data_cnt) <= sda_miso_i;
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            if (data_cnt = 0) then
                                state <= ACK_1;
                            else
                                data_cnt <= data_cnt - 1;
                            end if;
                        end if;
                    -- Read Ackownledgment (to be written) 
                    when ACK_1 => 
                        if (falling_clk = '1') then
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= RST_1;
                        end if;
                    -- Wait
                    when RST_1 => 
                        if (low_clk = '1') then
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= ENDING_RD;
                        end if;
                    -- ENDING
                    when ENDING_RD => 
                        if (low_clk = '1') then
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= STOP;
                        end if;
                    -- Write
                    when WR => 
                        if (falling_clk = '1') then -- low_clk
                            sda_mosi_o <= din(data_cnt);
                            sda_tri_o <= '0';
                            if (data_cnt = 0) then
                                state <= RST_2;
                            else
                                data_cnt <= data_cnt - 1;
                            end if;
                        end if;
                    -- Wait (free the bus for slave to write)
                    when RST_2 => 
                        if (falling_clk = '1') then
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            state <= ACK_2;
                        end if;
                    -- Write Ackownledgment (to be read)
                    when ACK_2 => 
                        if (high_clk = '1') then
                            sda_mosi_o <= '1';
                            sda_tri_o <= '1';
                            if (sda_miso_i = '0') then
                                state <= ENDING_WR;
                            else
                                state <= ERROR;
                            end if;
                        end if;
                    -- ENDING
                    when ENDING_WR => 
                        if (falling_clk = '1') then
                            sda_mosi_o <= '0';
                            sda_tri_o <= '0';
                            state <= STOP;
                        end if;
                    -- STOP
                    when STOP => 
                        if (high_clk = '1') then
                            valid_o <= '1';
                            error_o <= '0';
                            case rw_n is
                                when '1' => data_o <= dout;
                                when others => data_o <= (others => '0');
                            end case;
                            sda_mosi_o <= '1';
                            sda_tri_o <= '0';
                            state <= IDLE;
                        end if;
                    -- ERROR
                    when ERROR => 
                        if (high_clk = '1') then
                            valid_o <= '0';
                            error_o <= '1';
                            data_o <= (others => '0');
                            sda_mosi_o <= '1';
                            sda_tri_o <= '0';
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