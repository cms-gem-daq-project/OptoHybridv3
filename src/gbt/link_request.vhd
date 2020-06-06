----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Link Request
-- T. Lenzi, A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module buffers wishbone requests to and from the OH
----------------------------------------------------------------------------------
-- 2017/08/01 -- Initial working version with thermometer adapted from v2
-- 2018/09/10 -- Addition of Artix-7 primitives
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

library work;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;

library UNIMACRO;
use UNIMACRO.vcomponents.all;

entity link_request is
  port(

    fabric_clock_i : in std_logic;
    reset_i        : in std_logic;

    ipb_mosi_o : out ipb_wbus;
    ipb_miso_i : in  ipb_rbus;

    rx_en_i   : in std_logic;
    rx_data_i : in std_logic_vector(IPB_REQ_BITS-1 downto 0);

    tx_en_i    : in  std_logic;
    tx_valid_o : out std_logic;
    tx_data_o  : out std_logic_vector(31 downto 0)

    );
end link_request;

architecture Behavioral of link_request is

  signal rd_valid : std_logic;
  signal rd_data  : std_logic_vector(IPB_REQ_BITS-1 downto 0);

  signal sbiterr : std_logic;
  signal dbiterr : std_logic;

  component fifo_request_tx
    port (
      rst     : in  std_logic;
      clk     : in  std_logic;
      wr_en   : in  std_logic;
      din     : in  std_logic_vector(31 downto 0);
      rd_en   : in  std_logic;
      valid   : out std_logic;
      dout    : out std_logic_vector(31 downto 0);
      full    : out std_logic;
      empty   : out std_logic;
      sbiterr : out std_logic;
      dbiterr : out std_logic
      );
  end component;

  component fifo_request_rx
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      din     : in  std_logic_vector(48 downto 0);
      wr_en   : in  std_logic;
      rd_en   : in  std_logic;
      dout    : out std_logic_vector(48 downto 0);
      full    : out std_logic;
      empty   : out std_logic;
      valid   : out std_logic;
      sbiterr : out std_logic;
      dbiterr : out std_logic
      );
  end component;


