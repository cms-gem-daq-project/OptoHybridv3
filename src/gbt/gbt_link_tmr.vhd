----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- GBT Link Parser
-- A. Peck
----------------------------------------------------------------------------------
-- Description: TMR wrapper for gbt link module
----------------------------------------------------------------------------------
-- 2019/05/16 -- Init
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.ipbus_pkg.all;

entity gbt_link_tmr is
  generic (g_ENABLE_TMR : integer := 1);
  port(

    -- reset
    reset_i : in std_logic;

    -- clk inputs
    clock : in std_logic;

    -- parallel data to/from serdes
    data_i : in  std_logic_vector (7 downto 0);
    data_o : out std_logic_vector(7 downto 0);

    -- wishbone
    ipb_mosi_o : out ipb_wbus;
    ipb_miso_i : in  ipb_rbus;

    -- decoded ttc
    l1a_o    : out std_logic;
    bc0_o    : out std_logic;
    resync_o : out std_logic;

    -- status
    ready_o    : out std_logic;
    error_o    : out std_logic;
    unstable_o : out std_logic
    );
end gbt_link_tmr;

architecture Behavioral of gbt_link_tmr is

begin

  NO_TMR : if (g_ENABLE_TMR = 0) generate
    gbt_link_inst : entity work.gbt_link
      generic map(
        g_TMR_INSTANCE => 0
        )
      port map(

        -- reset
        reset_i => reset_i,

        -- clock inputs
        clock => clock,

        -- parallel data
        data_i => data_i,
        data_o => data_o,

        -- wishbone master
        ipb_mosi_o => ipb_mosi_o,
        ipb_miso_i => ipb_miso_i,

        -- decoded TTC
        resync_o => resync_o,
        l1a_o    => l1a_o,
        bc0_o    => bc0_o,

        -- outputs
        unstable_o => unstable_o,
        error_o    => error_o
        );
  end generate NO_TMR;

  TMR : if (g_ENABLE_TMR = 1) generate
    signal resync_tmr   : std_logic_vector(2 downto 0);
    signal l1a_tmr      : std_logic_vector(2 downto 0);
    signal bc0_tmr      : std_logic_vector(2 downto 0);
    signal unstable_tmr : std_logic_vector(2 downto 0);
    signal rdy_tmr      : std_logic_vector(2 downto 0);
    signal error_tmr    : std_logic_vector(2 downto 0);
    signal ready_tmr    : std_logic_vector(2 downto 0);
    signal ipb_mosi_tmr : ipb_wbus_array (2 downto 0);
    signal data_tmr     : t_std8_array (2 downto 0);

    attribute DONT_TOUCH : string;

    attribute DONT_TOUCH of resync_tmr   : signal is "true";
    attribute DONT_TOUCH of l1a_tmr      : signal is "true";
    attribute DONT_TOUCH of bc0_tmr      : signal is "true";
    attribute DONT_TOUCH of unstable_tmr : signal is "true";
    attribute DONT_TOUCH of rdy_tmr      : signal is "true";
    attribute DONT_TOUCH of error_tmr    : signal is "true";
    attribute DONT_TOUCH of ready_tmr    : signal is "true";
    attribute DONT_TOUCH of ipb_mosi_tmr : signal is "true";
    attribute DONT_TOUCH of data_tmr     : signal is "true";
  begin

    tmr_loop : for I in 0 to 2 generate
    begin
      gbt_link_inst : entity work.gbt_link
        generic map(
          g_TMR_INSTANCE => I
          )
        port map(

          -- reset
          reset_i => reset_i,

          -- clock inputs
          clock => clock,

          -- parallel data
          data_i => data_i,
          data_o => data_tmr(I),

          -- wishbone master
          ipb_mosi_o => ipb_mosi_tmr(I),
          ipb_miso_i => ipb_miso_i,

          -- decoded TTC
          resync_o => resync_tmr(I),
          l1a_o    => l1a_tmr(I),
          bc0_o    => bc0_tmr(I),

          -- outputs
          unstable_o => unstable_tmr(I),
          error_o    => error_tmr(I)

          );

    end generate;

    data_o <= majority (data_tmr(0), data_tmr(1), data_tmr(2));

    ipb_mosi_o.ipb_wdata  <= majority (ipb_mosi_tmr(0).ipb_wdata, ipb_mosi_tmr(1).ipb_wdata, ipb_mosi_tmr(2).ipb_wdata);
    ipb_mosi_o.ipb_write  <= majority (ipb_mosi_tmr(0).ipb_write, ipb_mosi_tmr(1).ipb_write, ipb_mosi_tmr(2).ipb_write);
    ipb_mosi_o.ipb_strobe <= majority (ipb_mosi_tmr(0).ipb_strobe, ipb_mosi_tmr(1).ipb_strobe, ipb_mosi_tmr(2).ipb_strobe);
    ipb_mosi_o.ipb_addr   <= majority (ipb_mosi_tmr(0).ipb_addr, ipb_mosi_tmr(1).ipb_addr, ipb_mosi_tmr(2).ipb_addr);

    resync_o <= majority (resync_tmr(0), resync_tmr(1), resync_tmr(2));
    l1a_o    <= majority (l1a_tmr(0), l1a_tmr(1), l1a_tmr(2));
    bc0_o    <= majority (bc0_tmr(0), bc0_tmr(1), bc0_tmr(2));

    unstable_o <= majority (unstable_tmr(0), unstable_tmr(1), unstable_tmr(2));
    error_o    <= majority (error_tmr(0), error_tmr(1), error_tmr(2));
    ready_o    <= majority (ready_tmr(0), ready_tmr(1), ready_tmr(2));
  end generate TMR;

end Behavioral;
