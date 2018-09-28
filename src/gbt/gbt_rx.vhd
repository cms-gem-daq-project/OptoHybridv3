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
-- 2017/11/07 -- Add idle state
-- 2018/09/27 -- Conversion to single-link 6b8b format
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;
use work.types_pkg.all;

library work;
use work.ipbus_pkg.all;

entity gbt_rx is
port(

    -- reset
    reset_i         : in std_logic;

    -- 40 MHz fabric clock
    clock         : in std_logic;

    -- parallel data input from deserializer
    data_i          : in std_logic_vector(7 downto 0);

    -- decoded ttc commands
    l1a_o           : out std_logic;
    bc0_o           : out std_logic;
    resync_o        : out std_logic;

    -- 49 bit output packet to fifo
    req_en_o        : out std_logic;
    req_data_o      : out std_logic_vector(WB_REQ_BITS-1 downto 0);

    -- status
    error_o         : out std_logic

);
end gbt_rx ;

architecture Behavioral of gbt_rx is

    type state_t is (ERR, IDLE, START, ADDR_0, ADDR_1, ADDR_2, DATA_0, DATA_1, DATA_2, DATA_3, DATA_4);

    signal req_valid    : std_logic;
    signal req_data     : std_logic_vector(WB_REQ_BITS-1 downto 0);

    signal state        : state_t;

    signal data6       : std_logic_vector (5 downto 0);
    signal data6_delay : std_logic_vector (5 downto 0);

    signal char_is_data    : std_logic;
    signal not_in_table    : std_logic;

    signal reset         : std_logic;

    signal last_data_frame : std_logic;

    signal l1a           : std_logic;
    signal bc0           : std_logic;
    signal idle_rx       : std_logic;
    signal resync        : std_logic;

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
            if     (reset = '1')  then error_o <= '0';
            elsif  (STATE=ERR)    then error_o <= '1';
            else                       error_o <= '0';
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
                l1a_o         <= l1a;
                resync_o      <= resync;
                bc0_o         <= bc0;
            end if;
        end if;
    end process;


    -- 8b to 6b conversion
    eightbit_sixbit_inst : entity work.eightbit_sixbit
    port map (
        eightbit     => data_i,
        sixbit       => data6,
        not_in_table => not_in_table,
        char_is_data => char_is_data,
        l1a          => l1a,
        bc0          => bc0,
        resync       => resync,
        idle         => idle_rx
    );

    process (clock) begin
        if (rising_edge(clock)) then
            -- only latch if char_is_data so that we can "pause" the sequencer if a ttc command is received
            -- during a packet
            if (char_is_data='1') then
                data6_delay <= data6;
            end if;
        end if;
    end process;

    process(clock)
    begin
        if (rising_edge(clock)) then

            if (reset = '1') then
                state <= IDLE;
            else
                case state is
                    when ERR =>
                        if (not_in_table='0') then
                            state <= IDLE;
                        end if;
                    when IDLE =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= START;
                        end if;
                    when START =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= ADDR_0;
                        end if;
                    when ADDR_0 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= ADDR_1;
                        end if;
                    when ADDR_1 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= ADDR_2;
                        end if;
                    when ADDR_2 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= DATA_0;
                        end if;
                    when DATA_0 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= DATA_1;
                        end if;
                    when DATA_1 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= DATA_2;
                        end if;
                    when DATA_2 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= DATA_3;
                        end if;
                    when DATA_3 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= DATA_4;
                        end if;
                    when DATA_4 =>
                        if    (not_in_table='1') then state <= ERR;
                        elsif (char_is_data='1') then state <= START;
                        elsif (idle_rx='1')      then state <= IDLE;
                        end if;
                    when others => state <= ERR;

                end case;
            end if;
        end if;
    end process;

    --== REQUEST ==--

    process(clock)
    begin
        if (rising_edge(clock)) then

            -- latch request after data frame 4
             if (STATE = DATA_4) then
                 last_data_frame <= '1';
             else
                 last_data_frame <= '0';
            end if;

            if (last_data_frame='1') then
                    req_en_o   <= req_valid; -- fifo_wr
                    req_data_o <= req_data;  -- 49 bit stable output (1 bit WE, 16 bit adr, 32 bit data)
            end if;

            if (reset = '1') then
                req_en_o   <= '0';
                req_data_o <= (others => '0');
                req_valid  <= '0';
                req_data   <= (others => '0');
            else
                case state is
                    when IDLE  =>
                                   req_en_o               <= '0';
                                   req_valid              <= '0';
                                   req_data               <= (others => '0');
                    when START =>
                                   req_en_o               <= '0';
                                   req_valid              <= data6_delay(5);              -- request valid
                                   req_data(48)           <= data6_delay(4);              -- write enable
                                -- reserved               <= data6_delay(3 downto 0);
                    when ADDR_0 =>
                                   req_data(47 downto 42) <= data6_delay              ;   -- address[15:10]
                    when ADDR_1 =>
                                   req_data(41 downto 36) <= data6_delay              ;   -- address[9:4]
                    when ADDR_2 =>
                                   req_data(35 downto 32) <= data6_delay(5 downto 2)  ;   -- address[3:0]
                                   req_data(31 downto 30) <= data6_delay(1 downto 0)  ;   -- data[31:30]
                    when DATA_0 =>
                                   req_data(29 downto 24) <= data6_delay              ;   -- data[29:24]
                    when DATA_1 =>
                                   req_data(23 downto 18) <= data6_delay              ;   -- data[23:18]
                    when DATA_2 =>
                                   req_data(17 downto 12) <= data6_delay              ;   -- data[17:12]
                    when DATA_3 =>
                                   req_data(11 downto  6) <= data6_delay              ;   -- data[11:6]
                    when DATA_4 =>
                                   req_data(5  downto  0) <= data6_delay              ;   -- data[5:0]
                    when others =>
                        req_en_o  <= '0';
                        req_valid <= '0';
                end case;
            end if;
        end if;
    end process;


end Behavioral;
