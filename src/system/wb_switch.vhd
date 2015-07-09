----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    14:33:08 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Wishbone switch
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

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity wb_switch is
generic(
    
    MASTERS     : integer := 1;
    SLAVES      : integer := 3
    
);
port(

    wb_clk_i    : in std_logic;
    reset_i     : in std_logic;
    
    wb_req_i    : in wb_req_array_t((MASTERS - 1) downto 0);
    wb_req_o    : out wb_req_array_t((SLAVES - 1) downto 0);
    
    wb_res_i    : in wb_req_array_t((SLAVES - 1) downto 0);
    wb_res_o    : out wb_req_array_t((MASTERS - 1) downto 0)

);
end wb_switch;

architecture Behavioral of wb_switch is
begin

    --== reqs IN reqs OUT ==--

    req_process_loop : for I in 0 to SLAVES generate  
    begin
    
        process(wb_clk_i)
        
            variable fnd_mux    : std_logic;
            variable sel        : integer;
        
        begin
            if (rising_edge(wb_clk_i)) then
                if (reset_i = '1') then
                    wb_req_o(I) <= (addr => (others => '0'),
                                    data => (others => '0'),
                                    we => '0',
                                    stb => '0');
                else
                
                    fnd_mux := '0';
                    
                    for I in 0 to (MASTERS - 1) loop
                        if (fnd_mux = '0' and wb_req_i(I).stb = '1') then
                            sel := wb_addr_sel(wb_req_i(I).addr);
                            wb_req_o(sel).addr <= wb_req_i(I).addr;
                            wb_req_o(sel).data <= wb_req_i(I).data;
                            wb_req_o(sel).we <= wb_req_i(I).we;                    
                            wb_req_o(sel).stb <= wb_req_i(I).stb;   
                        elsif (fnd_mux = '0' and wb_req_i(I).stb = '0') then
                            sel := wb_addr_sel(wb_req_i(I).addr);
                            wb_req_o(sel).addr <= (others => ;
                            wb_req_o(sel).data <= wb_req_i(I).data;
                            wb_req_o(sel).we <= wb_req_i(I).we;                    
                            wb_req_o(sel).stb <= wb_req_i(I).stb;   
                        end if;
                    end loop;
                    
                end if;
            end if;
        end process;
    
    end generate;


end Behavioral;

