----------------------------------------------------------------------------------
-- Company:        IIHE - ULB
-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)
-- 
-- Create Date:    11:22:49 06/30/2015 
-- Design Name:    OptoHybrid v2
-- Module Name:    vfat2_t1_controller_req - Behavioral 
-- Project Name:   OptoHybrid v2
-- Target Devices: xc6vlx130t-1ff1156
-- Tool versions:  ISE  P.20131013
-- Description: 
--
-- Handles the T1 commands
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

entity vfat2_t1_controller_req is
port(
    -- VFAT2 reference clock
    vfat2_mclk_i    : in std_logic;
    -- System reset
    reset_i         : in std_logic;
    -- Enable signal
    req_en_i        : in std_logic;
    -- Operation mode
    req_op_mode_i   : in std_logic_vector(1 downto 0);
    -- Command type
    req_type_i      : in std_logic_vector(1 downto 0);
    -- Number of events
    req_events_i    : in std_logic_vector(31 downto 0);
    -- Interval
    req_interval_i  : in std_logic_vector(31 downto 0);
    -- Delay
    req_delay_i     : in std_logic_vector(31 downto 0);
    -- Sequences
    req_lv1a_seq_i  : in std_logic_vector(63 downto 0);
    req_cal_seq_i   : in std_logic_vector(63 downto 0);
    req_sync_seq_i  : in std_logic_vector(63 downto 0);
    req_bc0_seq_i   : in std_logic_vector(63 downto 0);
    -- Output T1 commands
    vfat2_t1_0      : out t1_t
);
end vfat2_t1_controller_req;

architecture Behavioral of vfat2_t1_controller_req is
 
    type state_t is (IDLE);
    
    signal state            : state_t;
      
    -- Saved values of the entries to ensure stability
    signal op_mode          : std_logic_vector(1 downto 0);
    signal t1_type          : std_logic_vector(1 downto 0);
    signal events_limit     : std_logic_vector(31 downto 0);
    signal interval         : std_logic_vector(31 downto 0);
    signal delay            : std_logic_vector(31 downto 0);
    signal lv1a_sequence    : std_logic_vector(63 downto 0);
    signal cal_sequence     : std_logic_vector(63 downto 0);
    signal sync_sequence    : std_logic_vector(63 downto 0);
    signal bc0_sequence     : std_logic_vector(63 downto 0);
    
    -- Counter for the scan
    signal threshold        : unsigned(7 downto 0);
    signal event_counter    : unsigned(23 downto 0);
    signal hit_counter      : unsigned(23 downto 0);
    
begin

    
end Behavioral;