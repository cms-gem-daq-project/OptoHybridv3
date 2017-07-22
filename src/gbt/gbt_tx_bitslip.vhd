library ieee;
use ieee.std_logic_1164.all;

entity gbt_tx_bitslip is
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    bitslip_cnt : in integer range 0 to 7;
    din         : in std_logic_vector(15 downto 0);
    dout        : out std_logic_vector(15 downto 0)
);
end gbt_tx_bitslip;

architecture behavioral of gbt_tx_bitslip is

    signal buf1     : std_logic_vector(15 downto 0); -- buffer for elink 1
    signal buf2     : std_logic_vector(15 downto 0); -- buffer for elink 2

    signal data     : std_logic_vector(15 downto 0);
    signal data_inv : std_logic_vector(15 downto 0);

begin

    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                buf1 <= (others => '0');
                buf2 <= (others => '0');
                data <= (others => '0');
            else
                buf1 <= buf1(7 downto 0) & din(7 downto 0);
                buf2 <= buf2(7 downto 0) & din(15 downto 8);

                data <= buf2((7 + bitslip_cnt) downto bitslip_cnt) &
                        buf1((7 + bitslip_cnt) downto bitslip_cnt);
            end if;
        end if;
    end process;

    -- Rearrange data

    data_inv <= (not  data(15 downto 0));

    dout     <= not data_inv(1) & not data_inv(3)  & not data_inv(5)  & not data_inv(7)   &
                not data_inv(9) & not data_inv(11) & not data_inv(13) & not data_inv(15)  &
                not data_inv(0) & not data_inv(2)  & not data_inv(4)  & not data_inv(6)   &
                not data_inv(8) & not data_inv(10) & not data_inv(12) & not data_inv(14);

end behavioral;
