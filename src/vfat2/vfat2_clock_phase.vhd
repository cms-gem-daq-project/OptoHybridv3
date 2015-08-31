----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_clock_phase - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
-- Shifts the phase of the readout clock by a given amount
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity vfat2_clock_phase is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    req_en_i    : in std_logic;
    req_shift_i : in std_logic_vector(7 downto 0);
    
    req_ack_o   : out std_logic;
    req_err_o   : out std_logic;
    
    vfat2_clk_o : out std_logic    
    
);
end vfat2_clock_phase;

architecture Behavioral of vfat2_clock_phase is    

    signal locked       : std_logic;
    signal ps_reset     : std_logic;
    signal ps_en        : std_logic;
    signal ps_incdec    : std_logic;
    signal ps_done      : std_logic;
    
begin

    vfat2_clock_phase_req_inst : entity work.vfat2_clock_phase_req
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        req_en_i    => req_en_i,
        req_shift_i => req_shift_i,
        req_ack_o   => req_ack_o,
        req_err_o   => req_err_o,
        locked_i    => locked,
        ps_reset_o  => ps_reset,
        ps_en_o     => ps_en,
        ps_incdec_o => ps_incdec,
        ps_done_i   => ps_done        
    );

    vfat2_readout_clk_inst : entity work.vfat2_readout_clk
    port map(
        clk_i       => ref_clk_i,
        reset_i     => (reset_i or ps_reset),
        clk_o       => vfat2_clk_o,
        locked_o    => locked,
        ps_clk_i    => ref_clk_i,
        ps_en_i     => ps_en,
        ps_incdec_i => ps_incdec,
        ps_done_o   => ps_done
    ); 

end Behavioral;