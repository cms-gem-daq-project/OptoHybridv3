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
    
    tk_data_i       : in tk_data_array_t(23 downto 0);
    vfat2_tk_mask_i : in std_logic_vector(23 downto 0);
    
    tk_rd_en_i      : in std_logic;
    tk_rd_valid_o   : out std_logic;
    tk_rd_data_o    : out std_logic_vector(15 downto 0);
    tk_rd_csb_o     : out std_logic
    
);
end gtx_tk_concentrator;

architecture Behavioral of gtx_tk_concentrator is
      
    type state_t is (LOOPING, SAVING_0, SAVING_1, SAVING_2);

    signal state        : state_t;
      
    signal vfat2_cnt    : integer range 0 to 23;

    signal tk_data      : tk_data_array_t(23 downto 0);    
    signal tk_data_stb  : std_logic_vector(23 downto 0);
    signal tk_data_ack  : std_logic_vector(23 downto 0);
    
    signal tk_wr_en     : std_logic;
    signal tk_wr_data   : std_logic_vector(63 downto 0);
    
begin

    --== Store the tracking data ==--

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then        
            if (reset_i = '1') then
                tk_data <= (others => (valid => '0', bc => (others => '0'), ec => (others => '0'), flags => (others => '0'), chip_id => (others => '0'), strips => (others => '0'), crc => (others => '0'), crc_ok => '0'));
                tk_data_stb <= (others => '0');
            else
                for I in 0 to 23 loop
                    if (tk_data_stb(I) = '0' and tk_data_ack(I) = '0') then
                        if (tk_data_i(I).valid = '1' and vfat2_tk_mask_i(I) = '0') then
                            tk_data(I) <= tk_data_i(I);
                            tk_data_stb(I) <= '1';
                        end if;
                    elsif (tk_data_stb(I) = '1' and tk_data_ack(I) = '1') then
                        tk_data_stb(I) <= '0';
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
                state <= LOOPING;
                vfat2_cnt <= 0;
                tk_data_ack <= (others => '0');
                tk_wr_en <= '0';
                tk_wr_data <= (others => '0');
            else
                case state is
                    when LOOPING =>                
                        -- Check the strobe
                        if (tk_data_stb(vfat2_cnt) = '1' and tk_data_ack(vfat2_cnt) = '0') then
                            tk_data_ack(vfat2_cnt) <= '1';
                            state <= SAVING_0;
                        elsif (tk_data_stb(vfat2_cnt) = '0' and tk_data_ack(vfat2_cnt) = '1') then
                            tk_data_ack(vfat2_cnt) <= '0';
                        else
                            if (vfat2_cnt = 23) then
                                vfat2_cnt <= 0;
                            else
                                vfat2_cnt <= vfat2_cnt + 1;
                            end if;
                        end if; 
                        tk_wr_en <= '0';   
                    when SAVING_0 =>
                        tk_wr_en <= '1';
                        tk_wr_data <= "1010" & tk_data(vfat2_cnt).bc & "1100" & tk_data(vfat2_cnt).ec & tk_data(vfat2_cnt).flags & "1110" & tk_data(vfat2_cnt).chip_id & tk_data(vfat2_cnt).strips(127 downto 112);
                        state <= SAVING_1;
                    when SAVING_1 =>
                        tk_wr_en <= '1';
                        tk_wr_data <= tk_data(vfat2_cnt).strips(111 downto 48);
                        state <= SAVING_2;
                    when SAVING_2 =>
                        tk_wr_en <= '1';
                        tk_wr_data <= tk_data(vfat2_cnt).strips(47 downto 0) & tk_data(vfat2_cnt).crc;
                        state <= LOOPING;                    
                    when others =>        
                        state <= LOOPING;
                        vfat2_cnt <= 0;
                        tk_data_ack <= (others => '0');
                        tk_wr_en <= '0';
                        tk_wr_data <= (others => '0');
                end case;                  
            end if;        
        end if;    
    end process; 
    
    --== FIFO ==--
    
    fifo128x64_inst : entity work.fifo128x64
    port map(
        rst     => reset_i,
        wr_clk  => ref_clk_i,
        wr_en   => tk_wr_en,
        din     => tk_wr_data,        
        rd_clk  => gtx_clk_i,
        rd_en   => tk_rd_en_i,
        valid   => tk_rd_valid_o,
        dout    => tk_rd_data_o,
        full    => open,
        empty   => tk_rd_csb_o
    );
    
end Behavioral;