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

library xpm;
use xpm.vcomponents.all;

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

library work;
use work.ipbus_pkg.all;
use work.hardware_pkg.all;

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

  -- Rx Request processing

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

  --------------------------------------------------------------------------------
  -- Artix 7
  --------------------------------------------------------------------------------

  gen_fifo_series7 : if (FPGA_TYPE = "A7") generate


    gbt_rx_fifo_inst : xpm_fifo_sync
      generic map (
        DOUT_RESET_VALUE    => "0",      -- String
        ECC_MODE            => "en_ecc", -- String
        FIFO_MEMORY_TYPE    => "block",  -- String
        FIFO_READ_LATENCY   => 2,        -- DECIMAL
        FULL_RESET_VALUE    => 0,        -- DECIMAL
        PROG_EMPTY_THRESH   => 3,        -- DECIMAL
        PROG_FULL_THRESH    => 3,        -- DECIMAL
        READ_MODE           => "std",    -- String
        USE_ADV_FEATURES    => "0707",   -- String
        WAKEUP_TIME         => 0,        -- DECIMAL
        FIFO_WRITE_DEPTH    => 512,      -- DECIMAL
        READ_DATA_WIDTH     => 64,       -- DECIMAL
        WRITE_DATA_WIDTH    => 64,       -- DECIMAL
        RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
        WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
        )
      port map (
        almost_empty       => open,            -- 1-bit output: Almost Empty : When asserted, this signal indicates that only one more read can be performed before the FIFO goes to empty.
        almost_full        => open,            -- 1-bit output: Almost Full: When asserted, this signal indicates that only one more write can be performed before the FIFO is full.
        data_valid         => rd_valid,        -- 1-bit output: Read Data Valid: When asserted, this signal indicates that valid data is available on the output bus (dout).
        dbiterr            => open,            -- 1-bit output: Double Bit Error: Indicates that the ECC decoder detected a double-bit error and data in the FIFO core is corrupted.
        dout(48 downto 0)  => rd_data,         -- READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven when reading the FIFO.
        dout(63 downto 49) => open,            -- READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven when reading the FIFO.
        empty              => open,            -- 1-bit output: Empty Flag: When asserted, this signal indicates that the FIFO is empty. Read requests are ignored when the FIFO is empty, initiating a read while empty is not destructive to the FIFO.
        full               => open,            -- 1-bit output: Full Flag: When asserted, this signal indicates that the FIFO is full. Write requests are ignored when the FIFO is full, initiating a write when the FIFO is full is not destructive to the contents of the FIFO.
        overflow           => open,            -- 1-bit output: Overflow: This signal indicates that a write request (wren) during the prior clock cycle was rejected, because the FIFO is full. Overflowing the FIFO is not destructive to the contents of the FIFO.
        prog_empty         => open,            -- 1-bit output: Programmable Empty: This signal is asserted when the number of words in the FIFO is less than or equal to the programmable empty threshold value. It is de-asserted when the number of words in the FIFO exceeds the programmable empty threshold value.
        prog_full          => open,            -- 1-bit output: Programmable Full: This signal is asserted when the number of words in the FIFO is greater than or equal to the programmable full threshold value. It is de-asserted when the number of words in the FIFO is less than the programmable full threshold value.
        rd_data_count      => open,            -- RD_DATA_COUNT_WIDTH-bit output: Read Data Count: This bus indicates the number of words read from the FIFO.
        rd_rst_busy        => open,            -- 1-bit output: Read Reset Busy: Active-High indicator that the FIFO read domain is currently in a reset state.
        sbiterr            => open,            -- 1-bit output: Single Bit Error: Indicates that the ECC decoder detected and fixed a single-bit error.
        underflow          => open,            -- 1-bit output: Underflow: Indicates that the read request (rd_en) during the previous clock cycle was rejected because the FIFO is empty. Under flowing the FIFO is not destructive to the FIFO.
        wr_ack             => open,            -- 1-bit output: Write Acknowledge: This signal indicates that a write request (wr_en) during the prior clock cycle is succeeded.
        wr_data_count      => open,            -- WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus indicates the number of words written into the FIFO.
        wr_rst_busy        => open,            -- 1-bit output: Write Reset Busy: Active-High indicator that the FIFO write domain is currently in a reset state.
        din(48 downto 0)   => rx_data_i,       -- WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when writing the FIFO.
        din(63 downto 49)  => (others => '0'), -- WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when writing the FIFO.
        injectdbiterr      => '0',             -- 1-bit input: Double Bit Error Injection: Injects a double bit error if the ECC feature is used on block RAMs or UltraRAM macros.
        injectsbiterr      => '0',             -- 1-bit input: Single Bit Error Injection: Injects a single bit error if the ECC feature is used on block RAMs or UltraRAM macros.
        rd_en              => '1',             -- 1-bit input: Read Enable: If the FIFO is not empty, asserting this signal causes data (on dout) to be read from the FIFO. Must be held active-low when rd_rst_busy is active high. .
        rst                => reset_i,         -- 1-bit input: Reset: Must be synchronous to wr_clk. Must be applied only when wr_clk is stable and free-running.
        sleep              => '0',             -- 1-bit input: Dynamic power saving- If sleep is High, the memory/fifo block is in power saving mode.
        wr_clk             => fabric_clock_i,  -- 1-bit input: Write clock: Used for write operation. wr_clk must be a free running clock.
        wr_en              => rx_en_i          -- 1-bit input: Write Enable: If the FIFO is not full, asserting this signal causes data (on din) to be written to the FIFO Must be held active-low when rst or wr_rst_busy or rd_rst_busy is active high
        );

    gbt_tx_fifo_inst : xpm_fifo_sync
      generic map (
        DOUT_RESET_VALUE    => "0",      -- String
        ECC_MODE            => "no_ecc", -- String
        FIFO_MEMORY_TYPE    => "block",  -- String
        FIFO_READ_LATENCY   => 2,        -- DECIMAL
        FIFO_WRITE_DEPTH    => 512,      -- DECIMAL
        FULL_RESET_VALUE    => 0,        -- DECIMAL
        PROG_EMPTY_THRESH   => 3,        -- DECIMAL
        PROG_FULL_THRESH    => 3,        -- DECIMAL
        RD_DATA_COUNT_WIDTH => 1,        -- DECIMAL
        READ_DATA_WIDTH     => 32,       -- DECIMAL
        READ_MODE           => "std",    -- String
        USE_ADV_FEATURES    => "0707",   -- String
        WAKEUP_TIME         => 0,        -- DECIMAL
        WRITE_DATA_WIDTH    => 32,       -- DECIMAL
        WR_DATA_COUNT_WIDTH => 1         -- DECIMAL
        )
      port map (
        almost_empty  => open,                 -- 1-bit output: Almost Empty : When asserted, this signal indicates that only one more read can be performed before the FIFO goes to empty.
        almost_full   => open,                 -- 1-bit output: Almost Full: When asserted, this signal indicates that only one more write can be performed before the FIFO is full.
        data_valid    => tx_valid_o,           -- 1-bit output: Read Data Valid: When asserted, this signal indicates that valid data is available on the output bus (dout).
        dbiterr       => open,                 -- 1-bit output: Double Bit Error: Indicates that the ECC decoder detected a double-bit error and data in the FIFO core is corrupted.
        dout          => tx_data_o,            -- READ_DATA_WIDTH-bit output: Read Data: The output data bus is driven when reading the FIFO.
        empty         => open,                 -- 1-bit output: Empty Flag: When asserted, this signal indicates that the FIFO is empty. Read requests are ignored when the FIFO is empty, initiating a read while empty is not destructive to the FIFO.
        full          => open,                 -- 1-bit output: Full Flag: When asserted, this signal indicates that the FIFO is full. Write requests are ignored when the FIFO is full, initiating a write when the FIFO is full is not destructive to the contents of the FIFO.
        overflow      => open,                 -- 1-bit output: Overflow: This signal indicates that a write request (wren) during the prior clock cycle was rejected, because the FIFO is full. Overflowing the FIFO is not destructive to the contents of the FIFO.
        prog_empty    => open,                 -- 1-bit output: Programmable Empty: This signal is asserted when the number of words in the FIFO is less than or equal to the programmable empty threshold value. It is de-asserted when the number of words in the FIFO exceeds the programmable empty threshold value.
        prog_full     => open,                 -- 1-bit output: Programmable Full: This signal is asserted when the number of words in the FIFO is greater than or equal to the programmable full threshold value. It is de-asserted when the number of words in the FIFO is less than the programmable full threshold value.
        rd_data_count => open,                 -- RD_DATA_COUNT_WIDTH-bit output: Read Data Count: This bus indicates the number of words read from the FIFO.
        rd_rst_busy   => open,                 -- 1-bit output: Read Reset Busy: Active-High indicator that the FIFO read domain is currently in a reset state.
        sbiterr       => open,                 -- 1-bit output: Single Bit Error: Indicates that the ECC decoder detected and fixed a single-bit error.
        underflow     => open,                 -- 1-bit output: Underflow: Indicates that the read request (rd_en) during the previous clock cycle was rejected because the FIFO is empty. Under flowing the FIFO is not destructive to the FIFO.
        wr_ack        => open,                 -- 1-bit output: Write Acknowledge: This signal indicates that a write request (wr_en) during the prior clock cycle is succeeded.
        wr_data_count => open,                 -- WR_DATA_COUNT_WIDTH-bit output: Write Data Count: This bus indicates the number of words written into the FIFO.
        wr_rst_busy   => open,                 -- 1-bit output: Write Reset Busy: Active-High indicator that the FIFO write domain is currently in a reset state.
        din           => ipb_miso_i.ipb_rdata, -- WRITE_DATA_WIDTH-bit input: Write Data: The input data bus used when writing the FIFO.
        injectdbiterr => '0',                  -- 1-bit input: Double Bit Error Injection: Injects a double bit error if the ECC feature is used on block RAMs or UltraRAM macros.
        injectsbiterr => '0',                  -- 1-bit input: Single Bit Error Injection: Injects a single bit error if the ECC feature is used on block RAMs or UltraRAM macros.
        rd_en         => tx_en_i,              -- 1-bit input: Read Enable: If the FIFO is not empty, asserting this signal causes data (on dout) to be read from the FIFO. Must be held active-low when rd_rst_busy is active high. .
        rst           => reset_i,              -- 1-bit input: Reset: Must be synchronous to wr_clk. Must be applied only when wr_clk is stable and free-running.
        sleep         => '0',                  -- 1-bit input: Dynamic power saving- If sleep is High, the memory/fifo block is in power saving mode.
        wr_clk        => fabric_clock_i,       -- 1-bit input: Write clock: Used for write operation. wr_clk must be a free running clock.
        wr_en         => ipb_miso_i.ipb_ack    -- 1-bit input: Write Enable: If the FIFO is not full, asserting this signal causes data (on din) to be written to the FIFO Must be held active-low when rst or wr_rst_busy or rd_rst_busy is active high
        );

  end generate gen_fifo_series7;

  gen_fifo_series6 : if (FPGA_TYPE = "V6") generate
    fifo_request_rx_inst : fifo_request_rx
      port map(
        rst     => reset_i,
        clk     => fabric_clock_i,
        din     => rx_data_i,
        dout    => rd_data,
        rd_en   => '1',
        wr_en   => rx_en_i,
        valid   => rd_valid,
        full    => open,
        empty   => open,
        sbiterr => open,
        dbiterr => open
        );
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
  end generate gen_fifo_series6;

end Behavioral;
