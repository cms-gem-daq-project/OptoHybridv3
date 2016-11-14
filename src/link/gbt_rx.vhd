----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    08:37:33 07/07/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    gbt_rx_tracking - Behavioral
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity gbt_rx is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic_vector(15 downto 0);
    valid_i         : in std_logic;

    vfat2_t1_o      : out t1_t;

    req_en_o        : out std_logic;
    req_data_o      : out std_logic_vector(64 downto 0);

    error_o         : out std_logic;
    
    sync_reset_o    : out std_logic
    
);
end gbt_rx ;

architecture Behavioral of gbt_rx is

    type state_t is (SYNCING, FRAME_BEGIN, ADDR_0, ADDR_1, FRAME_MIDDLE, DATA_0, DATA_1, FRAME_END);

    signal state        : state_t;

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(64 downto 0);

    signal sync_req_cnt : integer range 0 to 127 := 0;
    
begin

    --== STATE ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING => state <= FRAME_END; -- start by looking at the FRAME_END as it contains a fixed value
                    when FRAME_BEGIN => state <= ADDR_0;
                    when ADDR_0 => state <= ADDR_1;
                    when ADDR_1 => state <= FRAME_MIDDLE;
                    when FRAME_MIDDLE => state <= DATA_0;
                    when DATA_0 => state <= DATA_1;
                    when DATA_1 => state <= FRAME_END;
                    when FRAME_END => 
                        if (data_i(11 downto 0) = x"ABC") then
                            state <= FRAME_BEGIN;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== ERROR ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                error_o <= '0';
            else
                case state is
                    when FRAME_END => 
                        if (data_i(11 downto 0) = x"ABC") then
                            error_o <= '0';
                        else
                            error_o <= '1';
                        end if;
                    when others => error_o <= '0';
                end case;
            end if;
        end if;
    end process;
    
    --== TTC ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
            else
                case state is
                    when SYNCING =>
                        vfat2_t1_o <= (lv1a => '0', calpulse => '0', resync => '0', bc0 => '0');
                    when others  =>                        
                        vfat2_t1_o <= (lv1a => data_i(15), calpulse => data_i(14), resync => data_i(13), bc0 => data_i(12));
                end case;
            end if;
        end if;
    end process;    

    --== REQUEST ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                req_en_o <= '0';
                req_data_o <= (others => '0');
                req_valid <= '0';
                req_data <= (others => '0');
            else
                case state is
                    when FRAME_BEGIN =>
                        req_en_o <= '0';
                        req_valid <= data_i(11);
                        req_data(64) <= data_i(10);
                        req_data(63 downto 56) <= data_i(7 downto 0);    
                    when ADDR_0 =>
                        req_data(55 downto 44) <= data_i(11 downto 0);
                    when ADDR_1 =>
                        req_data(43 downto 32) <= data_i(11 downto 0);
                    when FRAME_MIDDLE =>
                        req_data(31 downto 24) <= data_i(7 downto 0);
                    when DATA_0 =>
                        req_data(23 downto 12) <= data_i(11 downto 0);
                    when DATA_1 =>
                        req_data(11 downto 0) <= data_i(11 downto 0);
                    when FRAME_END =>
                        req_en_o <= req_valid;
                        req_data_o <= req_data;
                    when others =>
                        req_en_o <= '0';
                        req_valid <= '0';
                end case;
            end if;
        end if;
    end process;

    --== SYNC RESET REQUEST ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (data_i = x"ffff") then
                sync_req_cnt <= sync_req_cnt + 1;
            else
                sync_req_cnt <= 0;
            end if;
            
            if (sync_req_cnt >= 100) then
                sync_reset_o <= '1';
            else
                sync_reset_o <= '0';
            end if;
        end if;
    end process;   

end Behavioral;
