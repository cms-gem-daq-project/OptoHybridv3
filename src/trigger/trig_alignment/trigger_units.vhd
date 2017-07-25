----------------------------------------------------------------------------------
-- Company:        University
-- Engineer:       John Smith   (john.smith@email.com)
--
-- Produce Trigger units from VFAT trigger inputs
--
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;

entity trigger_units is
port(

    vfat0_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat0_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat1_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat1_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat2_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat2_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat3_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat3_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat4_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat4_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat5_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat5_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat6_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat6_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat7_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat7_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat8_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat8_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat9_sbits_p_i       : in std_logic_vector(7 downto 0);
    vfat9_sbits_n_i       : in std_logic_vector(7 downto 0);

    vfat10_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat10_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat11_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat11_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat12_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat12_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat13_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat13_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat14_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat14_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat15_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat15_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat16_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat16_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat17_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat17_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat18_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat18_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat19_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat19_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat20_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat20_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat21_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat21_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat22_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat22_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat23_sbits_p_i      : in std_logic_vector(7 downto 0);
    vfat23_sbits_n_i      : in std_logic_vector(7 downto 0);

    vfat0_sof_p_i  : in std_logic;
    vfat0_sof_n_i  : in std_logic;
    vfat1_sof_p_i  : in std_logic;
    vfat1_sof_n_i  : in std_logic;
    vfat2_sof_p_i  : in std_logic;
    vfat2_sof_n_i  : in std_logic;
    vfat3_sof_p_i  : in std_logic;
    vfat3_sof_n_i  : in std_logic;
    vfat4_sof_p_i  : in std_logic;
    vfat4_sof_n_i  : in std_logic;
    vfat5_sof_p_i  : in std_logic;
    vfat5_sof_n_i  : in std_logic;
    vfat6_sof_p_i  : in std_logic;
    vfat6_sof_n_i  : in std_logic;
    vfat7_sof_p_i  : in std_logic;
    vfat7_sof_n_i  : in std_logic;
    vfat8_sof_p_i  : in std_logic;
    vfat8_sof_n_i  : in std_logic;
    vfat9_sof_p_i  : in std_logic;
    vfat9_sof_n_i  : in std_logic;
    vfat10_sof_p_i : in std_logic;
    vfat10_sof_n_i : in std_logic;
    vfat11_sof_p_i : in std_logic;
    vfat11_sof_n_i : in std_logic;
    vfat12_sof_p_i : in std_logic;
    vfat12_sof_n_i : in std_logic;
    vfat13_sof_p_i : in std_logic;
    vfat13_sof_n_i : in std_logic;
    vfat14_sof_p_i : in std_logic;
    vfat14_sof_n_i : in std_logic;
    vfat15_sof_p_i : in std_logic;
    vfat15_sof_n_i : in std_logic;
    vfat16_sof_p_i : in std_logic;
    vfat16_sof_n_i : in std_logic;
    vfat17_sof_p_i : in std_logic;
    vfat17_sof_n_i : in std_logic;
    vfat18_sof_p_i : in std_logic;
    vfat18_sof_n_i : in std_logic;
    vfat19_sof_p_i : in std_logic;
    vfat19_sof_n_i : in std_logic;
    vfat20_sof_p_i : in std_logic;
    vfat20_sof_n_i : in std_logic;
    vfat21_sof_p_i : in std_logic;
    vfat21_sof_n_i : in std_logic;
    vfat22_sof_p_i : in std_logic;
    vfat22_sof_n_i : in std_logic;
    vfat23_sof_p_i : in std_logic;
    vfat23_sof_n_i : in std_logic;

    trigger_units_o : out trigger_unit_array_t (23 downto 0)

);
end trigger_units;

architecture Behavioral of trigger_units is

