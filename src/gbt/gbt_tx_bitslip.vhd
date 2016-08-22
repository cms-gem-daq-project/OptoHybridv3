library ieee;
use ieee.std_logic_1164.all;

entity gbt_tx_bitslip is
generic(
    DEBUG : boolean := FALSE
);
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    bitslip     : in std_logic;
    din         : in std_logic_vector(31 downto 0);
    dout        : out std_logic_vector(31 downto 0)
);
end gbt_tx_bitslip;

architecture behavioral of gbt_tx_bitslip is

    signal tmp : std_logic_vector(63 downto 0);
    signal slip_cnt : integer range 0 to 31;

    signal data : std_logic_vector(31 downto 0);
    signal data_inv : std_logic_vector(31 downto 0);

begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                tmp <= (others => '0');
                slip_cnt <= 0;
                data <= (others => '0');
            elsif (bitslip = '1') then
                tmp <= din & tmp(63 downto 32);
                slip_cnt <= slip_cnt + 1;
                data <= tmp((31 + slip_cnt) downto slip_cnt);
            else
                tmp <= din & tmp(63 downto 32);
                slip_cnt <= slip_cnt;
                data <= tmp((31 + slip_cnt) downto slip_cnt);
            end if;
        end if;
    end process;
    
    -- Rearrane data

    debug_gen : if DEBUG = TRUE generate
    begin    dout <= data;
        
    end generate;
    
    nodebug_gen : if DEBUG = FALSE generate
    begin

        data_inv <= (not data(31 downto 24)) & data(23 downto 16) & (not  data(15 downto 0));
        dout <= data_inv(24) & data_inv(16) & data_inv(8) & data_inv(0) & data_inv(25) & data_inv(17) & data_inv(9) & data_inv(1) & data_inv(26) & data_inv(18) & data_inv(10) & data_inv(2) & data_inv(27) & data_inv(19) & data_inv(11) & data_inv(3) & data_inv(28) & data_inv(20) & data_inv(12) & data_inv(4) & data_inv(29) & data_inv(21) & data_inv(13) & data_inv(5) & data_inv(30) & data_inv(22) & data_inv(14) & data_inv(6) & data_inv(31) & data_inv(23) & data_inv(15) & data_inv(7);

    end generate;

end behavioral;