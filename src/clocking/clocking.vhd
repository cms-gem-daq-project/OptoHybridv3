----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:10:11 09/15/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    clocking - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.types_pkg.all;

entity clocking is
port(

    reset_i             : in std_logic;

    -- Input clocks
    clk_onboard_i       : in std_logic;
    clk_gtx_rec_i       : in std_logic;
    clk_ext_i           : in std_logic;

    sys_clk_sel_i       : in std_logic_vector(1 downto 0);

    -- Output reference clock
    ref_clk_o           : out std_logic;
    
    -- Link stability
    gtx_tk_error_i      : in std_logic
    
);
end clocking;

architecture Behavioral of clocking is

    type state_t is (DETECT, RESET);
    
    signal state        : state_t;
    signal clk_source   : std_logic_vector(1 downto 0);
    signal err_counter  : unsigned(15 downto 0);

    signal clk_rec      : std_logic;

begin    
    
    --== GTX PLL ==--
    
    gtx_rec_pll_inst : entity work.gtx_rec_pll
    port map(
        clk_160MHz_i    => clk_gtx_rec_i,
        clk_40MHz_o     => clk_rec,
        reset_i         => '0',
        locked_o        => open
    );
    
    --== Clock switch ==--
    
--    process(clk_onboard_i)
--    begin
--        if (rising_edge(clk_onboard_i)) then
--            if (reset_i = '1') then
--                state <= DETECT;
--                clk_source <= (others => '0');
--                err_counter <= (others => '0');
--            else            
--                case sys_clk_sel_i is
--                    when "01" => 
--                        case state is
--                            when DETECT =>
--                                clk_source <= "01";
--                                if (gtx_tk_error_i = '1') then
--                                    if (err_counter = 2047) then
--                                        state <= RESET;
--                                    else
--                                        err_counter <= err_counter + 1;
--                                    end if;
--                                else
--                                    err_counter <= (others => '0');
--                                end if;
--                            when RESET =>
--                                clk_source <= "00";
--                                if (err_counter = 2047) then
--                                    state <= DETECT;
--                                else
--                                    err_counter <= err_counter + 1;
--                                end if;
--                            when others => 
--                                state <= DETECT;
--                                clk_source <= "01";
--                                err_counter <= (others => '0');
--                        end case;
--                    when others => 
--                        state <= DETECT;
--                        clk_source <= sys_clk_sel_i;
--                        err_counter <= (others => '0');
--                end case;            
--            end if;
--        end if;
--    end process;

clk_source <= sys_clk_sel_i;
    
    --== Clock mux ==--

    ref_clk_o <= clk_onboard_i when clk_source = "00" else
                 clk_rec when clk_source= "01" else
                 clk_ext_i when clk_source = "10" else
                 clk_onboard_i;

end Behavioral;

