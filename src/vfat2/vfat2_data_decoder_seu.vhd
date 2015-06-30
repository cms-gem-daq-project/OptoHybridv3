----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    13:13:21 03/12/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_data_decoder_seu - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- SEU version of the VFAT2 tracking data deserializer
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

entity vfat2_data_decoder_seu is
port(

    vfat2_mclk_i    : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic;
    
    valid_o         : out std_logic;
    bc_o            : out std_logic_vector(11 downto 0);
    ec_o            : out std_logic_vector(7 downto 0);
    flags_o         : out std_logic_vector(3 downto 0);
    chip_id_o       : out std_logic_vector(11 downto 0);
    strips_o        : out std_logic_vector(127 downto 0);
    crc_o           : out std_logic_vector(15 downto 0)
    
);
end vfat2_data_decoder_seu;

architecture Behavioral of vfat2_data_decoder_seu is

    signal valid_0, valid_1, valid_2        : std_logic;
    signal bc_0, bc_1, bc_2                 : std_logic_vector(11 downto 0);
    signal ec_0, ec_1, ec_2                 : std_logic_vector(7 downto 0);
    signal flags_0, flags_1, flags_2        : std_logic_vector(3 downto 0);
    signal chip_id_0, chip_id_1, chip_id_2  : std_logic_vector(11 downto 0);
    signal strips_0, strips_1, strips_2     : std_logic_vector(127 downto 0);
    signal crc_0, crc_1, crc_2              : std_logic_vector(15 downto 0);
  
begin
    
    --== VFAT2 decoders ==--
    
    vfat2_data_decoder_0_inst : entity work.vfat2_data_decoder
    port map(
        vfat2_mclk_i    => vfat2_mclk_i,
        reset_i         => reset_i,
        data_i          => data_i,
        valid_o         => valid_0,
        bc_o            => bc_0,
        ec_o            => ec_0,
        flags_o         => flags_0,
        chip_id_o       => chip_id_0,
        strips_o        => strips_0,
        crc_o           => crc_0
    );
    
    vfat2_data_decoder_1_inst : entity work.vfat2_data_decoder
    port map(
        vfat2_mclk_i    => vfat2_mclk_i,
        reset_i         => reset_i,
        data_i          => data_i,
        valid_o         => valid_1,
        bc_o            => bc_1,
        ec_o            => ec_1,
        flags_o         => flags_1,
        chip_id_o       => chip_id_1,
        strips_o        => strips_1,
        crc_o           => crc_1
    );
    
    vfat2_data_decoder_2_inst : entity work.vfat2_data_decoder
    port map(
        vfat2_mclk_i    => vfat2_mclk_i,
        reset_i         => reset_i,
        data_i          => data_i,
        valid_o         => valid_2,
        bc_o            => bc_2,
        ec_o            => ec_2,
        flags_o         => flags_2,
        chip_id_o       => chip_id_2,
        strips_o        => strips_2,
        crc_o           => crc_2
    );
    
    --== SEU voters ==--
    
    valid_seu_voter : entity work.seu_voter_bit
    generic map(
        ASYNC       => false, 
        WIDTH       => 1
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => valid_0, 
        data_1_i    => valid_1, 
        data_2_i    => valid_2, 
        data_o      => valid_o
    );  
        
    bc_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 12
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => bc_0, 
        data_1_i    => bc_1, 
        data_2_i    => bc_2, 
        data_o      => bc_o
    );  
        
    ec_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 8
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => ec_0, 
        data_1_i    => ec_1, 
        data_2_i    => ec_2, 
        data_o      => ec_o
    );  
    
    flags_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 4
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => flags_0, 
        data_1_i    => flags_1, 
        data_2_i    => flags_2, 
        data_o      => flags_o
    );  
    
    chip_id_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 12
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => chip_id_0, 
        data_1_i    => chip_id_1, 
        data_2_i    => chip_id_2, 
        data_o      => chip_id_o
    );  
    
    strips_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 128
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => strips_0, 
        data_1_i    => strips_1, 
        data_2_i    => strips_2, 
        data_o      => strips_o
    ); 
    
    crc_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 16
    )
    port map(
        clk_i       => vfat2_mclk_i, 
        reset_i     => reset_i, 
        data_0_i    => crc_0, 
        data_1_i    => crc_1, 
        data_2_i    => crc_2, 
        data_o      => crc_o
    ); 
    
end Behavioral;