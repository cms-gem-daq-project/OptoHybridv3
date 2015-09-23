----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:37:20 07/07/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    adc_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description:
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity adc_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;    

    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    -- ADC control signals
    adc_en_o        : out std_logic;
    adc_data_o      : out std_logic_vector(3 downto 0);
    adc_valid_i     : in std_logic;
    adc_data_i      : in std_logic_vector(11 downto 0)
    
);
end adc_req;

architecture Behavioral of adc_req is

    type state_t is (IDLE, EXEC, ACK);
    
    signal state    : state_t;
    
    -- I2C transaction parameters
    signal data     : std_logic_vector(3 downto 0);
    
begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                wb_slv_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                adc_en_o <= '0';
                adc_data_o <= (others => '0');
                state <= IDLE;
                data <= (others => '0');
            else
                case state is                
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        wb_slv_res_o.ack <= '0';
                        -- On request
                        if (wb_slv_req_i.stb = '1') then
                            data <= wb_slv_req_i.addr(3 downto 0);
                            -- Change state
                            state <= EXEC;
                        end if;                                               
                    -- Send the request
                    when EXEC =>
                        adc_en_o <= '1';
                        adc_data_o <= data;
                        state <= ACK;
                    -- Acknowledgment
                    when ACK =>
                        -- Reset the strobe
                        adc_en_o <= '0';
                        -- Wait for a valid signal
                        if (adc_valid_i = '1') then
                            -- Send response
                            wb_slv_res_o <= (ack => '1', stat => WB_NO_ERR, data => x"00000" & adc_data_i);
                            state <= IDLE;
                        end if;                                               
                    --
                    when others => 
                        wb_slv_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                        adc_en_o <= '0';
                        adc_data_o <= (others => '0');
                        state <= IDLE;
                        data <= (others => '0');                        
                end case;
            end if;
        end if;
    end process;

end Behavioral;