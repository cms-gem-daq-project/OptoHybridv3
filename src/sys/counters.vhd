----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:44:34 08/18/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    counters - Behavioral 
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

entity counters is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;    
    
    -- Data to count
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0)
    
);
end counters;

architecture Behavioral of counters is
    
    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector(63 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector(63 downto 0);
    signal reg_err      : std_logic_vector(63 downto 0);
    signal reg_data     : std32_array_t(63 downto 0);

begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 64,
        OFFSET      => 0
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        wb_req_i    => wb_slv_req_i,
        wb_res_o    => wb_slv_res_o,
        stb_o       => wb_stb,
        we_o        => wb_we,
        addr_o      => wb_addr,
        data_o      => wb_data,
        ack_i       => reg_ack,
        err_i       => reg_err,
        data_i      => reg_data
    );
    
    --=============--
    --== Mapping ==--
    --=============--
    
    tk_data_good_cnt_loop : for I in 0 to 23 generate
    begin
    
        tk_data_good_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(I) and wb_we), en_i => (vfat2_tk_data_i(I).valid and vfat2_tk_data_i(I).crc_ok), data_o => reg_data(I));
        reg_ack(I) <= wb_stb(I);
        reg_err(I) <= '0';
    
    end generate;
    
    tk_data_bad_cnt_loop : for I in 0 to 23 generate
    begin
    
        tk_data_bad_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(24 + I) and wb_we), en_i => (vfat2_tk_data_i(I).valid and (not vfat2_tk_data_i(I).crc_ok)), data_o => reg_data(24 + I));
        reg_ack(24 + I) <= wb_stb(24 + I);
        reg_err(24 + I) <= '0';
    
    end generate;

end Behavioral;