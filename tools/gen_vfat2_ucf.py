import sys

def chr2int(c):
    return ord(c) - 65

def int2chr(i):
    return chr(i + 65)

# Differential pairs to FPGA pins: p1, n1, p2, n2, ...

diffs = [[] for x in range(14)] 

diffs[0] = ["C32", "B32", "J26", "J27", "E32", "E33", "F30", "G30", "A33", "B33", "G31", "H30", "C33", "B34", "K28", "J29", "D34", "C34", "K26", "K27", "F33", "G33", "F31", "E31", "E34", "F34", "J30", "K29", "H34", "H33", "D31", "D32", "K33", "J34", "G32", "H32", "L25", "L26", "J31", "J32"]
diffs[1] = ["AE21", "AD21", "AM18", "AL18", "AG22", "AH22", "AP19", "AN18", "AK22", "AJ22", "AN19", "AN20", "AC20", "AD20", "AM20", "AL20", "AF19", "AE19", "AP20", "AP21", "AK19", "AL19", "AF20", "AF21", "AJ20", "AH20", "AM21", "AL21", "AC19", "AD19", "AM23", "AL23", "AK21", "AJ21", "AM22", "AN22", "AG20", "AG21", "AP22", "AN23"]
diffs[2] = ["M31", "L31", "N25", "M25", "K32", "K31", "M26", "M27", "P31", "P30", "N27", "P27", "L33", "M32", "L28", "M28", "N32", "P32", "N28", "N29", "N33", "M33", "L29", "L30", "P25", "P26", "R28", "R27", "R31", "R32", "R26", "T26", "K34", "L34", "M30", "N30", "N34", "P34", "P29", "R29"]
diffs[3] = ["AH27", "AH28", "AN30", "AM30", "AG25", "AG26", "AP30", "AP31", "AL29", "AK29", "AN29", "AP29", "AL28", "AK28", "AN28", "AM28", "AH25", "AJ25", "AN27", "AM27", "AK27", "AJ27", "AH23", "AH24", "AK26", "AJ26", "AL26", "AM26", "AJ24", "AK24", "AP27", "AP26", "AM25", "AL25", "AN25", "AN24", "AK23", "AL24", "AP25", "AP24"]
diffs[4] = ["D25", "D26", "C24", "C25", "E26", "F26", "B25", "A25", "D27", "E27", "B26", "A26", "G26", "G27", "B27", "C27", "D24", "E24", "C28", "B28", "C29", "D29", "F25", "G25", "H27", "G28", "A28", "A29", "F28", "E28", "A30", "B30", "E29", "F29", "C30", "D30", "H28", "H29", "B31", "A31"]
diffs[5] = ["AD25", "AD26", "AE27", "AD27", "AH33", "AH32", "AE28", "AE29", "AJ34", "AH34", "AF28", "AF29", "AL34", "AK34", "AH29", "AH30", "AN33", "AN34", "AG27", "AG28", "AF30", "AG30", "AF26", "AE26", "AJ31", "AJ32", "AJ29", "AJ30", "AK33", "AK32", "AL31", "AK31", "AM33", "AL33", "AN32", "AM32", "AP32", "AP33", "AL30", "AM31"]
diffs[6] = ["AA34", "AA33", "AA30", "AA31", "AD34", "AC34", "AB30", "AB31", "AC33", "AB33", "AE31", "AD31", "AA25", "Y26", "AA28", "AA29", "AE34", "AF34", "AD30", "AC30", "AE33", "AF33", "AD29", "AC29", "AB32", "AC32", "AB28", "AC28", "AD32", "AE32", "AB27", "AC27", "AG33", "AG32", "AA26", "AB26", "AG31", "AF31", "AB25", "AC25"]
diffs[7] = ["U25", "T25", "T28", "T29", "R33", "R34", "T30", "T31", "T33", "T34", "U26", "U27", "U33", "U32", "U28", "V29", "U31", "U30", "V30", "W30", "V34", "W34", "V28", "V27", "V32", "V33", "Y32", "Y31", "Y33", "Y34", "W29", "Y29", "W31", "W32", "Y28", "Y27", "W25", "V25", "W27", "W26"]
diffs[8] = ["C20", "D20", "A23", "A24", "G21", "G22", "B23", "C23", "J20", "J21", "B21", "B22", "E22", "E23", "A20", "A21", "F19", "F20", "B20", "C19", "F21", "G20", "H19", "H20", "D21", "E21", "E19", "D19", "H22", "J22", "A18", "A19", "K21", "K22", "B18", "C18", "L20", "L21", "C22", "D22"]
diffs[9] = ["AG15", "AF15", "AK14", "AJ14", "AJ15", "AH15", "AL15", "AL14", "AG16", "AF16", "AN15", "AM15", "AJ17", "AJ16", "AP16", "AP15", "AH17", "AG17", "AC15", "AD15", "AE16", "AD16", "AC18", "AC17", "AH18", "AG18", "AN17", "AP17", "AJ19", "AH19", "AM17", "AM16", "AD17", "AE17", "AK18", "AK17", "AE18", "AF18", "AL16", "AK16"]
diffs[10] = ["AE13", "AE12", "AJ11", "AK11", "AD14", "AC14", "AK12", "AJ12", "AF11", "AE11", "AM10", "AL10", "AG11", "AG10", "AL11", "AM11", "AJ10", "AH10", "AC13", "AC12", "AD12", "AD11", "AP11", "AP12", "AF13", "AG13", "AM12", "AN12", "AE14", "AF14", "AN13", "AM13", "AG12", "AH12", "AK13", "AL13", "AH13", "AH14", "AP14", "AN14"]
diffs[11] = ["G13", "H14", "D14", "C14", "G11", "F11", "A13", "A14", "G12", "H13", "F14", "E14", "H10", "G10", "B12", "B13", "K14", "J14", "L13", "M13", "M12", "M11", "C13", "C12", "H12", "J12", "A11", "B11", "J11", "J10", "E13", "F13", "K11", "L11", "D12", "E12", "K13", "K12", "D11", "E11"]
diffs[12] = ["F18", "E17", "E18", "D17", "K18", "K17", "H17", "G17", "L19", "L18", "C17", "B17", "K19", "J19", "M18", "M17", "G18", "H18", "K16", "L16", "L15", "L14", "A16", "B16", "F16", "G16", "E16", "D16", "J17", "J16", "A15", "B15", "G15", "F15", "M16", "M15", "H15", "J15", "D15", "C15"]
diffs[13] = ["L23", "M22", "K24", "K23", "M23", "L24", "F24", "F23", "N23", "N24", "H23", "G23", "R24", "P24", "H25", "H24", "T24", "T23", "J25", "J24", "U23", "V23", "AD24", "AE24", "V24", "W24", "AF25", "AF24", "Y24", "AA24", "AF23", "AG23", "AA23", "AB23", "AE23", "AE22", "AC23", "AC24", "AC22", "AD22"]

