library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

entity oversample is
port(
  rxd_p       : in std_logic;
  rxd_n       : in std_logic;
  clk2x_0     : in std_logic;
  clk2x_90    : in std_logic;
  clk2x_180   : in std_logic;
  clk1x_logic : in std_logic;
  clk2x_logic : in std_logic;
  rst         : in std_logic;
  rxdata_o    : out std_logic_vector(7 downto 0)
);
end oversample;

architecture behavioral of oversample is

  signal data_p,data_n : std_logic;
  signal q             : std_logic_vector(7 downto 0);
  signal rxdata        : std_logic_vector(7 downto 0):=(others=>'0');
  signal rxce          : std_logic:='0';
  signal data          : std_logic_vector(1 downto 0);


begin

        rx_ibuf_d:ibufds_diff_out
        generic map(
                IBUF_LOW_PWR => TRUE,
                DIFF_TERM    => TRUE,
                IOSTANDARD   => "LVDS_25")
        port map(
                i=>rxd_p,
                ib=>rxd_n,
                o=>data_p,
                ob=>data_n
        );

        id_m:iodelaye1
        generic map(
                IDELAY_TYPE=>"FIXED",
                IDELAY_VALUE=>0,
                HIGH_PERFORMANCE_MODE => TRUE,
                REFCLK_FREQUENCY=>200.0)
        port map(
                c           => '0',
                t           => '1',
                rst         => '0',
                ce          => '0',
                inc         => '0',
                cinvctrl    => '0',
                cntvaluein  => "00000",
                clkin       => '0',
                idatain     => data_p,
                datain      => '0',
                odatain     => '0',
                dataout     => data(0),
                cntvalueout => open
        );

        id_s:iodelaye1
        generic map(
                IDELAY_TYPE           => "FIXED",
                IDELAY_VALUE          => 10,
                HIGH_PERFORMANCE_MODE => TRUE,
                REFCLK_FREQUENCY      => 200.0)
        port map(
                c           => '0',
                t           => '1',
                rst         => '0',
                ce          => '0',
                inc         => '0',
                cinvctrl    => '0',
                cntvaluein  => "01010",
                clkin       => '0',
                idatain     => data_n,
                datain      => '0',
                odatain     => '0',
                dataout     => data(1),
                cntvalueout => open
        );

        ise1_m:iserdese1
        generic map(
                INTERFACE_TYPE => "OVERSAMPLE",
                DATA_RATE      => "DDR", -- SPECIFY DATA RATE OF "DDR" OR "SDR"
                DATA_WIDTH     => 4,     -- SPECIFY DATA WIDTH: NETWORKING SDR: 2, 3, 4, 5, 6, 7, 8 : DDR 4, 6, 8, 10
                OFB_USED       => FALSE, --
                NUM_CE         => 2,     -- DEFINE NUMBER OR CLOCK ENABLES TO AN INTEGER OF 1 OR 2
                SERDES_MODE    => "MASTER",
                IOBDELAY       => "IFD")
        port map(
                clk          => clk2x_0,
                clkb         => clk2x_180,
                oclk         => clk2x_90,
                d            => '0',
                bitslip      => '0',
                ce1          => '1',
                ce2          => '1',
                clkdiv       => '0',
                ddly         => data(0),
                dynclkdivsel => '0',
                dynclksel    => '0',
                ofb          => '0',
                rst          => '0',
                shiftin1     => '0',
                shiftin2     => '0',
                o            => open,
                q1           => q(1),
                q2           => q(5),
                q3           => q(3),
                q4           => q(7),
                q5           => open,
                q6           => open,
                shiftout1    => open,
                shiftout2    => open
        );

        ise1_s:iserdese1
        generic map(
                INTERFACE_TYPE => "OVERSAMPLE",
                DATA_RATE      => "DDR", -- SPECIFY DATA RATE OF "DDR" OR "SDR"
                DATA_WIDTH     => 4,     -- SPECIFY DATA WIDTH: NETWORKING SDR: 2, 3, 4, 5, 6, 7, 8 : DDR 4, 6, 8, 10
                OFB_USED       => FALSE, --
                NUM_CE         => 2,     -- DEFINE NUMBER OR CLOCK ENABLES TO AN INTEGER OF 1 OR 2
                SERDES_MODE    => "MASTER",
                IOBDELAY       => "IFD")
        port map(
                clk          => clk2x_0,
                clkb         => clk2x_180,
                oclk         => clk2x_90,
                d            => '0',
                bitslip      => '0',
                ce1          => '1',
                ce2          => '1',
                clkdiv       => '0',
                ddly         => data(1),
                dynclkdivsel => '0',
                dynclksel    => '0',
                ofb          => '0',
                rst          => '0',
                shiftin1     => '0',
                shiftin2     => '0',
                o            => open,
                q1           => q(0),
                q2           => q(4),
                q3           => q(2),
                q4           => q(6),
                q5           => open,
                q6           => open,
                shiftout1    => open,
                shiftout2    => open
        );

        dr: entity work.dru
        port map(
                i     => q,           -- the even bits are inverted!
                clk1x => clk1x_logic, --
                clk2x => clk2x_logic, --
                o     => rxdata,      -- 8-bit deserialized data
                vo    => rxce         --
        );

        rxdata_o <= rxdata (7 downto 0);

end behavioral;
