----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    cdce - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
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

entity cdce is
port(

    --== CDCE raw ==--
    
    cdce_clk_p_i        : in std_logic;
    cdce_clk_n_i        : in std_logic;
    
    cdce_clk_pri_p_o    : out std_logic;
    cdce_clk_pri_n_o    : out std_logic;

    cdce_aux_out_o      : out std_logic;
    cdce_aux_in_i       : in std_logic;
    cdce_ref_o          : out std_logic;
    cdce_pwrdown_o      : out std_logic;
    cdce_sync_o         : out std_logic;
    cdce_locked_i       : in std_logic;
    
    cdce_sck_o          : out std_logic;
    cdce_mosi_o         : out std_logic;
    cdce_le_o           : out std_logic;
    cdce_miso_i         : in std_logic;
    
    --== CDCE packed ==--
    
    wb_req_i            : in wb_req_t;
    wb_res_o            : in wb_res_t
    
);
end cdce;

architecture Behavioral of cdce is

    signal cdce_clk     : std_logic;
    signal cdce_clk_pri : std_logic;
    signal cdce_aux_out : std_logic;
    signal cdce_aux_in  : std_logic;
    signal cdce_ref     : std_logic;
    signal cdce_pwrdown : std_logic;
    signal cdce_sync    : std_logic;
    signal cdce_locked  : std_logic;
    signal cdce_sck     : std_logic;
    signal cdce_mosi    : std_logic;
    signal cdce_le      : std_logic;
    signal cdce_miso    : std_logic;

begin 

    --==================--
    --== CDCE buffers ==--
    --==================--

    cdce_buffers_inst : entity work.cdce_buffers
    port map(
        -- Raw
        cdce_clk_p_i        => cdce_clk_p_i,
        cdce_clk_n_i        => cdce_clk_n_i,
        cdce_clk_pri_p_o    => cdce_clk_pri_p_o,
        cdce_clk_pri_n_o    => cdce_clk_pri_n_o,
        cdce_aux_out_o      => cdce_aux_out_o,
        cdce_aux_in_i       => cdce_aux_in_i,
        cdce_ref_o          => cdce_ref_o,
        cdce_pwrdown_o      => cdce_pwrdown_o,
        cdce_sync_o         => cdce_sync_o,
        cdce_locked_i       => cdce_locked_i,
        cdce_sck_o          => cdce_sck_o,
        cdce_mosi_o         => cdce_mosi_o,
        cdce_le_o           => cdce_le_o,
        cdce_miso_i         => cdce_miso_i,
        -- Buffered
        cdce_clk_o          => cdce_clk,
        cdce_clk_pri_i      => cdce_clk_pri,
        cdce_aux_out_i      => cdce_aux_out,
        cdce_aux_in_o       => cdce_aux_in,
        cdce_ref_i          => cdce_ref,
        cdce_pwrdown_i      => cdce_pwrdown,
        cdce_sync_i         => cdce_sync,
        cdce_locked_o       => cdce_locked,
        cdce_sck_i          => cdce_sck,
        cdce_mosi_i         => cdce_mosi,
        cdce_le_i           => cdce_le,
        cdce_miso_o         => cdce_miso
    );

end Behavioral;