# VFAT2 signals to differential pairs: s1, s2, ..., dataout_p, dataout_n

vfat2s = [[] for x in range(24)] 

vfat2s[0] = ["K6", "K12", "K14", "K16", "K20", "J8", "J16", "J14", "B2"]
vfat2s[1] = ["B4", "B6", "B10", "B18", "B20", "B16", "D20", "D14", "D16"]
vfat2s[2] = ["D8", "D6", "F9", "F18", "F17", "F7", "F15", "F5", "F3"]
vfat2s[3] = ["G17", "G9", "G15", "G3", "G5", "G1", "H15", "H11", "H13"]
vfat2s[4] = ["H8", "H10", "H17", "H14", "G4", "G13", "G10", "G6", "G11"]
vfat2s[5] = ["G19", "F8", "F13", "F14", "F16", "F20", "D2", "F19", "D4"]
vfat2s[6] = ["D7", "D11", "D10", "D13", "D18", "D19", "B5", "B14", "B8"]
vfat2s[7] = ["B11", "J15", "J18", "J20", "J6", "J4", "K18", "K4", "K8"]
vfat2s[8] = ["L11", "L5", "L1", "L9", "M19", "M13", "M1", "M9", "I9"]
vfat2s[9] = ["J9", "J7", "J3", "J2", "K19", "K17", "K2", "K7", "K9"]
vfat2s[10] = ["I11", "I3", "I15", "N9", "C2", "E12", "E16", "A10", "I19"]
vfat2s[11] = ["D3", "D17", "D15", "B3", "B17", "B13", "B9", "J13", "J19"]
vfat2s[12] = ["C6", "C16", "H1", "E20", "A16", "E7", "E13", "E19", "A8"]
vfat2s[13] = ["F10", "G20", "F1", "B1", "B12", "D9", "D5", "D1", "F12"]
vfat2s[14] = ["C12", "C8", "C4", "C10", "C20", "C14", "H2", "H6", "H12"]
vfat2s[15] = ["H16", "G8", "G2", "G14", "G12", "F2", "F4", "F11", "F6"]
vfat2s[16] = ["H7", "H5", "H3", "C19", "C11", "C7", "C17", "A17", "A20"]
vfat2s[17] = ["A15", "A11", "A13", "A3", "A9", "A7", "A5", "E14", "E10"]
vfat2s[18] = ["E8", "E6", "E4", "I2", "I4", "I6", "I8", "I10", "I16"]
vfat2s[19] = ["I18", "M6", "M12", "M20", "M16", "L2", "L12", "L20", "L15"]
vfat2s[20] = ["A14", "C3", "C1", "C18", "C9", "C5", "C15", "H4", "H9"]
vfat2s[21] = ["E15", "E11", "A1", "E18", "E17", "A12", "A4", "A18", "A6"]
vfat2s[22] = ["I1", "I13", "I20", "I7", "E9", "E2", "E1", "E3", "E5"]
vfat2s[23] = ["L17", "L3", "L18", "L16", "L6", "M17", "M14", "M2", "I14"]

