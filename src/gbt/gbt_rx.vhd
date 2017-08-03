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

entity gbt_rx is
    generic(
        g_16BIT : boolean := true
    );
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
    reset_fats_o    : out std_logic;

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

    type state_t is (SYNCING, FRAME_BEGIN, ADDR_0, ADDR_1, ADDR_2, ADDR_3, ADDR_4, DATA_0, DATA_1, DATA_2, DATA_3, DATA_4, FRAME_END);

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(64 downto 0);

    signal state        : state_t;

    signal sync_req_cnt : integer range 0 to 127 := 0;

    signal frame_end_valid : boolean;

begin

    --== STATE ==--

    -- 10 bit decoding (1 320 MHz e-link, 1 80 MHz e-link)

    g_ten_seq : IF (not g_16BIT) GENERATE

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING      =>
                        if (frame_end_valid) then
                            state <= FRAME_BEGIN;
                        end if;
                    when FRAME_BEGIN  => state <= ADDR_0;
                    when ADDR_0       => state <= ADDR_1;
                    when ADDR_1       => state <= ADDR_2;
                    when ADDR_2       => state <= ADDR_3;
                    when ADDR_3       => state <= ADDR_4;
                    when ADDR_4       => state <= DATA_0;
                    when DATA_0       => state <= DATA_1;
                    when DATA_1       => state <= DATA_2;
                    when DATA_2       => state <= DATA_3;
                    when DATA_3       => state <= DATA_4;
                    when DATA_4       => state <= FRAME_END;
                    when FRAME_END    =>
                        if (frame_end_valid) then
                            state <= FRAME_BEGIN;
                        else
                            state <= SYNCING;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    END GENERATE g_ten_seq;

    -- 16 bit decoding (two 320 MHz e-links)

    g_sixteen_seq : IF (g_16BIT) GENERATE

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset_i = '1' or valid_i = '0') then
                state <= SYNCING;
            else
                case state is
                    when SYNCING      =>
                        if (frame_end_valid) then
                            state <= FRAME_BEGIN;
                        end if;
                    when FRAME_BEGIN  => state <= ADDR_0;
                    when ADDR_0       => state <= ADDR_1;
                    when ADDR_1       => state <= DATA_0;
                    when DATA_0       => state <= DATA_1;
                    when DATA_1       => state <= DATA_2;
                    when DATA_2       => state <= FRAME_END;
                    when FRAME_END    =>
                        if (frame_end_valid) then
                            state <= FRAME_BEGIN;
                        else
                            state <= SYNCING;
                        end if;
                    when others => state <= SYNCING;
                end case;
            end if;
        end if;
    end process;

    END GENERATE g_sixteen_seq;

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
                        l1a_o        <= '0';
                        reset_fats_o <= '0';
                        resync_o     <= '0';
                        bc0_o        <= '0';
                    when others  =>
                        l1a_o        <= data_i(15);
                        reset_fats_o <= data_i(14);
                        resync_o     <= data_i(13);
                        bc0_o        <= data_i(12);
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

    --== REQUEST ==--

    g_ten : IF (not g_16BIT) GENERATE

    -- use a 6 bit end frame symbol
    frame_end_valid <= data_i(11 downto 8) & data_i (6) & data_i(2) = x"A" & "10";

    process(clock)
    begin
        if (rising_edge(clock)) then
            if (reset_i = '1') then
                req_en_o   <= '0';
                req_data_o <= (others => '0');
                req_valid  <= '0';
                req_data   <= (others => '0');
            else
                case state is
                    when FRAME_BEGIN =>
                                   req_en_o               <= '0';
                                   req_valid              <= data_i(11);            -- request valid
                                   req_data(64)           <= data_i(10);            -- write enable
                                   req_data(63 downto 62) <= data_i(9 downto 8);    -- address[31:30]
                                   req_data(61 downto 60) <= data_i(6) & data_i(2); -- address[29:28]
                    when ADDR_0 =>
                                   req_data(59 downto 56) <= data_i(11 downto 8);   -- address[27:24]
                                   req_data(55 downto 54) <= data_i(6) & data_i(2); -- address[23:22]
                    when ADDR_1 =>
                                   req_data(53 downto 50) <= data_i(11 downto 8);   -- address[21:18]
                                   req_data(49 downto 48) <= data_i(6) & data_i(2); -- address[17:16]
                    when ADDR_2 =>
                                   req_data(47 downto 44) <= data_i(11 downto 8);   -- address[15:12]
                                   req_data(43 downto 42) <= data_i(6) & data_i(2); -- address[11:10]
                    when ADDR_3 =>
                                   req_data(41 downto 38) <= data_i(11 downto 8);   -- address[9:6]
                                   req_data(37 downto 36) <= data_i(6) & data_i(2); -- address[5:4]
                    when ADDR_4 =>
                                   req_data(35 downto 32) <= data_i(11 downto 8);   -- address[3:0]
                                   req_data(31 downto 30) <= data_i(6) & data_i(2); -- data[31:30]
                    when DATA_0 =>
                                   req_data(29 downto 26) <= data_i(11 downto 8);   -- data[29:26]
                                   req_data(25 downto 24) <= data_i(6) & data_i(2); -- data[25:24]
                    when DATA_1 =>
                                   req_data(23 downto 20) <= data_i(11 downto 8);   -- data[23:20]
                                   req_data(19 downto 18) <= data_i(6) & data_i(2); -- data[19:18]
                    when DATA_2 =>
                                   req_data(17 downto 14) <= data_i(11 downto 8);   -- data[17:14]
                                   req_data(13 downto 12) <= data_i(6) & data_i(2); -- data[13:12]
                    when DATA_3 =>
                                   req_data(11 downto  8) <= data_i(11 downto 8);   -- data[11:8]
                                   req_data(7  downto  6) <= data_i(6) & data_i(2); -- data[7:6]
                    when DATA_4 =>
                                   req_data(5  downto  2) <= data_i(11 downto 8);   -- data[5:2]
                                   req_data(1  downto  0) <= data_i(6) & data_i(2); -- data[1:0]

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

    g_sixteen : IF (g_16BIT) GENERATE

    frame_end_valid <= data_i(11 downto 0) = x"ABC";

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
                                   req_en_o               <= '0';
                                   req_valid              <= data_i(11);          -- request valid
                                   req_data(64)           <= data_i(10);          -- write enable
                                   req_data(63 downto 56) <= data_i(7 downto 0);  -- address[31:24]
                    when ADDR_0 => req_data(55 downto 44) <= data_i(11 downto 0); -- address[23:12]
                    when ADDR_1 => req_data(43 downto 32) <= data_i(11 downto 0); -- address[11:0]
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

    sync_reset_o <= '0';

end Behavioral;
