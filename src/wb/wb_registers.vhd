----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    15:17:59 07/09/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    wb_registers - Behavioral 
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

entity wb_registers is
generic(
    BASE        : std_logic_vector(31 downto 0) := x"00000000";
    SIZE        : integer := 8
);
port(

    wb_clk_i    : in std_logic;
    reset_i     : in std_logic;
   
    wb_req_i    : in wb_req_t;
    wb_res_o    : out wb_res_t;
    
    regs_o      : out register_array_t((SIZE - 1) downto 0)
    
);
end wb_registers;

architecture Behavioral of wb_registers is

    signal registers    : register_array_t((SIZE - 1) downto 0);
    
    constant base_int   : integer := to_integer(unsigned(BASE));

begin

    process(wb_clk_i)
    
        variable sel    : integer;
        
    begin
        if (rising_edge(wb_clk_i)) then
            if (reset_i = '1') then
                registers <= (others => (others => '0'));
            else
                if (wb_req_i.stb = '1') then
                    sel := to_integer(unsigned(wb_req_i.addr)) - base_int;
                    if (sel >= SIZE or sel < 0) then
                        wb_res_o <= (ack    => '1',
                                     stat   => "01",
                                     data   => (others => '0'));
                    else
                        if (wb_req_i.we = '1') then
                            registers(sel) <= wb_req_i.data;
                        end if;
                        wb_res_o <= (ack    => '1',
                                     stat   => "00",
                                     data   => registers(sel));
                    end if;
                else
                    wb_res_o.ack <= '0';
                end if;
            end if;
        end if;
    end process;
    
    regs_o <= registers;

end Behavioral;

