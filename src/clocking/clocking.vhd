----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:10:11 09/15/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    clocking - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- 0..2 : vfat2 readout clock phase shifting
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use work.types_pkg.all;

entity clocking is
port(

    ref_clk_i           : in std_logic;
    reset_i             : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i        : in wb_req_t;
    wb_slv_res_o        : out wb_res_t;
    
    -- VFAT2 readout clock
    vfat2_readout_clk_o : out std_logic_vector(2 downto 0)
    
);
end clocking;

architecture Behavioral of clocking is

    -- Signals from the Wishbone Splitter
    signal wb_stb       : std_logic_vector(2 downto 0);
    signal wb_we        : std_logic;
    signal wb_addr      : std_logic_vector(31 downto 0);
    signal wb_data      : std_logic_vector(31 downto 0);
    
    -- Signals for the registers
    signal reg_ack      : std_logic_vector(2 downto 0);
    signal reg_err      : std_logic_vector(2 downto 0);
    signal reg_data     : std32_array_t(2 downto 0);
    
begin    

    --===============================--
    --== Wishbone request splitter ==--
    --===============================--

    wb_splitter_inst : entity work.wb_splitter
    generic map(
        SIZE        => 3,
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
    
    --===============--
    --== Registers ==--
    --===============--
   
    -- 0..2 : vfat2 readout clock phase shifting

    registers_inst : entity work.registers
    generic map(
        SIZE        => 3
    )
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        stb_i       => wb_stb,
        we_i        => wb_we,
        data_i      => wb_data,
        ack_o       => reg_ack,
        err_o       => reg_err,
        data_o      => reg_data        
    );
    
    --=====================--
    -- VFAT2 Readout clock --
    --=====================--
    
    readout_clock_gen : for I in 0 to 2 generate
    begin
    
        readout_clock_inst : entity work.readout_clock
        port map(
            ref_clk_i   => ref_clk_i,
            reset_i     => reset_i,            
            req_en_i    => wb_stb(I),
            req_shift_i => wb_data(7 downto 0),           
            req_ack_o   => open,
            req_err_o   => open,            
            vfat2_clk_o => vfat2_readout_clk_o(I)               
        );
            
    end generate;


end Behavioral;