begin

  --==============================================================================
  --== RX buffer
  --==============================================================================

  --==============--
  --== Virtex 6 ==--
  --==============--

  gen_rx_fifo_series6 : if (FPGA_TYPE = "V6") generate
    fifo_request_rx_inst : fifo_request_rx
      port map(
        rst     => reset_i,
        clk     => fabric_clock_i,
        wr_en   => rx_en_i,
        din     => rx_data_i,
        rd_en   => '1',
        valid   => rd_valid,
        dout    => rd_data,
        full    => open,
        empty   => open,
        sbiterr => open,
        dbiterr => open
        );
  end generate gen_rx_fifo_series6;

  --=============--
  --== Artix 7 ==--
  --=============--

  gbt_rx_fifo_inst : FIFO_DUALCLOCK_MACRO
    generic map (
      DEVICE                  => "7SERIES",  -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES"
      ALMOST_FULL_OFFSET      => X"0080",    -- Sets almost full threshold
      ALMOST_EMPTY_OFFSET     => X"0080",    -- Sets the almost empty threshold
      DATA_WIDTH              => 49,         -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
      FIFO_SIZE               => "36Kb",     -- Target BRAM, "18Kb" or "36Kb"
      FIRST_WORD_FALL_THROUGH => false)      -- Sets the FIFO FWFT to TRUE or FALSE
    port map (
      ALMOSTEMPTY => open,                   -- 1-bit output almost empty
      ALMOSTFULL  => open,                   -- 1-bit output almost full
      EMPTY       => open,                   -- 1-bit output empty
      FULL        => open,                   -- 1-bit output full
      RDCOUNT     => open,                   -- Output read count, width determined by FIFO depth
      RDERR       => open,                   -- 1-bit output read error
      WRCOUNT     => open,                   -- Output write count, width determined by FIFO depth
      WRERR       => open,                   -- 1-bit output write error
      DI          => rx_data_i,              -- Input data, width defined by DATA_WIDTH parameter
      DO          => rd_data,                -- Output data, width defined by DATA_WIDTH parameter
      RDCLK       => fabric_clock_i,         -- 1-bit input read clock
      RDEN        => '1',                    -- 1-bit input read enable
      RST         => reset_i,                -- 1-bit input reset
      WRCLK       => fabric_clock_i,         -- 1-bit input write clock
      WREN        => rx_en_i                 -- 1-bit input write enable
      );

  --== Rx Request processing ==--

  process(fabric_clock_i)
  begin
    if (rising_edge(fabric_clock_i)) then
      if (reset_i = '1') then
        ipb_mosi_o <= (ipb_strobe => '0', ipb_write => '0', ipb_addr => (others => '0'), ipb_wdata => (others => '0'));
      else
        if (rd_valid = '1') then
          ipb_mosi_o <= (
            ipb_strobe => '1',
            ipb_write  => rd_data(IPB_REQ_BITS-1),
            ipb_addr   => rd_data(47 downto 32),
            ipb_wdata  => rd_data(31 downto 0)
            );
        else
          ipb_mosi_o.ipb_strobe <= '0';
        end if;
      end if;
    end if;
  end process;

  --==============================================================================
  --== TX buffer
  --==============================================================================

  --==============--
  --== Virtex 6 ==--
  --==============--

  gen_tx_fifo_series6 : if (FPGA_TYPE = "V6") generate
    fifo_request_tx_inst : fifo_request_tx
      port map(
        rst     => reset_i,
        clk     => fabric_clock_i,
        wr_en   => ipb_miso_i.ipb_ack,
        din     => ipb_miso_i.ipb_rdata,
        rd_en   => tx_en_i,
        valid   => tx_valid_o,
        dout    => tx_data_o,
        full    => open,
        empty   => open,
        sbiterr => open,
        dbiterr => open
        );
  end generate gen_tx_fifo_series6;

  --=============--
  --== Artix 7 ==--
  --=============--

  gen_tx_fifo_series7 : if (FPGA_TYPE = "A7") generate
    gbt_tx_fifo_inst : FIFO_DUALCLOCK_MACRO
      generic map (
        DEVICE                  => "7SERIES",  -- Target Device: "VIRTEX5", "VIRTEX6", "7SERIES"
        ALMOST_FULL_OFFSET      => X"0080",    -- Sets almost full threshold
        ALMOST_EMPTY_OFFSET     => X"0080",    -- Sets the almost empty threshold
        DATA_WIDTH              => 32,         -- Valid values are 1-72 (37-72 only valid when FIFO_SIZE="36Kb")
        FIFO_SIZE               => "16Kb",     -- Target BRAM, "18Kb" or "36Kb"
        FIRST_WORD_FALL_THROUGH => false)      -- Sets the FIFO FWFT to TRUE or FALSE
      port map (
        ALMOSTEMPTY => open,                   -- 1-bit output almost empty
        ALMOSTFULL  => open,                   -- 1-bit output almost full
        EMPTY       => open,                   -- 1-bit output empty
        FULL        => open,                   -- 1-bit output full
        RDCOUNT     => open,                   -- Output read count, width determined by FIFO depth
        RDERR       => open,                   -- 1-bit output read error
        WRCOUNT     => open,                   -- Output write count, width determined by FIFO depth
        WRERR       => open,                   -- 1-bit output write error
        DI          => ipb_miso_i.ipb_rdata,   -- Input data, width defined by DATA_WIDTH parameter
        DO          => tx_data_o,              -- Output data, width defined by DATA_WIDTH parameter
        RDCLK       => fabric_clock_i,         -- 1-bit input read clock
        RDEN        => tx_en_i,                -- 1-bit input read enable
        RST         => reset_i,                -- 1-bit input reset
        WRCLK       => fabric_clock_i,         -- 1-bit input write clock
        WREN        => ipb_miso_i.ipb_ack      -- 1-bit input write enable
        );
  end generate gen_tx_fifo_series7;

end Behavioral;
