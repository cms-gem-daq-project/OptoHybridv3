----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_func_t1 - Behavioral 
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
-- 14 : status (2 bits)
-- 15 : local reset
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_func_t1 is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    -- Output T1 commands
    vfat2_t1_0      : out t1_t; 
    
    -- T1 running mode
    t1_running_o  : out std_logic_vector(1 downto 0)
    
);
end vfat2_func_t1;

architecture Behavioral of vfat2_func_t1 is

    -- Local reset
    signal local_reset  : std_logic;
    
    -- Signals from the Wishbone Splitter
    signal wb_stb       : std_logic_vector(15 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector(15 downto 0);
    signal reg_err      : std_logic_vector(15 downto 0);
    signal reg_data     : std32_array_t(15 downto 0);
    
    -- T1 status
    signal t1_running   : std_logic_vector(1 downto 0);
    
begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 16,
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
    
    --===========================--
    --== T1 controller routine ==--
    --===========================--
    
    -- 0 : enable/disable
    
    vfat2_func_t1_req_inst : entity work.vfat2_func_t1_req
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => local_reset,
        req_en_i        => wb_stb(0),
        req_op_mode_i   => reg_data(1)(1 downto 0),
        req_type_i      => reg_data(2)(1 downto 0),
        req_events_i    => reg_data(3),
        req_interval_i  => reg_data(4),
        req_delay_i     => reg_data(5),
        req_lv1a_seq_i  => (reg_data(7) & reg_data(6)),
        req_cal_seq_i   => (reg_data(9) & reg_data(8)),
        req_sync_seq_i  => (reg_data(11) & reg_data(10)),
        req_bc0_seq_i   => (reg_data(13) & reg_data(12)),
        req_ack_o       => reg_ack(0),
        req_err_o       => reg_err(0),
        vfat2_t1_0      => vfat2_t1_0,
        t1_running_o    => t1_running
    );
            
    --===============--
    --== Registers ==--
    --===============--
   
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
        SIZE        => 13
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(13 downto 1),
        we_i        => wb_we,
        data_i      => wb_data,
        ack_o       => reg_ack(13 downto 1),
        err_o       => reg_err(13 downto 1),
        data_o      => reg_data(13 downto 1)
    );
    
    --=================--
    --== Scan status ==--
    --=================--
    
    -- 14 : status (2 bits)
    
    t1_running_o <= t1_running;
    
    -- Connect signals for automatic response
    reg_ack(14) <= wb_stb(14);
    reg_err(14) <= '0';
    reg_data(14) <= x"0000000" & "00" & t1_running;
    
    --=================--
    --== Local reset ==--
    --=================--
    
    -- 15 : local reset

    local_reset <= reset_i or wb_stb(15);
    
    -- Connect signals for automatic response
    reg_ack(15) <= wb_stb(15);
    reg_err(15) <= '0';
    reg_data(15) <= (others => '0');
    
end Behavioral;