----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_controller - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Wishbone slave that sends T1 commands according to patterns
--
-- Register map:
-- 0 : enable/disable
-- 1 : operation mode (2 bits)
-- 2 : type (2 bits)
-- 3 : number of events (32 bits)
-- 4 : interval (32 bits)
-- 5 : delay (32 bits)
-- 7 & 6 : lv1a sequence (64 bits)
-- 9 & 8 : calpulse sequence (64 bits)
-- 11 & 10 : resync sequence (64 bits)
-- 13 & 12 : bc0 sequence (64 bits)
-- 14 : local reset
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_t1_controller is
port(
    -- VFAT2 reference clock
    vfat2_mclk_i    : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Request from the system
    wb_slv_req_i    : in wb_req_t;
    -- Response to the system
    wb_slv_res_o    : out wb_res_t;
    -- Output T1 commands
    vfat2_t1_0      : out t1_t
);
end vfat2_t1_controller;

architecture Behavioral of vfat2_t1_controller is

    -- Local reset
    signal local_reset  : std_logic;
    
    -- Signals from the Wishbone Splitter
    signal wb_stb       : std_logic_vector(14 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector(14 downto 0);
    signal reg_err      : std_logic_vector(14 downto 0);
    signal reg_data     : std32_array_t(14 downto 0);
    
begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 15
    )
    port map(
        wb_clk_i    => ref_clk_i,
        reset_i     => local_reset,
        wb_req_i    => wb_slv_req_i,
        wb_res_o    => wb_slv_res_o,
        stb_o       => wb_stb,
        we_o        => wb_we,
        addr_o      => wb_addr,
        data_o      => wb_data,
        ack_i       => reg_ack,
        err_i       => reg_err,
        data_i      => reg_dout
    );    
    
    --===========================--
    --== T1 controller routine ==--
    --===========================--
    
    vfat2_t1_controller_req_inst : entity work.vfat2_t1_controller_req
    port map(
        vfat2_mclk_i    => ref_clk_i,
        reset_i         => local_reset,
        req_en_i        => reg_data(0)(0),
        req_op_mode_i   => reg_data(1)(1 downto 0),
        req_type_i      => reg_data(2)(1 downto 0),
        req_events_i    => reg_data(3),
        req_interval_i  => reg_data(4),
        req_delay_i     => reg_data(5),
        req_lv1a_seq_i  => (reg_data(7) & reg_data(6)),
        req_cal_seq_i   => (reg_data(9) & reg_data(8)),
        req_sync_seq_i  => (reg_data(11) & reg_data(10)),
        req_bc0_seq_i   => (reg_data(13) & reg_data(12)),
        vfat2_t1_0      => vfat2_t1_0
    );
            
    --===============--
    --== Registers ==--
    --===============--
   
    -- 0 : enable/disable
    -- 1 : operation mode (2 bits)
    -- 2 : type (2 bits)
    -- 3 : number of events (32 bits)
    -- 4 : interval (32 bits)
    -- 5 : delay (32 bits)
    -- 7 & 6 : lv1a sequence (64 bits)
    -- 9 & 8 : calpulse sequence (64 bits)
    -- 11 & 10 : resync sequence (64 bits)
    -- 13 & 12 : bc0 sequence (64 bits)
   
    registers_inst : entity work.registers
    generic map(
        SIZE        => 14
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(13 downto 1),
        we_i        => wb_we,
        data_i      => wb_din,
        ack_o       => reg_ack(13 downto 1),
        err_o       => reg_err(13 downto 1),
        data_o      => reg_data(13 downto 1)
    );
    
    --=================--
    --== Local reset ==--
    --=================--

    local_reset <= reset_i or wb_stb(14);
    
    -- Connect signals for automatic response
    wb_ack(14) <= wb_stb(14);
    wb_err(14) <= '0';
    wb_dout(14) <= (others => '0');
    
end Behavioral;