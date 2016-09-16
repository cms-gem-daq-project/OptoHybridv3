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

--    process(fabric_clk)
--    begin
--        if (rising_edge(fabric_clk)) then
--            if (reset = '1') then
--                tmp <= (others => '0');
--                slip_cnt <= 0;
--                data <= (others => '0');
--            elsif (bitslip = '1') then
--                tmp <= din & tmp(63 downto 32);
--                slip_cnt <= slip_cnt + 1;
--                data <= tmp((31 + slip_cnt) downto slip_cnt);
--            else
--                tmp <= din & tmp(63 downto 32);
--                slip_cnt <= slip_cnt;
--                data <= tmp((31 + slip_cnt) downto slip_cnt);
--            end if;
--        end if;
--    end process;
    
--    dout <= (20 => not data(0),
--             16 => not data(1),
--             12 => not data(2),
--             8 => not data(3),
--             4 => not data(4),
--             0 => not data(5),
--             28 => not data(6),
--             24 => not data(7),
--             21 => not data(8),
--             17 => not data(9),
--             13 => not data(10),
--             9 => not data(11),
--             5 => not data(12),
--             1 => not data(13),
--             29 => not data(14),
--             25 => not data(15),
--             18 => data(16),
--             14 => data(17),
--             10 => data(18),
--             6 => data(19),
--             2 => data(20),
--             30 => data(21),
--             26 => data(22),
--             22 => data(23),
--             23 => not data(24),
--             19 => not data(25),
--             15 => not data(26),
--             11 => not data(27),
--             7 => not data(28),
--             3 => not data(29),
--             31 => not data(30),
--             27 => not data(31));
    
    
    process(fabric_clk)
        variable state : integer range 0 to 47 := 0;
    begin
        if (rising_edge(fabric_clk)) then
            case state is 
                when 0 to 15  => data <= x"00000000";
                when 16 => data <= x"00000001";
                when 17 => data <= x"00000002";
                when 18 => data <= x"00000004";
                when 19 => data <= x"00000008";
                when 20 => data <= x"00000010";
                when 21 => data <= x"00000020";
                when 22 => data <= x"00000040";
                when 23 => data <= x"00000080";
                when 24 => data <= x"00000100";
                when 25 => data <= x"00000200";
                when 26 => data <= x"00000400";
                when 27 => data <= x"00000800";
                when 28 => data <= x"00001000";
                when 29 => data <= x"00002000";
                when 30 => data <= x"00004000";
                when 31 => data <= x"00008000";
                when 32 => data <= x"00010000";
                when 33 => data <= x"00020000";
                when 34 => data <= x"00040000";
                when 35 => data <= x"00080000";
                when 36 => data <= x"00100000";
                when 37 => data <= x"00200000";
                when 38 => data <= x"00400000";
                when 39 => data <= x"00800000";
                when 40 => data <= x"01000000";
                when 41 => data <= x"02000000";
                when 42 => data <= x"04000000";
                when 43 => data <= x"08000000";
                when 44 => data <= x"10000000";
                when 45 => data <= x"20000000";
                when 46 => data <= x"40000000";
                when 47 => data <= x"80000000";
                when others => data <= x"00000000";
            end case;
            dout <= (20 => not data(0),
                     16 => not data(1),
                     12 => not data(2),
                     8 => not data(3),
                     4 => not data(4),
                     0 => not data(5),
                     28 => not data(6),
                     24 => not data(7),
                     21 => not data(8),
                     17 => not data(9),
                     13 => not data(10),
                     9 => not data(11),
                     5 => not data(12),
                     1 => not data(13),
                     29 => not data(14),
                     25 => not data(15),
                     18 => data(16),
                     14 => data(17),
                     10 => data(18),
                     6 => data(19),
                     2 => data(20),
                     30 => data(21),
                     26 => data(22),
                     22 => data(23),
                     23 => not data(24),
                     19 => not data(25),
                     15 => not data(26),
                     11 => not data(27),
                     7 => not data(28),
                     3 => not data(29),
                     31 => not data(30),
                     27 => not data(31));            
            if (state = 47) then
                state := 0;
            else
                state := state + 1;
            end if;
        end if;
    end process;
    
--    -- Rearrane data
--
--    debug_gen : if DEBUG = TRUE generate
--    begin    
--    
--        dout <= data;
--        
--    end generate;
--    
--    nodebug_gen : if DEBUG = FALSE generate
--    begin
--
--        data_inv <= (not data(31 downto 24)) & data(23 downto 16) & (not data(15 downto 0));
--        dout <= data_inv(24) & data_inv(16) & data_inv(8) & data_inv(0) & 
--                data_inv(25) & data_inv(17) & data_inv(9) & data_inv(1) & 
--                data_inv(26) & data_inv(18) & data_inv(10) & data_inv(2) & 
--                data_inv(27) & data_inv(19) & data_inv(11) & data_inv(3) & 
--                data_inv(28) & data_inv(20) & data_inv(12) & data_inv(4) & 
--                data_inv(29) & data_inv(21) & data_inv(13) & data_inv(5) & 
--                data_inv(30) & data_inv(22) & data_inv(14) & data_inv(6) & 
--                data_inv(31) & data_inv(23) & data_inv(15) & data_inv(7);
--
--    end generate;

end behavioral;