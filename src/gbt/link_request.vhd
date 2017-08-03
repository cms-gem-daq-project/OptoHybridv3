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
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;

entity link_request is
port(

    fabric_clock_i  : in std_logic;
    ext_clock_i     : in std_logic;
    reset_i         : in std_logic;

    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in  wb_res_t;

    rx_en_i         : in std_logic;
    rx_data_i       : in std_logic_vector(64 downto 0);

    tx_en_i         : in std_logic;
    tx_valid_o      : out std_logic;
    tx_data_o       : out std_logic_vector(31 downto 0)

);
end link_request;

architecture Behavioral of link_request is

    signal rd_valid : std_logic;
    signal rd_data  : std_logic_vector(64 downto 0);

begin

    --== RX buffer ==--

    fifo_request_rx_inst : entity work.fifo_request_rx
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

    --== Request processing ==--

    process(fabric_clock_i)
    begin
        if (rising_edge(fabric_clock_i)) then
            if (reset_i = '1') then
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
            else
                if (rd_valid = '1') then
                    wb_mst_req_o <= (
                                    stb => '1',
                                    we   => rd_data(64),
                                    addr => rd_data(63 downto 32),
                                    data => rd_data(31 downto 0)
                    );
                else
                    wb_mst_req_o.stb <= '0';
                end if;
            end if;
        end if;
    end process;

    --== TX buffer ==--

    fifo_request_tx_inst : entity work.fifo_request_tx
    port map(
        rst     => reset_i,
        clk     => fabric_clock_i,
        wr_en   => wb_mst_res_i.ack,
        din     => wb_mst_res_i.data,
        rd_en   => tx_en_i,
        valid   => tx_valid_o,
        dout    => tx_data_o,
        full    => open,
        empty   => open,
        sbiterr => open,
        dbiterr => open
    );

end Behavioral;
