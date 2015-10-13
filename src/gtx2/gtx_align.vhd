----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    09:48:46 08/19/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    gtx_align - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library unisim;
use unisim.vcomponents.all;

library work;

entity gtx_align is
generic(

    PACKET_LENGTH   : integer range 0 to 255

);
port(

    gtx_rec_clk_i   : in std_logic;
    reset_i         : in std_logic;
    
    data_i          : in std_logic_vector(15 downto 0);
    kchar_i         : in std_logic_vector(1 downto 0);
    
    slide_o         : out std_logic;
    rec_clk_o       : out std_logic;
    lock_done_o     : out std_logic
    
);
end gtx_align;
    
architecture Behavioral of gtx_align is

    type state_t is (LOOK, CHECK, SLIDE, DLY, DONE);

    signal state    : state_t;
    
    signal counter  : integer range 0 to 255;
    
    signal clk_cnt  : integer range 0 to 3;

begin

    process(gtx_rec_clk_i) 
    begin
        if (rising_edge(gtx_rec_clk_i)) then
            if (reset_i = '1') then
                rec_clk_o <= '0';
                clk_cnt <= 0;
            else
                case clk_cnt is 
                    when 0 =>
                        rec_clk_o <= '1';
                        clk_cnt <= 1;
                    when 1 =>
                        rec_clk_o <= '1';
                        clk_cnt <= 2;
                    when 2 =>
                        rec_clk_o <= '0';
                        clk_cnt <= 3;
                    when 3 =>
                        rec_clk_o <= '0';
                        clk_cnt <= 0;
                    when others =>
                        rec_clk_o <= '0';
                        clk_cnt <= 0;
                end case;
            end if;
        end if;
    end process;

    process(gtx_rec_clk_i)
    begin
        if (rising_edge(gtx_rec_clk_i)) then
            if (reset_i = '1') then
                slide_o <= '0';
                lock_done_o <= '0';
                state <= LOOK;
            else                    
                case state is
                    when LOOK => 
                        lock_done_o <= '0';
                        if (data_i = x"00BC" and kchar_i = "01") then
                            state <= CHECK;
                            counter <= 0;
                        elsif (counter = (PACKET_LENGTH - 1)) then
                            state <= SLIDE;
                        else
                            counter <= counter + 1;
                        end if;
                    when SLIDE =>
                        slide_o <= '1';
                        lock_done_o <= '0';
                        state <= DLY;
                        counter <= 0;
                    when DLY =>
                        slide_o <= '0';
                        lock_done_o <= '0';
                        if (counter = 31) then
                            state <= LOOK;
                        else
                            counter <= counter + 1;
                        end if;                       
                    when CHECK =>
                        lock_done_o <= '0';
                        if (kchar_i = "10") then  
                            state <= LOOK;
                        elsif (counter = (PACKET_LENGTH - 2)) then
                            state <= DONE;
                        else
                            counter <= counter + 1;
                        end if;
                    when DONE => 
                        state <= DONE;
                        lock_done_o <= '1';
                    when others => 
                        slide_o <= '0';
                        lock_done_o <= '0';
                        state <= LOOK;
                end case; 
            end if;
        end if;
    end process;

end Behavioral;


