----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:15:06 03/13/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_packer - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:    This entity adds differential input buffers to all VFAT2 Sbits and DataOut signals
--                 and packes them inside an array.
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

library work;
use work.vfat2_pkg.all;

entity vfat2_packer is
port(

    --==
    --== VFAT2s Control
    --==
    
    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);
    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);
    
    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);
    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);
    
    vfat2_resb_o            : out std_logic_vector(2 downto 0);
    vfat2_resh_o            : out std_logic_vector(2 downto 0);
    
    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);
    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);

    vfat2_scl_o             : out std_logic_vector(5 downto 0);
    vfat2_sda_io            : inout std_logic_vector(5 downto 0);    

    --
    
    vfat2_t1_i              : in std_logic_vector(2 downto 0);
    
    vfat2_mclk_i            : in std_logic_vector(2 downto 0);
    
    vfat2_resb_i            : in std_logic_vector(2 downto 0);
    vfat2_resh_i            : in std_logic_vector(2 downto 0);
    
    vfat2_data_valid_o      : out std_logic_vector(5 downto 0);
    
    vfat2_scl_i             : in std_logic_vector(5 downto 0);
    vfat2_sda_i             : in std_logic_vector(5 downto 0); 
    vfat2_sda_o             : out std_logic_vector(5 downto 0); 
    vfat2_sda_t             : in std_logic_vector(5 downto 0); 

    --==
    --== VFAT2s Data
    --==
    
    vfat2_0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_0_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_0_data_out_p_i    : in std_logic;
    vfat2_0_data_out_n_i    : in std_logic;

    vfat2_1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_1_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_1_data_out_p_i    : in std_logic;
    vfat2_1_data_out_n_i    : in std_logic;

    vfat2_2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_2_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_2_data_out_p_i    : in std_logic;
    vfat2_2_data_out_n_i    : in std_logic;

    vfat2_3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_3_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_3_data_out_p_i    : in std_logic;
    vfat2_3_data_out_n_i    : in std_logic;

    vfat2_4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_4_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_4_data_out_p_i    : in std_logic;
    vfat2_4_data_out_n_i    : in std_logic;

    vfat2_5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_5_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_5_data_out_p_i    : in std_logic;
    vfat2_5_data_out_n_i    : in std_logic;

    vfat2_6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_6_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_6_data_out_p_i    : in std_logic;
    vfat2_6_data_out_n_i    : in std_logic;

    vfat2_7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_7_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_7_data_out_p_i    : in std_logic;
    vfat2_7_data_out_n_i    : in std_logic;

    vfat2_8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_8_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_8_data_out_p_i    : in std_logic;
    vfat2_8_data_out_n_i    : in std_logic;

    vfat2_9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_9_sbits_n_i       : in std_logic_vector(7 downto 0);
    vfat2_9_data_out_p_i    : in std_logic;
    vfat2_9_data_out_n_i    : in std_logic;

    vfat2_10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_10_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_10_data_out_p_i   : in std_logic;
    vfat2_10_data_out_n_i   : in std_logic;

    vfat2_11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_11_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_11_data_out_p_i   : in std_logic;
    vfat2_11_data_out_n_i   : in std_logic;

    vfat2_12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_12_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_12_data_out_p_i   : in std_logic;
    vfat2_12_data_out_n_i   : in std_logic;

    vfat2_13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_13_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_13_data_out_p_i   : in std_logic;
    vfat2_13_data_out_n_i   : in std_logic;

    vfat2_14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_14_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_14_data_out_p_i   : in std_logic;
    vfat2_14_data_out_n_i   : in std_logic;

    vfat2_15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_15_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_15_data_out_p_i   : in std_logic;
    vfat2_15_data_out_n_i   : in std_logic;

    vfat2_16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_16_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_16_data_out_p_i   : in std_logic;
    vfat2_16_data_out_n_i   : in std_logic;

    vfat2_17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_17_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_17_data_out_p_i   : in std_logic;
    vfat2_17_data_out_n_i   : in std_logic;

    vfat2_18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_18_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_18_data_out_p_i   : in std_logic;
    vfat2_18_data_out_n_i   : in std_logic;

    vfat2_19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_19_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_19_data_out_p_i   : in std_logic;
    vfat2_19_data_out_n_i   : in std_logic;

    vfat2_20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_20_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_20_data_out_p_i   : in std_logic;
    vfat2_20_data_out_n_i   : in std_logic;

    vfat2_21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_21_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_21_data_out_p_i   : in std_logic;
    vfat2_21_data_out_n_i   : in std_logic;

    vfat2_22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_22_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_22_data_out_p_i   : in std_logic;
    vfat2_22_data_out_n_i   : in std_logic;

    vfat2_23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat2_23_sbits_n_i      : in std_logic_vector(7 downto 0);
    vfat2_23_data_out_p_i   : in std_logic;
    vfat2_23_data_out_n_i   : in std_logic; 
    
    --
    
    vfat2s_data_o           : out vfat2s_data_t(23 downto 0)

);
end vfat2_packer;

