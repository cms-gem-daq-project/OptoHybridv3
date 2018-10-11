library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package types_pkg is

    --============--
    --== Common ==--
    --============--

    type int_array_t   is array(integer range <>) of integer;
    type std_array_t   is array(integer range <>) of std_logic;
    type u24_array_t   is array(integer range <>) of unsigned(23 downto 0);
    type u32_array_t   is array(integer range <>) of unsigned(31 downto 0);
    type t_std_array   is array(integer range <>) of std_logic;
    type t_std2_array  is array(integer range <>) of std_logic_vector(1 downto 0);
    type t_std4_array  is array(integer range <>) of std_logic_vector(3 downto 0);
    type t_std5_array  is array(integer range <>) of std_logic_vector(4 downto 0);
    type t_std8_array  is array(integer range <>) of std_logic_vector(7 downto 0);
    type t_std16_array is array(integer range <>) of std_logic_vector(15 downto 0);
    type t_std32_array is array(integer range <>) of std_logic_vector(31 downto 0);
    type t_std64_array is array(integer range <>) of std_logic_vector(63 downto 0);



    --==================--
    --== Trigger data ==--
    --==================--

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

    subtype sbit_cluster_t is std_logic_vector(13 downto 0);

    type sbit_cluster_array_t is array(integer range<>) of sbit_cluster_t;

    --==============--
    --== Wishbone ==--
    --==============--

    type wb_req_t is record
        stb     : std_logic;
        we      : std_logic;
        addr    : std_logic_vector(15 downto 0);
        data    : std_logic_vector(31 downto 0);
    end record;

    type wb_req_array_t is array(integer range <>) of wb_req_t;


    type wb_res_t is record
        ack     : std_logic;
        stat    : std_logic_vector(3 downto 0);
        data    : std_logic_vector(31 downto 0);
    end record;

    type wb_res_array_t is array(integer range <>) of wb_res_t;

end types_pkg;
