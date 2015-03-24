import sys

vfat2s = [[] for x in range(24)]

vfat2s[0] = [0, 0, 1, 0, 0, 1, 1, 1, 1]
vfat2s[1] = [1, 0, 0, 0, 0, 0, 1, 0, 1]
vfat2s[2] = [1, 0, 0, 0, 0, 0, 0, 0, 0]
vfat2s[3] = [0, 1, 1, 0, 0, 1, 0, 1, 1]
vfat2s[4] = [0, 0, 1, 0, 0, 0, 1, 1, 0]
vfat2s[5] = [1, 0, 0, 1, 1, 0, 1, 1, 1]
vfat2s[6] = [1, 1, 0, 0, 0, 1, 1, 1, 1]
vfat2s[7] = [0, 0, 0, 1, 1, 0, 0, 1, 0]
vfat2s[8] = [1, 0, 0, 1, 0, 0, 1, 0, 0]
vfat2s[9] = [1, 0, 1, 1, 1, 0, 0, 0, 0]
vfat2s[10] = [1, 0, 0, 1, 0, 0, 1, 0, 1]
vfat2s[11] = [1, 0, 1, 0, 1, 1, 1, 1, 1]
vfat2s[12] = [0, 0, 1, 1, 1, 0, 1, 1, 1]
vfat2s[13] = [1, 0, 1, 1, 1, 0, 1, 1, 1]
vfat2s[14] = [0, 0, 1, 1, 0, 0, 1, 1, 0]
vfat2s[15] = [0, 0, 1, 0, 1, 1, 1, 0, 1]
vfat2s[16] = [1, 0, 1, 1, 0, 1, 1, 0, 1]
vfat2s[17] = [0, 1, 1, 1, 0, 0, 1, 1, 1]
vfat2s[18] = [0, 1, 1, 1, 0, 1, 1, 0, 1]
vfat2s[19] = [0, 0, 1, 0, 0, 1, 0, 1, 0]
vfat2s[20] = [0, 0, 1, 0, 0, 0, 1, 1, 0]
vfat2s[21] = [1, 0, 1, 0, 0, 1, 0, 0, 0]
vfat2s[22] = [1, 1, 1, 0, 1, 0, 0, 0, 0]
vfat2s[23] = [1, 1, 0, 0, 1, 1, 1, 1, 0]

t1s = [1, 1, 1]

mclks = [1, 0, 0]

data_valids = [1, 0, 1, 0, 0, 1]

# Generate the VHDL file

print "----------------------------------------------------------------------------------"
print "-- Company:        IIHE - ULB"
print "-- Engineer:       Thomas Lenzi (thomas.lenzi@cern.ch)"
print "-- "
print "-- Create Date:    11:15:06 03/13/2015"
print "-- Design Name:    OptoHybrid v2"
print "-- Module Name:    vfat2_buffers - Behavioral"
print "-- Project Name:   OptoHybrid v2"
print "-- Target Devices: xc6vlx130t-1ff1156"
print "-- Tool versions:  ISE  P.20131013"
print "-- Description:    This entity adds differential input buffers to all VFAT2 Sbits and DataOut signals"
print "--                 and packes them inside an array."
print "--                  This file is generated automatically by tools/gen_vfat2_vhdl.py"
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
print "entity vfat2_buffers is"
print "port("
print ""
print "    --== VFAT2s raw control ==--"
print ""
print "    vfat2_mclk_p_o          : out std_logic_vector(2 downto 0);"
print "    vfat2_mclk_n_o          : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_resb_o            : out std_logic_vector(2 downto 0);"
print "    vfat2_resh_o            : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_t1_p_o            : out std_logic_vector(2 downto 0);"
print "    vfat2_t1_n_o            : out std_logic_vector(2 downto 0);"
print ""
print "    vfat2_scl_o             : out std_logic_vector(5 downto 0);"
print "    vfat2_sda_io            : inout std_logic_vector(5 downto 0);"
print ""
print "    vfat2_data_valid_p_i    : in std_logic_vector(5 downto 0);"
print "    vfat2_data_valid_n_i    : in std_logic_vector(5 downto 0);"
print ""
print "    --== VFAT2s packed control ==--"
print ""
print "    vfat2_mclk_i            : in std_logic;"
print ""
print "    vfat2_reset_i           : in std_logic;"
print ""
print "    vfat2_t1_i              : in std_logic;"
print ""
print "    vfat2_scl_i             : in std_logic_vector(5 downto 0);"
print "    vfat2_sda_i             : in std_logic_vector(5 downto 0);" 
print "    vfat2_sda_o             : out std_logic_vector(5 downto 0);" 
print "    vfat2_sda_t             : in std_logic_vector(5 downto 0);"
print ""
print "    vfat2_data_valid_o      : out std_logic_vector(5 downto 0);"
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
print "end vfat2_buffers;"
print ""
print "architecture Behavioral of vfat2_buffers is"
print ""
print "    signal vfat2_t1             : std_logic_vector(2 downto 0); "
print "    signal vfat2_mclk           : std_logic_vector(2 downto 0); "
print "    signal vfat2_data_valid     : std_logic_vector(5 downto 0); "
print ""

for i in range(24):
    print ("    signal vfat2_" + str(i) + "_sbits").ljust(32) + ": std_logic_vector(23 downto 0);"
    print ("    signal vfat2_" + str(i) + "_data_out").ljust(32) + ": std_logic;"
    print ""

print "begin"
print ""

