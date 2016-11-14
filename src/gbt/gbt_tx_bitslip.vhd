library ieee;
use ieee.std_logic_1164.all;

entity gbt_tx_bitslip is
port(
    fabric_clk  : in std_logic;
    reset       : in std_logic;
    bitslip_cnt : in integer range 0 to 7;
    din         : in std_logic_vector(31 downto 0);
    dout        : out std_logic_vector(31 downto 0)
);
end gbt_tx_bitslip;

architecture behavioral of gbt_tx_bitslip is

    signal buf1     : std_logic_vector(15 downto 0); -- buffer for elink 1
    signal buf2     : std_logic_vector(15 downto 0); -- buffer for elink 2
    signal buf3     : std_logic_vector(15 downto 0); -- buffer for elink 3
    signal buf4     : std_logic_vector(15 downto 0); -- buffer for elink 4

    signal data     : std_logic_vector(31 downto 0);
    signal data_inv : std_logic_vector(31 downto 0);

begin
	
    process(fabric_clk)
    begin
        if (rising_edge(fabric_clk)) then
            if (reset = '1') then
                buf1 <= (others => '0');
                buf2 <= (others => '0');
                buf3 <= (others => '0');
                buf4 <= (others => '0');
                data <= (others => '0');
            else
                buf1 <= buf1(7 downto 0) & din(7 downto 0);
                buf2 <= buf2(7 downto 0) & din(15 downto 8);
                buf3 <= buf3(7 downto 0) & din(23 downto 16);
                buf4 <= buf4(7 downto 0) & din(31 downto 24);

                data <= buf4((7 + bitslip_cnt) downto bitslip_cnt) &
					    buf3((7 + bitslip_cnt) downto bitslip_cnt) & 
                        buf2((7 + bitslip_cnt) downto bitslip_cnt) &
                        buf1((7 + bitslip_cnt) downto bitslip_cnt);
            end if;
        end if;
    end process;
    
    -- Rearrane data
    
    data_inv <= (not data(31 downto 24)) & data(23 downto 16) & (not  data(15 downto 0));
    
    dout <= data_inv(24) & data_inv(16) & data_inv(8) & data_inv(0) &
            data_inv(25) & data_inv(17) & data_inv(9) & data_inv(1) &
            data_inv(26) & data_inv(18) & data_inv(10) & data_inv(2) &
            data_inv(27) & data_inv(19) & data_inv(11) & data_inv(3) &
            data_inv(28) & data_inv(20) & data_inv(12) & data_inv(4) &
            data_inv(29) & data_inv(21) & data_inv(13) & data_inv(5) &
            data_inv(30) & data_inv(22) & data_inv(14) & data_inv(6) &
            data_inv(31) & data_inv(23) & data_inv(15) & data_inv(7);

end behavioral;