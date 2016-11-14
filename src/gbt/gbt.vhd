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

   sync_reset_i     : in std_logic;
   
   to_gbt_p         : out std_logic_vector(3 downto 0);
   to_gbt_n         : out std_logic_vector(3 downto 0);
   
   from_gbt_p       : in std_logic_vector(1 downto 0);
   from_gbt_n       : in std_logic_vector(1 downto 0);
   
   data_clk_p       : in std_logic;
   data_clk_n       : in std_logic;
   
   gbt_ttc_clk_p    : in std_logic;
   gbt_ttc_clk_n    : in std_logic;
   
   gbt_clk_o        : out std_logic;
   
   data_i           : in std_logic_vector(31 downto 0);
   data_o           : out std_logic_vector(15 downto 0);
   valid_o          : out std_logic;
   
   header_io        : out std_logic_vector(15 downto 0)
   
);
end gbt;

architecture Behavioral of gbt is
    
    signal from_gbt_raw     : std_logic_vector(15 downto 0) := (others => '0');
    signal from_gbt         : std_logic_vector(15 downto 0) := (others => '0');
    
    signal to_gbt           : std_logic_vector(31 downto 0) := (others => '0');
    signal to_gbt_raw       : std_logic_vector(31 downto 0) := (others => '0');
    
    signal data_clk_tmp     : std_logic := '0';
    signal fabric_clk_tmp   : std_logic := '0';
    signal data_clk_inv     : std_logic := '0';
    signal fabric_clk_inv   : std_logic := '0';
    signal data_clk         : std_logic := '0';
    signal fabric_clk       : std_logic := '0';
    signal io_reset         : std_logic := '0';
    
begin

    --================--
    --==   Wiring   ==--
    --================--
    
    gbt_clk_o <= fabric_clk;
    data_o <= from_gbt;
    to_gbt <= data_i;

    --================--
    --==    RESET   ==--
    --================--
    
    -- power-on reset - this must be a fabric_clk synchronous pulse of a minimum of 2 and max 32 clock cycles (ISERDES spec)
    process(fabric_clk)
        variable countdown : integer := 400_000; -- 10ms - probably way too long, but ok for now
        variable pulse_length : integer := 5;
    begin
        if (falling_edge(fabric_clk)) then
            if (countdown > 0) then
              io_reset <= '0';
              countdown := countdown - 1;
            else
                if (sync_reset_i = '1') then
                    pulse_length := 5;
                end if;
                
                if (pulse_length > 0) then
                    io_reset <= '1';
                    pulse_length := pulse_length - 1;
                else
                    io_reset <= '0';
                end if;
            end if;
        end if;
    end process; 

    --=====================--
    --==   I/O Buffers   ==--
    --=====================--
    
    --------- GBT TTC clock ---------
    
    i_ibufgds_clk_gbt_ttc : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => gbt_ttc_clk_p,
        IB  => gbt_ttc_clk_n,
        O   => fabric_clk_tmp
    );
    
    i_bufg_clk_gbt_ttc : BUFG
    port map(
        I   => fabric_clk_tmp,
        O   => fabric_clk_inv
    );

    fabric_clk <= not fabric_clk_inv;

    --------- GBT elink clock ---------

    i_ibufgds_clk_gbt_data : IBUFGDS
    generic map(
        iostandard      => "lvds_25"
    )
    port map(
        I   => data_clk_p,
        IB  => data_clk_n,
        O   => data_clk_tmp
    );
    
    i_bufg_clk_gbt_data : BUFG
    port map(
        I   => data_clk_tmp,
        O   => data_clk_inv
    );

    data_clk <= not data_clk_inv;

    --================--
    --== INPUT DATA ==--
    --================--

    -- Input deserializer
    i_from_gbt_des : entity work.from_gbt_des
    port map(
        data_in_from_pins_p => from_gbt_p,
        data_in_from_pins_n => from_gbt_n,
        data_in_to_device   => from_gbt_raw,
        bitslip             => '0',
        clk_in              => data_clk,
        clk_div_in          => fabric_clk,
        io_reset            => io_reset
    );    
    
    from_gbt <= not from_gbt_raw(1) & not from_gbt_raw(3) & not from_gbt_raw(5) & not from_gbt_raw(7) &
                not from_gbt_raw(9) & not from_gbt_raw(11) & not from_gbt_raw(13) & not from_gbt_raw(15) &
                not from_gbt_raw(0) & not from_gbt_raw(2) & not from_gbt_raw(4) & not from_gbt_raw(6) &
                not from_gbt_raw(8) & not from_gbt_raw(10) & not from_gbt_raw(12) & not from_gbt_raw(14);
        
    --=================--
    --== OUTPUT DATA ==--
    --=================--

    -- Bitslip and format the output to serializer
    -- Static bitslip count = 3
    i_gbt_tx_bitslip : entity work.gbt_tx_bitslip
    port map(
        fabric_clk  => fabric_clk,
        reset       => io_reset,
        bitslip_cnt => 7,
        din         => to_gbt,
        dout        => to_gbt_raw
    );  

    -- Output serializer
    i_to_gbt_ser : entity work.to_gbt_ser
    port map(
        data_out_from_device    => to_gbt_raw,
        data_out_to_pins_p      => to_gbt_p,
        data_out_to_pins_n      => to_gbt_n,
        clk_in                  => data_clk_inv,
        clk_div_in              => fabric_clk,
        io_reset                => io_reset
    ); 
        
    valid_o <= not io_reset;
    
    --===========--
    --== OTHER ==--
    --===========--
    
    header_io <= from_gbt(15 downto 0);

end Behavioral;

