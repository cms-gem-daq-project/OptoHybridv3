-- file: to_gbt_ser_exdes.vhd
-- (c) Copyright 2009 - 2011 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.

------------------------------------------------------------------------------
-- SelectIO wizard example design
------------------------------------------------------------------------------
-- This example design instantiates the IO circuitry
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_misc.and_reduce;

library unisim;
use unisim.vcomponents.all;

entity to_gbt_ser_exdes is
generic (
  -- width of the data for the system
  sys_w      : integer := 4;
  -- width of the data for the device
  dev_w      : integer := 32
);
port (
  PATTERN_COMPLETED_OUT     : out   std_logic_vector (1 downto 0);
  -- From the system into the device
  DATA_IN_FROM_PINS_P      : in    std_logic_vector(sys_w-1 downto 0);
  DATA_IN_FROM_PINS_N      : in    std_logic_vector(sys_w-1 downto 0);
  DATA_OUT_TO_PINS_P         : out   std_logic_vector(sys_w-1 downto 0);
  DATA_OUT_TO_PINS_N         : out   std_logic_vector(sys_w-1 downto 0);

  CLK_IN                   : in    std_logic;
  CLK_RESET                : in    std_logic;
  IO_RESET                 : in    std_logic);
end to_gbt_ser_exdes;

architecture xilinx of to_gbt_ser_exdes is

component to_gbt_ser is
generic
 (-- width of the data for the system
  sys_w       : integer := 4;
  -- width of the data for the device
  dev_w       : integer := 32);
port
 (
  -- From the device out to the system
  DATA_OUT_FROM_DEVICE    : in    std_logic_vector(dev_w-1 downto 0);
  DATA_OUT_TO_PINS_P      : out   std_logic_vector(sys_w-1 downto 0);
  DATA_OUT_TO_PINS_N      : out   std_logic_vector(sys_w-1 downto 0);

 
-- Clock and reset signals
  CLK_IN                  : in    std_logic;                    -- Fast clock from PLL/MMCM 
  CLK_DIV_IN              : in    std_logic;                    -- Slow clock from PLL/MMCM
  IO_RESET                : in    std_logic);                   -- Reset signal for IO circuit
end component;

   constant num_serial_bits  : integer := dev_w/sys_w;
   signal unused             : std_logic;
   signal clkin1             : std_logic;
   signal count_out          : std_logic_vector (num_serial_bits-1 downto 0);
   signal local_counter      : std_logic_vector(num_serial_bits-1 downto 0);
   signal count_out1         : std_logic_vector (num_serial_bits-1 downto 0);
   signal count_out2         : std_logic_vector (num_serial_bits-1 downto 0);
   signal pat_out            : std_logic_vector (num_serial_bits-1 downto 0);
   signal pattern_completed    : std_logic_vector (1 downto 0) := "00";
   signal clk_in_int_inv       : std_logic;
            -- connection between ram and io circuit
   signal data_in_to_device         : std_logic_vector(dev_w-1 downto 0);
   signal data_in_to_device_int2    : std_logic_vector(dev_w-1 downto 0);
   signal data_in_to_device_int3    : std_logic_vector(dev_w-1 downto 0);

   signal data_out_from_device : std_logic_vector(dev_w-1 downto 0);

    type serdarr is array (0 to 9) of std_logic_vector(sys_w-1 downto 0);
   signal serdesstrobe             : std_logic;
   signal iserdes_q                : serdarr := (( others => (others => '0')));
   signal icascade1                : std_logic_vector(sys_w-1 downto 0);
   signal icascade2                : std_logic_vector(sys_w-1 downto 0);

   signal data_out_from_device_q    : std_logic_vector(dev_w-1 downto 0) ;
   signal data_in_from_pins_int     : std_logic_vector(sys_w-1 downto 0);
   signal data_in_to_device_int     : std_logic_vector(dev_w-1 downto 0);
   signal tristate_predelay         : std_logic_vector(sys_w-1 downto 0);
   signal data_out_to_pins_int      : std_logic_vector(sys_w-1 downto 0);
   signal data_out_to_pins_predelay : std_logic_vector(sys_w-1 downto 0);
   constant clock_enable            : std_logic := '1';

   signal clk_in_pll           : std_logic;
   signal clk_div_in_int       : std_logic;
   signal clk_div_in           : std_logic;
   signal locked               : std_logic;
