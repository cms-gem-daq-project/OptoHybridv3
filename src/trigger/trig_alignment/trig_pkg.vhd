----------------------------------------------------------------------------------
-- CMS Muon Endcap
-- GEM Collaboration
-- Optohybrid v3 Firmware -- Tap Delays
-- A. Peck
----------------------------------------------------------------------------------
-- Description:
--   This module holds trig polarity swaps derived from the Optohybrid PCB
----------------------------------------------------------------------------------
-- 2017/11/06 -- Initial
-- 2017/11/13 -- Port to vhdl
----------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package trig_pkg is

  constant DDR : integer := 0;
  constant MXSBITS : integer := 64 * (DDR+1);
  constant MXSBITS_CHAMBER : integer := 24*MXSBITS;

---- START: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----
  constant  SOT_INVERT  : std_logic_vector (23 downto 0) :=
    '0' & -- SOF_INVERT[23]
    '1' & -- SOF_INVERT[22]
    '1' & -- SOF_INVERT[21]
    '0' & -- SOF_INVERT[20]
    '0' & -- SOF_INVERT[19]
    '1' & -- SOF_INVERT[18]
    '0' & -- SOF_INVERT[17]
    '1' & -- SOF_INVERT[16]
    '0' & -- SOF_INVERT[15]
    '1' & -- SOF_INVERT[14]
    '0' & -- SOF_INVERT[13]
    '0' & -- SOF_INVERT[12]
    '1' & -- SOF_INVERT[11]
    '0' & -- SOF_INVERT[10]
    '0' & -- SOF_INVERT[9]
    '1' & -- SOF_INVERT[8]
    '1' & -- SOF_INVERT[7]
    '0' & -- SOF_INVERT[6]
    '0' & -- SOF_INVERT[5]
    '1' & -- SOF_INVERT[4]
    '1' & -- SOF_INVERT[3]
    '1' & -- SOF_INVERT[2]
    '1' & -- SOF_INVERT[1]
    '1' ; -- SOF_INVERT[0]

  constant TU_INVERT  : std_logic_vector (191 downto 0) :=
    '0' & -- TU_INVERT[191] (VFAT=23 BIT=7)
    '1' & -- TU_INVERT[190] (VFAT=23 BIT=6)
    '0' & -- TU_INVERT[189] (VFAT=23 BIT=5)
    '0' & -- TU_INVERT[188] (VFAT=23 BIT=4)
    '0' & -- TU_INVERT[187] (VFAT=23 BIT=3)
    '1' & -- TU_INVERT[186] (VFAT=23 BIT=2)
    '0' & -- TU_INVERT[185] (VFAT=23 BIT=1)
    '1' & -- TU_INVERT[184] (VFAT=23 BIT=0)
    '0' & -- TU_INVERT[183] (VFAT=22 BIT=7)
    '1' & -- TU_INVERT[182] (VFAT=22 BIT=6)
    '1' & -- TU_INVERT[181] (VFAT=22 BIT=5)
    '0' & -- TU_INVERT[180] (VFAT=22 BIT=4)
    '0' & -- TU_INVERT[179] (VFAT=22 BIT=3)
    '1' & -- TU_INVERT[178] (VFAT=22 BIT=2)
    '1' & -- TU_INVERT[177] (VFAT=22 BIT=1)
    '1' & -- TU_INVERT[176] (VFAT=22 BIT=0)
    '0' & -- TU_INVERT[175] (VFAT=21 BIT=7)
    '1' & -- TU_INVERT[174] (VFAT=21 BIT=6)
    '0' & -- TU_INVERT[173] (VFAT=21 BIT=5)
    '0' & -- TU_INVERT[172] (VFAT=21 BIT=4)
    '0' & -- TU_INVERT[171] (VFAT=21 BIT=3)
    '1' & -- TU_INVERT[170] (VFAT=21 BIT=2)
    '1' & -- TU_INVERT[169] (VFAT=21 BIT=1)
    '0' & -- TU_INVERT[168] (VFAT=21 BIT=0)
    '1' & -- TU_INVERT[167] (VFAT=20 BIT=7)
    '1' & -- TU_INVERT[166] (VFAT=20 BIT=6)
    '1' & -- TU_INVERT[165] (VFAT=20 BIT=5)
    '0' & -- TU_INVERT[164] (VFAT=20 BIT=4)
    '0' & -- TU_INVERT[163] (VFAT=20 BIT=3)
    '1' & -- TU_INVERT[162] (VFAT=20 BIT=2)
    '1' & -- TU_INVERT[161] (VFAT=20 BIT=1)
    '1' & -- TU_INVERT[160] (VFAT=20 BIT=0)
    '0' & -- TU_INVERT[159] (VFAT=19 BIT=7)
    '0' & -- TU_INVERT[158] (VFAT=19 BIT=6)
    '1' & -- TU_INVERT[157] (VFAT=19 BIT=5)
    '0' & -- TU_INVERT[156] (VFAT=19 BIT=4)
    '1' & -- TU_INVERT[155] (VFAT=19 BIT=3)
    '1' & -- TU_INVERT[154] (VFAT=19 BIT=2)
    '0' & -- TU_INVERT[153] (VFAT=19 BIT=1)
    '1' & -- TU_INVERT[152] (VFAT=19 BIT=0)
    '1' & -- TU_INVERT[151] (VFAT=18 BIT=7)
    '0' & -- TU_INVERT[150] (VFAT=18 BIT=6)
    '1' & -- TU_INVERT[149] (VFAT=18 BIT=5)
    '1' & -- TU_INVERT[148] (VFAT=18 BIT=4)
    '1' & -- TU_INVERT[147] (VFAT=18 BIT=3)
    '1' & -- TU_INVERT[146] (VFAT=18 BIT=2)
    '0' & -- TU_INVERT[145] (VFAT=18 BIT=1)
    '1' & -- TU_INVERT[144] (VFAT=18 BIT=0)
    '0' & -- TU_INVERT[143] (VFAT=17 BIT=7)
    '0' & -- TU_INVERT[142] (VFAT=17 BIT=6)
    '0' & -- TU_INVERT[141] (VFAT=17 BIT=5)
    '0' & -- TU_INVERT[140] (VFAT=17 BIT=4)
    '1' & -- TU_INVERT[139] (VFAT=17 BIT=3)
    '0' & -- TU_INVERT[138] (VFAT=17 BIT=2)
    '0' & -- TU_INVERT[137] (VFAT=17 BIT=1)
    '0' & -- TU_INVERT[136] (VFAT=17 BIT=0)
    '0' & -- TU_INVERT[135] (VFAT=16 BIT=7)
    '0' & -- TU_INVERT[134] (VFAT=16 BIT=6)
    '1' & -- TU_INVERT[133] (VFAT=16 BIT=5)
    '1' & -- TU_INVERT[132] (VFAT=16 BIT=4)
    '0' & -- TU_INVERT[131] (VFAT=16 BIT=3)
    '0' & -- TU_INVERT[130] (VFAT=16 BIT=2)
    '1' & -- TU_INVERT[129] (VFAT=16 BIT=1)
    '0' & -- TU_INVERT[128] (VFAT=16 BIT=0)
    '0' & -- TU_INVERT[127] (VFAT=15 BIT=7)
    '1' & -- TU_INVERT[126] (VFAT=15 BIT=6)
    '1' & -- TU_INVERT[125] (VFAT=15 BIT=5)
    '1' & -- TU_INVERT[124] (VFAT=15 BIT=4)
    '0' & -- TU_INVERT[123] (VFAT=15 BIT=3)
    '0' & -- TU_INVERT[122] (VFAT=15 BIT=2)
    '0' & -- TU_INVERT[121] (VFAT=15 BIT=1)
    '1' & -- TU_INVERT[120] (VFAT=15 BIT=0)
    '0' & -- TU_INVERT[119] (VFAT=14 BIT=7)
    '0' & -- TU_INVERT[118] (VFAT=14 BIT=6)
    '0' & -- TU_INVERT[117] (VFAT=14 BIT=5)
    '0' & -- TU_INVERT[116] (VFAT=14 BIT=4)
    '0' & -- TU_INVERT[115] (VFAT=14 BIT=3)
    '1' & -- TU_INVERT[114] (VFAT=14 BIT=2)
    '1' & -- TU_INVERT[113] (VFAT=14 BIT=1)
    '1' & -- TU_INVERT[112] (VFAT=14 BIT=0)
    '1' & -- TU_INVERT[111] (VFAT=13 BIT=7)
    '1' & -- TU_INVERT[110] (VFAT=13 BIT=6)
    '0' & -- TU_INVERT[109] (VFAT=13 BIT=5)
    '1' & -- TU_INVERT[108] (VFAT=13 BIT=4)
    '1' & -- TU_INVERT[107] (VFAT=13 BIT=3)
    '1' & -- TU_INVERT[106] (VFAT=13 BIT=2)
    '0' & -- TU_INVERT[105] (VFAT=13 BIT=1)
    '0' & -- TU_INVERT[104] (VFAT=13 BIT=0)
    '1' & -- TU_INVERT[103] (VFAT=12 BIT=7)
    '1' & -- TU_INVERT[102] (VFAT=12 BIT=6)
    '1' & -- TU_INVERT[101] (VFAT=12 BIT=5)
    '0' & -- TU_INVERT[100] (VFAT=12 BIT=4)
    '1' & -- TU_INVERT[99] (VFAT=12 BIT=3)
    '1' & -- TU_INVERT[98] (VFAT=12 BIT=2)
    '1' & -- TU_INVERT[97] (VFAT=12 BIT=1)
    '0' & -- TU_INVERT[96] (VFAT=12 BIT=0)
    '1' & -- TU_INVERT[95] (VFAT=11 BIT=7)
    '0' & -- TU_INVERT[94] (VFAT=11 BIT=6)
    '1' & -- TU_INVERT[93] (VFAT=11 BIT=5)
    '0' & -- TU_INVERT[92] (VFAT=11 BIT=4)
    '1' & -- TU_INVERT[91] (VFAT=11 BIT=3)
    '1' & -- TU_INVERT[90] (VFAT=11 BIT=2)
    '0' & -- TU_INVERT[89] (VFAT=11 BIT=1)
    '1' & -- TU_INVERT[88] (VFAT=11 BIT=0)
    '0' & -- TU_INVERT[87] (VFAT=10 BIT=7)
    '0' & -- TU_INVERT[86] (VFAT=10 BIT=6)
    '0' & -- TU_INVERT[85] (VFAT=10 BIT=5)
    '1' & -- TU_INVERT[84] (VFAT=10 BIT=4)
    '0' & -- TU_INVERT[83] (VFAT=10 BIT=3)
    '1' & -- TU_INVERT[82] (VFAT=10 BIT=2)
    '1' & -- TU_INVERT[81] (VFAT=10 BIT=1)
    '1' & -- TU_INVERT[80] (VFAT=10 BIT=0)
    '1' & -- TU_INVERT[79] (VFAT=9 BIT=7)
    '1' & -- TU_INVERT[78] (VFAT=9 BIT=6)
    '1' & -- TU_INVERT[77] (VFAT=9 BIT=5)
    '0' & -- TU_INVERT[76] (VFAT=9 BIT=4)
    '0' & -- TU_INVERT[75] (VFAT=9 BIT=3)
    '1' & -- TU_INVERT[74] (VFAT=9 BIT=2)
    '0' & -- TU_INVERT[73] (VFAT=9 BIT=1)
    '1' & -- TU_INVERT[72] (VFAT=9 BIT=0)
    '1' & -- TU_INVERT[71] (VFAT=8 BIT=7)
    '0' & -- TU_INVERT[70] (VFAT=8 BIT=6)
    '0' & -- TU_INVERT[69] (VFAT=8 BIT=5)
    '0' & -- TU_INVERT[68] (VFAT=8 BIT=4)
    '1' & -- TU_INVERT[67] (VFAT=8 BIT=3)
    '1' & -- TU_INVERT[66] (VFAT=8 BIT=2)
    '1' & -- TU_INVERT[65] (VFAT=8 BIT=1)
    '1' & -- TU_INVERT[64] (VFAT=8 BIT=0)
    '1' & -- TU_INVERT[63] (VFAT=7 BIT=7)
    '1' & -- TU_INVERT[62] (VFAT=7 BIT=6)
    '1' & -- TU_INVERT[61] (VFAT=7 BIT=5)
    '0' & -- TU_INVERT[60] (VFAT=7 BIT=4)
    '0' & -- TU_INVERT[59] (VFAT=7 BIT=3)
    '0' & -- TU_INVERT[58] (VFAT=7 BIT=2)
    '1' & -- TU_INVERT[57] (VFAT=7 BIT=1)
    '0' & -- TU_INVERT[56] (VFAT=7 BIT=0)
    '0' & -- TU_INVERT[55] (VFAT=6 BIT=7)
    '0' & -- TU_INVERT[54] (VFAT=6 BIT=6)
    '0' & -- TU_INVERT[53] (VFAT=6 BIT=5)
    '0' & -- TU_INVERT[52] (VFAT=6 BIT=4)
    '0' & -- TU_INVERT[51] (VFAT=6 BIT=3)
    '1' & -- TU_INVERT[50] (VFAT=6 BIT=2)
    '1' & -- TU_INVERT[49] (VFAT=6 BIT=1)
    '0' & -- TU_INVERT[48] (VFAT=6 BIT=0)
    '0' & -- TU_INVERT[47] (VFAT=5 BIT=7)
    '0' & -- TU_INVERT[46] (VFAT=5 BIT=6)
    '1' & -- TU_INVERT[45] (VFAT=5 BIT=5)
    '1' & -- TU_INVERT[44] (VFAT=5 BIT=4)
    '0' & -- TU_INVERT[43] (VFAT=5 BIT=3)
    '0' & -- TU_INVERT[42] (VFAT=5 BIT=2)
    '0' & -- TU_INVERT[41] (VFAT=5 BIT=1)
    '0' & -- TU_INVERT[40] (VFAT=5 BIT=0)
    '0' & -- TU_INVERT[39] (VFAT=4 BIT=7)
    '1' & -- TU_INVERT[38] (VFAT=4 BIT=6)
    '0' & -- TU_INVERT[37] (VFAT=4 BIT=5)
    '1' & -- TU_INVERT[36] (VFAT=4 BIT=4)
    '1' & -- TU_INVERT[35] (VFAT=4 BIT=3)
    '1' & -- TU_INVERT[34] (VFAT=4 BIT=2)
    '0' & -- TU_INVERT[33] (VFAT=4 BIT=1)
    '1' & -- TU_INVERT[32] (VFAT=4 BIT=0)
    '0' & -- TU_INVERT[31] (VFAT=3 BIT=7)
    '1' & -- TU_INVERT[30] (VFAT=3 BIT=6)
    '1' & -- TU_INVERT[29] (VFAT=3 BIT=5)
    '0' & -- TU_INVERT[28] (VFAT=3 BIT=4)
    '0' & -- TU_INVERT[27] (VFAT=3 BIT=3)
    '0' & -- TU_INVERT[26] (VFAT=3 BIT=2)
    '0' & -- TU_INVERT[25] (VFAT=3 BIT=1)
    '0' & -- TU_INVERT[24] (VFAT=3 BIT=0)
    '0' & -- TU_INVERT[23] (VFAT=2 BIT=7)
    '1' & -- TU_INVERT[22] (VFAT=2 BIT=6)
    '1' & -- TU_INVERT[21] (VFAT=2 BIT=5)
    '1' & -- TU_INVERT[20] (VFAT=2 BIT=4)
    '0' & -- TU_INVERT[19] (VFAT=2 BIT=3)
    '0' & -- TU_INVERT[18] (VFAT=2 BIT=2)
    '1' & -- TU_INVERT[17] (VFAT=2 BIT=1)
    '1' & -- TU_INVERT[16] (VFAT=2 BIT=0)
    '0' & -- TU_INVERT[15] (VFAT=1 BIT=7)
    '0' & -- TU_INVERT[14] (VFAT=1 BIT=6)
    '0' & -- TU_INVERT[13] (VFAT=1 BIT=5)
    '0' & -- TU_INVERT[12] (VFAT=1 BIT=4)
    '1' & -- TU_INVERT[11] (VFAT=1 BIT=3)
    '0' & -- TU_INVERT[10] (VFAT=1 BIT=2)
    '1' & -- TU_INVERT[9] (VFAT=1 BIT=1)
    '0' & -- TU_INVERT[8] (VFAT=1 BIT=0)
    '0' & -- TU_INVERT[7] (VFAT=0 BIT=7)
    '0' & -- TU_INVERT[6] (VFAT=0 BIT=6)
    '0' & -- TU_INVERT[5] (VFAT=0 BIT=5)
    '1' & -- TU_INVERT[4] (VFAT=0 BIT=4)
    '0' & -- TU_INVERT[3] (VFAT=0 BIT=3)
    '1' & -- TU_INVERT[2] (VFAT=0 BIT=2)
    '0' & -- TU_INVERT[1] (VFAT=0 BIT=1)
    '0' ; -- TU_INVERT[0] (VFAT=0 BIT=0)
---- END: AUTO GENERATED POLARITY SWAPS -- DO NOT EDIT ----

end package;