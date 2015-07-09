----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    t1_switch - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Selects the source of the T1 signals
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

entity t1_switch is
generic(

    ASYNC       : boolean := false;
    WIDTH       : integer := 4
    
);
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    t1_i        : in t1_array_t((WIDTH - 1) downto 0);
    mask_i      : in std_logic_vector((WIDTH - 1) downto 0);
    
    t1_o        : out t1_t
    
);
end t1_switch;

architecture Behavioral of t1_switch is
begin

    --=========================--
    --== Asynchronous switch ==--
    --=========================--
    
    async_gen : if ASYNC = true generate
    
        signal lv1a     : std_logic_vector(WIDTH downto 0);
        signal calpulse : std_logic_vector(WIDTH downto 0);
        signal resync   : std_logic_vector(WIDTH downto 0);
        signal bc0      : std_logic_vector(WIDTH downto 0);
    
    begin
    
        lv1a(0) <= '0';
        calpulse(0) <= '0';
        resync(0) <= '0';
        bc0(0) <= '0';
   
        async_loop : for I in 0 to (WIDTH - 1) generate
        begin
        
            lv1a(I + 1) <= lv1a(I) or (t1_i(I).lv1a and mask_i(I));
            calpulse(I + 1) <= calpulse(I) or (t1_i(I).calpulse and mask_i(I));
            resync(I + 1) <= resync(I) or (t1_i(I).resync and mask_i(I));
            bc0(I + 1) <= bc0(I) or (t1_i(I).bc0 and mask_i(I));
        
        end generate;
    
        t1_o.lv1a <= lv1a(WIDTH);
        t1_o.calpulse <= calpulse(WIDTH);
        t1_o.resync <= resync(WIDTH);
        t1_o.bc0 <= bc0(WIDTH);
            
    end generate;
    
    --========================--
    --== Synchronous switch ==--
    --========================--
    
    sync_gen : if ASYNC = false generate
    begin
        process(ref_clk_i)
        
            variable lv1a       : std_logic;
            variable calpulse   : std_logic;
            variable resync     : std_logic;
            variable bc0        : std_logic;
        
        begin
            if (rising_edge(ref_clk_i)) then
                if (reset_i = '1') then
                    t1_o <= (others => '0');
                    lv1a := '0';
                    calpulse := '0';
                    resync := '0';
                    bc0 := '0';
                else
                    
                    lv1a := '0';
                    calpulse := '0';
                    resync := '0';
                    bc0 := '0';
                   
                    for I in 0 to (WIDTH - 1) loop
                    
                        lv1a := lv1a or (t1_i(I).lv1a and mask_i(I));
                        calpulse := calpulse or (t1_i(I).calpulse and mask_i(I));
                        resync := resync or (t1_i(I).resync and mask_i(I));
                        bc0 := bc0 or (t1_i(I).bc0 and mask_i(I));
                    
                    end loop;
                    
                    t1_o.lv1a <= lv1a;
                    t1_o.calpulse <= calpulse;
                    t1_o.resync <= resync;
                    t1_o.bc0 <= bc0;
                   
                end if;
            end if;
        end process;
    end generate;
    
end Behavioral;