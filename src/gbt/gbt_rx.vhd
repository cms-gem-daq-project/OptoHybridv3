----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Rx Parser
-- 2017/07/24 -- Removal of VFAT2 event building
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

entity gbt_rx is
port(

    -- reset
    reset_i         : in std_logic;

    -- 40 MHz fabric clock
    clock         : in std_logic;

    -- parallel data input from deserializer
    data_i          : in std_logic_vector(15 downto 0);
    valid_i         : in std_logic;

    -- decoded ttc commands
    l1a_o           : out std_logic;
    bc0_o           : out std_logic;
    resync_o        : out std_logic;

    -- 65 bit output packet to fifo
    req_en_o        : out std_logic;
    req_data_o      : out std_logic_vector(64 downto 0);

    -- status
    error_o         : out std_logic;

    -- slow reset output
    sync_reset_o    : out std_logic

);
end gbt_rx ;

architecture Behavioral of gbt_rx is

    type state_t is (SYNCING, FRAME_BEGIN, ADDR_0, ADDR_1, FRAME_MIDDLE, DATA_0, DATA_1, FRAME_END);

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(64 downto 0);

    signal state        : state_t;

    signal sync_req_cnt : integer range 0 to 127 := 0;

begin

    --== STATE ==--

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING      => state <= FRAME_END; -- start by looking at the FRAME_END as it contains a fixed value
                    when FRAME_BEGIN  => state <= ADDR_0;
                    when ADDR_0       => state <= ADDR_1;
                    when ADDR_1       => state <= FRAME_MIDDLE;
                    when FRAME_MIDDLE => state <= DATA_0;
                    when DATA_0       => state <= DATA_1;
                    when DATA_1       => state <= FRAME_END;
                    when FRAME_END    =>
                        if (data_i(11 downto 0) = x"ABC") then
                            state <= FRAME_BEGIN;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== ERROR ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
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

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset_i = '1') then
                l1a_o    <= '0';
                resync_o <= '0';
                bc0_o    <= '0';
            else
                case state is
                    when SYNCING =>
                        l1a_o    <= '0';
                        resync_o <= '0';
                        bc0_o    <= '0';
                    when others  =>
                        l1a_o    <= data_i(15);
                        resync_o <= data_i(13);
                        bc0_o    <= data_i(12);
                end case;
            end if;
        end if;
    end process;

    --== REQUEST ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
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

    -- this logic is seriously fucked
    -- reset the serdes if we receive enough ffffs but these are inverted so
    -- that is just receive enough zeroes and we suicide. disable for now... don't see why this is needed anyway

    -- process(clock)
    -- begin
    --     if (rising_edge(clock)) then
    --         if (data_i = x"ffff") then
    --             sync_req_cnt <= sync_req_cnt + 1;
    --         else
    --             sync_req_cnt <= 0;
    --         end if;

    --         if (sync_req_cnt >= 100) then
    --             sync_reset_o <= '1';
    --         else
    --             sync_reset_o <= '0';
    --         end if;
    --     end if;
    -- end process;

    sync_reset_o <= '0';

end Behavioral;