--   signal clkin1             : std_logic;
  -- Output clock buffering / unused connectors
   signal clkfbout             : std_logic;
   signal clkfbout_buf         : std_logic;
   signal clkfboutb_unused     : std_logic;
   signal clkout0              : std_logic;
   signal clkout0b_unused      : std_logic;
   signal clkout1          : std_logic;
   signal clkout1b_unused  : std_logic;
   signal clkout2_unused   : std_logic;
   signal clkout2b_unused  : std_logic;
   signal clkout3_unused   : std_logic;
   signal clkout3b_unused  : std_logic;
   signal clkout4_unused   : std_logic;
   signal clkout5_unused   : std_logic;
   signal clkout6_unused   : std_logic;
  -- Dynamic programming unused signals
   signal do_unused        : std_logic_vector(15 downto 0);
   signal drdy_unused      : std_logic;
  -- Dynamic phase shift unused signals
   signal psdone_unused    : std_logic;
  -- Unused status signals
   signal clkfbstopped_unused : std_logic;
   signal clkinstopped_unused : std_logic;
   signal rst_sync      : std_logic;
   signal rst_sync_int  : std_logic;
   signal rst_sync_int1 : std_logic;
   signal rst_sync_int2 : std_logic;
   signal rst_sync_int3 : std_logic;
   signal rst_sync_int4 : std_logic;
   signal rst_sync_int5 : std_logic;
   signal rst_sync_int6 : std_logic;
   signal bitslip       : std_logic := '0';
   signal bitslip_int   : std_logic := '0';
   signal equal         : std_logic := '0';
   signal equal1        : std_logic := '0';
   signal count_out3    : std_logic_vector(2 downto 0);
   signal start_count   : std_logic := '0';
   signal start_check   : std_logic := '0';
   signal bit_count     : std_logic_vector (2 downto 0);
   type delay_arr is array (0 to sys_w -1) of std_logic_vector(num_serial_bits-1 downto 0);
   signal data_delay_int1 : delay_arr;
   signal data_delay_int2 : delay_arr;
   signal data_delay     : delay_arr; 
   signal slave_shiftout          : std_logic_vector(sys_w-1 downto 0);

   attribute KEEP : string;
   attribute KEEP of clk_div_in_int : signal is "TRUE";



