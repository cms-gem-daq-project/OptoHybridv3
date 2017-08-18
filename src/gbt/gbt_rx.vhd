----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Rx Parser
-- T. Lenzi, E. Juska, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module decodes received GBT frames and outputs a 65 bit wishbone request
----------------------------------------------------------------------------------
-- 2017/07/24 -- Removal of VFAT2 event building
-- 2017/08/03 -- Addition of 10 bit decoding for OHv3a w/ 1x 80Mhz + 1x 320 Mhz
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

library work;
use work.wb_pkg.all;

entity gbt_rx is
    generic(
        g_16BIT : boolean := false
    );
port(

    -- reset
    reset_i         : in std_logic;

    -- 40 MHz fabric clock
    clock         : in std_logic;

    -- parallel data input from deserializer
    data_i          : in std_logic_vector(15 downto 0);

    -- decoded ttc commands
    l1a_o           : out std_logic;
    bc0_o           : out std_logic;
    resync_o        : out std_logic;
    reset_vfats_o   : out std_logic;

    -- 65 bit output packet to fifo
    req_en_o        : out std_logic;
    req_data_o      : out std_logic_vector(WB_REQ_BITS-1 downto 0);

    -- status
    error_o         : out std_logic

);
end gbt_rx ;

architecture Behavioral of gbt_rx is

    type state_t is (SYNCING, FRAME_BEGIN, ADDR_0, ADDR_1, ADDR_2, DATA_0, DATA_1, DATA_2, DATA_3, DATA_4, FRAME_END);

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(WB_REQ_BITS-1 downto 0);

    signal state        : state_t;

    signal sync_req_cnt : integer range 0 to 127 := 0;

    signal data6 : std_logic_vector (5 downto 0);

    signal sync_valid : boolean;

    signal reset : std_logic;

