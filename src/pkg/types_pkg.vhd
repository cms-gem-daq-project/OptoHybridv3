library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.hardware_pkg.all;

package types_pkg is

  --------------------------------------------------------------------------------
  -- Common
  --------------------------------------------------------------------------------

  type int_array_t is array(integer range <>) of integer;
  type std_array_t is array(integer range <>) of std_logic;
  type u24_array_t is array(integer range <>) of unsigned(23 downto 0);
  type u32_array_t is array(integer range <>) of unsigned(31 downto 0);
  type t_std_array is array(integer range <>) of std_logic;
  type t_std2_array is array(integer range <>) of std_logic_vector(1 downto 0);
  type t_std4_array is array(integer range <>) of std_logic_vector(3 downto 0);
  type t_std5_array is array(integer range <>) of std_logic_vector(4 downto 0);
  type t_std8_array is array(integer range <>) of std_logic_vector(7 downto 0);
  type t_std10_array is array(integer range <>) of std_logic_vector(9 downto 0);
  type t_std11_array is array(integer range <>) of std_logic_vector(10 downto 0);
  type t_std16_array is array(integer range <>) of std_logic_vector(15 downto 0);
  type t_std32_array is array(integer range <>) of std_logic_vector(31 downto 0);
  type t_std64_array is array(integer range <>) of std_logic_vector(63 downto 0);

  type t_elink_packet_array is array(integer range <>) of std_logic_vector(8*11-1 downto 0);
  type t_fiber_packet_array is array(integer range <>) of std_logic_vector(16*5-1 downto 0);

  type drp_i_t is record
    addr : std_logic_vector(8 downto 0);
    clk  : std_logic;
    di   : std_logic_vector(15 downto 0);
    en   : std_logic;
    we   : std_logic;
  end record;

  constant drp_i_null  : drp_i_t :=
    (
    addr => (others => '0'),
    di   => (others => '0'),
    clk  => '0',
    en   => '0',
    we   => '0'

);

  type drp_o_t is record
    do  : std_logic_vector(15 downto 0);
    rdy : std_logic;
  end record;

  type drp_i_array is array(integer range <>) of drp_i_t;
  type drp_o_array is array(integer range <>) of drp_o_t;

  type mgt_status_t is record
    txfsm_reset_done : std_logic;
    txfsm_done       : std_logic;
    txreset_done     : std_logic;
    rxprbserr        : std_logic;
    txpmaresetdone   : std_logic;
    txphaligndone    : std_logic;
  end record;

  type mgt_control_t is record
    txdiffctrl     : std_logic_vector (3 downto 0);
    txloopback     : std_logic_vector (2 downto 0);
    gttxreset      : std_logic;
    txuserrdy      : std_logic;
    rxprbssel      : std_logic_vector (2 downto 0);
    txprbssel      : std_logic_vector (2 downto 0);
    txprbsforceerr : std_logic;
    rxprbscntreset : std_logic;
    txpcsreset     : std_logic;
    txpmareset     : std_logic;

  --force_not_ready  : std_logic;
  --gtxtest_start    : std_logic;
  --mgt_realign      : std_logic;
  --mgt_reset        : std_logic_vector (3 downto 0);
  --pll_reset        : std_logic;
  --tx_prbs_mode     : std_logic_vector (2 downto 0);
  --txpllpowerdown   : std_logic;
  --txpowerdown      : std_logic;
  --txpowerdown_mode : std_logic_vector (1 downto 0);
  --txreset          : std_logic;
  end record;

  type mgt_status_array is array(integer range <>) of mgt_status_t;
  type mgt_control_array is array(integer range <>) of mgt_control_t;

  type ttc_t is record
    resync : std_logic;
    l1a    : std_logic;
    bc0    : std_logic;
  end record;

  type clocks_t is record
    locked    : std_logic;
    sysclk    : std_logic;
    clk40     : std_logic;
    clk160_0  : std_logic;
    clk160_90 : std_logic;
    clk200    : std_logic;
  end record;

  ---------------------------------------------------------------------------------
  -- Trigger data
  ---------------------------------------------------------------------------------

  type trigger_unit_t is record
    start_of_frame_p : std_logic;
    start_of_frame_n : std_logic;
    trig_data_p      : std_logic_vector (7 downto 0);
    trig_data_n      : std_logic_vector (7 downto 0);
  end record;

  subtype transmission_unit is std_logic_vector(7 downto 0);

  type trigger_unit_array_t is array (integer range <>) of trigger_unit_t;

  subtype sbits_t is std_logic_vector(63 downto 0);

  type sbits_array_t is array(integer range <>) of sbits_t;


  type sbit_cluster_t is record
    adr : std_logic_vector (MXADRB-1 downto 0);
    cnt : std_logic_vector (MXCNTB-1 downto 0);
    prt : std_logic_vector (MXPRTB-1 downto 0);
    vpf : std_logic;                    -- high for full 25ns
  end record;

  constant NULL_CLUSTER : sbit_cluster_t := (
    adr => (others => '1'),
    cnt => (others => '1'),
    prt => (others => '1'),
    vpf => '0');

  type sbit_cluster_array_t is array(integer range<>) of sbit_cluster_t;
  type sbit_cluster_array_array_t is array(integer range<>)
    of sbit_cluster_array_t (NUM_FOUND_CLUSTERS-1 downto 0);

  subtype partition_t is std_logic_vector(c_PARTITION_SIZE*MXSBITS-1 downto 0);
  type partition_array_t is array(integer range <>) of partition_t;

  function cluster_to_vector (a : sbit_cluster_t; size : integer)
    return std_logic_vector;

  function if_then_else (bool : boolean; a : integer; b : integer)
    return integer;
  function if_then_else (bool : boolean; a : boolean; b : boolean)
    return boolean;
  function if_then_else (bool : boolean; a : std_logic; b : std_logic)
    return std_logic;
  function if_then_else (bool : boolean; a : std_logic_vector; b : std_logic_vector)
    return std_logic_vector;

  ---------------------------------------------------------------------------------
  -- Wishbone
  ---------------------------------------------------------------------------------

  type wb_req_t is record
    stb  : std_logic;
    we   : std_logic;
    addr : std_logic_vector(15 downto 0);
    data : std_logic_vector(31 downto 0);
  end record;

  type wb_req_array_t is array(integer range <>) of wb_req_t;

  type wb_res_t is record
    ack  : std_logic;
    stat : std_logic_vector(3 downto 0);
    data : std_logic_vector(31 downto 0);
  end record;

  type wb_res_array_t is array(integer range <>) of wb_res_t;

  function majority (a : std_logic_vector; b : std_logic_vector; c : std_logic_vector)
    return std_logic_vector;

  function majority (a : std_logic; b : std_logic; c : std_logic)
    return std_logic;