# Control signals

# Test arrays lengths

for i in range(0, 14):
    if (len(diffs[i]) != 40): 
        print "Bank " + int2chr(i) + " does not contain 40 elements!"
        sys.exit(0)

for i in range(0, 24):
    if (len(vfat2s[i]) != 9): 
        print "VFAT2 " + str(i) + " does not contain 9 elements!"
        sys.exit(0)

for i in range(0, 24):
    if (len(vfat2s_inv[i]) != 9): 
        print "VFAT2 INV " + str(i) + " does not contain 9 elements!"
        sys.exit(0)

# Generate the VHDL file

print "----------------------------------------------------------------------------------"
print "-- Company:        IIHE - ULB"
print "-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)"
print "-- "
print "-- Create Date:    11:15:06 03/13/2015"
print "-- Design Name:    OptoHybrid v2"
print "-- Module Name:    vfat2_packer - Behavioral"
print "-- Project Name:   OptoHybrid v2"
print "-- Target Devices: xc6vlx130t-1ff1156"
print "-- Tool versions:  ISE  P.20131013"
print "-- Description:    This entity adds differential input buffers to all VFAT2 Sbits and DataOut signals"
print "--                 and packes them inside an array."
print "--                  This file is generated automatically by tools/gen_vhdl_vfat2.py"
print "--"
print "-- Dependencies:"
print "--"
print "-- Revision:"
print "-- Revision 0.01 - File Created"
print "-- Additional Comments:"
print "--"
print "----------------------------------------------------------------------------------"
print ""
print "library ieee;"
print "use ieee.std_logic_1164.all;"
print ""
print "library unisim;"
print "use unisim.vcomponents.all;"
print ""
print "library work;"
print "use work.vfat2_pkg.all;"
print ""
print "entity vfat2_packer is"
print "port("
print ""
print "    --== VFAT2s control ==--"
print ""
print "    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);"
print "    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);"
print "    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_resb_o            : out std_logic_vector(2 downto 0);"
print "    vfat2_resh_o            : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);"
print "    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);"
print ""
print "    vfat2_scl_o             : out std_logic_vector(5 downto 0);"
print "    vfat2_sda_io            : inout std_logic_vector(5 downto 0);"
print ""
print "    --"
print ""
print "    vfat2_t1_i              : in std_logic_vector(2 downto 0);"
print ""
print "    vfat2_mclk_i            : in std_logic_vector(2 downto 0);"
print ""
print "    vfat2_resb_i            : in std_logic_vector(2 downto 0);"
print "    vfat2_resh_i            : in std_logic_vector(2 downto 0);"
print ""
print "    vfat2_data_valid_o      : out std_logic_vector(5 downto 0);"
print ""
print "    vfat2_scl_i             : in std_logic_vector(5 downto 0);"
print "    vfat2_sda_i             : in std_logic_vector(5 downto 0);" 
print "    vfat2_sda_o             : out std_logic_vector(5 downto 0);" 
print "    vfat2_sda_t             : in std_logic_vector(5 downto 0);"
print ""
print ""
print "    --== VFAT2s raw data ==--"
print ""

