----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_forward - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity gtx_forward is
port(

	ref_clk_i       : in std_logic;
    gtx_clk_i       : in std_logic;
	reset_i         : in std_logic;
    
	wb_mst_req_o    : out wb_req_t;
	wb_mst_res_i    : in wb_res_t;
    
    rx_en_i         : in std_logic;
    rx_data_i       : in std_logic_vector(64 downto 0);
    
    tx_en_i         : in std_logic;
    tx_valid_o      : out std_logic;
    tx_data_o       : out std_logic_vector(31 downto 0)
    
);
end gtx_forward;

architecture Behavioral of gtx_forward is
    
    signal rd_valid : std_logic;
    signal rd_data  : std_logic_vector(64 downto 0);
    
begin

    --== RX buffer ==--
    
    fifo16x65_inst : entity work.fifo16x65
    port map(
        rst     => reset_i,
        wr_clk  => gtx_clk_i,
        wr_en   => rx_en_i,
        din     => rx_data_i,        
        rd_clk  => ref_clk_i,
        rd_en   => '1',
        valid   => rd_valid,
        dout    => rd_data,
        full    => open,
        empty   => open
    );
    
    --== Request processing ==--
    
    process(ref_clk_i)
    begin    
        if (rising_edge(ref_clk_i)) then        
            if (reset_i = '1') then
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
            else   
                if (rd_valid = '1') then
                    wb_mst_req_o <= (stb => '1', we => rd_data(64), addr => rd_data(63 downto 32), data => rd_data(31 downto 0));                
                else
                    wb_mst_req_o.stb <= '0';    
                end if;
            end if;
        end if;
    end process; 
    
    --== TX buffer ==--
    
    fifo16x32_inst : entity work.fifo16x32
    port map(
        rst     => reset_i,
        wr_clk  => ref_clk_i,
        wr_en   => wb_mst_res_i.ack,
        din     => wb_mst_res_i.data,        
        rd_clk  => gtx_clk_i,
        rd_en   => tx_en_i,
        valid   => tx_valid_o,
        dout    => tx_data_o,
        full    => open,
        empty   => open
    );    
        
end Behavioral;