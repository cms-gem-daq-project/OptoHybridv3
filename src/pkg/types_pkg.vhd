library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package types_pkg is

    --============--
    --== Common ==--
    --============--
   
    type int_array_t is array(integer range <>) of integer;
    
    type std_array_t is array(integer range <>) of std_logic;
    
    type u32_array_t is array(integer range <>) of unsigned(31 downto 0);
    
    type std32_array_t is array(integer range <>) of std_logic_vector(31 downto 0);

    type std64_array_t is array(integer range <>) of std_logic_vector(63 downto 0);
    
    --==================--
    --== Trigger data ==--
    --==================--
    
    subtype sbits_t is std_logic_vector(7 downto 0);
 
    type sbits_array_t is array(integer range <>) of sbits_t;
    
    subtype sbit_cluster_t is std_logic_vector(13 downto 0);
    
    type sbit_cluster_array_t is array(integer range<>) of sbit_cluster_t;
    
    --===================--
    --== Tracking data ==--
    --===================--
 
    type tk_data_t is record
        valid   : std_logic;
        bc      : std_logic_vector(11 downto 0);
        ec      : std_logic_vector(7 downto 0);
        flags   : std_logic_vector(3 downto 0);
        chip_id : std_logic_vector(11 downto 0);
        strips  : std_logic_vector(127 downto 0);
        crc     : std_logic_vector(15 downto 0);  
        crc_ok  : std_logic;
        hit     : std_logic;
    end record;
    
    type tk_data_array_t is array(integer range <>) of tk_data_t;
        
    --================--
    --== T1 command ==--
    --================--
    
    type t1_t is record
        lv1a        : std_logic;
        calpulse    : std_logic;
        resync      : std_logic;
        bc0         : std_logic;
    end record;
    
    type t1_array_t is array(integer range <>) of t1_t;
    
    function "or"(a : t1_t; b : t1_t) return t1_t;

    --==============--
    --== Wishbone ==--
    --==============--
    
    type wb_req_t is record
        stb     : std_logic;
        we      : std_logic;
        addr    : std_logic_vector(31 downto 0);
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

package body types_pkg is 

    function "or"(a : t1_t; b : t1_t) return t1_t is
        variable res    : t1_t;
    begin
        res.lv1a := a.lv1a or b.lv1a;
        res.calpulse := a.calpulse or b.calpulse;
        res.resync := a.resync or b.resync;
        res.bc0 := a.bc0 or b.bc0;
        return res;
    end "or";
  
end types_pkg;
