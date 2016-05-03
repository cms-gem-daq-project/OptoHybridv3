----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    link_tkdata - Behavioral 
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

entity link_tkdata is
port(

    ref_clk_i       : in std_logic;
    gtx_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    vfat2_t1_i      : in t1_t;
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    zero_suppress_i : in std_logic;
    
    evt_en_i        : in std_logic;
    evt_valid_o     : out std_logic;
    evt_data_o      : out std_logic_vector(223 downto 0)
    
);
end link_tkdata;

architecture Behavioral of link_tkdata is
      
    type state_t is (IDLE, REQ_BX, ACK_BX, SAVING);

    signal state        : state_t;
      
    signal vfat2_cnt    : integer range 0 to 23;
    signal last_cnt     : integer range 0 to 127;

    signal evt_data     : tk_data_array_t(23 downto 0); 
    signal evt_stb      : std_logic_vector(23 downto 0);
    signal evt_ack      : std_logic_vector(23 downto 0);
    
    signal evt_wr_en    : std_logic;
    signal evt_wr_data  : std_logic_vector(223 downto 0);
    
    signal bx_counter   : std_logic_vector(31 downto 0);
    signal last_bx      : std_logic_vector(31 downto 0);
    
    signal bx_rd_en     : std_logic;
    signal bx_rd_data   : std_logic_vector(31 downto 0);
    signal bx_rd_valid  : std_logic;
    signal bx_rd_err    : std_logic;
    
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
                last_cnt <= 0;
                evt_ack <= (others => '0');
                evt_wr_en <= '0';
                evt_wr_data <= (others => '0');
                last_bx <= (others => '0');
                bx_rd_en <= '0';
            else
                case state is                     
                    when IDLE =>                
                        -- Data is ready
                        if (evt_stb(vfat2_cnt) = '1' and evt_ack(vfat2_cnt) = '0') then
                            evt_ack(vfat2_cnt) <= '1';
                            -- Check if require new BX
                            if (last_cnt = 0) then
                                last_cnt <= 127;
                                state <= REQ_BX;
                            else
                                state <= SAVING;
                            end if;
                        else
                            -- Reset strobe
                            if (evt_stb(vfat2_cnt) = '0' and evt_ack(vfat2_cnt) = '1') then
                                evt_ack(vfat2_cnt) <= '0';
                            end if;
                            -- Rotate VFAT2s
                            if (vfat2_cnt = 23) then
                                vfat2_cnt <= 0;
                            else
                                vfat2_cnt <= vfat2_cnt + 1;
                            end if;
                            -- Decrease last BX counter
                            if (last_cnt /= 0) then
                                last_cnt <= last_cnt - 1;
                            end if;
                        end if;  
                        evt_wr_en <= '0';  
                        bx_rd_en <= '0';
                    when REQ_BX =>
                        evt_wr_en <= '0';  
                        bx_rd_en <= '1';
                        state <= ACK_BX;
                    when ACK_BX => 
                        if (bx_rd_valid = '1') then
                            last_bx <= bx_rd_data;
                            state <= SAVING;
                        elsif (bx_rd_err = '1') then
                            last_bx <= (others => '0');
                            state <= SAVING;
                        end if;
                        evt_wr_en <= '0';  
                        bx_rd_en <= '0';                        
                    when SAVING =>
                        bx_rd_en <= '0';
                        evt_wr_en <= '1';
                        evt_wr_data <= "1010" & evt_data(vfat2_cnt).bc & "1100" & evt_data(vfat2_cnt).ec & evt_data(vfat2_cnt).flags & "1110" & evt_data(vfat2_cnt).chip_id & evt_data(vfat2_cnt).strips(127 downto 0) & evt_data(vfat2_cnt).crc & last_bx;
                        state <= IDLE;                  
                    when others =>        
                        state <= IDLE;
                        vfat2_cnt <= 0;
                        last_cnt <= 0;
                        evt_ack <= (others => '0');
                        evt_wr_en <= '0';
                        evt_wr_data <= (others => '0');
                        last_bx <= (others => '0');
                        bx_rd_en <= '0';
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
        rd_en   => evt_en_i,
        valid   => evt_valid_o,
        dout    => evt_data_o,
        full    => open,
        empty   => open
    );
    
    --== BX FIFO ==--
    
    bx_counter_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (reset_i or vfat2_t1_i.resync or vfat2_t1_i.bc0), en_i => '1', data_o => bx_counter);
    
    fifo256x32_inst : entity work.fifo256x32
    port map(
        clk         => ref_clk_i,
        rst         => reset_i,
        wr_en       => vfat2_t1_i.lv1a,
        din         => bx_counter,
        rd_en       => bx_rd_en,
        valid       => bx_rd_valid,
        dout        => bx_rd_data,
        underflow   => bx_rd_err,
        full        => open,
        empty       => open
    );    
    
end Behavioral;