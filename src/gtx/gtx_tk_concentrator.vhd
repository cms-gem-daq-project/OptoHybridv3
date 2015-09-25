----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_tk_concentrator - Behavioral 
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

entity gtx_tk_concentrator is
port(

    ref_clk_i       : in std_logic;
    gtx_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    
    evt_rd_en_i     : in std_logic;
    evt_rd_valid_o  : out std_logic;
    evt_rd_data_o   : out std_logic_vector(15 downto 0);
    evt_rd_ready_o  : out std_logic
    
);
end gtx_tk_concentrator;

architecture Behavioral of gtx_tk_concentrator is
      
    type state_t is (IDLE, DELAY_0, DELAY_1, LOOPING, SAVING_0, SAVING_1, SAVING_2);

    signal state        : state_t;
      
    signal vfat2_cnt    : integer range 0 to 23;

    signal evt_data     : tk_data_array_t(23 downto 0);    
    signal evt_stb      : std_logic_vector(23 downto 0);
    signal evt_ack      : std_logic_vector(23 downto 0);
    
    signal evt_wr_en    : std_logic;
    signal evt_wr_data  : std_logic_vector(63 downto 0);
    
    signal evt_empty    : std_logic;
    signal evt_busy     : std_logic;
    
begin

    evt_rd_ready_o <= (not evt_busy) and (not evt_empty);

    --== Store the tracking data ==--

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
                            evt_data(I) <= vfat2_tk_data_i(I);
                            evt_stb(I) <= '1';
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
                evt_wr_en <= '0';
                evt_wr_data <= (others => '0');
                evt_busy <= '0';
            else
                case state is
                    when IDLE =>
                        if (evt_stb /= x"000000") then
                            state <= DELAY_0;
                            evt_busy <= '1';
                        else
                            evt_busy <= '0';
                        end if;
                    when DELAY_0 => state <= DELAY_1;
                    when DELAY_1 => state <= LOOPING;                        
                    when LOOPING =>                
                        -- Check the strobe
                        if (evt_stb(vfat2_cnt) = '1' and evt_ack(vfat2_cnt) = '0') then
                            evt_ack(vfat2_cnt) <= '1';
                            state <= SAVING_0;
                        elsif (evt_stb(vfat2_cnt) = '0' and evt_ack(vfat2_cnt) = '1') then
                            evt_ack(vfat2_cnt) <= '0';
                        else
                            if (vfat2_cnt = 23) then
                                vfat2_cnt <= 0;
                                state <= IDLE;
                            else
                                vfat2_cnt <= vfat2_cnt + 1;
                            end if;
                        end if; 
                        evt_wr_en <= '0';   
                    when SAVING_0 =>
                        evt_wr_en <= '1';
                        evt_wr_data <= "1010" & evt_data(vfat2_cnt).bc & "1100" & evt_data(vfat2_cnt).ec & evt_data(vfat2_cnt).flags & "1110" & evt_data(vfat2_cnt).chip_id & evt_data(vfat2_cnt).strips(127 downto 112);
                        state <= SAVING_1;
                    when SAVING_1 =>
                        evt_wr_en <= '1';
                        evt_wr_data <= evt_data(vfat2_cnt).strips(111 downto 48);
                        state <= SAVING_2;
                    when SAVING_2 =>
                        evt_wr_en <= '1';
                        evt_wr_data <= evt_data(vfat2_cnt).strips(47 downto 0) & evt_data(vfat2_cnt).crc;
                        state <= LOOPING;                    
                    when others =>        
                        state <= IDLE;
                        vfat2_cnt <= 0;
                        evt_ack <= (others => '0');
                        evt_wr_en <= '0';
                        evt_wr_data <= (others => '0');
                        evt_busy <= '0';
                end case;                  
            end if;        
        end if;    
    end process;    
    
    --== FIFO ==--
    
    fifo128x64_inst : entity work.fifo128x64
    port map(
        rst     => reset_i,
        wr_clk  => ref_clk_i,
        wr_en   => evt_wr_en,
        din     => evt_wr_data,        
        rd_clk  => gtx_clk_i,
        rd_en   => evt_rd_en_i,
        valid   => evt_rd_valid_o,
        dout    => evt_rd_data_o,
        full    => open,
        empty   => evt_empty
    );
    
end Behavioral;