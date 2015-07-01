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

library work;
use work.types_pkg.all;

entity vfat2_data_decoder_seu is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    data_i      : in std_logic;
    
    valid_o     : out std_logic;
    data_o      : out tk_data_t
    
);
end vfat2_data_decoder_seu;

architecture Behavioral of vfat2_data_decoder_seu is

    signal valid_0, valid_1, valid_2    : std_logic;
    signal data_0, data_1, data_2       : tk_data_t;
  
begin
    
    --== VFAT2 decoders ==--
    
    vfat2_data_decoder_0_inst : entity work.vfat2_data_decoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        data_i      => data_i,
        valid_o     => valid_0,
        data_o      => data_0
    );
    
    vfat2_data_decoder_1_inst : entity work.vfat2_data_decoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        data_i      => data_i,
        valid_o     => valid_1,
        data_o      => data_1
    );
    
    vfat2_data_decoder_2_inst : entity work.vfat2_data_decoder
    port map(
        ref_clk_i   => ref_clk_i,
        reset_i     => reset_i,
        data_i      => data_i,
        valid_o     => valid_2,
        data_o      => data_2
    );
    
    --== SEU voters ==--
    
    valid_seu_voter : entity work.seu_voter_bit
    generic map(
        ASYNC       => false, 
        WIDTH       => 1
    )
    port map(
        clk_i       => ref_clk_i, 
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
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.bc, 
        data_1_i    => data_1.bc, 
        data_2_i    => data_2.bc, 
        data_o      => data_o.bc
    );  
        
    ec_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 8
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.ec, 
        data_1_i    => data_1.ec, 
        data_2_i    => data_2.ec, 
        data_o      => data_o.ec
    );  
    
    flags_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 4
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.flags, 
        data_1_i    => data_1.flags, 
        data_2_i    => data_2.flags, 
        data_o      => data_o.flags
    );  
    
    chip_id_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 12
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.chip_id, 
        data_1_i    => data_1.chip_id, 
        data_2_i    => data_2.chip_id, 
        data_o      => data_o.chip_id
    );  
    
    strips_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 128
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.strips, 
        data_1_i    => data_1.strips, 
        data_2_i    => data_2.strips, 
        data_o      => data_o.strips
    ); 
    
    crc_seu_voter : entity work.seu_voter_vector
    generic map(
        ASYNC       => false, 
        WIDTH       => 16
    )
    port map(
        clk_i       => ref_clk_i, 
        reset_i     => reset_i, 
        data_0_i    => data_0.crc, 
        data_1_i    => data_1.crc, 
        data_2_i    => data_2.crc, 
        data_o      => data_o.crc
    ); 
    
end Behavioral;