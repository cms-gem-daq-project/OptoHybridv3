library ieee;
use ieee.std_logic_1164.all;

entity gbt_rx_data_mux is
generic(
    DEBUG : boolean := FALSE
);
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    din         : in std_logic_vector(15 downto 0);
    dout        : out std_logic_vector(15 downto 0)
);
end gbt_rx_data_mux;

architecture behavioral of gbt_rx_data_mux is

    signal data_inv : std_logic_vector(15 downto 0);

begin

    debug_gen : if DEBUG = TRUE generate
    begin
    
        dout <= din;
        
    end generate;
    
    nodebug_gen : if DEBUG = FALSE generate
    begin

        data_inv <= not din;
        dout <= data_inv(1) & data_inv(3) & data_inv(5) & data_inv(7) & data_inv(9) & data_inv(11) & data_inv(13) & data_inv(15) & data_inv(0) & data_inv(2) & data_inv(4) & data_inv(6) & data_inv(8) & data_inv(10) & data_inv(12) & data_inv(14);
    
    end generate;
    
end behavioral;