print "    --== MCLK signals ==--"
print ""
for i in range(3):
    if mclks[i] == 1:
        print "    vfat2_mclk_" + str(i) + "_oddr_inst : oddr"
        print "    generic map("
        print "        ddr_clk_edge => \"opposite_edge\","
        print "        init => '0',"
        print "        srtype => \"sync\""
        print "    )"
        print "    port map ("
        print "        q   => vfat2_mclk(" + str(i) + "),"
        print "        c   => vfat2_mclk_i,"
        print "        ce  => '1',"
        print "        d1  => '1',"
        print "        d2  => '0',"
        print "        r   => '0',"
        print "        s   => '0'"
        print "    );"
    else:
        print "    vfat2_mclk_" + str(i) + "_oddr_inst : oddr"
        print "    generic map("
        print "        ddr_clk_edge => \"opposite_edge\","
        print "        init => '0',"
        print "        srtype => \"sync\""
        print "    )"
        print "    port map ("
        print "        q   => vfat2_mclk(" + str(i) + "),"
        print "        c   => vfat2_mclk_i,"
        print "        ce  => '1',"
        print "        d1  => '0',"
        print "        d2  => '1',"
        print "        r   => '0',"
        print "        s   => '0'"
        print "    );"
    print ""
    print "    vfat2_mclk_" + str(i) + "_obufds_inst : obufds"
    print "    generic map("
    print "        iostandard  => \"lvds_25\""
    print "    )"
    print "    port map ("
    print "        i   => vfat2_mclk(" + str(i) + "),"
    print "        o   => vfat2_mclk_p_o(" + str(i) + "),"
    print "        ob  => vfat2_mclk_n_o(" + str(i) + ")"
    print "    );"
    print ""
    print ""

print "    --== Reset signals ==--"
print ""
for i in range(3):
    print "    vfat2_resb_" + str(i) + "_obuf_inst : obuf"
    print "    generic map("
    print "        drive => 12,"
    print "        iostandard => \"lvcmos25\","
    print "        slew => \"slow\""
    print "    )"
    print "    port map("
    print "        o => vfat2_resb_o(" + str(i) + "),"
    print "        i => not vfat2_reset_i"
    print "    );"
    print ""
    print "    vfat2_resh_" + str(i) + "_obuf_inst : obuf"
    print "    generic map("
    print "        drive => 12,"
    print "        iostandard => \"lvcmos25\","
    print "        slew => \"slow\""
    print "    )"
    print "    port map("
    print "        o => vfat2_resh_o(" + str(i) + "),"
    print "        i => not vfat2_reset_i"
    print "    );"
    print ""
    print ""

print "    --== T1 signals ==--"
print ""
for i in range(3):
    print "    vfat2_t1_" + str(i) + "_obufds_inst : obufds"
    print "    generic map("
    print "        iostandard  => \"lvds_25\""
    print "    )"
    print "    port map("
    print "        i   => vfat2_t1(" + str(i) + "),"
    print "        o   => vfat2_t1_p_o(" + str(i) + "),"
    print "        ob   => vfat2_t1_n_o(" + str(i) + ")"
    print "    );"
    print ""
    if t1s[i] == 1:
        print "    vfat2_t1(" + str(i) + ") <= not vfat2_t1_i;"
    else: 
        print "    vfat2_t1(" + str(i) + ") <= vfat2_t1_i;"
    print ""
    print ""

print "    --== I2C signals ==--"
print ""
for i in range(6):
    print "    vfat2_sda_" + str(i) + "_iobuf_inst : iobuf"
    print "    generic map ("
    print "        drive => 12,"
    print "        slew => \"slow\""
    print "    )"
    print "    port map ("
    print "        o => vfat2_sda_o(" + str(i) + "),"
    print "        io => vfat2_sda_io(" + str(i) + "),"
    print "        i => vfat2_sda_i(" + str(i) + "),"
    print "        t => vfat2_sda_t(" + str(i) + ")"
    print "    );"
    print ""
    print "    vfat2_scl_" + str(i) + "_obuf_inst : obuf"
    print "    generic map("
    print "        drive => 12,"
    print "        iostandard => \"lvcmos25\","
    print "        slew => \"slow\""
    print "    )"
    print "    port map("
    print "        o => vfat2_scl_o(" + str(i) + "),"
    print "        i => vfat2_scl_i(" + str(i) + ")"
    print "    );"    
    print ""
    print ""

print "    --== Data valid signals ==--"
print ""
for i in range(6):
    print "    vfat2_data_valid_" + str(i) + "_ibufds_inst : ibufds"
    print "    generic map("
    print "        diff_term   => true,"
    print "        iostandard  => \"lvds_25\""
    print "    )"
    print "    port map("
    print "        i   => vfat2_data_valid_p_i(" + str(i) + "),"
    print "        ib  => vfat2_data_valid_n_i(" + str(i) + "),"
    print "        o   => vfat2_data_valid(" + str(i) + ")"
    print "    );"
    print ""
    if data_valids[i] == 1:
        print "    vfat2_data_valid_o(" + str(i) + ") <= not vfat2_data_valid(" + str(i) + ");"
    else: 
        print "    vfat2_data_valid_o(" + str(i) + ") <= vfat2_data_valid(" + str(i) + ");"
    print ""
    print ""

for i in range(24):
    print "    --== VFAT2 " + str(i) + " signals ==--"
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
        if vfat2s[i][j] == 1:
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
    if vfat2s[i][j] == 1:
        print "    vfat2s_data_o(" + str(i) + ").data_out <= not vfat2_" + str(i) + "_data_out;"
    else: 
        print "    vfat2s_data_o(" + str(i) + ").data_out <= vfat2_" + str(i) + "_data_out;"
    print ""  
    print ""      

print "end Behavioral;"