end types_pkg;

package body types_pkg is

  function majority (a : std_logic_vector; b : std_logic_vector; c : std_logic_vector)
    return std_logic_vector is
    variable tmp : std_logic_vector (a'length-1 downto 0);
  begin
    tmp := (a and b) or (b and c) or (a and c);
    return tmp;
  end function;

  function majority (a : std_logic; b : std_logic; c : std_logic)
    return std_logic is
    variable tmp : std_logic;
  begin
    tmp := (a and b) or (b and c) or (a and c);
    return tmp;
  end function;

  function cluster_to_vector (a : sbit_cluster_t; size : integer)
    return std_logic_vector is
    variable tmp  : std_logic_vector (a.cnt'length + a.prt'length + a.adr'length-1 downto 0);
    variable tmp2 : std_logic_vector (size-1 downto 0);
  begin
    tmp  := a.cnt & a.prt & a.adr;
    tmp2 := std_logic_vector(resize(unsigned(tmp), size));
    return tmp2;
  end function;

  function if_then_else (bool : boolean; a : std_logic; b : std_logic) return std_logic is
  begin
    if (bool) then
      return a;
    else
      return b;
    end if;
  end if_then_else;

  function if_then_else (bool : boolean; a : integer; b : integer) return integer is
  begin
    if (bool) then
      return a;
    else
      return b;
    end if;
  end if_then_else;

  function if_then_else (bool : boolean; a : boolean; b : boolean) return boolean is
  begin
    if (bool) then
      return a;
    else
      return b;
    end if;
  end if_then_else;

  function if_then_else (bool : boolean; a : std_logic_vector; b : std_logic_vector) return std_logic_vector is
  begin
    if (bool) then
      return a;
    else
      return b;
    end if;
  end if_then_else;

end package body;
