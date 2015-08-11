----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_i2c_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the I2C requests for the VFAT2s
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

entity vfat2_i2c_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
   
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    i2c_en_o        : out std_logic;
    i2c_address_o   : out std_logic_vector(6 downto 0);
    i2c_rw_o        : out std_logic;
    i2c_data_o      : out std_logic_vector(7 downto 0);
    
    i2c_valid_i     : in std_logic;
    i2c_error_i     : in std_logic;
    i2c_data_i      : in std_logic_vector(7 downto 0)
    
);
end vfat2_i2c_req;

architecture Behavioral of vfat2_i2c_req is

    type state_t is (IDLE, STB, ACK_0, ACK_1);
    
    signal state    : state_t;

    signal chipid   : std_logic_vector(2 downto 0);
    signal reg      : unsigned(7 downto 0);
    signal data     : std_logic_vector(7 downto 0);
    signal rw       : std_logic;

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            if (reset_i = '1') then
                wb_slv_res_o <= (ack    => '0',
                                 stat   => "00",
                                 data   => (others => '0'));
                i2c_en_o <= '0';
                i2c_address_o <= (others => '0');
                i2c_rw_o <= '0';
                i2c_data_o <= (others => '0');
                state <= IDLE;
                chipid <= (others => '0');
                reg <= (others => '0');
                data <= (others => '0');
                rw <= '0';
            else
                case state is
                    -- IDLE
                    when IDLE =>
                        wb_slv_res_o.ack <= '0';
                        if (wb_slv_req_i.stb = '1') then
                            case wb_slv_req_i.addr(12 downto 8) is
                                when "00000" | "00100" | "01000" | "01100" | "10000" | "10100" => chipid <= "110";
                                when "00001" | "00101" | "01001" | "01101" | "10001" | "10101" => chipid <= "101";
                                when "00010" | "00110" | "01010" | "01110" | "10010" | "10110" => chipid <= "100";
                                when "00011" | "00111" | "01011" | "01111" | "10011" | "10111" => chipid <= "011";
                                when others => chipid <= "000"; 
                            end case;
                            reg <= unsigned(wb_slv_req_i.addr(7 downto 0));
                            data <= wb_slv_req_i.data(7 downto 0);
                            rw <= not wb_slv_req_i.we;
                            state <= STB;
                        end if;
                    -- STB
                    when STB =>
                        -- Check ChipID
                        if (chipid = "000") then
                            wb_slv_res_o <= (ack    => '1',
                                             stat   => "01",
                                             data   => (others => '0'));
                            state <= IDLE;
                        else
                            -- Normal reg
                            if (reg < 16) then
                                i2c_en_o <= '1';
                                i2c_address_o <= chipid & std_logic_vector(reg(3 downto 0));
                                i2c_rw_o <= rw;
                                i2c_data_o <= data;
                                state <= ACK_0;
                            -- Extended reg
                            elsif (reg < 157) then  
                                i2c_en_o <= '1';                        
                                i2c_address_o <= chipid & "1110";
                                i2c_rw_o <= '0';
                                i2c_data_o <= std_logic_vector(reg - 16);
                                state <= ACK_1;
                            else
                                wb_slv_res_o <= (ack    => '1',
                                                 stat   => "10",
                                                 data   => (others => '0'));
                                state <= IDLE;
                            end if;
                        end if;
                    -- ACK_0 (normal reg)
                    when ACK_0 =>
                        i2c_en_o <= '0';
                        if (i2c_valid_i = '1') then
                            wb_slv_res_o <= (ack    => '1',
                                             stat   => "00",
                                             data   => x"000000" & i2c_data_i);
                            state <= IDLE;
                        elsif (i2c_error_i = '1') then
                            wb_slv_res_o <= (ack    => '1',
                                             stat   => "11",
                                             data   => (others => '0'));
                            state <= IDLE;
                        end if;
                    -- ACK_1 (extended reg)
                    when ACK_1 =>
                        i2c_en_o <= '0';
                        if (i2c_valid_i = '1') then
                            i2c_en_o <= '1';
                            i2c_address_o <= chipid & "1111";
                            i2c_rw_o <= rw;
                            i2c_data_o <= data;
                            state <= ACK_0;  
                        elsif (i2c_error_i = '1') then
                            wb_slv_res_o <= (ack    => '1',
                                             stat   => "11",
                                             data   => (others => '0'));
                            state <= IDLE;
                        end if;
                    --
                    when others => 
                        wb_slv_res_o <= (ack    => '0',
                                         stat   => "00",
                                         data   => (others => '0'));
                        i2c_en_o <= '0';
                        i2c_address_o <= (others => '0');
                        i2c_rw_o <= '0';
                        i2c_data_o <= (others => '0');
                        state <= IDLE;
                        chipid <= (others => '0');
                        reg <= (others => '0');
                        data <= (others => '0');
                        rw <= '0';
                end case;
            end if;
        end if;
    end process;

end Behavioral;