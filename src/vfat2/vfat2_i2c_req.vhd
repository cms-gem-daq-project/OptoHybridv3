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
-- Translates the Wishbone request to an I2C request that is then sent to the common
-- I2C communication module.
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.wb_pkg.all;

entity vfat2_i2c_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    -- I2C control lines for the I2C core
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

    type state_t is (IDLE, CHECKS, EXEC, ACK_0, ACK_1);
    
    signal state    : state_t;
    
    -- I2C transaction parameters
    signal chipid   : std_logic_vector(2 downto 0);
    signal id       : std_logic_vector(4 downto 0);
    signal reg      : unsigned(7 downto 0);
    signal data     : std_logic_vector(7 downto 0);
    signal rw       : std_logic;

begin

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset & default values
            if (reset_i = '1') then
                wb_slv_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                i2c_en_o <= '0';
                i2c_address_o <= (others => '0');
                i2c_rw_o <= '0';
                i2c_data_o <= (others => '0');
                state <= IDLE;
                chipid <= (others => '0');
                id <= (others => '0');
                reg <= (others => '0');
                data <= (others => '0');
                rw <= '0';
            else
                case state is                
                    -- Wait for request
                    when IDLE =>
                        -- Reset the flags
                        wb_slv_res_o.ack <= '0';
                        -- On request
                        if (wb_slv_req_i.stb = '1') then
                            -- Store the request values
                            case wb_slv_req_i.addr(12 downto 8) is
                                when "00000" | "00100" | "01000" | "01100" | "10000" | "10100" => chipid <= "110";
                                when "00001" | "00101" | "01001" | "01101" | "10001" | "10101" => chipid <= "101";
                                when "00010" | "00110" | "01010" | "01110" | "10010" | "10110" => chipid <= "100";
                                when "00011" | "00111" | "01011" | "01111" | "10011" | "10111" => chipid <= "011";
                                when others => chipid <= "000"; 
                            end case;
                            id <= wb_slv_req_i.addr(12 downto 8);
                            reg <= unsigned(wb_slv_req_i.addr(7 downto 0));
                            data <= wb_slv_req_i.data(7 downto 0);
                            rw <= not wb_slv_req_i.we;
                            -- Change state
                            state <= CHECKS;
                        end if;                           
                    -- Check the parameters
                    when CHECKS =>
                        -- Check ChipID
                        if (chipid = "000") then
                            -- The chip ID is not valid, send an error
                            wb_slv_res_o <= (ack => '1', stat => WB_ERR_I2C_CHIPID, data => "0000010" & rw & "000" & id & std_logic_vector(reg) & data);
                            state <= IDLE;
                        -- Check the register
                        elsif (reg > 150) then
                            -- The register is not valid, send an error
                            wb_slv_res_o <= (ack => '1', stat => WB_ERR_I2C_REG, data => "0000010" & rw & "000" & id & std_logic_vector(reg) & data);
                            state <= IDLE;
                        else
                            -- Move on
                            state <= EXEC;
                        end if;                       
                    -- Send the request
                    when EXEC =>
                        -- Normal reg
                        if (reg(7 downto 4) = "0000") then
                            -- Send a request
                            i2c_en_o <= '1';
                            i2c_address_o <= chipid & std_logic_vector(reg(3 downto 0));
                            i2c_rw_o <= rw;
                            i2c_data_o <= data;
                            state <= ACK_0;
                        -- Extended reg
                        else
                            -- Send a request
                            i2c_en_o <= '1';                        
                            i2c_address_o <= chipid & "1110";
                            i2c_rw_o <= '0';
                            i2c_data_o <= std_logic_vector(reg - 16);
                            state <= ACK_1;
                        end if;                        
                    -- Acknowledgment for a normal register
                    when ACK_0 =>
                        -- Reset the strobe
                        i2c_en_o <= '0';
                        -- Wait for a valid signal
                        if (i2c_valid_i = '1') then
                            -- Send response
                            wb_slv_res_o <= (ack => '1', stat => WB_NO_ERR, data => "0000001" & rw & "000" & id & std_logic_vector(reg) & i2c_data_i);
                            state <= IDLE;
                        -- Wait for an error signal
                        elsif (i2c_error_i = '1') then
                            -- Send error
                            wb_slv_res_o <= (ack => '1', stat => WB_ERR_I2C_ACK, data => "0000010" & rw & "000" & id & std_logic_vector(reg) & "00000000");
                            state <= IDLE;
                        end if;                        
                    -- Acknowledgment for an extended register
                    when ACK_1 =>
                        -- Reset the strobe
                        i2c_en_o <= '0';
                        -- Wait for a valid signal
                        if (i2c_valid_i = '1') then
                            -- Start the second transaction
                            i2c_en_o <= '1';
                            i2c_address_o <= chipid & "1111";
                            i2c_rw_o <= rw;
                            i2c_data_o <= data;
                            state <= ACK_0;  
                        -- Wait for an error signal
                        elsif (i2c_error_i = '1') then
                            -- Send error
                            wb_slv_res_o <= (ack => '1', stat => WB_ERR_I2C_ACK, data => "0000010" & rw & "000" & id & std_logic_vector(reg) & "00000000");
                            state <= IDLE;
                        end if;                        
                    --
                    when others => 
                        wb_slv_res_o <= (ack => '0', stat => (others => '0'), data => (others => '0'));
                        i2c_en_o <= '0';
                        i2c_address_o <= (others => '0');
                        i2c_rw_o <= '0';
                        i2c_data_o <= (others => '0');
                        state <= IDLE;
                        chipid <= (others => '0');
                        id <= (others => '0');
                        reg <= (others => '0');
                        data <= (others => '0');
                        rw <= '0';                        
                end case;
            end if;
        end if;
    end process;

end Behavioral;