----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
--
-- Create Date:    08:37:33 07/07/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    tracking_concentrator - Behavioral
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

entity tracking_concentrator is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;

    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    zero_suppress_i : in std_logic;

    ec_bc_rd_o      : out std_logic;
    ec_bc_valid_i   : in std_logic;
    ec_bc_error_i   : in std_logic;
    ec_bc_data_i    : in std_logic_vector(31 downto 0);

    evt_wr_o        : out std_logic;
    evt_data_o      : out std_logic_vector(223 downto 0)

);
end tracking_concentrator;

architecture Behavioral of tracking_concentrator is

    type state_t is (IDLE, TIMEOUT, REQ_BX, ACK_BX, RUN, SAVING);

    signal state        : state_t;

    signal vfat2_cnt    : integer range 0 to 23;
    
    signal ec_bc        : std_logic_vector(31 downto 0);

    signal evt_data     : tk_data_array_t(23 downto 0);
    signal evt_stb      : std_logic_vector(23 downto 0);
    signal evt_ack      : std_logic_vector(23 downto 0);

begin

    --== Store the tracking data in a temporary buffer ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                evt_data <= (others => (valid => '0', bc => (others => '0'), ec => (others => '0'), flags => (others => '0'), chip_id => (others => '0'), strips => (others => '0'), crc => (others => '0'), crc_ok => '0', hit => '0'));
                evt_stb <= (others => '0');
            else
                for I in 0 to 23 loop
                    if (evt_stb(I) = '0' and evt_ack(I) = '0') then
                        if (vfat2_tk_data_i(I).valid = '1' and vfat2_tk_mask_i(I) = '0') then
                            if (zero_suppress_i = '1' and vfat2_tk_data_i(I).hit = '1') then
                                evt_data(I) <= vfat2_tk_data_i(I);
                                evt_stb(I) <= '1';
                            elsif (zero_suppress_i = '0') then
                                evt_data(I) <= vfat2_tk_data_i(I);
                                evt_stb(I) <= '1';
                            end if;
                        end if;
                    elsif (evt_stb(I) = '1' and evt_ack(I) = '1') then
                        evt_stb(I) <= '0';
                    end if;
                end loop;
            end if;
        end if;
    end process;

    --== Push the tracking data in the FIFO ==--
    
    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                state <= IDLE;
                vfat2_cnt <= 0;
                evt_ack <= (others => '0');
                ec_bc <= (others => '0');
                ec_bc_rd_o <= '0';
                evt_wr_o <= '0';
                evt_data_o <= (others => '0');
            else
                case state is
                    when IDLE =>
                        -- Data is ready
                        if (evt_stb /= x"000000") then
                            vfat2_cnt <= 0;
                            state <= TIMEOUT;
                        end if;
                        evt_wr_o <= '0';
                    when TIMEOUT => 
                        if (vfat2_cnt = 5) then
                            vfat2_cnt <= 0;
                            state <= REQ_BX;
                        else 
                            vfat2_cnt <= vfat2_cnt + 1;
                        end if;
                    when REQ_BX =>
                        ec_bc_rd_o <= '1';
                        state <= ACK_BX;
                    when ACK_BX =>
                        ec_bc_rd_o <= '0';
                        if (ec_bc_valid_i = '1') then
                            ec_bc <= ec_bc_data_i;
                            state <= RUN;
                        elsif (ec_bc_error_i = '1') then
                            ec_bc <= (others => '0');
                            state <= RUN;
                        end if;
                    when RUN =>
                        if (evt_stb(vfat2_cnt) = '1' and evt_ack(vfat2_cnt) = '0') then
                            evt_ack(vfat2_cnt) <= '1';
                            state <= SAVING;
                        else
                            evt_ack(vfat2_cnt) <= '0';
                            -- Rotate VFAT2s
                            if (vfat2_cnt = 23) then
                                state <= IDLE;
                            else
                                vfat2_cnt <= vfat2_cnt + 1;
                            end if;
                        end if;
                        evt_wr_o <= '0';
                    when SAVING =>
                        evt_wr_o <= '1';
                        evt_data_o <= "1010" & evt_data(vfat2_cnt).bc & "1100" & evt_data(vfat2_cnt).ec & evt_data(vfat2_cnt).flags & "1110" & evt_data(vfat2_cnt).chip_id & evt_data(vfat2_cnt).strips(127 downto 0) & evt_data(vfat2_cnt).crc & ec_bc;
                        -- Rotate VFAT2s
                        evt_ack(vfat2_cnt) <= '0';
                        if (vfat2_cnt = 23) then
                            state <= IDLE;
                        else
                            vfat2_cnt <= vfat2_cnt + 1;
                            state <= RUN;
                        end if;
                    when others =>
                        state <= IDLE;
                        vfat2_cnt <= 0;
                        evt_ack <= (others => '0');
                        ec_bc <= (others => '0');
                        ec_bc_rd_o <= '0';
                        evt_wr_o <= '0';
                        evt_data_o <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;
