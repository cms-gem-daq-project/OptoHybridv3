----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    08:44:34 08/18/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    func_i2c_req - Behavioral 
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

entity func_i2c_req is
port(

    ref_clk_i       : in std_logic;
    reset_i         : in std_logic;
    
    -- Wishbone slave
    wb_slv_req_i    : in wb_req_t;
    wb_slv_res_o    : out wb_res_t;
    
    -- Wishbone master
    wb_mst_req_o    : out wb_req_t;
    wb_mst_res_i    : in wb_res_t;
    
    -- VFAT2 masks
    req_mask_i      : in std_logic_vector(23 downto 0);
    
    -- FIFO control
    fifo_rst_o      : out std_logic;
    fifo_we_o       : out std_logic;
    fifo_din_o      : out std_logic_vector(31 downto 0)
    
);
end func_i2c_req;

architecture Behavioral of func_i2c_req is

    type state_t is (IDLE, REQ_I2C, ACK_I2C);
        
    signal state            : state_t;
    
    -- request parameters
    signal req_mask         : std_logic_vector(23 downto 0);
    signal req_register     : std_logic_vector(7 downto 0);
    signal req_data         : std_logic_vector(7 downto 0);
    signal req_we           : std_logic;
    
    -- Counter for the scan
    signal vfat2_counter    : unsigned(4 downto 0);

begin
    
    -- Automatic response to request
    wb_slv_res_o <= (ack => wb_slv_req_i.stb, stat => "00", data => (others => '0'));

    process(ref_clk_i)
    begin
        if (rising_edge(ref_clk_i)) then
            -- Reset and default values
            if (reset_i = '1') then
                wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                fifo_rst_o <= '0';
                fifo_we_o <= '0';
                fifo_din_o <= (others => '0');
                state <= IDLE;
                req_mask <= (others => '0');
                req_register <= (others => '0');
                req_data <= (others => '0');
                req_we <= '0';
                vfat2_counter <= (others => '0');
            else
                case state is                
                    -- Wait for a request
                    when IDLE =>
                        -- Reset the flags
                        fifo_rst_o <= '0';
                        fifo_we_o <= '0';
                        -- On a request strobe
                        if (wb_slv_req_i.stb = '1') then
                            -- Save the parameters by applying the default value if 0                            
                            req_mask <= req_mask_i;
                            req_register <= wb_slv_req_i.addr(7 downto 0);
                            req_data <= wb_slv_req_i.data(7 downto 0);
                            req_we <= wb_slv_req_i.we;
                            -- Set the counter
                            vfat2_counter <= (others => '0');
                            -- Reset the FIFO
                            fifo_rst_o <= '1';
                            -- Change state
                            state <= REQ_I2C;
                        end if;                                                
                    -- Send an I2C request to change the latency
                    when REQ_I2C =>
                        -- Enable the FIFO
                        fifo_rst_o <= '0';
                        -- Reset the write enable 
                        fifo_we_o <= '0';
                        -- Increment the VFAT2 counter
                        if (vfat2_counter = 24) then
                            state <= IDLE;
                        else
                            -- Send an I2C request if needed
                            if (req_mask(to_integer(vfat2_counter)) = '0') then
                                wb_mst_req_o <= (stb => '1', we => req_we, addr => WB_ADDR_I2C & "000000000000000" & std_logic_vector(vfat2_counter) & req_register, data => x"000000" & req_data);
                                state <= ACK_I2C;
                            else
                                vfat2_counter <= vfat2_counter + 1;
                            end if;
                        end if;                        
                    -- Wait for the acknowledgment
                    when ACK_I2C => 
                        -- Reset the strobe
                        wb_mst_req_o.stb <= '0';
                        -- On acknowledgment
                        if (wb_mst_res_i.ack = '1') then
                            -- Write in the FIFO
                            fifo_we_o <= '1';
                            fifo_din_o <= x"00" & "000000" & wb_mst_res_i.stat & "000" & std_logic_vector(vfat2_counter) & wb_mst_res_i.data(7 downto 0);
                            -- Increment the counter
                            vfat2_counter <= vfat2_counter + 1;
                            -- Change state
                            state <= REQ_I2C;
                        end if;                    
                    --
                    when others =>
                        wb_mst_req_o <= (stb => '0', we => '0', addr => (others => '0'), data => (others => '0'));
                        fifo_rst_o <= '0';
                        fifo_we_o <= '0';
                        fifo_din_o <= (others => '0');
                        state <= IDLE;
                        req_mask <= (others => '0');
                        req_register <= (others => '0');
                        req_data <= (others => '0');
                        req_we <= '0';
                        vfat2_counter <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;

