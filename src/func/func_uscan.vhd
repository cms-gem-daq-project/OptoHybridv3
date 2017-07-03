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
-- 2 : mask (5 bits)
-- 3 : channel to scan (7 bits)
-- 4 : minimum value (8 bits)
-- 5 : maximum value (8 bits)
-- 6 : stepping (8 bits)
-- 7 : number of events (24 bits)
-- 8 - 31 : read out the results (32 bits = 8 bits of value & 24 bits of number of events hit)
-- 32 : status (2 bits)
-- 33 : local reset
-- 34 : scan direction (1 bit)
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity func_uscan is
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
end func_uscan;

architecture Behavioral of func_uscan is

    -- Local reset
    signal local_reset  : std_logic;

    -- Signals from the Wishbone Splitter
    signal wb_stb       : std_logic_vector(34 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);

    -- Signals for the registers
    signal reg_ack      : std_logic_vector(34 downto 0);
    signal reg_err      : std_logic_vector(34 downto 0);
    signal reg_data     : std32_array_t(34 downto 0);

    -- Signals to the FIFO
    signal fifo_we      : std_logic_vector(23 downto 0);
    signal fifo_din     : std32_array_t(23 downto 0);

    -- Scan status
    signal scan_running : std_logic_vector(2 downto 0);
    signal scan_error   : std_logic;
    signal scan_data    : std_logic_vector(23 downto 0);
    signal scan_data_or : std_logic;
    signal scan_mask    : std_logic_vector(23 downto 0);

begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 35,
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

    func_uscan_req_inst : entity work.func_uscan_req
    port map(
        ref_clk_i       => ref_clk_i,
        reset_i         => local_reset,
        req_stb_i       => wb_stb(0),
        req_mode_i      => reg_data(1)(2 downto 0),
        req_mask_i      => reg_data(2)(23 downto 0),
        req_channel_i   => reg_data(3)(6 downto 0),
        req_min_i       => reg_data(4)(7 downto 0),
        req_max_i       => reg_data(5)(7 downto 0),
        req_step_i      => reg_data(6)(7 downto 0),
        req_events_i    => reg_data(7)(23 downto 0),
        req_dir_i       => reg_data(34)(0),
        req_ack_o       => reg_ack(0),
        req_err_o       => reg_err(0),
        wb_mst_req_o    => wb_mst_req_o,
        wb_mst_res_i    => wb_mst_res_i,
        vfat2_sbits_i   => vfat2_sbits_i,
        vfat2_tk_data_i => vfat2_tk_data_i,
        fifo_we_o       => fifo_we,
        fifo_din_o      => fifo_din,
        scan_running_o  => scan_running,
        scan_error_o    => scan_error,
        scan_mask_o     => scan_mask
    );

    --===============--
    --== Registers ==--
    --===============--

    -- 1 : scan type (2 bits)
    -- 2 : VFAT2 mask (24 bits)
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
    
    -- 34 : scan direction (1 bit)
    
    registers2_inst : entity work.registers
    generic map(
        SIZE        => 1
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => local_reset,
        stb_i       => wb_stb(34 downto 34),
        we_i        => wb_we,
        data_i      => wb_data,
        ack_o       => reg_ack(34 downto 34),
        err_o       => reg_err(34 downto 34),
        data_o      => reg_data(34 downto 34)        
    );  

    --=======================--
    --== FIFO with results ==--
    --=======================--

    -- 8-31 : read out the results of the individual VFAT2s (32 bits = 8 bits of value & 24 bits of number of events hit)
    
    vfat2_loop : for I in 0 to 23 generate
    begin
    
        fifo256x32_inst : entity work.fifo256x32
        port map(
            clk         => ref_clk_i,
            rst         => (wb_stb(0) or local_reset), -- Reset the fifo when a new scan is started
            wr_en       => fifo_we(I),
            din         => fifo_din(I),
            rd_en       => wb_stb(8 + I),
            valid       => reg_ack(8 + I),
            dout        => reg_data(8 + I),
            underflow   => reg_err(8 + I),
            full        => open,
            empty       => scan_data(I)
        );
    
    end generate;

    --=================--
    --== Scan status ==--
    --=================--

    -- 32 : status (3 bits)

    scan_running_o <= scan_running;

    -- Connect signals for automatic response
    reg_ack(32) <= wb_stb(32);
    reg_err(32) <= '0';
    reg_data(32) <= scan_mask & "00" & scan_data_or & scan_error & '0' & scan_running;
    scan_data_or <= (not scan_data(0)) or (not scan_data(1)) or (not scan_data(2)) or (not scan_data(3)) or (not scan_data(4)) or (not scan_data(5)) or (not scan_data(6)) or (not scan_data(7)) or (not scan_data(8)) or (not scan_data(9)) or (not scan_data(10)) or (not scan_data(11)) or (not scan_data(12)) or (not scan_data(13)) or (not scan_data(14)) or (not scan_data(15)) or (not scan_data(16)) or (not scan_data(17)) or (not scan_data(18)) or (not scan_data(19)) or (not scan_data(20)) or (not scan_data(21)) or (not scan_data(22)) or (not scan_data(23));
    
    --=================--
    --== Local reset ==--
    --=================--

    -- 33 : local reset

    local_reset <= reset_i or wb_stb(33);

    -- Connect signals for automatic response
    reg_ack(33) <= wb_stb(33);
    reg_err(33) <= '0';
    reg_data(33) <= (others => '0');

end Behavioral;
