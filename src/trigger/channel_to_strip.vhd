----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- S-Bits
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module remaps S-bits according to the Channel-to-Strip mapping, determined
--   by the Hybrid and the readout board
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;
use ieee.numeric_std.all;

library work;
use work.types_pkg.all;
use work.hardware_pkg.all;

entity channel_to_strip is
  port(
    channels_in : in  sbits_array_t(c_NUM_VFATS-1 downto 0);
    strips_out  : out sbits_array_t(c_NUM_VFATS-1 downto 0)
    );
end channel_to_strip;

architecture Behavioral of channel_to_strip is
begin

  vfat_loop : for I in 0 to (c_NUM_VFATS-1) generate
  begin

    remap_ge11 : if (GE11 = 1 and REMAP_STRIPS) generate
      map_a : if (I = 2 or I = 3 or I = 5 or I = 7 or I = 8 or I = 9 or I = 10 or I = 11 or I = 13 or I = 15) generate
        strips_out(i)(0)  <= channels_in(I)(0);
        strips_out(i)(1)  <= channels_in(I)(63);
        strips_out(i)(2)  <= channels_in(I)(1);
        strips_out(i)(3)  <= channels_in(I)(62);
        strips_out(i)(4)  <= channels_in(I)(2);
        strips_out(i)(5)  <= channels_in(I)(61);
        strips_out(i)(6)  <= channels_in(I)(3);
        strips_out(i)(7)  <= channels_in(I)(60);
        strips_out(i)(8)  <= channels_in(I)(4);
        strips_out(i)(9)  <= channels_in(I)(59);
        strips_out(i)(10) <= channels_in(I)(5);
        strips_out(i)(11) <= channels_in(I)(58);
        strips_out(i)(12) <= channels_in(I)(6);
        strips_out(i)(13) <= channels_in(I)(57);
        strips_out(i)(14) <= channels_in(I)(7);
        strips_out(i)(15) <= channels_in(I)(56);
        strips_out(i)(16) <= channels_in(I)(8);
        strips_out(i)(17) <= channels_in(I)(55);
        strips_out(i)(18) <= channels_in(I)(9);
        strips_out(i)(19) <= channels_in(I)(54);
        strips_out(i)(20) <= channels_in(I)(10);
        strips_out(i)(21) <= channels_in(I)(53);
        strips_out(i)(22) <= channels_in(I)(11);
        strips_out(i)(23) <= channels_in(I)(52);
        strips_out(i)(24) <= channels_in(I)(12);
        strips_out(i)(25) <= channels_in(I)(51);
        strips_out(i)(26) <= channels_in(I)(13);
        strips_out(i)(27) <= channels_in(I)(50);
        strips_out(i)(28) <= channels_in(I)(14);
        strips_out(i)(29) <= channels_in(I)(49);
        strips_out(i)(30) <= channels_in(I)(15);
        strips_out(i)(31) <= channels_in(I)(48);
        strips_out(i)(32) <= channels_in(I)(16);
        strips_out(i)(33) <= channels_in(I)(47);
        strips_out(i)(34) <= channels_in(I)(17);
        strips_out(i)(35) <= channels_in(I)(46);
        strips_out(i)(36) <= channels_in(I)(18);
        strips_out(i)(37) <= channels_in(I)(45);
        strips_out(i)(38) <= channels_in(I)(19);
        strips_out(i)(39) <= channels_in(I)(44);
        strips_out(i)(40) <= channels_in(I)(20);
        strips_out(i)(41) <= channels_in(I)(43);
        strips_out(i)(42) <= channels_in(I)(21);
        strips_out(i)(43) <= channels_in(I)(42);
        strips_out(i)(44) <= channels_in(I)(22);
        strips_out(i)(45) <= channels_in(I)(41);
        strips_out(i)(46) <= channels_in(I)(23);
        strips_out(i)(47) <= channels_in(I)(40);
        strips_out(i)(48) <= channels_in(I)(24);
        strips_out(i)(49) <= channels_in(I)(39);
        strips_out(i)(50) <= channels_in(I)(25);
        strips_out(i)(51) <= channels_in(I)(38);
        strips_out(i)(52) <= channels_in(I)(26);
        strips_out(i)(53) <= channels_in(I)(37);
        strips_out(i)(54) <= channels_in(I)(27);
        strips_out(i)(55) <= channels_in(I)(36);
        strips_out(i)(56) <= channels_in(I)(28);
        strips_out(i)(57) <= channels_in(I)(35);
        strips_out(i)(58) <= channels_in(I)(29);
        strips_out(i)(59) <= channels_in(I)(34);
        strips_out(i)(60) <= channels_in(I)(30);
        strips_out(i)(61) <= channels_in(I)(33);
        strips_out(i)(62) <= channels_in(I)(31);
        strips_out(i)(63) <= channels_in(I)(32);
      end generate;

      map_b : if (I = 0 or I = 1 or I = 4 or I = 6 or I = 12 or I = 14) generate
        strips_out(i)(0)  <= channels_in(I)(31);
        strips_out(i)(1)  <= channels_in(I)(32);
        strips_out(i)(2)  <= channels_in(I)(30);
        strips_out(i)(3)  <= channels_in(I)(33);
        strips_out(i)(4)  <= channels_in(I)(29);
        strips_out(i)(5)  <= channels_in(I)(34);
        strips_out(i)(6)  <= channels_in(I)(28);
        strips_out(i)(7)  <= channels_in(I)(35);
        strips_out(i)(8)  <= channels_in(I)(27);
        strips_out(i)(9)  <= channels_in(I)(36);
        strips_out(i)(10) <= channels_in(I)(26);
        strips_out(i)(11) <= channels_in(I)(37);
        strips_out(i)(12) <= channels_in(I)(25);
        strips_out(i)(13) <= channels_in(I)(38);
        strips_out(i)(14) <= channels_in(I)(24);
        strips_out(i)(15) <= channels_in(I)(39);
        strips_out(i)(16) <= channels_in(I)(23);
        strips_out(i)(17) <= channels_in(I)(40);
        strips_out(i)(18) <= channels_in(I)(22);
        strips_out(i)(19) <= channels_in(I)(41);
        strips_out(i)(20) <= channels_in(I)(21);
        strips_out(i)(21) <= channels_in(I)(42);
        strips_out(i)(22) <= channels_in(I)(20);
        strips_out(i)(23) <= channels_in(I)(43);
        strips_out(i)(24) <= channels_in(I)(19);
        strips_out(i)(25) <= channels_in(I)(44);
        strips_out(i)(26) <= channels_in(I)(18);
        strips_out(i)(27) <= channels_in(I)(45);
        strips_out(i)(28) <= channels_in(I)(17);
        strips_out(i)(29) <= channels_in(I)(46);
        strips_out(i)(30) <= channels_in(I)(16);
        strips_out(i)(31) <= channels_in(I)(47);
        strips_out(i)(32) <= channels_in(I)(15);
        strips_out(i)(33) <= channels_in(I)(48);
        strips_out(i)(34) <= channels_in(I)(14);
        strips_out(i)(35) <= channels_in(I)(49);
        strips_out(i)(36) <= channels_in(I)(13);
        strips_out(i)(37) <= channels_in(I)(50);
        strips_out(i)(38) <= channels_in(I)(12);
        strips_out(i)(39) <= channels_in(I)(51);
        strips_out(i)(40) <= channels_in(I)(11);
        strips_out(i)(41) <= channels_in(I)(52);
        strips_out(i)(42) <= channels_in(I)(10);
        strips_out(i)(43) <= channels_in(I)(53);
        strips_out(i)(44) <= channels_in(I)(9);
        strips_out(i)(45) <= channels_in(I)(54);
        strips_out(i)(46) <= channels_in(I)(8);
        strips_out(i)(47) <= channels_in(I)(55);
        strips_out(i)(48) <= channels_in(I)(7);
        strips_out(i)(49) <= channels_in(I)(56);
        strips_out(i)(50) <= channels_in(I)(6);
        strips_out(i)(51) <= channels_in(I)(57);
        strips_out(i)(52) <= channels_in(I)(5);
        strips_out(i)(53) <= channels_in(I)(58);
        strips_out(i)(54) <= channels_in(I)(4);
        strips_out(i)(55) <= channels_in(I)(59);
        strips_out(i)(56) <= channels_in(I)(3);
        strips_out(i)(57) <= channels_in(I)(60);
        strips_out(i)(58) <= channels_in(I)(2);
        strips_out(i)(59) <= channels_in(I)(61);
        strips_out(i)(60) <= channels_in(I)(1);
        strips_out(i)(61) <= channels_in(I)(62);
        strips_out(i)(62) <= channels_in(I)(0);
        strips_out(i)(63) <= channels_in(I)(63);
      end generate;

      map_c : if (I = 16 or I = 17 or I = 20 or I = 22) generate
        strips_out(i)(0)  <= channels_in(I)(63);
        strips_out(i)(1)  <= channels_in(I)(0);
        strips_out(i)(2)  <= channels_in(I)(62);
        strips_out(i)(3)  <= channels_in(I)(1);
        strips_out(i)(4)  <= channels_in(I)(61);
        strips_out(i)(5)  <= channels_in(I)(2);
        strips_out(i)(6)  <= channels_in(I)(60);
        strips_out(i)(7)  <= channels_in(I)(3);
        strips_out(i)(8)  <= channels_in(I)(59);
        strips_out(i)(9)  <= channels_in(I)(4);
        strips_out(i)(10) <= channels_in(I)(58);
        strips_out(i)(11) <= channels_in(I)(5);
        strips_out(i)(12) <= channels_in(I)(57);
        strips_out(i)(13) <= channels_in(I)(6);
        strips_out(i)(14) <= channels_in(I)(56);
        strips_out(i)(15) <= channels_in(I)(7);
        strips_out(i)(16) <= channels_in(I)(55);
        strips_out(i)(17) <= channels_in(I)(8);
        strips_out(i)(18) <= channels_in(I)(54);
        strips_out(i)(19) <= channels_in(I)(9);
        strips_out(i)(20) <= channels_in(I)(53);
        strips_out(i)(21) <= channels_in(I)(10);
        strips_out(i)(22) <= channels_in(I)(52);
        strips_out(i)(23) <= channels_in(I)(11);
        strips_out(i)(24) <= channels_in(I)(51);
        strips_out(i)(25) <= channels_in(I)(12);
        strips_out(i)(26) <= channels_in(I)(50);
        strips_out(i)(27) <= channels_in(I)(13);
        strips_out(i)(28) <= channels_in(I)(49);
        strips_out(i)(29) <= channels_in(I)(14);
        strips_out(i)(30) <= channels_in(I)(48);
        strips_out(i)(31) <= channels_in(I)(15);
        strips_out(i)(32) <= channels_in(I)(47);
        strips_out(i)(33) <= channels_in(I)(16);
        strips_out(i)(34) <= channels_in(I)(46);
        strips_out(i)(35) <= channels_in(I)(17);
        strips_out(i)(36) <= channels_in(I)(45);
        strips_out(i)(37) <= channels_in(I)(18);
        strips_out(i)(38) <= channels_in(I)(44);
        strips_out(i)(39) <= channels_in(I)(19);
        strips_out(i)(40) <= channels_in(I)(43);
        strips_out(i)(41) <= channels_in(I)(20);
        strips_out(i)(42) <= channels_in(I)(42);
        strips_out(i)(43) <= channels_in(I)(21);
        strips_out(i)(44) <= channels_in(I)(41);
        strips_out(i)(45) <= channels_in(I)(22);
        strips_out(i)(46) <= channels_in(I)(40);
        strips_out(i)(47) <= channels_in(I)(23);
        strips_out(i)(48) <= channels_in(I)(39);
        strips_out(i)(49) <= channels_in(I)(24);
        strips_out(i)(50) <= channels_in(I)(38);
        strips_out(i)(51) <= channels_in(I)(25);
        strips_out(i)(52) <= channels_in(I)(37);
        strips_out(i)(53) <= channels_in(I)(26);
        strips_out(i)(54) <= channels_in(I)(36);
        strips_out(i)(55) <= channels_in(I)(27);
        strips_out(i)(56) <= channels_in(I)(35);
        strips_out(i)(57) <= channels_in(I)(28);
        strips_out(i)(58) <= channels_in(I)(34);
        strips_out(i)(59) <= channels_in(I)(29);
        strips_out(i)(60) <= channels_in(I)(33);
        strips_out(i)(61) <= channels_in(I)(30);
        strips_out(i)(62) <= channels_in(I)(32);
        strips_out(i)(63) <= channels_in(I)(31);
      end generate;

      map_d : if (I = 18 or I = 19 or I = 21 or I = 23) generate
        strips_out(i)(0)  <= channels_in(I)(32);
        strips_out(i)(1)  <= channels_in(I)(31);
        strips_out(i)(2)  <= channels_in(I)(33);
        strips_out(i)(3)  <= channels_in(I)(30);
        strips_out(i)(4)  <= channels_in(I)(34);
        strips_out(i)(5)  <= channels_in(I)(29);
        strips_out(i)(6)  <= channels_in(I)(35);
        strips_out(i)(7)  <= channels_in(I)(28);
        strips_out(i)(8)  <= channels_in(I)(36);
        strips_out(i)(9)  <= channels_in(I)(27);
        strips_out(i)(10) <= channels_in(I)(37);
        strips_out(i)(11) <= channels_in(I)(26);
        strips_out(i)(12) <= channels_in(I)(38);
        strips_out(i)(13) <= channels_in(I)(25);
        strips_out(i)(14) <= channels_in(I)(39);
        strips_out(i)(15) <= channels_in(I)(24);
        strips_out(i)(16) <= channels_in(I)(40);
        strips_out(i)(17) <= channels_in(I)(23);
        strips_out(i)(18) <= channels_in(I)(41);
        strips_out(i)(19) <= channels_in(I)(22);
        strips_out(i)(20) <= channels_in(I)(42);
        strips_out(i)(21) <= channels_in(I)(21);
        strips_out(i)(22) <= channels_in(I)(43);
        strips_out(i)(23) <= channels_in(I)(20);
        strips_out(i)(24) <= channels_in(I)(44);
        strips_out(i)(25) <= channels_in(I)(19);
        strips_out(i)(26) <= channels_in(I)(45);
        strips_out(i)(27) <= channels_in(I)(18);
        strips_out(i)(28) <= channels_in(I)(46);
        strips_out(i)(29) <= channels_in(I)(17);
        strips_out(i)(30) <= channels_in(I)(47);
        strips_out(i)(31) <= channels_in(I)(16);
        strips_out(i)(32) <= channels_in(I)(48);
        strips_out(i)(33) <= channels_in(I)(15);
        strips_out(i)(34) <= channels_in(I)(49);
        strips_out(i)(35) <= channels_in(I)(14);
        strips_out(i)(36) <= channels_in(I)(50);
        strips_out(i)(37) <= channels_in(I)(13);
        strips_out(i)(38) <= channels_in(I)(51);
        strips_out(i)(39) <= channels_in(I)(12);
        strips_out(i)(40) <= channels_in(I)(52);
        strips_out(i)(41) <= channels_in(I)(11);
        strips_out(i)(42) <= channels_in(I)(53);
        strips_out(i)(43) <= channels_in(I)(10);
        strips_out(i)(44) <= channels_in(I)(54);
        strips_out(i)(45) <= channels_in(I)(9);
        strips_out(i)(46) <= channels_in(I)(55);
        strips_out(i)(47) <= channels_in(I)(8);
        strips_out(i)(48) <= channels_in(I)(56);
        strips_out(i)(49) <= channels_in(I)(7);
        strips_out(i)(50) <= channels_in(I)(57);
        strips_out(i)(51) <= channels_in(I)(6);
        strips_out(i)(52) <= channels_in(I)(58);
        strips_out(i)(53) <= channels_in(I)(5);
        strips_out(i)(54) <= channels_in(I)(59);
        strips_out(i)(55) <= channels_in(I)(4);
        strips_out(i)(56) <= channels_in(I)(60);
        strips_out(i)(57) <= channels_in(I)(3);
        strips_out(i)(58) <= channels_in(I)(61);
        strips_out(i)(59) <= channels_in(I)(2);
        strips_out(i)(60) <= channels_in(I)(62);
        strips_out(i)(61) <= channels_in(I)(1);
        strips_out(i)(62) <= channels_in(I)(63);
        strips_out(i)(63) <= channels_in(I)(0);
      end generate;
    end generate;

    noremap_ge21 : if (not REMAP_STRIPS and GE21 = 1) generate
    begin
      strips_out(I)(0)  <= channels_in(I)(0);
      strips_out(I)(1)  <= channels_in(I)(1);
      strips_out(I)(2)  <= channels_in(I)(2);
      strips_out(I)(3)  <= channels_in(I)(3);
      strips_out(I)(4)  <= channels_in(I)(4);
      strips_out(I)(5)  <= channels_in(I)(5);
      strips_out(I)(6)  <= channels_in(I)(6);
      strips_out(I)(7)  <= channels_in(I)(7);
      strips_out(I)(8)  <= channels_in(I)(8);
      strips_out(I)(9)  <= channels_in(I)(9);
      strips_out(I)(10) <= channels_in(I)(10);
      strips_out(I)(11) <= channels_in(I)(11);
      strips_out(I)(12) <= channels_in(I)(12);
      strips_out(I)(13) <= channels_in(I)(13);
      strips_out(I)(14) <= channels_in(I)(14);
      strips_out(I)(15) <= channels_in(I)(15);
      strips_out(I)(16) <= channels_in(I)(16);
      strips_out(I)(17) <= channels_in(I)(17);
      strips_out(I)(18) <= channels_in(I)(18);
      strips_out(I)(19) <= channels_in(I)(19);
      strips_out(I)(20) <= channels_in(I)(20);
      strips_out(I)(21) <= channels_in(I)(21);
      strips_out(I)(22) <= channels_in(I)(22);
      strips_out(I)(23) <= channels_in(I)(23);
      strips_out(I)(24) <= channels_in(I)(24);
      strips_out(I)(25) <= channels_in(I)(25);
      strips_out(I)(26) <= channels_in(I)(26);
      strips_out(I)(27) <= channels_in(I)(27);
      strips_out(I)(28) <= channels_in(I)(28);
      strips_out(I)(29) <= channels_in(I)(29);
      strips_out(I)(30) <= channels_in(I)(30);
      strips_out(I)(31) <= channels_in(I)(31);
      strips_out(I)(32) <= channels_in(I)(32);
      strips_out(I)(33) <= channels_in(I)(33);
      strips_out(I)(34) <= channels_in(I)(34);
      strips_out(I)(35) <= channels_in(I)(35);
      strips_out(I)(36) <= channels_in(I)(36);
      strips_out(I)(37) <= channels_in(I)(37);
      strips_out(I)(38) <= channels_in(I)(38);
      strips_out(I)(39) <= channels_in(I)(39);
      strips_out(I)(40) <= channels_in(I)(40);
      strips_out(I)(41) <= channels_in(I)(41);
      strips_out(I)(42) <= channels_in(I)(42);
      strips_out(I)(43) <= channels_in(I)(43);
      strips_out(I)(44) <= channels_in(I)(44);
      strips_out(I)(45) <= channels_in(I)(45);
      strips_out(I)(46) <= channels_in(I)(46);
      strips_out(I)(47) <= channels_in(I)(47);
      strips_out(I)(48) <= channels_in(I)(48);
      strips_out(I)(49) <= channels_in(I)(49);
      strips_out(I)(50) <= channels_in(I)(50);
      strips_out(I)(51) <= channels_in(I)(51);
      strips_out(I)(52) <= channels_in(I)(52);
      strips_out(I)(53) <= channels_in(I)(53);
      strips_out(I)(54) <= channels_in(I)(54);
      strips_out(I)(55) <= channels_in(I)(55);
      strips_out(I)(56) <= channels_in(I)(56);
      strips_out(I)(57) <= channels_in(I)(57);
      strips_out(I)(58) <= channels_in(I)(58);
      strips_out(I)(59) <= channels_in(I)(59);
      strips_out(I)(60) <= channels_in(I)(60);
      strips_out(I)(61) <= channels_in(I)(61);
      strips_out(I)(62) <= channels_in(I)(62);
      strips_out(I)(63) <= channels_in(I)(63);
    end generate;

    noremap_ge11 : if (not REMAP_STRIPS and GE11 = 1) generate
    begin
      strips_out(I)(0)  <= channels_in(I)(0);
      strips_out(I)(1)  <= channels_in(I)(1);
      strips_out(I)(2)  <= channels_in(I)(2);
      strips_out(I)(3)  <= channels_in(I)(3);
      strips_out(I)(4)  <= channels_in(I)(4);
      strips_out(I)(5)  <= channels_in(I)(5);
      strips_out(I)(6)  <= channels_in(I)(6);
      strips_out(I)(7)  <= channels_in(I)(7);
      strips_out(I)(8)  <= channels_in(I)(8);
      strips_out(I)(9)  <= channels_in(I)(9);
      strips_out(I)(10) <= channels_in(I)(10);
      strips_out(I)(11) <= channels_in(I)(11);
      strips_out(I)(12) <= channels_in(I)(12);
      strips_out(I)(13) <= channels_in(I)(13);
      strips_out(I)(14) <= channels_in(I)(14);
      strips_out(I)(15) <= channels_in(I)(15);
      strips_out(I)(16) <= channels_in(I)(16);
      strips_out(I)(17) <= channels_in(I)(17);
      strips_out(I)(18) <= channels_in(I)(18);
      strips_out(I)(19) <= channels_in(I)(19);
      strips_out(I)(20) <= channels_in(I)(20);
      strips_out(I)(21) <= channels_in(I)(21);
      strips_out(I)(22) <= channels_in(I)(22);
      strips_out(I)(23) <= channels_in(I)(23);
      strips_out(I)(24) <= channels_in(I)(24);
      strips_out(I)(25) <= channels_in(I)(25);
      strips_out(I)(26) <= channels_in(I)(26);
      strips_out(I)(27) <= channels_in(I)(27);
      strips_out(I)(28) <= channels_in(I)(28);
      strips_out(I)(29) <= channels_in(I)(29);
      strips_out(I)(30) <= channels_in(I)(30);
      strips_out(I)(31) <= channels_in(I)(31);
      strips_out(I)(32) <= channels_in(I)(32);
      strips_out(I)(33) <= channels_in(I)(33);
      strips_out(I)(34) <= channels_in(I)(34);
      strips_out(I)(35) <= channels_in(I)(35);
      strips_out(I)(36) <= channels_in(I)(36);
      strips_out(I)(37) <= channels_in(I)(37);
      strips_out(I)(38) <= channels_in(I)(38);
      strips_out(I)(39) <= channels_in(I)(39);
      strips_out(I)(40) <= channels_in(I)(40);
      strips_out(I)(41) <= channels_in(I)(41);
      strips_out(I)(42) <= channels_in(I)(42);
      strips_out(I)(43) <= channels_in(I)(43);
      strips_out(I)(44) <= channels_in(I)(44);
      strips_out(I)(45) <= channels_in(I)(45);
      strips_out(I)(46) <= channels_in(I)(46);
      strips_out(I)(47) <= channels_in(I)(47);
      strips_out(I)(48) <= channels_in(I)(48);
      strips_out(I)(49) <= channels_in(I)(49);
      strips_out(I)(50) <= channels_in(I)(50);
      strips_out(I)(51) <= channels_in(I)(51);
      strips_out(I)(52) <= channels_in(I)(52);
      strips_out(I)(53) <= channels_in(I)(53);
      strips_out(I)(54) <= channels_in(I)(54);
      strips_out(I)(55) <= channels_in(I)(55);
      strips_out(I)(56) <= channels_in(I)(56);
      strips_out(I)(57) <= channels_in(I)(57);
      strips_out(I)(58) <= channels_in(I)(58);
      strips_out(I)(59) <= channels_in(I)(59);
      strips_out(I)(60) <= channels_in(I)(60);
      strips_out(I)(61) <= channels_in(I)(61);
      strips_out(I)(62) <= channels_in(I)(62);
      strips_out(I)(63) <= channels_in(I)(63);
    end generate;

  end generate;

end Behavioral;