begin

   process (clk_div_in, IO_RESET) begin
     if (IO_RESET = '1') then
       rst_sync <= '1';
       rst_sync_int <= '1';
       rst_sync_int1 <= '1';
       rst_sync_int2 <= '1';
       rst_sync_int3 <= '1';
       rst_sync_int4 <= '1';
       rst_sync_int5 <= '1';
       rst_sync_int6 <= '1';
     elsif (clk_div_in = '1' and clk_div_in'event) then
       rst_sync <= '0';
       rst_sync_int <= rst_sync;
       rst_sync_int1 <= rst_sync_int;
       rst_sync_int2 <= rst_sync_int1;
       rst_sync_int3 <= rst_sync_int2;
       rst_sync_int4 <= rst_sync_int3;
       rst_sync_int5 <= rst_sync_int4;
       rst_sync_int6 <= rst_sync_int5;
     end if;
   end process;




   clkin_in_buf : IBUFG
    port map
      (O => clkin1,
       I => CLK_IN);

  mmcm_adv_inst : MMCM_ADV
  generic map
   (BANDWIDTH            => "OPTIMIZED",
    CLKOUT4_CASCADE      => FALSE,
    CLOCK_HOLD           => FALSE,
    COMPENSATION         => "ZHOLD",
    STARTUP_WAIT         => FALSE,
    DIVCLK_DIVIDE        => 1,
    CLKFBOUT_MULT_F      => 10.000,
    CLKFBOUT_PHASE       => 0.000,
    CLKFBOUT_USE_FINE_PS => FALSE,
    CLKOUT0_DIVIDE_F     => 10.000,
    CLKOUT0_PHASE        => 0.000,
    CLKOUT0_DUTY_CYCLE   => 0.500,
    CLKOUT0_USE_FINE_PS  => FALSE,
    CLKOUT1_DIVIDE       => 10*num_serial_bits,
    CLKOUT1_PHASE        => 0.000,
    CLKOUT1_DUTY_CYCLE   => 0.500,
--    CLKOUT1_DIVIDE       => 10,
--    CLKOUT1_PHASE        => 0.000,
--    CLKOUT1_DUTY_CYCLE   => 0.500,
    CLKOUT1_USE_FINE_PS  => FALSE,
    CLKIN1_PERIOD        => 10.0,
    REF_JITTER1          => 0.010)
  port map
    -- Output clocks
   (CLKFBOUT            => clkfbout,
    CLKFBOUTB           => clkfboutb_unused,
    CLKOUT0             => clkout0,
    CLKOUT0B            => clkout0b_unused,
    CLKOUT1             => clk_div_in_int,
    CLKOUT1B            => clkout1b_unused,
    CLKOUT2             => clkout2_unused,
    CLKOUT2B            => clkout2b_unused,
    CLKOUT3             => clkout3_unused,
    CLKOUT3B            => clkout3b_unused,
    CLKOUT4             => clkout4_unused,
    CLKOUT5             => clkout5_unused,
    CLKOUT6             => clkout6_unused,
    -- Input clock control
    CLKFBIN             => clkfbout_buf,
    CLKIN1              => clkin1,
    CLKIN2              => '0',
    -- Tied to always select the primary input clock
    CLKINSEL            => '1',
    -- Ports for dynamic reconfiguration
    DADDR               => (others => '0'),
    DCLK                => '0',
    DEN                 => '0',
    DI                  => (others => '0'),
    DO                  => do_unused,
    DRDY                => drdy_unused,
    DWE                 => '0',
    -- Ports for dynamic phase shift
    PSCLK               => '0',
    PSEN                => '0',
    PSINCDEC            => '0',
    PSDONE              => psdone_unused,
    -- Other control and status signals
    LOCKED              => locked,
    CLKINSTOPPED        => clkinstopped_unused,
    CLKFBSTOPPED        => clkfbstopped_unused,
    PWRDWN              => '0',
    RST                 => CLK_RESET);


  -- Output buffering
  -------------------------------------
   clkf_buf : BUFG
    port map
      (O => clkfbout_buf,
       I => clkfbout);


   clkout1_buf : BUFG
    port map
      (O   => clk_in_pll,
       I   => clkout0);

   clkout2_buf : BUFG
    port map
      (O   => clk_div_in,
       I   => clk_div_in_int);



   process(clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       equal1 <= '0';
     else
       if (count_out3 = "100") then
          equal1 <= equal;
       else
          equal1 <= equal1;
       end if;
     end if;
    end if;
   end process;


   process(clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       count_out3 <= (others => '0');
     elsif (equal = '1' and count_out3 < "100" ) then
       count_out3 <= count_out3 + 1;
     else
       count_out3 <= (others => '0');
     end if;
    end if;
   end process;

   process(clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       count_out1 <= (others => '0');
       pat_out <= "10011011";
       count_out1 <= (others => '0');
     elsif locked='1' then
     if equal1='0' then
      pat_out <= "10011011";
       count_out1 <= (others => '0');
    else
       count_out1 <= count_out1 + 1;
     end if;
    end if;
   end if;
  end process;

   process(clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       count_out2 <= (others => '0');
     elsif equal1='1' then
       count_out2 <= count_out1;
     else
       count_out2 <= pat_out;
     end if;
    end if;
   end process;   

   process(clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       count_out <= (others => '0');
     else
       count_out <= count_out2;
     end if;
    end if;
   end process; 
   


assign:for assg in 0 to num_serial_bits-1 generate begin
pinsss:for pinsss in 0 to sys_w-1 generate begin
   data_out_from_device(pinsss+sys_w*assg) <= count_out(assg);
end generate pinsss;
end generate assign;

   data_delay(0) <=                 data_in_to_device(28) &
                data_in_to_device(24) &
                data_in_to_device(20) &
                data_in_to_device(16) &
                data_in_to_device(12) &
                data_in_to_device(8) &
                data_in_to_device(4) &
   data_in_to_device(0);
   data_delay(1) <=                 data_in_to_device(29) &
                data_in_to_device(25) &
                data_in_to_device(21) &
                data_in_to_device(17) &
                data_in_to_device(13) &
                data_in_to_device(9) &
                data_in_to_device(5) &
   data_in_to_device(1);
   data_delay(2) <=                 data_in_to_device(30) &
                data_in_to_device(26) &
                data_in_to_device(22) &
                data_in_to_device(18) &
                data_in_to_device(14) &
                data_in_to_device(10) &
                data_in_to_device(6) &
   data_in_to_device(2);
   data_delay(3) <=                 data_in_to_device(31) &
                data_in_to_device(27) &
                data_in_to_device(23) &
                data_in_to_device(19) &
                data_in_to_device(15) &
                data_in_to_device(11) &
                data_in_to_device(7) &
   data_in_to_device(3);

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       start_check <= '0';
     else
       if (data_delay(0) /= "00000000") then
 
         start_check <= '1';
       end if;
     end if;
    end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       start_count <= '0';
     else
       if (data_delay(0) = "00000001" and equal = '1') then
 
         start_count <= '1';
       end if;
     end if;
    end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then    
     if (rst_sync_int6 = '1') then
       local_counter <= (others =>'0');
     else
       if start_count = '1' then
         local_counter <= local_counter + 1;
       else
         local_counter <= (others =>'0');
       end if;
     end if;
    end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       data_delay_int1(0) <= (others => '0');
       data_delay_int2(0) <= (others => '0');
       data_delay_int1(1) <= (others => '0');
       data_delay_int2(1) <= (others => '0');
       data_delay_int1(2) <= (others => '0');
       data_delay_int2(2) <= (others => '0');
       data_delay_int1(3) <= (others => '0');
       data_delay_int2(3) <= (others => '0');
     else
       data_delay_int1(0) <= data_delay(0);
       data_delay_int2(0) <= data_delay_int1(0);
       data_delay_int1(1) <= data_delay(1);
       data_delay_int2(1) <= data_delay_int1(1);
       data_delay_int1(2) <= data_delay(2);
       data_delay_int2(2) <= data_delay_int1(2);
       data_delay_int1(3) <= data_delay(3);
       data_delay_int2(3) <= data_delay_int1(3);
     end if;
   end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if rst_sync_int6 = '1' then
       bitslip_int <= '0';
       equal <= '0';
     else
      if (equal = '0' and locked = '1' and start_check = '1') then
        if (
      (data_delay(3) = pat_out) and
      (data_delay(2) = pat_out) and
      (data_delay(1) = pat_out) and
      (data_delay(0) = pat_out)) then 
          bitslip_int <= '0';
          equal <= '1';
        else
          bitslip_int <= '1';
          equal <= '0';
        end if;
      else
        bitslip_int <= '0';
      end if;
     end if;
    end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if (rst_sync_int6 = '1') then
       bitslip <= '0';
       bit_count <= "000";
     else
       bit_count <= bit_count + '1';
         if bit_count = "111" then
           if bitslip_int='1' then
             bitslip <= not(bitslip);
           else
             bitslip <= '0';
           end if;
         else
           bitslip <= '0';
         end if;
      end if;
     end if;
   end process;

   process (clk_div_in) begin
   if (clk_div_in='1' and clk_div_in'event) then
     if equal = '1' then
      if (
        (data_delay_int2(1) = local_counter) and
        (data_delay_int2(2) = local_counter) and
        (data_delay_int2(3) = local_counter) and
        (data_delay_int2(0) = local_counter)) then
        if (local_counter = "11111111") then
          pattern_completed <= "11";
        -- all over
        else
          pattern_completed <= "01";
          -- bitslip done, data checking in progress
        end if;
     else
          if (start_count = '1') then
             pattern_completed <= "10";
         -- incorrect data
          else
             pattern_completed <= pattern_completed;
          end if;
     end if;
   else
          pattern_completed <= "00";
         -- yet to get bitslip
   end if;
  end if;
 end process;



 
   PATTERN_COMPLETED_OUT <= pattern_completed;
  







  pins: for pin_count in 0 to sys_w-1 generate
    -- Instantiate the buffers
    ----------------------------------
     ibufds_inst : IBUFDS
       generic map (
         DIFF_TERM  => FALSE,             -- Differential termination
         IOSTANDARD => "LVDS_25")
       port map (
         I          => DATA_IN_FROM_PINS_P  (pin_count),
         IB         => DATA_IN_FROM_PINS_N  (pin_count),
         O          => data_in_from_pins_int(pin_count));

     -- Instantiate the serdes primitive
     ----------------------------------
     clk_in_int_inv <= not (clk_in_pll);
     -- declare the iserdes
     iserdese1_master : ISERDESE1
       generic map (
         DATA_RATE         => "SDR",
         DATA_WIDTH        => 8,
         INTERFACE_TYPE    => "NETWORKING", 
         DYN_CLKDIV_INV_EN => FALSE,
         DYN_CLK_INV_EN    => FALSE,
         NUM_CE            => 2,
 
         OFB_USED          => FALSE,
         IOBDELAY          => "NONE",                             -- Use input at D to output the data on Q1-Q6
         SERDES_MODE       => "MASTER")
       port map (
         Q1                => iserdes_q(0)(pin_count),
         Q2                => iserdes_q(1)(pin_count),
         Q3                => iserdes_q(2)(pin_count),
         Q4                => iserdes_q(3)(pin_count),
         Q5                => iserdes_q(4)(pin_count),
         Q6                => iserdes_q(5)(pin_count),
         SHIFTOUT1         => icascade1(pin_count),               -- Cascade connection to Slave ISERDES
         SHIFTOUT2         => icascade2(pin_count),               -- Cascade connection to Slave ISERDES
         BITSLIP    => bitslip,
         CE1               => clock_enable,                       -- 1-bit Clock enable input
         CE2               => clock_enable,                       -- 1-bit Clock enable input
         CLK               => clk_in_pll,                     -- Fast Source Synchronous SERDES clock from BUFIO
         CLKB              => clk_in_int_inv,                     -- Locally inverted clock
         CLKDIV            => clk_div_in,                         -- Slow clock driven by MMCM
         D                 => data_in_from_pins_int(pin_count), -- 1-bit Input signal from IOB.
         DDLY              => '0',
         RST               => IO_RESET,                           -- 1-bit Asynchronous reset only.
         SHIFTIN1          => '0',
         SHIFTIN2          => '0',

        -- unused connections
         DYNCLKDIVSEL      => '0',
         DYNCLKSEL         => '0',
         OFB               => '0',
         OCLK              => '0',
         O                 => open);                              -- unregistered output of ISERDESE1

     iserdese1_slave : ISERDESE1
       generic map (
         DATA_RATE         => "SDR",
         DATA_WIDTH        => 8,
         INTERFACE_TYPE    => "NETWORKING",
         DYN_CLKDIV_INV_EN => FALSE,
         DYN_CLK_INV_EN    => FALSE,
         NUM_CE            => 2,
 
         OFB_USED          => FALSE,
         IOBDELAY          => "NONE",                             -- Use input at D to output the data on Q1-Q6
         SERDES_MODE       => "SLAVE")
       port map (
         Q1                => open,
         Q2                => open,
         Q3                => iserdes_q(6)(pin_count),
         Q4                => iserdes_q(7)(pin_count),
         Q5                => iserdes_q(8)(pin_count),
         Q6                => iserdes_q(9)(pin_count),
         SHIFTOUT1         => open,
         SHIFTOUT2         => open,
         SHIFTIN1          => icascade1(pin_count),               -- Cascade connections from Master ISERDES
         SHIFTIN2          => icascade2(pin_count),               -- Cascade connections from Master ISERDES
         BITSLIP    => bitslip,
         CE1               => clock_enable,                       -- 1-bit Clock enable input
         CE2               => clock_enable,                       -- 1-bit Clock enable input
         CLK               => clk_in_pll,                     -- Fast Source Synchronous SERDES clock from BUFIO
         CLKB              => clk_in_int_inv,                     -- locally inverted clock
         CLKDIV            => clk_div_in,                         -- Slow clock driven by MMCM
         D                 => '0',                                -- Slave ISERDES module. No need to connect D, DDLY
         DDLY              => '0',
         RST               => IO_RESET,                           -- 1-bit Asynchronous reset only.
        -- unused connections
         DYNCLKDIVSEL      => '0',
         DYNCLKSEL         => '0',
         OFB               => '0',
          OCLK             => '0',
          O                => open);                              -- unregistered output of ISERDESE1


     -- Concatenate the serdes outputs together. Keep the timesliced
     --   bits together, and placing the earliest bits on the right
     --   ie, if data comes in 0, 1, 2, 3, 4, 5, 6, 7, ...
     --       the output will be 3210, 7654, ...
     -------------------------------------------------------------
     in_slices: for slice_count in 0 to num_serial_bits-1 generate begin
        -- This places the first data in time on the right
        data_in_to_device(slice_count*sys_w+sys_w-1 downto slice_count*sys_w) <=
          iserdes_q(num_serial_bits-slice_count-1);
        -- To place the first data in time on the left, use the
        --   following code, instead
        -- data_in_to_device2(slice_count*sys_w+sys_w-1 downto sys_w) <=
        --   iserdes_q(slice_count);
     end generate in_slices;
  end generate pins;



   -- Instantiate the IO design
   io_inst : to_gbt_ser
   port map
   (
    -- From the drive out to the system
    DATA_OUT_FROM_DEVICE    => data_out_from_device,
    DATA_OUT_TO_PINS_P      => DATA_OUT_TO_PINS_P,
    DATA_OUT_TO_PINS_N      => DATA_OUT_TO_PINS_N,

 

    CLK_IN                  => clk_in_pll,
    CLK_DIV_IN              => clk_div_in,
    IO_RESET                => rst_sync_int);
end xilinx;
