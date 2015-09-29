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
use work.wb_pkg.all;

entity counters is
generic(
    N               : integer := 106
);
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;    
    
    -- Wishbone request
    wb_m_req_i      : in wb_req_array_t((WB_MASTERS - 1) downto 0);
    wb_m_res_i      : in wb_res_array_t((WB_MASTERS - 1) downto 0);    
    wb_s_req_i      : in wb_req_array_t((WB_SLAVES - 1) downto 0);
    wb_s_res_i      : in wb_res_array_t((WB_SLAVES - 1) downto 0);
    
    -- Tracking data
    vfat2_tk_data_i : in tk_data_array_t(23 downto 0);
    
    -- T1
    vfat2_t1_i      : in t1_array_t(4 downto 0);
    
    -- GTX
    gtx_tk_error_i  : in std_logic;
    gtx_tr_error_i  : in std_logic
    
);
end counters;

architecture Behavioral of counters is
    
    -- Signals from the Wishbone Hub
    signal wb_stb       : std_logic_vector((N - 1) downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector((N - 1) downto 0);
    signal reg_err      : std_logic_vector((N - 1) downto 0);
    signal reg_data     : std32_array_t((N - 1) downto 0);

begin

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => N,
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
    
    --========================--
    --== Automatic response ==--
    --========================--
    
    ack_err_loop : for I in 0 to (N - 1) generate
    begin
    
        reg_ack(I) <= wb_stb(I);
        reg_err(I) <= '0';
        
    end generate;
    
    --==============--
    --== Counters ==--
    --==============--  
    
    -- 0 - 7 : WB master
    
    wb_m_cnt_loop : for I in 0 to 3 generate
    begin
    
        wb_m_req_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(I) and wb_we), en_i => wb_m_req_i(I).stb, data_o => reg_data(I));
    
        wb_m_res_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(4 + I) and wb_we), en_i => wb_m_res_i(I).ack, data_o => reg_data(4 + I));
    
    end generate;
    
    -- 8 - 35 : WB slaves
    
    wb_s_cnt_loop : for I in 0 to 13 generate
    begin
    
        wb_s_req_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(8 + I) and wb_we), en_i => wb_s_req_i(I).stb, data_o => reg_data(8 + I));
    
        wb_s_res_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(22 + I) and wb_we), en_i => wb_s_res_i(I).ack, data_o => reg_data(22 + I));

    end generate;
    
    -- 36 - 59 : Good tracking data
    
    tk_data_godd_cnt_loop : for I in 0 to 23 generate
    begin
    
        tk_data_good_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(36 + I) and wb_we), en_i => (vfat2_tk_data_i(I).valid and vfat2_tk_data_i(I).crc_ok), data_o => reg_data(36 + I));
    
    end generate;
    
    -- 60 - 83 : Bad tracking data
    
    tk_data_bad_cnt_loop : for I in 0 to 23 generate
    begin
    
        tk_data_bad_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(60 + I) and wb_we), en_i => (vfat2_tk_data_i(I).valid and (not vfat2_tk_data_i(I).crc_ok)), data_o => reg_data(60 + I));
    
    end generate;
    
    -- 84 - 103 : T1 commands  

    t1_cnt_loop : for I in 0 to 4 generate
    begin
    
        lv1a_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(84 + I * 4) and wb_we), en_i => vfat2_t1_i(I).lv1a, data_o => reg_data(84 + I * 4));
        
        calpulse_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(85 + I * 4) and wb_we), en_i => vfat2_t1_i(I).calpulse, data_o => reg_data(85 + I * 4));
        
        resync_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(86 + I * 4) and wb_we), en_i => vfat2_t1_i(I).resync, data_o => reg_data(86 + I * 4));
        
        bc0_cnt_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(87 + I * 4) and wb_we), en_i => vfat2_t1_i(I).bc0, data_o => reg_data(87 + I * 4));
    
    end generate;
    
    -- 104 - 105 : GTX error (TK & Trigger)
    
    gtx_tk_error_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(104) and wb_we), en_i => gtx_tk_error_i, data_o => reg_data(104));
    
    gtx_tr_error_inst : entity work.counter port map(ref_clk_i => ref_clk_i, reset_i => (wb_stb(105) and wb_we), en_i => gtx_tr_error_i, data_o => reg_data(105));

end Behavioral;