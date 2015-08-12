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
-- 0 : start the scan for a given VFAT2
-- 1 : minimum threshold (8 bits)
-- 2 : maximum threshold (8 bits)
-- 3 : threshold step (8 bits)
-- 4 : number of events  (24 bits)
-- 5 : read out the results (32 bits = 8 bits of threshold value & 24 bits of number of events hit)
-- 6 : local reset
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
    signal wb_stb       : std_logic_vector(6 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_din       : std_logic_vector(31 downto 0);
    
    signal wb_ack       : std_logic_vector(6 downto 0);
    signal wb_err       : std_logic_vector(6 downto 0);
    signal wb_dout      : std32_array_t(6 downto 0);
    
begin

    --== Local reset ==--

    local_reset <= reset_i or wb_stb(6);

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 7
    )
    port map(
        wb_clk_i    => ref_clk_i,
        reset_i     => local_reset,
        wb_req_i    => wb_slv_req_i,
        wb_res_o    => wb_slv_res_o,
        stb_o       => wb_stb,
        we_o        => wb_we,
        addr_o      => wb_addr,
        data_o      => wb_din,
        ack_i       => wb_ack,
        err_i       => wb_err,
        data_i      => wb_dout
    );    
    
    --===========================--
    --== T1 controller routine ==--
    --===========================--
    
    -- 0 : start the scan for a given VFAT2

    
    -- Connect signals for automatic response
    wb_ack(0) <= wb_stb(0);
    wb_err(0) <= '0';
    wb_dout(0) <= (others => '0');
        
    --===============--
    --== Registers ==--
    --===============--
   
    -- 1 : minimum threshold (8 bits)
    -- 2 : maximum threshold (8 bits)
    -- 3 : threshold step (8 bits)
    -- 4 : number of events  (24 bits)   
   
    registers_inst : entity work.registers
    generic map(
        SIZE        => 4
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(4 downto 1),
        we_i        => (others => wb_we),
        data_i      => (others => wb_din),
        ack_o       => wb_ack(4 downto 1),
        err_o       => wb_err(4 downto 1),
        data_o      => wb_dout(4 downto 1)
    );
    
end Behavioral;