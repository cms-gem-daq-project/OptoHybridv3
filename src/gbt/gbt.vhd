library ieee;
use ieee.std_logic_1164.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gbt is
generic(
    DEBUG : boolean := FALSE
);
port(

   to_gbt_p     : out std_logic_vector(3 downto 0);
   to_gbt_n     : out std_logic_vector(3 downto 0);
   
   from_gbt_p   : in std_logic_vector(1 downto 0);
   from_gbt_n   : in std_logic_vector(1 downto 0);
   
   data_clk_p   : in std_logic;
   data_clk_n   : in std_logic;
   
   data_i       : in std_logic_vector(31 downto 0);
   data_o       : out std_logic_vector(15 downto 0);
   valid_o      : out std_logic;
   
   rx_aligned_o : out std_logic;
   tx_aligned_o : out std_logic;
   
   header_io    : out std_logic_vector(15 downto 0)
   
);
end gbt;

architecture Behavioral of gbt is
    
    signal from_gbt_raw : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt : std_logic_vector(15 downto 0) := (others => '0');
    
    signal to_gbt : std_logic_vector(31 downto 0) := (others => '0');
    signal to_gbt_mux : std_logic_vector(31 downto 0) := (others => '0');
    signal to_gbt_raw : std_logic_vector(31 downto 0) := (others => '0');
    
    signal data_clk : std_logic := '0';
    signal fabric_clk : std_logic := '0';
    signal clk_reset : std_logic := '0';
    signal io_reset : std_logic := '0';
    signal pll_locked : std_logic := '0';
    
    signal gbt_rx_slip : std_logic := '0';
    signal gbt_tx_slip : std_logic := '0';
    
    signal gbt_rx_aligned : std_logic := '0';
    signal gbt_tx_aligned : std_logic := '0';    

begin

    -- MMCM clocks
    gbt_clock_inst : entity work.gbt_clock
    port map(
        clk_in1_p   => data_clk_p,
        clk_in1_n   => data_clk_n,
        clk_out1    => data_clk,
        clk_out2    => fabric_clk,
        reset       => clk_reset,
        locked      => pll_locked
    );
    
    --================--
    --== INPUT DATA ==--
    --================--

    -- Input deserializer
    from_gbt_des_inst : entity work.from_gbt_des
    port map(
        data_in_from_pins_p => from_gbt_p,
        data_in_from_pins_n => from_gbt_n,
        data_in_to_device   => from_gbt_raw,
        bitslip             => gbt_rx_slip,
        clk_in              => data_clk,
        clk_div_in          => fabric_clk,
        io_reset            => io_reset
    );    
    
    -- Input data formater
    gbt_rx_data_mux_inst : entity work.gbt_rx_data_mux
    generic map(
        DEBUG       => DEBUG
    )
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        din         => from_gbt_raw,
        dout        => from_gbt
    );   
    
    -- Input aligner
    gbt_rx_aligner_inst : entity work.gbt_rx_aligner
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        from_gbt    => from_gbt,
        bitslip     => gbt_rx_slip,
        gbt_aligned => gbt_rx_aligned
    );    
    
    -- DONE
    -- from_gbt is the data packet to use in the code
    data_o <= from_gbt;
    
    --=================--
    --== OUTPUT DATA ==--
    --=================--
  
     -- Output data formater  
    gbt_tx_data_mux_inst : entity work.gbt_tx_data_mux
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        rx_aligned  => gbt_rx_aligned,
        tx_aligned  => gbt_tx_aligned,
        din         => to_gbt,
        dout        => to_gbt_mux
    );     
     
    -- Output aligner
    gbt_tx_aligner_inst : entity work.gbt_tx_aligner
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        from_gbt    => from_gbt,
        rx_aligned  => gbt_rx_aligned,
        bitslip     => gbt_tx_slip,
        gbt_aligned => gbt_tx_aligned
    );       
     
    -- Output bitslip
    gbt_tx_bitslip_inst : entity work.gbt_tx_bitslip    
    generic map(
        DEBUG       => DEBUG
    )
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        bitslip     => gbt_tx_slip,
        din         => to_gbt_mux,
        dout        => to_gbt_raw
    );  

    -- Output serializer
--    to_gbt_ser_inst : entity work.to_gbt_ser
--    port map(
--        data_out_from_device    => to_gbt_raw,
--        data_out_to_pins_p      => to_gbt_p,
--        data_out_to_pins_n      => to_gbt_n,
--        clk_in                  => data_clk,
--        clk_div_in              => fabric_clk,
--        io_reset                => io_reset
--    ); 

    gbt0 : obufds generic map(iostandard  => "lvds_25") port map(i => '0', o => to_gbt_p(0), ob => to_gbt_n(0));
    gbt1 : obufds generic map(iostandard  => "lvds_25") port map(i => '0', o => to_gbt_p(1), ob => to_gbt_n(1));
    gbt2 : obufds generic map(iostandard  => "lvds_25") port map(i => '0', o => to_gbt_p(2), ob => to_gbt_n(2));
    gbt3 : obufds generic map(iostandard  => "lvds_25") port map(i => '0', o => to_gbt_p(3), ob => to_gbt_n(3));
    
    -- DONE
    -- to_gbt holds the data you want to send
    to_gbt <= data_i;
    
    valid_o <= gbt_rx_aligned and gbt_tx_aligned;
    rx_aligned_o <= gbt_rx_aligned;
    tx_aligned_o <= gbt_tx_aligned;
    
    --===========--
    --== OTHER ==--
    --===========--
    
    header_io <= gbt_rx_aligned & gbt_tx_aligned & from_gbt(13 downto 0);

end Behavioral;

