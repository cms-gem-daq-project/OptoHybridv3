----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:02:05 07/08/2015
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_switch_test - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 
 
library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity wb_switch_test is
end wb_switch_test;
 
architecture behavior of wb_switch_test is 

    --Inputs
    signal wb_clk_i         : std_logic := '0';
    signal reset_i          : std_logic := '0';
    signal wb_m_req_i       : wb_req_array_t((WB_MASTERS - 1) downto 0);
    signal wb_s_res_i       : wb_res_array_t((WB_SLAVES - 1) downto 0);

    --Outputs
    signal wb_s_req_o       : wb_req_array_t((WB_SLAVES - 1) downto 0);
    signal wb_m_res_o       : wb_res_array_t((WB_MASTERS - 1) downto 0);

    constant wb_clk_period  : time := 10 ns;
    constant empty_sig      : wb_req_t := (addr  => (others => '0'), data  => (others => '0'), we    => '0', stb   => '0');

begin
 
    -- Instantiate the Unit Under Test (UUT)
    uut : entity work.wb_switch 
    port map(
        wb_clk_i    => wb_clk_i,
        reset_i     => reset_i,
        wb_m_req_i  => wb_m_req_i,
        wb_s_req_o  => wb_s_req_o,
        wb_s_res_i  => wb_s_res_i,
        wb_m_res_o  => wb_m_res_o
    );

    -- Clock process definitions
    process
    begin
        wb_clk_i <= '1';
        wait for wb_clk_period / 2;
        wb_clk_i <= '0';
        wait for wb_clk_period / 2;
    end process;
    
    -- Reset process
    process
    begin		
        reset_i <= '1';
        wait for 100 ns;
        reset_i <= '0';
        wait;
    wait;
    end process;
    
    -- Data process
    process
    begin
        wb_m_req_i(0) <= empty_sig;
        wb_m_req_i(1) <= empty_sig;
        wait for 150 ns;
        ---
        wb_m_req_i(0) <= (addr  => x"00000000",
                          data  => (others => '0'),
                          we    => '1',
                          stb   => '1');        
        wb_m_req_i(1) <= (addr  => x"00000025",
                          data  => (others => '0'),
                          we    => '1',
                          stb   => '1');      
        wb_m_req_i(2) <= (addr  => x"00000650",
                          data  => (others => '0'),
                          we    => '1',
                          stb   => '1');      
        wb_m_req_i(3) <= (addr  => x"00000601",
                          data  => (others => '0'),
                          we    => '1',
                          stb   => '1');
        wait for wb_clk_period;
        wb_m_req_i(0).stb <= '0';
        wb_m_req_i(1).stb <= '0';
        wb_m_req_i(2).stb <= '0';
        wb_m_req_i(3).stb <= '0';
        wait;
    end process;
    
    
    -- Slave simulation
    slaves_gen : for I in 0 to (WB_SLAVES - 1) generate
    begin
        process(wb_clk_i)
            variable num    : unsigned(31 downto 0);
        begin
            if (rising_edge(wb_clk_i)) then
                if (reset_i = '1') then
                    wb_s_res_i(I) <= (ack   => '0',
                                      stat  => "00",
                                      data  => (others => '0'));
                    num := (others => '0');
                else
                    if (wb_s_req_o(I).stb = '1') then
                        num := num + 1;
                        wb_s_res_i(I) <= (ack   => '1',
                                          stat  => "00",
                                          data  => std_logic_vector(num));
                    else
                        wb_s_res_i(I).ack <= '0';
                    end if;
                end if;
            end if;
        end process;
    end generate;

end;
