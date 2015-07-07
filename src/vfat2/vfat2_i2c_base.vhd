----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_i2c_base - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles I2C communications with the VFAT2
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

entity vfat2_i2c_base is
generic(
    DIV         : integer := 400
);
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    en_i        : in std_logic;
    address_i   : in std_logic_vector(6 downto 0);
    rw_i        : in std_logic;
    data_i      : in std_logic_vector(7 downto 0);
    
    busy_o      : out std_logic;
    valid_o     : out std_logic;
    data_o      : out std_logic_vector(7 downto 0);
    
    scl_o       : out std_logic;
    sda_i       : in std_logic;
    sda_o       : out std_logic;
    sda_t       : out std_logic
    
);
end vfat2_i2c_base;

architecture Behavioral of vfat2_i2c_base is
    
    type states is (IDLE, START, ADDRESS, RW, RST_0, ACK_0, RD, ACK_1, WR, ACK_2, STOP);
    
    signal state            : states;
    
    signal clk_divider      : integer range 0 to DIV;
    signal high_clk_pulse   : std_logic;
    signal low_clk_pulse    : std_logic;
    
    signal address          : std_logic_vector(6 downto 0);
    signal rw               : std_logic;
    signal din              : std_logic_vector(7 downto 0);
    signal dout             : std_logic_vector(7 downto 0);
    
    signal address_cnt      : integer range 0 to 6;
    signal data_cnt         : integer range 0 to 7;

begin

    --== Clocking and pulses ==--
    
    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                clk_divider <= 0;
                scl_o <= '0';
                high_clk_pulse <= '0';
                low_clk_pulse <= '0';
            else
                -- Counting
                if (clk_divider = (DIV - 1)) then
                    clk_divider <= 0;
                else
                    clk_divider <= clk_divier + 1;
                end if;
                -- SCK generation
                if (clk_divider < (DIV - 1) / 2) then
                    scl_o <= '1';
                else
                    scl_o <= '0';
                end if;
                -- Start / Stop pulse & Read pulse
                if (clk_divider = (DIV - 1) / 4) then
                    high_clk_pulse <= '1';
                else
                    high_clk_pulse <= '0';
                end if;
                -- Data pulse
                if (clk_divider = (DIV - 1) * 3 / 4) then
                    low_clk_pulse <= '1';
                else
                    low_clk_pulse <= '0';
                end if;
            end if;
        end if;
    end process;
    
    
    --== State switching ==--

    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                sda_o <= 'Z';
                sda_t <= '1';
                state <= IDLE;
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        if (en_i = '1') then
                            state <= START;
                            address <= address_i;
                            rw <= rw_i;
                            din <= data_i;
                        else
                            state <= IDLE;
                        end if;
                        sda_o <= '1';
                        sda_t <= '0';
                    -- Start
                    when START =>
                        if (high_clk_pulse = '1') then
                            state <= ADDRESS;
                            sda_o <= '0';
                            sda_t <= '0';
                            address_cnt <= 0;
                        end if;
                    -- Address
                    when ADDRESS => 
                        if (low_clk_pulse = '1') then
                            sda_o <= address(address_cnt);
                            sda_t <= '0';
                            if (address_cnt = 7) then
                                state <= RW;
                            else
                                state <= ADDRESS;
                                address_cnt <= address_cnt + 1;
                            end if;
                        end if;
                    -- RW bit
                    when RW => 
                        if (low_clk_pulse = '1') then
                            sda_o <= rw;
                            sda_t <= '0';
                            state <= RST_0;
                        end if;
                    -- Wait
                    when RST_0 => 
                        if (low_clk_pulse = '1') then
                            sda_o <= 'Z';
                            sda_t <= '1';
                            state <= ACK_0;
                        end if;
                    -- Ackownledgment
                    when ACK_0 =>
                        if (high_clk_pulse = '1') then
                            state <= ADDRESS;
                            sda_o <= 'Z';
                            sda_t <= '1';
                            data_cnt <= 0;
                            if (sda_i = '1') then
                                case rw is
                                    when '1' => state <= RD;
                                    when others => state <= WR;
                                end case;
                            else
                                state <= STOP;
                            end if;
                        end if;
                    -- Read
                    when RD => 
                        if (high_clk_pulse = '1') then
                            dout(data_cnt) <= sda_i;
                            sda_o <= 'Z';
                            sda_t <= '1';
                            if (data_cnt = 7) then
                                state <= ACK_1;
                            else
                                state <= RD;
                                data_cnt <= data_cnt + 1;
                            end if;
                        end if;
                    -- Ackownledgment
                    when ACK_1 => 
                        if (low_clk_pulse = '1') then
                            sda_o <= '1';
                            sda_t <= '0';
                            state <= STOP;
                        end if;
                    --
                    when others => state <= IDLE;
                end case;  
            end if;
        end if;
    end process;
    
end Behavioral;