begin

    trigger_units_o(0).trig_data_p      <= vfat0_sbits_p_i;
    trigger_units_o(0).trig_data_n      <= vfat0_sbits_n_i;
    trigger_units_o(0).start_of_frame_p <= vfat0_sof_p_i;
    trigger_units_o(0).start_of_frame_n <= vfat0_sof_n_i;

    trigger_units_o(1).trig_data_p      <= vfat1_sbits_p_i;
    trigger_units_o(1).trig_data_n      <= vfat1_sbits_n_i;
    trigger_units_o(1).start_of_frame_p <= vfat1_sof_p_i;
    trigger_units_o(1).start_of_frame_n <= vfat1_sof_n_i;

    trigger_units_o(2).trig_data_p      <= vfat2_sbits_p_i;
    trigger_units_o(2).trig_data_n      <= vfat2_sbits_n_i;
    trigger_units_o(2).start_of_frame_p <= vfat2_sof_p_i;
    trigger_units_o(2).start_of_frame_n <= vfat2_sof_n_i;

    trigger_units_o(3).trig_data_p      <= vfat3_sbits_p_i;
    trigger_units_o(3).trig_data_n      <= vfat3_sbits_n_i;
    trigger_units_o(3).start_of_frame_p <= vfat3_sof_p_i;
    trigger_units_o(3).start_of_frame_n <= vfat3_sof_n_i;

    trigger_units_o(4).trig_data_p      <= vfat4_sbits_p_i;
    trigger_units_o(4).trig_data_n      <= vfat4_sbits_n_i;
    trigger_units_o(4).start_of_frame_p <= vfat4_sof_p_i;
    trigger_units_o(4).start_of_frame_n <= vfat4_sof_n_i;

    trigger_units_o(5).trig_data_p      <= vfat5_sbits_p_i;
    trigger_units_o(5).trig_data_n      <= vfat5_sbits_n_i;
    trigger_units_o(5).start_of_frame_p <= vfat5_sof_p_i;
    trigger_units_o(5).start_of_frame_n <= vfat5_sof_n_i;

    trigger_units_o(6).trig_data_p      <= vfat6_sbits_p_i;
    trigger_units_o(6).trig_data_n      <= vfat6_sbits_n_i;
    trigger_units_o(6).start_of_frame_p <= vfat6_sof_p_i;
    trigger_units_o(6).start_of_frame_n <= vfat6_sof_n_i;

    trigger_units_o(7).trig_data_p      <= vfat7_sbits_p_i;
    trigger_units_o(7).trig_data_n      <= vfat7_sbits_n_i;
    trigger_units_o(7).start_of_frame_p <= vfat7_sof_p_i;
    trigger_units_o(7).start_of_frame_n <= vfat7_sof_n_i;

    trigger_units_o(8).trig_data_p      <= vfat8_sbits_p_i;
    trigger_units_o(8).trig_data_n      <= vfat8_sbits_n_i;
    trigger_units_o(8).start_of_frame_p <= vfat8_sof_p_i;
    trigger_units_o(8).start_of_frame_n <= vfat8_sof_n_i;

    trigger_units_o(9).trig_data_p      <= vfat9_sbits_p_i;
    trigger_units_o(9).trig_data_n      <= vfat9_sbits_n_i;
    trigger_units_o(9).start_of_frame_p <= vfat9_sof_p_i;
    trigger_units_o(9).start_of_frame_n <= vfat9_sof_n_i;

    trigger_units_o(10).trig_data_p      <= vfat10_sbits_p_i;
    trigger_units_o(10).trig_data_n      <= vfat10_sbits_n_i;
    trigger_units_o(10).start_of_frame_p <= vfat10_sof_p_i;
    trigger_units_o(10).start_of_frame_n <= vfat10_sof_n_i;

    trigger_units_o(11).trig_data_p      <= vfat11_sbits_p_i;
    trigger_units_o(11).trig_data_n      <= vfat11_sbits_n_i;
    trigger_units_o(11).start_of_frame_p <= vfat11_sof_p_i;
    trigger_units_o(11).start_of_frame_n <= vfat11_sof_n_i;

    trigger_units_o(12).trig_data_p      <= vfat12_sbits_p_i;
    trigger_units_o(12).trig_data_n      <= vfat12_sbits_n_i;
    trigger_units_o(12).start_of_frame_p <= vfat12_sof_p_i;
    trigger_units_o(12).start_of_frame_n <= vfat12_sof_n_i;

    trigger_units_o(13).trig_data_p      <= vfat13_sbits_p_i;
    trigger_units_o(13).trig_data_n      <= vfat13_sbits_n_i;
    trigger_units_o(13).start_of_frame_p <= vfat13_sof_p_i;
    trigger_units_o(13).start_of_frame_n <= vfat13_sof_n_i;

    trigger_units_o(14).trig_data_p      <= vfat14_sbits_p_i;
    trigger_units_o(14).trig_data_n      <= vfat14_sbits_n_i;
    trigger_units_o(14).start_of_frame_p <= vfat14_sof_p_i;
    trigger_units_o(14).start_of_frame_n <= vfat14_sof_n_i;

    trigger_units_o(15).trig_data_p      <= vfat15_sbits_p_i;
    trigger_units_o(15).trig_data_n      <= vfat15_sbits_n_i;
    trigger_units_o(15).start_of_frame_p <= vfat15_sof_p_i;
    trigger_units_o(15).start_of_frame_n <= vfat15_sof_n_i;

    trigger_units_o(16).trig_data_p      <= vfat16_sbits_p_i;
    trigger_units_o(16).trig_data_n      <= vfat16_sbits_n_i;
    trigger_units_o(16).start_of_frame_p <= vfat16_sof_p_i;
    trigger_units_o(16).start_of_frame_n <= vfat16_sof_n_i;

    trigger_units_o(17).trig_data_p      <= vfat17_sbits_p_i;
    trigger_units_o(17).trig_data_n      <= vfat17_sbits_n_i;
    trigger_units_o(17).start_of_frame_p <= vfat17_sof_p_i;
    trigger_units_o(17).start_of_frame_n <= vfat17_sof_n_i;

    trigger_units_o(18).trig_data_p      <= vfat18_sbits_p_i;
    trigger_units_o(18).trig_data_n      <= vfat18_sbits_n_i;
    trigger_units_o(18).start_of_frame_p <= vfat18_sof_p_i;
    trigger_units_o(18).start_of_frame_n <= vfat18_sof_n_i;

    trigger_units_o(19).trig_data_p      <= vfat19_sbits_p_i;
    trigger_units_o(19).trig_data_n      <= vfat19_sbits_n_i;
    trigger_units_o(19).start_of_frame_p <= vfat19_sof_p_i;
    trigger_units_o(19).start_of_frame_n <= vfat19_sof_n_i;

    trigger_units_o(20).trig_data_p      <= vfat20_sbits_p_i;
    trigger_units_o(20).trig_data_n      <= vfat20_sbits_n_i;
    trigger_units_o(20).start_of_frame_p <= vfat20_sof_p_i;
    trigger_units_o(20).start_of_frame_n <= vfat20_sof_n_i;

    trigger_units_o(21).trig_data_p      <= vfat21_sbits_p_i;
    trigger_units_o(21).trig_data_n      <= vfat21_sbits_n_i;
    trigger_units_o(21).start_of_frame_p <= vfat21_sof_p_i;
    trigger_units_o(21).start_of_frame_n <= vfat21_sof_n_i;

    trigger_units_o(22).trig_data_p      <= vfat22_sbits_p_i;
    trigger_units_o(22).trig_data_n      <= vfat22_sbits_n_i;
    trigger_units_o(22).start_of_frame_p <= vfat22_sof_p_i;
    trigger_units_o(22).start_of_frame_n <= vfat22_sof_n_i;

    trigger_units_o(23).trig_data_p      <= vfat23_sbits_p_i;
    trigger_units_o(23).trig_data_n      <= vfat23_sbits_n_i;
    trigger_units_o(23).start_of_frame_p <= vfat23_sof_p_i;
    trigger_units_o(23).start_of_frame_n <= vfat23_sof_n_i;


end Behavioral;