for i in range(24):
    print ("    vfat2_" + str(i) + "_sbits_p_i").ljust(28) + ": in std_logic_vector(7 downto 0);"
    print ("    vfat2_" + str(i) + "_sbits_n_i").ljust(28) + ": in std_logic_vector(7 downto 0);"
    print ("    vfat2_" + str(i) + "_data_out_p_i").ljust(28) + ": in std_logic;"
    print ("    vfat2_" + str(i) + "_data_out_n_i").ljust(28) + ": in std_logic;"
    print ""

print "    --== VFAT2s packed data ==--"
print ""
print "    vfat2s_data_o           : out vfat2s_data_t(23 downto 0)"
print ""
print ");"
print "end vfat2_packer;"
print ""
print "architecture Behavioral of vfat2_packer is"
print ""

for i in range(24):
    print ("    signal vfat2_" + str(i) + "_sbits").ljust(32) + ": std_logic_vector(23 downto 0);"
    print ("    signal vfat2_" + str(i) + "_data_out").ljust(32) + ": std_logic;"
    print ""

print "begin"
print ""

for i in range(24):
    print "    --== VFAT2 " + str(i) + " ==--"
    print ""

    for j in range(8):
        print "    vfat2_" + str(i) + "_sbit_" + str(j) + "_ibufds_inst : ibufds"
        print "    generic map("
        print "        diff_term   => true,"
        print "        iostandard  => \"lvds_25\""
        print "    )"
        print "    port map("
        print "        i   => vfat2_" + str(i) + "_sbits_p_i(" + str(j) + "),"
        print "        ib  => vfat2_" + str(i) + "_sbits_n_i(" + str(j) + "),"
        print "        o   => vfat2_" + str(i) + "_sbits(" + str(j) + ")"
        print "    );"
        print ""
        if vfat2s_inv[i][j] == 1:
            print "    vfat2s_data_o(" + str(i) + ").sbits(" + str(j) + ") <= not vfat2_" + str(i) + "_sbits(" + str(j) + ");"
        else: 
            print "    vfat2s_data_o(" + str(i) + ").sbits(" + str(j) + ") <= vfat2_" + str(i) + "_sbits(" + str(j) + ");"
        print ""
        print ""

    print "    vfat2_" + str(i) + "_data_out_ibufds_inst : ibufds"
    print "    generic map("
    print "        diff_term   => true,"
    print "        iostandard  => \"lvds_25\""
    print "    )"
    print "    port map("
    print "        i   => vfat2_" + str(i) + "_data_out_p_i,"
    print "        ib  => vfat2_" + str(i) + "_data_out_n_i,"
    print "        o   => vfat2_" + str(i) + "_data_out"
    print "    );"
    print ""
    if vfat2s_inv[i][j] == 1:
        print "    vfat2s_data_o(" + str(i) + ").data_out <= not vfat2_" + str(i) + "_data_out;"
    else: 
        print "    vfat2s_data_o(" + str(i) + ").data_out <= vfat2_" + str(i) + "_data_out;"
    print ""  
    print ""      

print "end Behavioral;"
print ""

