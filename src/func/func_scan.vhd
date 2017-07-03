----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:46:42 08/05/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    func_scan - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Function that handles the threshold, threshold2, and latency scans for all VFAT2s
--
-- Register map:
-- 0 : start the scan
-- 1 : scan type (2 bits)
-- 2 : VFAT2 ID (5 bits)
-- 3 : channel to scan (7 bits)
-- 4 : minimum value (8 bits)
-- 5 : maximum value (8 bits)
-- 6 : stepping (8 bits)
-- 7 : number of events (24 bits)
-- 8 : read out the results (32 bits = 8 bits of value & 24 bits of number of events hit)
-- 9 : status (2 bits)
-- 10 : local reset
-- 11 : scan direction (1 bit)
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity func_scan is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    -- Wishbone master
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in wb_res_t;
    
    -- VFAT2 data
    vfat2_sbits_i   : in sbits_array_t(23 downto 0);
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    
    -- Running mode
    scan_running_o  : out std_logic_vector(2 downto 0)
    
);
end func_scan;

architecture Behavioral of func_scan is

    -- Local reset
    signal local_reset  : std_logic;
    
    -- Signals from the Wishbone Splitter
    signal wb_stb       : std_logic_vector(11 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector(11 downto 0);
    signal reg_err      : std_logic_vector(11 downto 0);
    signal reg_data     : std32_array_t(11 downto 0);
    
    -- Signals to the FIFO
    signal fifo_rst     : std_logic;
    signal fifo_we      : std_logic;
    signal fifo_din     : std_logic_vector(31 downto 0);
    
    -- Scan status
    signal scan_running : std_logic_vector(2 downto 0);
    signal scan_error   : std_logic;
    signal scan_data    : std_logic;

begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 12,
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
    
    --==================--
    --== Scan routine ==--
    --==================--
    
    -- 0 : start the scan

    func_scan_req_inst : entity work.func_scan_req
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => local_reset,
        req_stb_i       => wb_stb(0), 
        req_mode_i      => reg_data(1)(2 downto 0),
        req_vfat2_i     => reg_data(2)(4 downto 0),
        req_channel_i   => reg_data(3)(6 downto 0),
        req_min_i       => reg_data(4)(7 downto 0),
        req_max_i       => reg_data(5)(7 downto 0),
        req_step_i      => reg_data(6)(7 downto 0),
        req_events_i    => reg_data(7)(23 downto 0),
        req_dir_i       => reg_data(11)(0),
        req_ack_o       => reg_ack(0),
        req_err_o       => reg_err(0),
        wb_mst_req_o    => wb_mst_req_o,
        wb_mst_res_i    => wb_mst_res_i,
        vfat2_sbits_i   => vfat2_sbits_i,
        vfat2_tk_data_i => vfat2_tk_data_i,
        fifo_we_o       => fifo_we,
        fifo_din_o      => fifo_din,
        scan_running_o  => scan_running,
        scan_error_o    => scan_error
    );
    
    --===============--
    --== Registers ==--
    --===============--
   
    -- 1 : scan type (2 bits)
    -- 2 : VFAT2 ID (5 bits)
    -- 3 : channel to scan  (7 bits)
    -- 4 : minimum value (8 bits)
    -- 5 : maximum value (8 bits)
    -- 6 : stepping (8 bits)
    -- 7 : number of events (24 bits)

    registers_inst : entity work.registers
    generic map(
        SIZE        => 7
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(7 downto 1),
        we_i        => wb_we,
        data_i      => wb_data,
        ack_o       => reg_ack(7 downto 1),
        err_o       => reg_err(7 downto 1),
        data_o      => reg_data(7 downto 1)        
    );
    
    -- 11 : scan direction (1 bit)
    
    registers2_inst : entity work.registers
    generic map(
        SIZE        => 1
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(11 downto 11),
        we_i        => wb_we,
        data_i      => wb_data,
        ack_o       => reg_ack(11 downto 11),
        err_o       => reg_err(11 downto 11),
        data_o      => reg_data(11 downto 11)        
    );    
    
    --=======================--
    --== FIFO with results ==--
    --=======================--

    -- 8 : read out the results (32 bits = 8 bits of value & 24 bits of number of events hit)

    fifo256x32_inst : entity work.fifo256x32
    port map(
        clk         => ref_clk_i,
        rst         => (wb_stb(0) or local_reset),  -- Reset the fifo when a new scan is started
        wr_en       => fifo_we,
        din         => fifo_din,
        rd_en       => wb_stb(8),
        valid       => reg_ack(8),
        dout        => reg_data(8),
        underflow   => reg_err(8),
        full        => open,
        empty       => scan_data
    );
    
    --=================--
    --== Scan status ==--
    --=================--
    
    -- 9 : status (3 bits)

    scan_running_o <= scan_running;
    
    -- Connect signals for automatic response
    reg_ack(9) <= wb_stb(9);
    reg_err(9) <= '0';
    reg_data(9) <= x"000000" & "00" & (not scan_data) & scan_error & '0' & scan_running;
        
    --=================--
    --== Local reset ==--
    --=================--

    -- 10 : local reset

    local_reset <= reset_i or wb_stb(10);
    
    -- Connect signals for automatic response
    reg_ack(10) <= wb_stb(10);
    reg_err(10) <= '0';
    reg_data(10) <= (others => '0');
    
end Behavioral;