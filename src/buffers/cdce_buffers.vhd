----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:33 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    cdce_buffers - Behavioral 
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

library unisim;
use unisim.vcomponents.all;

entity cdce_buffers is
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
    
    --== CDCE buffered ==--
     
    cdce_clk_o          : out std_logic;
    
    cdce_clk_pri_i      : in std_logic;

    cdce_aux_out_i      : in std_logic;
    cdce_aux_in_o       : out std_logic;
    cdce_ref_i          : in std_logic;
    cdce_pwrdown_i      : in std_logic;
    cdce_sync_i         : in std_logic;
    cdce_locked_o       : out std_logic;
    
    cdce_sck_i          : in std_logic;
    cdce_mosi_i         : in std_logic;
    cdce_le_i           : in std_logic;
    cdce_miso_o         : out std_logic
    
);
end cdce_buffers;

architecture Behavioral of cdce_buffers is

    signal cdce_clk     : std_logic;
    signal cdce_clk_pri : std_logic;

begin

    -- cdce_clk
    
    cdce_clk_ibufgds : ibufgds
    generic map(
        diff_term       => true,
        ibuf_low_pwr    => false,
        iostandard      => "lvds_25"
    )
    port map(
        i               => cdce_clk_p_i,
        ib              => cdce_clk_n_i,
        o               => cdce_clk
    );
    
    cdce_clk_o <= not cdce_clk; -- The signal is inverted on the PCB
    
    -- cdce_clk_pri
    
    cdce_clk_pri_oddr : oddr
    generic map(
        ddr_clk_edge    => "opposite_edge",
        init            => '0',
        srtype          => "sync"
    )
    port map (
        q               => cdce_clk_pri,
        c               => cdce_clk_pri_i,
        ce              => '1',
        d1              => '1',
        d2              => '0',
        r               => '0',
        s               => '0'
    );    
    
    cdce_clk_pri_obufds : obufds
    generic map(
        iostandard  => "lvds_25"
    )
    port map(
        i           => cdce_clk_pri,
        o           => cdce_clk_pri_p_o,
        ob          => cdce_clk_pri_n_o
    );
    
    -- cdce_sck
  
    cdce_sck_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "fast"
    )
    port map(
        i           => cdce_sck_i,
        o           => cdce_sck_o
    );
    
    -- cdce_aux_in
    
    cdce_aux_in_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => cdce_aux_in_i,
        o               => cdce_aux_in_o
    );
    
    -- cdce_locked

    cdce_locked_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => cdce_locked_i,
        o               => cdce_locked_o
    );
    
    -- cdce_miso

    cdce_miso_ibuf : ibuf
    generic map(
        ibuf_low_pwr    => true,
        iostandard      => "lvcmos25"
    )
    port map(
        i               => cdce_miso_i,
        o               => cdce_miso_o
    );    
    
    -- cdce_aux_out
    
    cdce_aux_out_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_aux_out_i,
        o           => cdce_aux_out_o
    );
    
    -- cdce_ref
    
    cdce_ref_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_ref_i,
        o           => cdce_ref_o
    );
    
    -- cdce_pwrdown
    
    cdce_pwrdown_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_pwrdown_i,
        o           => cdce_pwrdown_o
    );
    
    -- cdce_sync
    
    cdce_sync_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_sync_i,
        o           => cdce_sync_o
    );
    
    -- cdce_mosi
   
    cdce_mosi_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_mosi_i,
        o           => cdce_mosi_o
    );
    
    -- cdce_le
    
    cdce_le_obuf : obuf
    generic map(
        drive       => 12,
        iostandard  => "lvcmos25",
        slew        => "slow"
    )
    port map(
        i           => cdce_le_i,
        o           => cdce_le_o
    );
    
end Behavioral;