architecture Behavioral of vfat2_packer is
begin

    --==
    --== VFAT2s Control
    --==
    
    vfat2_columns : for I in 0 to 2 generate
    
        signal ddr_clk  : std_logic;
    
    begin
    
        vfat2_t1_obufds_inst : obufds
        port map (
            i   => vfat2_t1_i(I),
            o   => vfat2_t1_p_o(I),
            ob  => vfat2_t1_n_o(I)
        );
    
        vfat2_mclk_oddr_inst : oddr
        generic map(
            ddr_clk_edge => "opposite_edge",
            init => '0',
            srtype => "sync"
        )
        port map (
            q   => ddr_clk,
            c   => vfat2_mclk_i(I),
            ce  => '1',
            d1  => '0',
            d2  => '1',
            r   => '0',
            s   => '0'
        );    
    
        vfat2_mclk_obufds_inst : obufds
        port map (
            i   => ddr_clk,
            o   => vfat2_mclk_p_o(I),
            ob  => vfat2_mclk_n_o(I)
        );
    
        vfat2_resb_o(I) <= vfat2_resb_i(I);
        vfat2_resh_o(I) <= vfat2_resh_i(I);
    
    end generate;
    
    vfat2_sectors : for I in 0 to 5 generate
    begin
    
        vfat2_data_valid_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_data_valid_p_i(I),
            ib  => vfat2_data_valid_n_i(I),
            o   => vfat2_data_valid_o(I)
        );
    
        vfat2_sda_iobuf_inst : iobuf
        generic map (
            drive => 12,
            iostandard => "lvds_25",
            slew => "slow"
        )
        port map (
            o => vfat2_sda_o(I),
            io => vfat2_sda_io(I),
            i => vfat2_sda_i(I),
            t => vfat2_sda_t(I)
        );
        
        vfat2_scl_o(I) <= vfat2_scl_i(I);
        
    end generate;  

    --==
    --== VFAT2 0
    --==

    vfat2_0_sbits : for I in 0 to 7 generate
    begin

        vfat2_0_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_0_sbits_p_i(I),
            ib  => vfat2_0_sbits_n_i(I),
            o   => vfat2s_data_o(0).sbits(I)
        );

    end generate;

    vfat2_0_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_0_data_out_p_i,
        ib  => vfat2_0_data_out_n_i,
        o   => vfat2s_data_o(0).data_out
    );

    --==
    --== VFAT2 1
    --==

    vfat2_1_sbits : for I in 0 to 7 generate
    begin

        vfat2_1_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_1_sbits_p_i(I),
            ib  => vfat2_1_sbits_n_i(I),
            o   => vfat2s_data_o(1).sbits(I)
        );

    end generate;

    vfat2_1_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_1_data_out_p_i,
        ib  => vfat2_1_data_out_n_i,
        o   => vfat2s_data_o(1).data_out
    );

    --==
    --== VFAT2 2
    --==

    vfat2_2_sbits : for I in 0 to 7 generate
    begin

        vfat2_2_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_2_sbits_p_i(I),
            ib  => vfat2_2_sbits_n_i(I),
            o   => vfat2s_data_o(2).sbits(I)
        );

    end generate;

    vfat2_2_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_2_data_out_p_i,
        ib  => vfat2_2_data_out_n_i,
        o   => vfat2s_data_o(2).data_out
    );

    --==
    --== VFAT2 3
    --==

    vfat2_3_sbits : for I in 0 to 7 generate
    begin

        vfat2_3_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_3_sbits_p_i(I),
            ib  => vfat2_3_sbits_n_i(I),
            o   => vfat2s_data_o(3).sbits(I)
        );

    end generate;

    vfat2_3_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_3_data_out_p_i,
        ib  => vfat2_3_data_out_n_i,
        o   => vfat2s_data_o(3).data_out
    );

    --==
    --== VFAT2 4
    --==

    vfat2_4_sbits : for I in 0 to 7 generate
    begin

        vfat2_4_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_4_sbits_p_i(I),
            ib  => vfat2_4_sbits_n_i(I),
            o   => vfat2s_data_o(4).sbits(I)
        );

    end generate;

    vfat2_4_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_4_data_out_p_i,
        ib  => vfat2_4_data_out_n_i,
        o   => vfat2s_data_o(4).data_out
    );

    --==
    --== VFAT2 5
    --==

    vfat2_5_sbits : for I in 0 to 7 generate
    begin

        vfat2_5_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_5_sbits_p_i(I),
            ib  => vfat2_5_sbits_n_i(I),
            o   => vfat2s_data_o(5).sbits(I)
        );

    end generate;

    vfat2_5_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_5_data_out_p_i,
        ib  => vfat2_5_data_out_n_i,
        o   => vfat2s_data_o(5).data_out
    );

    --==
    --== VFAT2 6
    --==

    vfat2_6_sbits : for I in 0 to 7 generate
    begin

        vfat2_6_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_6_sbits_p_i(I),
            ib  => vfat2_6_sbits_n_i(I),
            o   => vfat2s_data_o(6).sbits(I)
        );

    end generate;

    vfat2_6_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_6_data_out_p_i,
        ib  => vfat2_6_data_out_n_i,
        o   => vfat2s_data_o(6).data_out
    );

    --==
    --== VFAT2 7
    --==

    vfat2_7_sbits : for I in 0 to 7 generate
    begin

        vfat2_7_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_7_sbits_p_i(I),
            ib  => vfat2_7_sbits_n_i(I),
            o   => vfat2s_data_o(7).sbits(I)
        );

    end generate;

    vfat2_7_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_7_data_out_p_i,
        ib  => vfat2_7_data_out_n_i,
        o   => vfat2s_data_o(7).data_out
    );

    --==
    --== VFAT2 8
    --==

    vfat2_8_sbits : for I in 0 to 7 generate
    begin

        vfat2_8_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_8_sbits_p_i(I),
            ib  => vfat2_8_sbits_n_i(I),
            o   => vfat2s_data_o(8).sbits(I)
        );

    end generate;

    vfat2_8_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_8_data_out_p_i,
        ib  => vfat2_8_data_out_n_i,
        o   => vfat2s_data_o(8).data_out
    );

    --==
    --== VFAT2 9
    --==

    vfat2_9_sbits : for I in 0 to 7 generate
    begin

        vfat2_9_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_9_sbits_p_i(I),
            ib  => vfat2_9_sbits_n_i(I),
            o   => vfat2s_data_o(9).sbits(I)
        );

    end generate;

    vfat2_9_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_9_data_out_p_i,
        ib  => vfat2_9_data_out_n_i,
        o   => vfat2s_data_o(9).data_out
    );

    --==
    --== VFAT2 10
    --==

    vfat2_10_sbits : for I in 0 to 7 generate
    begin

        vfat2_10_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_10_sbits_p_i(I),
            ib  => vfat2_10_sbits_n_i(I),
            o   => vfat2s_data_o(10).sbits(I)
        );

    end generate;

    vfat2_10_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_10_data_out_p_i,
        ib  => vfat2_10_data_out_n_i,
        o   => vfat2s_data_o(10).data_out
    );

    --==
    --== VFAT2 11
    --==

    vfat2_11_sbits : for I in 0 to 7 generate
    begin

        vfat2_11_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_11_sbits_p_i(I),
            ib  => vfat2_11_sbits_n_i(I),
            o   => vfat2s_data_o(11).sbits(I)
        );

    end generate;

    vfat2_11_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_11_data_out_p_i,
        ib  => vfat2_11_data_out_n_i,
        o   => vfat2s_data_o(11).data_out
    );

    --==
    --== VFAT2 12
    --==

    vfat2_12_sbits : for I in 0 to 7 generate
    begin

        vfat2_12_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_12_sbits_p_i(I),
            ib  => vfat2_12_sbits_n_i(I),
            o   => vfat2s_data_o(12).sbits(I)
        );

    end generate;

    vfat2_12_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_12_data_out_p_i,
        ib  => vfat2_12_data_out_n_i,
        o   => vfat2s_data_o(12).data_out
    );

    --==
    --== VFAT2 13
    --==

    vfat2_13_sbits : for I in 0 to 7 generate
    begin

        vfat2_13_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_13_sbits_p_i(I),
            ib  => vfat2_13_sbits_n_i(I),
            o   => vfat2s_data_o(13).sbits(I)
        );

    end generate;

    vfat2_13_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_13_data_out_p_i,
        ib  => vfat2_13_data_out_n_i,
        o   => vfat2s_data_o(13).data_out
    );

    --==
    --== VFAT2 14
    --==

    vfat2_14_sbits : for I in 0 to 7 generate
    begin

        vfat2_14_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_14_sbits_p_i(I),
            ib  => vfat2_14_sbits_n_i(I),
            o   => vfat2s_data_o(14).sbits(I)
        );

    end generate;

    vfat2_14_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_14_data_out_p_i,
        ib  => vfat2_14_data_out_n_i,
        o   => vfat2s_data_o(14).data_out
    );

    --==
    --== VFAT2 15
    --==

    vfat2_15_sbits : for I in 0 to 7 generate
    begin

        vfat2_15_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_15_sbits_p_i(I),
            ib  => vfat2_15_sbits_n_i(I),
            o   => vfat2s_data_o(15).sbits(I)
        );

    end generate;

    vfat2_15_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_15_data_out_p_i,
        ib  => vfat2_15_data_out_n_i,
        o   => vfat2s_data_o(15).data_out
    );

    --==
    --== VFAT2 16
    --==

    vfat2_16_sbits : for I in 0 to 7 generate
    begin

        vfat2_16_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_16_sbits_p_i(I),
            ib  => vfat2_16_sbits_n_i(I),
            o   => vfat2s_data_o(16).sbits(I)
        );

    end generate;

    vfat2_16_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_16_data_out_p_i,
        ib  => vfat2_16_data_out_n_i,
        o   => vfat2s_data_o(16).data_out
    );

    --==
    --== VFAT2 17
    --==

    vfat2_17_sbits : for I in 0 to 7 generate
    begin

        vfat2_17_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_17_sbits_p_i(I),
            ib  => vfat2_17_sbits_n_i(I),
            o   => vfat2s_data_o(17).sbits(I)
        );

    end generate;

    vfat2_17_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_17_data_out_p_i,
        ib  => vfat2_17_data_out_n_i,
        o   => vfat2s_data_o(17).data_out
    );

    --==
    --== VFAT2 18
    --==

    vfat2_18_sbits : for I in 0 to 7 generate
    begin

        vfat2_18_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_18_sbits_p_i(I),
            ib  => vfat2_18_sbits_n_i(I),
            o   => vfat2s_data_o(18).sbits(I)
        );

    end generate;

    vfat2_18_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_18_data_out_p_i,
        ib  => vfat2_18_data_out_n_i,
        o   => vfat2s_data_o(18).data_out
    );

    --==
    --== VFAT2 19
    --==

    vfat2_19_sbits : for I in 0 to 7 generate
    begin

        vfat2_19_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_19_sbits_p_i(I),
            ib  => vfat2_19_sbits_n_i(I),
            o   => vfat2s_data_o(19).sbits(I)
        );

    end generate;

    vfat2_19_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_19_data_out_p_i,
        ib  => vfat2_19_data_out_n_i,
        o   => vfat2s_data_o(19).data_out
    );

    --==
    --== VFAT2 20
    --==

    vfat2_20_sbits : for I in 0 to 7 generate
    begin

        vfat2_20_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_20_sbits_p_i(I),
            ib  => vfat2_20_sbits_n_i(I),
            o   => vfat2s_data_o(20).sbits(I)
        );

    end generate;

    vfat2_20_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_20_data_out_p_i,
        ib  => vfat2_20_data_out_n_i,
        o   => vfat2s_data_o(20).data_out
    );

    --==
    --== VFAT2 21
    --==

    vfat2_21_sbits : for I in 0 to 7 generate
    begin

        vfat2_21_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_21_sbits_p_i(I),
            ib  => vfat2_21_sbits_n_i(I),
            o   => vfat2s_data_o(21).sbits(I)
        );

    end generate;

    vfat2_21_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_21_data_out_p_i,
        ib  => vfat2_21_data_out_n_i,
        o   => vfat2s_data_o(21).data_out
    );

    --==
    --== VFAT2 22
    --==

    vfat2_22_sbits : for I in 0 to 7 generate
    begin

        vfat2_22_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_22_sbits_p_i(I),
            ib  => vfat2_22_sbits_n_i(I),
            o   => vfat2s_data_o(22).sbits(I)
        );

    end generate;

    vfat2_22_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_22_data_out_p_i,
        ib  => vfat2_22_data_out_n_i,
        o   => vfat2s_data_o(22).data_out
    );

    --==
    --== VFAT2 23
    --==

    vfat2_23_sbits : for I in 0 to 7 generate
    begin

        vfat2_23_sbits_ibufds_inst : ibufds
        generic map (
            diff_term   => true,
            iostandard  => "lvds_25"
        )
        port map (
            i   => vfat2_23_sbits_p_i(I),
            ib  => vfat2_23_sbits_n_i(I),
            o   => vfat2s_data_o(23).sbits(I)
        );

    end generate;

    vfat2_23_data_out_ibufds_inst : ibufds
    generic map (
        diff_term   => true,
        iostandard  => "lvds_25"
    )
    port map (
        i   => vfat2_23_data_out_p_i,
        ib  => vfat2_23_data_out_n_i,
        o   => vfat2s_data_o(23).data_out
    );

end Behavioral;