begin

    -- fanout reset tree

    process (clock) begin
        if (rising_edge(clock)) then
            reset <= reset_i;
        end if;
    end process;

    --== ERROR ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
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
            if (reset = '1') then
                l1a_o    <= '0';
                resync_o <= '0';
                bc0_o    <= '0';
            else
                case state is
                    when SYNCING =>
                        l1a_o         <= '0';
                        reset_vfats_o <= '0';
                        resync_o      <= '0';
                        bc0_o         <= '0';
                    when others  =>
                        l1a_o         <= data_i(15);
                        reset_vfats_o <= data_i(14);
                        resync_o      <= data_i(13);
                        bc0_o         <= data_i(12);
                end case;
            end if;
        end if;
    end process;


    -- if 1 e-link is running at 80 MHz, we have 10 bits total.
    -- need to keep the ttc bits of course
    -- (keep calling that 15, 14, 13 12)
    -- then the data is 11,10,9,8 from the 320 MHz link and
    -- we choose the "centered" bits picked out from the 80MHz sample on the
    -- 320 MHz deserializer, or it should be 2,6

    --== STATE ==--

    -- 10 bit decoding (1 320 MHz e-link, 1 80 MHz e-link)

    g_ten : IF (not g_16BIT) GENERATE

    data6 <= data_i (11 downto 8) & data_i (6) & data_i(2);

    sync_valid <= (data6 = "101010"); -- use a 6 bit end frame symbol

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset = '1') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING      =>
                        if (sync_valid) then
                            state <= FRAME_BEGIN;
                        end if;
                    when FRAME_BEGIN  => state <= ADDR_0;
                    when ADDR_0       => state <= ADDR_1;
                    when ADDR_1       => state <= ADDR_2;
                    when ADDR_2       => state <= DATA_0;
                    when DATA_0       => state <= DATA_1;
                    when DATA_1       => state <= DATA_2;
                    when DATA_2       => state <= DATA_3;
                    when DATA_3       => state <= DATA_4;
                    when DATA_4       => state <= FRAME_END;
                    when FRAME_END    =>
                        if (sync_valid) then
                            state <= FRAME_BEGIN;
                        else
                            state <= SYNCING;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    --== REQUEST ==--

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                req_en_o   <= '0';
                req_data_o <= (others => '0');
                req_valid  <= '0';
                req_data   <= (others => '0');
            else
                case state is
                    when FRAME_BEGIN =>
                                   req_en_o               <= '0';
                                   req_valid              <= data6(5);              -- request valid
                                   req_data(48)           <= data6(4);              -- write enable
                                   -- reserved data6(3 downto 0);
                    when ADDR_0 =>
                                   req_data(47 downto 42) <= data6              ;   -- address[15:10]
                    when ADDR_1 =>
                                   req_data(41 downto 36) <= data6              ;   -- address[9:4]
                    when ADDR_2 =>
                                   req_data(35 downto 32) <= data6(5 downto 2)  ;   -- address[3:0]
                                   req_data(31 downto 30) <= data6(1 downto 0)  ;   -- data[31:30]
                    when DATA_0 =>
                                   req_data(29 downto 24) <= data6              ;   -- data[29:24]
                    when DATA_1 =>
                                   req_data(23 downto 18) <= data6              ;   -- data[23:18]
                    when DATA_2 =>
                                   req_data(17 downto 12) <= data6              ;   -- data[17:12]
                    when DATA_3 =>
                                   req_data(11 downto  6) <= data6              ;   -- data[11:6]
                    when DATA_4 =>
                                   req_data(5  downto  0) <= data6              ;   -- data[5:0]
                    when FRAME_END =>
                        req_en_o   <= req_valid; -- fifo_wr
                        req_data_o <= req_data;  -- 65 bit stable output (1 bit WE, 32 bit adr, 32 bit data)
                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';
                end case;
            end if;
        end if;
    end process;

    END GENERATE g_ten;

    -- 16 bit decoding (two 320 MHz e-links)

    g_sixteen : IF (g_16BIT) GENERATE

    data6 <= (others => '0'); -- not used in 16 bit mode

    sync_valid <= data_i(11 downto 0) = x"ABC"; -- 12 bit DAV

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset = '1') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING      =>
                        if (sync_valid) then
                            state <= FRAME_BEGIN;
                        end if;
                    when FRAME_BEGIN  => state <= ADDR_0;
                    when ADDR_0       => state <= DATA_0;
                    when DATA_0       => state <= DATA_1;
                    when DATA_1       => state <= DATA_2;
                    when DATA_2       => state <= FRAME_END;
                    when FRAME_END    =>
                        if (sync_valid) then
                            state <= FRAME_BEGIN;
                        else
                            state <= SYNCING;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset = '1') then
                req_en_o   <= '0';
                req_data_o <= (others => '0');
                req_valid  <= '0';
                req_data   <= (others => '0'); else
                case state is
                    when FRAME_BEGIN =>
                                   req_en_o               <= '0';
                                   req_valid              <= data_i(11);          -- request valid
                                   req_data(48)           <= data_i(10);          -- write enable
                                   -- reserved            <= data_i(9 downto 4)
                                   req_data(47 downto 44) <= data_i(3 downto 0);  -- address[15:12]
                    when ADDR_0 => req_data(43 downto 32) <= data_i(11 downto 0); -- address[11:0]
                    when DATA_0 => req_data(31 downto 24) <= data_i (7 downto 0); -- data [31:24]
                    when DATA_1 => req_data(23 downto 12) <= data_i(11 downto 0); -- data [23:12]
                    when DATA_2 => req_data(11 downto 0)  <= data_i(11 downto 0); -- data [11:0]

                    when FRAME_END =>
                        req_en_o   <= req_valid; -- fifo_wr
                        req_data_o <= req_data;  -- 65 bit stable output (1 bit WE, 32 bit adr, 32 bit data)
                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';
                end case;
            end if;
        end if;
    end process;

    END GENERATE g_sixteen;

    --== SYNC RESET REQUEST ==--

    -- reset the serdes if we receive enough ffffs but these are inverted so
    -- that is just receive enough zeroes and we suicide. disable for now... don't see why this is needed anyway
    -- but if it is, should use a better pattern.... e.g. trigger on 5555 or aaaa agnostic to alignment

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

end Behavioral;
