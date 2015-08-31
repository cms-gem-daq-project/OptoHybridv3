----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_clock_phase_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity vfat2_clock_phase_req is
port(

    ref_clk_i   : in std_logic;
    reset_i     : in std_logic;
    
    req_en_i    : in std_logic;
    req_shift_i : in std_logic_vector(7 downto 0);
    
    req_ack_o   : out std_logic;
    req_err_o   : out std_logic;
    
    locked_i    : in std_logic;
    
    ps_reset_o  : out std_logic;
    ps_en_o     : out std_logic;
    ps_incdec_o : out std_logic;
    ps_done_i   : in std_logic
    
);
end vfat2_clock_phase_req;

architecture Behavioral of vfat2_clock_phase_req is    
    
    type state_t is (IDLE, CHECKS, WAIT_RESET, INC, WAIT_DONE);
    
    signal state        : state_t;
    
    signal inc_value    : integer range 0 to 255;
    signal inc_limit    : integer range 0 to 255;
    
begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                req_ack_o <= '0';
                req_err_o <= '0';
                ps_reset_o <= '0';
                ps_en_o <= '0';
                ps_incdec_o <= '0';
                inc_value <= 0;
                inc_limit <= 0;
            else
                case state is
                    -- Wait for request
                    when IDLE =>
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        ps_en_o <= '0';
                        -- Request
                        if (req_en_i = '1') then
                            -- Store the value
                            inc_value <= 0;
                            inc_limit <= to_integer(unsigned(req_shift_i));
                            -- Reset the clock to start from 0 again
                            ps_reset_o <= '1';
                            -- Change state
                            state <= WAIT_RESET;
                        end if;
                    -- Check the parameters
                    when CHECKS =>
                        if (inc_limit = 0) then
                            req_ack_o <= '0';
                            req_err_o <= '1';
                            state <= IDLE;
                        else
                            state <= WAIT_RESET;
                        end if;
                    -- Wait for signal to be locked again
                    when WAIT_RESET =>                        
                        ps_reset_o <= '0';
                        -- Check if the clock is locked again
                        if (locked_i = '1') then
                            state <= INC;
                        end if;
                    -- Increment the value
                    when INC =>
                        -- Increment the value
                        ps_en_o <= '1';
                        ps_incdec_o <= '1';
                        -- Increment the counter 
                        inc_value <= inc_value + 1;
                        --
                        state <= WAIT_DONE;
                    -- Wait for the done signal
                    when WAIT_DONE => 
                        ps_en_o <= '0';
                        -- Phase shifting is done
                        if (ps_done_i = '1') then
                            if (inc_value = inc_limit) then
                                req_ack_o <= '1';
                                req_err_o <= '0';
                                state <= IDLE;
                            else
                                state <= INC;
                            end if;
                        end if;
                    -- 
                    when others => 
                        req_ack_o <= '0';
                        req_err_o <= '0';
                        ps_reset_o <= '0';
                        ps_en_o <= '0';
                        ps_incdec_o <= '0';
                        inc_value <= 0;
                        inc_limit <= 0;
                end case;
           end if;
       end if;
   end process;

end Behavioral;