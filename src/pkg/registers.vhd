library IEEE;
use IEEE.STD_LOGIC_1164.all;

-----> !! This package is auto-generated from an address table file using <repo_root>/scripts/generate_registers.py !! <-----
package registers is

    --============================================================================
    --       >>> CONTROL Module <<<    base address: 0x00000000
    --
    -- Implements various control and monitoring functions of the Optohybrid
    --============================================================================

    constant REG_CONTROL_NUM_REGS : integer := 25;
    constant REG_CONTROL_ADDRESS_MSB : integer := 5;
    constant REG_CONTROL_ADDRESS_LSB : integer := 0;
    constant REG_CONTROL_LOOPBACK_DATA_ADDR    : std_logic_vector(5 downto 0) := "00" & x"0";
    constant REG_CONTROL_LOOPBACK_DATA_MSB    : integer := 31;
    constant REG_CONTROL_LOOPBACK_DATA_LSB     : integer := 0;
    constant REG_CONTROL_LOOPBACK_DATA_DEFAULT : std_logic_vector(31 downto 0) := x"01234567";

    constant REG_CONTROL_RELEASE_DATE_ADDR    : std_logic_vector(5 downto 0) := "00" & x"1";
    constant REG_CONTROL_RELEASE_DATE_MSB    : integer := 31;
    constant REG_CONTROL_RELEASE_DATE_LSB     : integer := 0;

    constant REG_CONTROL_RELEASE_VERSION_MAJOR_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_CONTROL_RELEASE_VERSION_MAJOR_MSB    : integer := 7;
    constant REG_CONTROL_RELEASE_VERSION_MAJOR_LSB     : integer := 0;

    constant REG_CONTROL_RELEASE_VERSION_MINOR_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_CONTROL_RELEASE_VERSION_MINOR_MSB    : integer := 15;
    constant REG_CONTROL_RELEASE_VERSION_MINOR_LSB     : integer := 8;

    constant REG_CONTROL_RELEASE_VERSION_BUILD_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_CONTROL_RELEASE_VERSION_BUILD_MSB    : integer := 23;
    constant REG_CONTROL_RELEASE_VERSION_BUILD_LSB     : integer := 16;

    constant REG_CONTROL_RELEASE_VERSION_GENERATION_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_CONTROL_RELEASE_VERSION_GENERATION_MSB    : integer := 31;
    constant REG_CONTROL_RELEASE_VERSION_GENERATION_LSB     : integer := 24;

    constant REG_CONTROL_SEM_CNT_SEM_CRITICAL_ADDR    : std_logic_vector(5 downto 0) := "00" & x"3";
    constant REG_CONTROL_SEM_CNT_SEM_CRITICAL_MSB    : integer := 15;
    constant REG_CONTROL_SEM_CNT_SEM_CRITICAL_LSB     : integer := 0;

    constant REG_CONTROL_SEM_CNT_SEM_CORRECTION_ADDR    : std_logic_vector(5 downto 0) := "00" & x"4";
    constant REG_CONTROL_SEM_CNT_SEM_CORRECTION_MSB    : integer := 31;
    constant REG_CONTROL_SEM_CNT_SEM_CORRECTION_LSB     : integer := 16;

    constant REG_CONTROL_VFAT_RESET_ADDR    : std_logic_vector(5 downto 0) := "00" & x"5";
    constant REG_CONTROL_VFAT_RESET_MSB    : integer := 11;
    constant REG_CONTROL_VFAT_RESET_LSB     : integer := 0;
    constant REG_CONTROL_VFAT_RESET_DEFAULT : std_logic_vector(11 downto 0) := x"000";

    constant REG_CONTROL_FMM_DONT_WAIT_ADDR    : std_logic_vector(5 downto 0) := "00" & x"6";
    constant REG_CONTROL_FMM_DONT_WAIT_BIT    : integer := 0;
    constant REG_CONTROL_FMM_DONT_WAIT_DEFAULT : std_logic := '1';

    constant REG_CONTROL_FMM_STOP_TRIGGER_ADDR    : std_logic_vector(5 downto 0) := "00" & x"7";
    constant REG_CONTROL_FMM_STOP_TRIGGER_BIT    : integer := 1;

    constant REG_CONTROL_TTC_BX0_CNT_LOCAL_ADDR    : std_logic_vector(5 downto 0) := "00" & x"8";
    constant REG_CONTROL_TTC_BX0_CNT_LOCAL_MSB    : integer := 23;
    constant REG_CONTROL_TTC_BX0_CNT_LOCAL_LSB     : integer := 0;

    constant REG_CONTROL_TTC_BX0_CNT_TTC_ADDR    : std_logic_vector(5 downto 0) := "00" & x"9";
    constant REG_CONTROL_TTC_BX0_CNT_TTC_MSB    : integer := 23;
    constant REG_CONTROL_TTC_BX0_CNT_TTC_LSB     : integer := 0;

    constant REG_CONTROL_TTC_BXN_CNT_LOCAL_ADDR    : std_logic_vector(5 downto 0) := "00" & x"a";
    constant REG_CONTROL_TTC_BXN_CNT_LOCAL_MSB    : integer := 11;
    constant REG_CONTROL_TTC_BXN_CNT_LOCAL_LSB     : integer := 0;

    constant REG_CONTROL_TTC_BXN_SYNC_ERR_ADDR    : std_logic_vector(5 downto 0) := "00" & x"b";
    constant REG_CONTROL_TTC_BXN_SYNC_ERR_BIT    : integer := 12;

    constant REG_CONTROL_TTC_BX0_SYNC_ERR_ADDR    : std_logic_vector(5 downto 0) := "00" & x"c";
    constant REG_CONTROL_TTC_BX0_SYNC_ERR_BIT    : integer := 13;

    constant REG_CONTROL_TTC_BXN_OFFSET_ADDR    : std_logic_vector(5 downto 0) := "00" & x"d";
    constant REG_CONTROL_TTC_BXN_OFFSET_MSB    : integer := 27;
    constant REG_CONTROL_TTC_BXN_OFFSET_LSB     : integer := 16;
    constant REG_CONTROL_TTC_BXN_OFFSET_DEFAULT : std_logic_vector(27 downto 16) := x"000";

    constant REG_CONTROL_TTC_L1A_CNT_ADDR    : std_logic_vector(5 downto 0) := "00" & x"e";
    constant REG_CONTROL_TTC_L1A_CNT_MSB    : integer := 23;
    constant REG_CONTROL_TTC_L1A_CNT_LSB     : integer := 0;

    constant REG_CONTROL_TTC_BXN_SYNC_ERR_CNT_ADDR    : std_logic_vector(5 downto 0) := "00" & x"f";
    constant REG_CONTROL_TTC_BXN_SYNC_ERR_CNT_MSB    : integer := 15;
    constant REG_CONTROL_TTC_BXN_SYNC_ERR_CNT_LSB     : integer := 0;

    constant REG_CONTROL_TTC_BX0_SYNC_ERR_CNT_ADDR    : std_logic_vector(5 downto 0) := "01" & x"0";
    constant REG_CONTROL_TTC_BX0_SYNC_ERR_CNT_MSB    : integer := 31;
    constant REG_CONTROL_TTC_BX0_SYNC_ERR_CNT_LSB     : integer := 16;

    constant REG_CONTROL_SBITS_CLUSTER_RATE_ADDR    : std_logic_vector(5 downto 0) := "01" & x"1";
    constant REG_CONTROL_SBITS_CLUSTER_RATE_MSB    : integer := 31;
    constant REG_CONTROL_SBITS_CLUSTER_RATE_LSB     : integer := 0;

    constant REG_CONTROL_HDMI_SBIT_SEL0_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL0_MSB    : integer := 4;
    constant REG_CONTROL_HDMI_SBIT_SEL0_LSB     : integer := 0;
    constant REG_CONTROL_HDMI_SBIT_SEL0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL1_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL1_MSB    : integer := 9;
    constant REG_CONTROL_HDMI_SBIT_SEL1_LSB     : integer := 5;
    constant REG_CONTROL_HDMI_SBIT_SEL1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL2_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL2_MSB    : integer := 14;
    constant REG_CONTROL_HDMI_SBIT_SEL2_LSB     : integer := 10;
    constant REG_CONTROL_HDMI_SBIT_SEL2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL3_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL3_MSB    : integer := 19;
    constant REG_CONTROL_HDMI_SBIT_SEL3_LSB     : integer := 15;
    constant REG_CONTROL_HDMI_SBIT_SEL3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL4_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL4_MSB    : integer := 24;
    constant REG_CONTROL_HDMI_SBIT_SEL4_LSB     : integer := 20;
    constant REG_CONTROL_HDMI_SBIT_SEL4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL5_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_CONTROL_HDMI_SBIT_SEL5_MSB    : integer := 29;
    constant REG_CONTROL_HDMI_SBIT_SEL5_LSB     : integer := 25;
    constant REG_CONTROL_HDMI_SBIT_SEL5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL6_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_SEL6_MSB    : integer := 4;
    constant REG_CONTROL_HDMI_SBIT_SEL6_LSB     : integer := 0;
    constant REG_CONTROL_HDMI_SBIT_SEL6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_SEL7_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_SEL7_MSB    : integer := 9;
    constant REG_CONTROL_HDMI_SBIT_SEL7_LSB     : integer := 5;
    constant REG_CONTROL_HDMI_SBIT_SEL7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_CONTROL_HDMI_SBIT_MODE0_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE0_MSB    : integer := 11;
    constant REG_CONTROL_HDMI_SBIT_MODE0_LSB     : integer := 10;
    constant REG_CONTROL_HDMI_SBIT_MODE0_DEFAULT : std_logic_vector(11 downto 10) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE1_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE1_MSB    : integer := 13;
    constant REG_CONTROL_HDMI_SBIT_MODE1_LSB     : integer := 12;
    constant REG_CONTROL_HDMI_SBIT_MODE1_DEFAULT : std_logic_vector(13 downto 12) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE2_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE2_MSB    : integer := 15;
    constant REG_CONTROL_HDMI_SBIT_MODE2_LSB     : integer := 14;
    constant REG_CONTROL_HDMI_SBIT_MODE2_DEFAULT : std_logic_vector(15 downto 14) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE3_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE3_MSB    : integer := 17;
    constant REG_CONTROL_HDMI_SBIT_MODE3_LSB     : integer := 16;
    constant REG_CONTROL_HDMI_SBIT_MODE3_DEFAULT : std_logic_vector(17 downto 16) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE4_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE4_MSB    : integer := 19;
    constant REG_CONTROL_HDMI_SBIT_MODE4_LSB     : integer := 18;
    constant REG_CONTROL_HDMI_SBIT_MODE4_DEFAULT : std_logic_vector(19 downto 18) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE5_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE5_MSB    : integer := 21;
    constant REG_CONTROL_HDMI_SBIT_MODE5_LSB     : integer := 20;
    constant REG_CONTROL_HDMI_SBIT_MODE5_DEFAULT : std_logic_vector(21 downto 20) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE6_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE6_MSB    : integer := 23;
    constant REG_CONTROL_HDMI_SBIT_MODE6_LSB     : integer := 22;
    constant REG_CONTROL_HDMI_SBIT_MODE6_DEFAULT : std_logic_vector(23 downto 22) := "00";

    constant REG_CONTROL_HDMI_SBIT_MODE7_ADDR    : std_logic_vector(5 downto 0) := "01" & x"3";
    constant REG_CONTROL_HDMI_SBIT_MODE7_MSB    : integer := 25;
    constant REG_CONTROL_HDMI_SBIT_MODE7_LSB     : integer := 24;
    constant REG_CONTROL_HDMI_SBIT_MODE7_DEFAULT : std_logic_vector(25 downto 24) := "00";

    constant REG_CONTROL_CNT_SNAP_PULSE_ADDR    : std_logic_vector(5 downto 0) := "01" & x"4";
    constant REG_CONTROL_CNT_SNAP_PULSE_BIT    : integer := 0;

    constant REG_CONTROL_CNT_SNAP_DISABLE_ADDR    : std_logic_vector(5 downto 0) := "01" & x"5";
    constant REG_CONTROL_CNT_SNAP_DISABLE_BIT    : integer := 1;
    constant REG_CONTROL_CNT_SNAP_DISABLE_DEFAULT : std_logic := '1';

    constant REG_CONTROL_SOFT_RESET_ADDR    : std_logic_vector(5 downto 0) := "01" & x"6";
    constant REG_CONTROL_SOFT_RESET_BIT    : integer := 0;

    constant REG_CONTROL_DNA_DNA_LSBS_ADDR    : std_logic_vector(5 downto 0) := "01" & x"7";
    constant REG_CONTROL_DNA_DNA_LSBS_MSB    : integer := 31;
    constant REG_CONTROL_DNA_DNA_LSBS_LSB     : integer := 0;

    constant REG_CONTROL_DNA_DNA_MSBS_ADDR    : std_logic_vector(5 downto 0) := "01" & x"8";
    constant REG_CONTROL_DNA_DNA_MSBS_MSB    : integer := 24;
    constant REG_CONTROL_DNA_DNA_MSBS_LSB     : integer := 0;


    --============================================================================
    --       >>> ADC Module <<<    base address: 0x00001000
    --
    -- Connects to the Virtex-6 XADC and allows for reading of temperature,
    -- VCCINT, and VCCAUX voltages
    --============================================================================

    constant REG_ADC_NUM_REGS : integer := 4;
    constant REG_ADC_ADDRESS_MSB : integer := 3;
    constant REG_ADC_ADDRESS_LSB : integer := 0;
    constant REG_ADC_CTRL_OVERTEMP_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_OVERTEMP_BIT    : integer := 0;

    constant REG_ADC_CTRL_VCCAUX_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_VCCAUX_ALARM_BIT    : integer := 1;

    constant REG_ADC_CTRL_VCCINT_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_VCCINT_ALARM_BIT    : integer := 2;

    constant REG_ADC_CTRL_ADR_IN_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_ADR_IN_MSB    : integer := 9;
    constant REG_ADC_CTRL_ADR_IN_LSB     : integer := 3;
    constant REG_ADC_CTRL_ADR_IN_DEFAULT : std_logic_vector(9 downto 3) := "000" & x"0";

    constant REG_ADC_CTRL_ENABLE_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_ENABLE_BIT    : integer := 10;
    constant REG_ADC_CTRL_ENABLE_DEFAULT : std_logic := '1';

    constant REG_ADC_CTRL_CNT_OVERTEMP_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_CNT_OVERTEMP_MSB    : integer := 17;
    constant REG_ADC_CTRL_CNT_OVERTEMP_LSB     : integer := 11;

    constant REG_ADC_CTRL_CNT_VCCAUX_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_CNT_VCCAUX_ALARM_MSB    : integer := 24;
    constant REG_ADC_CTRL_CNT_VCCAUX_ALARM_LSB     : integer := 18;

    constant REG_ADC_CTRL_CNT_VCCINT_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_ADC_CTRL_CNT_VCCINT_ALARM_MSB    : integer := 31;
    constant REG_ADC_CTRL_CNT_VCCINT_ALARM_LSB     : integer := 25;

    constant REG_ADC_CTRL_DATA_IN_ADDR    : std_logic_vector(3 downto 0) := x"1";
    constant REG_ADC_CTRL_DATA_IN_MSB    : integer := 15;
    constant REG_ADC_CTRL_DATA_IN_LSB     : integer := 0;
    constant REG_ADC_CTRL_DATA_IN_DEFAULT : std_logic_vector(15 downto 0) := x"0000";

    constant REG_ADC_CTRL_DATA_OUT_ADDR    : std_logic_vector(3 downto 0) := x"1";
    constant REG_ADC_CTRL_DATA_OUT_MSB    : integer := 31;
    constant REG_ADC_CTRL_DATA_OUT_LSB     : integer := 16;

    constant REG_ADC_CTRL_RESET_ADDR    : std_logic_vector(3 downto 0) := x"2";
    constant REG_ADC_CTRL_RESET_BIT    : integer := 0;

    constant REG_ADC_CTRL_WR_EN_ADDR    : std_logic_vector(3 downto 0) := x"3";
    constant REG_ADC_CTRL_WR_EN_BIT    : integer := 0;


    --============================================================================
    --       >>> TRIG Module <<<    base address: 0x00002000
    --
    -- Connects to the trigger control module
    --============================================================================

    constant REG_TRIG_NUM_REGS : integer := 100;
    constant REG_TRIG_ADDRESS_MSB : integer := 7;
    constant REG_TRIG_ADDRESS_LSB : integer := 0;
    constant REG_TRIG_CTRL_VFAT_MASK_ADDR    : std_logic_vector(7 downto 0) := x"00";
    constant REG_TRIG_CTRL_VFAT_MASK_MSB    : integer := 11;
    constant REG_TRIG_CTRL_VFAT_MASK_LSB     : integer := 0;
    constant REG_TRIG_CTRL_VFAT_MASK_DEFAULT : std_logic_vector(11 downto 0) := x"000";

    constant REG_TRIG_CTRL_SBIT_DEADTIME_ADDR    : std_logic_vector(7 downto 0) := x"00";
    constant REG_TRIG_CTRL_SBIT_DEADTIME_MSB    : integer := 27;
    constant REG_TRIG_CTRL_SBIT_DEADTIME_LSB     : integer := 24;
    constant REG_TRIG_CTRL_SBIT_DEADTIME_DEFAULT : std_logic_vector(27 downto 24) := x"7";

    constant REG_TRIG_CTRL_ACTIVE_VFATS_ADDR    : std_logic_vector(7 downto 0) := x"01";
    constant REG_TRIG_CTRL_ACTIVE_VFATS_MSB    : integer := 11;
    constant REG_TRIG_CTRL_ACTIVE_VFATS_LSB     : integer := 0;

    constant REG_TRIG_CTRL_CNT_OVERFLOW_ADDR    : std_logic_vector(7 downto 0) := x"02";
    constant REG_TRIG_CTRL_CNT_OVERFLOW_MSB    : integer := 15;
    constant REG_TRIG_CTRL_CNT_OVERFLOW_LSB     : integer := 0;

    constant REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_ADDR    : std_logic_vector(7 downto 0) := x"02";
    constant REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_MSB    : integer := 27;
    constant REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_LSB     : integer := 16;
    constant REG_TRIG_CTRL_ALIGNED_COUNT_TO_READY_DEFAULT : std_logic_vector(27 downto 16) := x"1ff";

    constant REG_TRIG_CTRL_SBIT_SOT_READY_ADDR    : std_logic_vector(7 downto 0) := x"03";
    constant REG_TRIG_CTRL_SBIT_SOT_READY_MSB    : integer := 11;
    constant REG_TRIG_CTRL_SBIT_SOT_READY_LSB     : integer := 0;

    constant REG_TRIG_CTRL_SBIT_SOT_UNSTABLE_ADDR    : std_logic_vector(7 downto 0) := x"04";
    constant REG_TRIG_CTRL_SBIT_SOT_UNSTABLE_MSB    : integer := 11;
    constant REG_TRIG_CTRL_SBIT_SOT_UNSTABLE_LSB     : integer := 0;

    constant REG_TRIG_CTRL_INVERT_SOT_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"05";
    constant REG_TRIG_CTRL_INVERT_SOT_INVERT_MSB    : integer := 11;
    constant REG_TRIG_CTRL_INVERT_SOT_INVERT_LSB     : integer := 0;
    constant REG_TRIG_CTRL_INVERT_SOT_INVERT_DEFAULT : std_logic_vector(11 downto 0) := x"802";

    constant REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"06";
    constant REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_MSB    : integer := 7;
    constant REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_LSB     : integer := 0;
    constant REG_TRIG_CTRL_INVERT_VFAT0_TU_INVERT_DEFAULT : std_logic_vector(7 downto 0) := x"ff";

    constant REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"06";
    constant REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_MSB    : integer := 15;
    constant REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_LSB     : integer := 8;
    constant REG_TRIG_CTRL_INVERT_VFAT1_TU_INVERT_DEFAULT : std_logic_vector(15 downto 8) := x"01";

    constant REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"06";
    constant REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_MSB    : integer := 23;
    constant REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_LSB     : integer := 16;
    constant REG_TRIG_CTRL_INVERT_VFAT2_TU_INVERT_DEFAULT : std_logic_vector(23 downto 16) := x"00";

    constant REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"06";
    constant REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_MSB    : integer := 31;
    constant REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_LSB     : integer := 24;
    constant REG_TRIG_CTRL_INVERT_VFAT3_TU_INVERT_DEFAULT : std_logic_vector(31 downto 24) := x"00";

    constant REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"07";
    constant REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_MSB    : integer := 7;
    constant REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_LSB     : integer := 0;
    constant REG_TRIG_CTRL_INVERT_VFAT4_TU_INVERT_DEFAULT : std_logic_vector(7 downto 0) := x"00";

    constant REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"07";
    constant REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_MSB    : integer := 15;
    constant REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_LSB     : integer := 8;
    constant REG_TRIG_CTRL_INVERT_VFAT5_TU_INVERT_DEFAULT : std_logic_vector(15 downto 8) := x"00";

    constant REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"07";
    constant REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_MSB    : integer := 23;
    constant REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_LSB     : integer := 16;
    constant REG_TRIG_CTRL_INVERT_VFAT6_TU_INVERT_DEFAULT : std_logic_vector(23 downto 16) := x"00";

    constant REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"07";
    constant REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_MSB    : integer := 31;
    constant REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_LSB     : integer := 24;
    constant REG_TRIG_CTRL_INVERT_VFAT7_TU_INVERT_DEFAULT : std_logic_vector(31 downto 24) := x"ec";

    constant REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"08";
    constant REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_MSB    : integer := 7;
    constant REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_LSB     : integer := 0;
    constant REG_TRIG_CTRL_INVERT_VFAT8_TU_INVERT_DEFAULT : std_logic_vector(7 downto 0) := x"20";

    constant REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"08";
    constant REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_MSB    : integer := 15;
    constant REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_LSB     : integer := 8;
    constant REG_TRIG_CTRL_INVERT_VFAT9_TU_INVERT_DEFAULT : std_logic_vector(15 downto 8) := x"de";

    constant REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"08";
    constant REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_MSB    : integer := 23;
    constant REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_LSB     : integer := 16;
    constant REG_TRIG_CTRL_INVERT_VFAT10_TU_INVERT_DEFAULT : std_logic_vector(23 downto 16) := x"7f";

    constant REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_ADDR    : std_logic_vector(7 downto 0) := x"08";
    constant REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_MSB    : integer := 31;
    constant REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_LSB     : integer := 24;
    constant REG_TRIG_CTRL_INVERT_VFAT11_TU_INVERT_DEFAULT : std_logic_vector(31 downto 24) := x"dd";

    constant REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_ADDR    : std_logic_vector(7 downto 0) := x"0e";
    constant REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_MSB    : integer := 8;
    constant REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_LSB     : integer := 4;
    constant REG_TRIG_CTRL_SBITS_MUX_SBIT_MUX_SEL_DEFAULT : std_logic_vector(8 downto 4) := '1' & x"0";

    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_LSB_ADDR    : std_logic_vector(7 downto 0) := x"0f";
    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_LSB_MSB    : integer := 31;
    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_LSB_LSB     : integer := 0;

    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_MSB_ADDR    : std_logic_vector(7 downto 0) := x"10";
    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_MSB_MSB    : integer := 31;
    constant REG_TRIG_CTRL_SBITS_MUX_SBITS_MUX_MSB_LSB     : integer := 0;

    constant REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"11";
    constant REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_MSB    : integer := 7;
    constant REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_LSB     : integer := 0;
    constant REG_TRIG_CTRL_TU_MASK_VFAT0_TU_MASK_DEFAULT : std_logic_vector(7 downto 0) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"11";
    constant REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_MSB    : integer := 15;
    constant REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_LSB     : integer := 8;
    constant REG_TRIG_CTRL_TU_MASK_VFAT1_TU_MASK_DEFAULT : std_logic_vector(15 downto 8) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"11";
    constant REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_MSB    : integer := 23;
    constant REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_LSB     : integer := 16;
    constant REG_TRIG_CTRL_TU_MASK_VFAT2_TU_MASK_DEFAULT : std_logic_vector(23 downto 16) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"11";
    constant REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_MSB    : integer := 31;
    constant REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_LSB     : integer := 24;
    constant REG_TRIG_CTRL_TU_MASK_VFAT3_TU_MASK_DEFAULT : std_logic_vector(31 downto 24) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"12";
    constant REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_MSB    : integer := 7;
    constant REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_LSB     : integer := 0;
    constant REG_TRIG_CTRL_TU_MASK_VFAT4_TU_MASK_DEFAULT : std_logic_vector(7 downto 0) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"12";
    constant REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_MSB    : integer := 15;
    constant REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_LSB     : integer := 8;
    constant REG_TRIG_CTRL_TU_MASK_VFAT5_TU_MASK_DEFAULT : std_logic_vector(15 downto 8) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"12";
    constant REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_MSB    : integer := 23;
    constant REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_LSB     : integer := 16;
    constant REG_TRIG_CTRL_TU_MASK_VFAT6_TU_MASK_DEFAULT : std_logic_vector(23 downto 16) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"12";
    constant REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_MSB    : integer := 31;
    constant REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_LSB     : integer := 24;
    constant REG_TRIG_CTRL_TU_MASK_VFAT7_TU_MASK_DEFAULT : std_logic_vector(31 downto 24) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"13";
    constant REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_MSB    : integer := 7;
    constant REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_LSB     : integer := 0;
    constant REG_TRIG_CTRL_TU_MASK_VFAT8_TU_MASK_DEFAULT : std_logic_vector(7 downto 0) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"13";
    constant REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_MSB    : integer := 15;
    constant REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_LSB     : integer := 8;
    constant REG_TRIG_CTRL_TU_MASK_VFAT9_TU_MASK_DEFAULT : std_logic_vector(15 downto 8) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"13";
    constant REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_MSB    : integer := 23;
    constant REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_LSB     : integer := 16;
    constant REG_TRIG_CTRL_TU_MASK_VFAT10_TU_MASK_DEFAULT : std_logic_vector(23 downto 16) := x"00";

    constant REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_ADDR    : std_logic_vector(7 downto 0) := x"13";
    constant REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_MSB    : integer := 31;
    constant REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_LSB     : integer := 24;
    constant REG_TRIG_CTRL_TU_MASK_VFAT11_TU_MASK_DEFAULT : std_logic_vector(31 downto 24) := x"00";

    constant REG_TRIG_CNT_VFAT0_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"17";
    constant REG_TRIG_CNT_VFAT0_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT0_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT1_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"18";
    constant REG_TRIG_CNT_VFAT1_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT1_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT2_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"19";
    constant REG_TRIG_CNT_VFAT2_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT2_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT3_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1a";
    constant REG_TRIG_CNT_VFAT3_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT3_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT4_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1b";
    constant REG_TRIG_CNT_VFAT4_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT4_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT5_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1c";
    constant REG_TRIG_CNT_VFAT5_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT5_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT6_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1d";
    constant REG_TRIG_CNT_VFAT6_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT6_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT7_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1e";
    constant REG_TRIG_CNT_VFAT7_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT7_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT8_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1f";
    constant REG_TRIG_CNT_VFAT8_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT8_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT9_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"20";
    constant REG_TRIG_CNT_VFAT9_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT9_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT10_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"21";
    constant REG_TRIG_CNT_VFAT10_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT10_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_VFAT11_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"22";
    constant REG_TRIG_CNT_VFAT11_SBITS_MSB    : integer := 31;
    constant REG_TRIG_CNT_VFAT11_SBITS_LSB     : integer := 0;

    constant REG_TRIG_CNT_RESET_ADDR    : std_logic_vector(7 downto 0) := x"2f";
    constant REG_TRIG_CNT_RESET_BIT    : integer := 0;

    constant REG_TRIG_CNT_SBIT_CNT_PERSIST_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_TRIG_CNT_SBIT_CNT_PERSIST_BIT    : integer := 0;
    constant REG_TRIG_CNT_SBIT_CNT_PERSIST_DEFAULT : std_logic := '0';

    constant REG_TRIG_CNT_SBIT_CNT_TIME_MAX_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_TRIG_CNT_SBIT_CNT_TIME_MAX_MSB    : integer := 31;
    constant REG_TRIG_CNT_SBIT_CNT_TIME_MAX_LSB     : integer := 0;
    constant REG_TRIG_CNT_SBIT_CNT_TIME_MAX_DEFAULT : std_logic_vector(31 downto 0) := x"02638e98";

    constant REG_TRIG_CNT_CLUSTER_COUNT_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_TRIG_CNT_CLUSTER_COUNT_MSB    : integer := 31;
    constant REG_TRIG_CNT_CLUSTER_COUNT_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x0_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_TRIG_CNT_SBITS_OVER_64x0_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x0_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x1_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_TRIG_CNT_SBITS_OVER_64x1_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x1_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x2_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_TRIG_CNT_SBITS_OVER_64x2_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x2_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x3_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_TRIG_CNT_SBITS_OVER_64x3_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x3_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x4_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_TRIG_CNT_SBITS_OVER_64x4_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x4_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x5_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_TRIG_CNT_SBITS_OVER_64x5_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x5_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x6_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_TRIG_CNT_SBITS_OVER_64x6_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x6_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x7_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_TRIG_CNT_SBITS_OVER_64x7_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x7_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x8_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_TRIG_CNT_SBITS_OVER_64x8_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x8_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x9_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_TRIG_CNT_SBITS_OVER_64x9_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x9_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x10_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_TRIG_CNT_SBITS_OVER_64x10_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x10_LSB     : integer := 0;

    constant REG_TRIG_CNT_SBITS_OVER_64x11_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_TRIG_CNT_SBITS_OVER_64x11_MSB    : integer := 15;
    constant REG_TRIG_CNT_SBITS_OVER_64x11_LSB     : integer := 0;

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"54";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"55";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"56";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"57";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"58";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"59";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"5a";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"5b";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"5c";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"5d";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"5e";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"5f";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"60";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"61";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_MSB    : integer := 4;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_LSB     : integer := 0;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_MSB    : integer := 9;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_LSB     : integer := 5;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_MSB    : integer := 14;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_LSB     : integer := 10;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_MSB    : integer := 19;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_LSB     : integer := 15;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_MSB    : integer := 24;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_LSB     : integer := 20;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"62";
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_MSB    : integer := 29;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_LSB     : integer := 25;
    constant REG_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_MSB    : integer := 4;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_LSB     : integer := 0;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_MSB    : integer := 9;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_LSB     : integer := 5;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_MSB    : integer := 14;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_LSB     : integer := 10;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_MSB    : integer := 19;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_LSB     : integer := 15;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_MSB    : integer := 24;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_LSB     : integer := 20;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_ADDR    : std_logic_vector(7 downto 0) := x"63";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_MSB    : integer := 29;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_LSB     : integer := 25;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_MSB    : integer := 4;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_LSB     : integer := 0;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_MSB    : integer := 9;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_LSB     : integer := 5;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_MSB    : integer := 14;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_LSB     : integer := 10;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_MSB    : integer := 19;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_LSB     : integer := 15;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_MSB    : integer := 24;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_LSB     : integer := 20;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_ADDR    : std_logic_vector(7 downto 0) := x"64";
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_MSB    : integer := 29;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_LSB     : integer := 25;
    constant REG_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_TRIG_LINKS_RESET_ADDR    : std_logic_vector(7 downto 0) := x"80";
    constant REG_TRIG_LINKS_RESET_BIT    : integer := 0;

    constant REG_TRIG_LINKS_TX_PLL_LOCKED_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TX_PLL_LOCKED_BIT    : integer := 0;

    constant REG_TRIG_LINKS_TX_RESET_DONE_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TX_RESET_DONE_BIT    : integer := 4;

    constant REG_TRIG_LINKS_TX_PRBS_MODE_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TX_PRBS_MODE_MSB    : integer := 10;
    constant REG_TRIG_LINKS_TX_PRBS_MODE_LSB     : integer := 8;
    constant REG_TRIG_LINKS_TX_PRBS_MODE_DEFAULT : std_logic_vector(10 downto 8) := "000";

    constant REG_TRIG_LINKS_TX_PLL_RESET_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TX_PLL_RESET_BIT    : integer := 11;
    constant REG_TRIG_LINKS_TX_PLL_RESET_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_MGT_RESET_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_MGT_RESET_MSB    : integer := 15;
    constant REG_TRIG_LINKS_MGT_RESET_LSB     : integer := 12;
    constant REG_TRIG_LINKS_MGT_RESET_DEFAULT : std_logic_vector(15 downto 12) := x"0";

    constant REG_TRIG_LINKS_GTXTEST_START_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_GTXTEST_START_BIT    : integer := 16;
    constant REG_TRIG_LINKS_GTXTEST_START_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_TXRESET_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TXRESET_BIT    : integer := 17;
    constant REG_TRIG_LINKS_TXRESET_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_MGT_REALIGN_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_MGT_REALIGN_BIT    : integer := 18;
    constant REG_TRIG_LINKS_MGT_REALIGN_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_TXPOWERDOWN_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TXPOWERDOWN_BIT    : integer := 19;
    constant REG_TRIG_LINKS_TXPOWERDOWN_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_TXPOWERDOWN_MODE_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TXPOWERDOWN_MODE_MSB    : integer := 21;
    constant REG_TRIG_LINKS_TXPOWERDOWN_MODE_LSB     : integer := 20;
    constant REG_TRIG_LINKS_TXPOWERDOWN_MODE_DEFAULT : std_logic_vector(21 downto 20) := "01";

    constant REG_TRIG_LINKS_TXPLLPOWERDOWN_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_TXPLLPOWERDOWN_BIT    : integer := 22;
    constant REG_TRIG_LINKS_TXPLLPOWERDOWN_DEFAULT : std_logic := '0';

    constant REG_TRIG_LINKS_FORCE_NOT_READY_ADDR    : std_logic_vector(7 downto 0) := x"81";
    constant REG_TRIG_LINKS_FORCE_NOT_READY_BIT    : integer := 23;
    constant REG_TRIG_LINKS_FORCE_NOT_READY_DEFAULT : std_logic := '0';

    constant REG_TRIG_SBIT_MONITOR_RESET_ADDR    : std_logic_vector(7 downto 0) := x"90";
    constant REG_TRIG_SBIT_MONITOR_RESET_MSB    : integer := 31;
    constant REG_TRIG_SBIT_MONITOR_RESET_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER0_ADDR    : std_logic_vector(7 downto 0) := x"91";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER0_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER0_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER1_ADDR    : std_logic_vector(7 downto 0) := x"92";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER1_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER1_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER2_ADDR    : std_logic_vector(7 downto 0) := x"93";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER2_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER2_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER3_ADDR    : std_logic_vector(7 downto 0) := x"94";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER3_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER3_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER4_ADDR    : std_logic_vector(7 downto 0) := x"95";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER4_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER4_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER5_ADDR    : std_logic_vector(7 downto 0) := x"96";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER5_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER5_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER6_ADDR    : std_logic_vector(7 downto 0) := x"97";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER6_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER6_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_CLUSTER7_ADDR    : std_logic_vector(7 downto 0) := x"98";
    constant REG_TRIG_SBIT_MONITOR_CLUSTER7_MSB    : integer := 15;
    constant REG_TRIG_SBIT_MONITOR_CLUSTER7_LSB     : integer := 0;

    constant REG_TRIG_SBIT_MONITOR_L1A_DELAY_ADDR    : std_logic_vector(7 downto 0) := x"a0";
    constant REG_TRIG_SBIT_MONITOR_L1A_DELAY_MSB    : integer := 31;
    constant REG_TRIG_SBIT_MONITOR_L1A_DELAY_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_RESET_ADDR    : std_logic_vector(7 downto 0) := x"b0";
    constant REG_TRIG_SBIT_HITMAP_RESET_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_RESET_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_ACQUIRE_ADDR    : std_logic_vector(7 downto 0) := x"b1";
    constant REG_TRIG_SBIT_HITMAP_ACQUIRE_BIT    : integer := 0;
    constant REG_TRIG_SBIT_HITMAP_ACQUIRE_DEFAULT : std_logic := '0';

    constant REG_TRIG_SBIT_HITMAP_VFAT0_MSB_ADDR    : std_logic_vector(7 downto 0) := x"b2";
    constant REG_TRIG_SBIT_HITMAP_VFAT0_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT0_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT0_LSB_ADDR    : std_logic_vector(7 downto 0) := x"b3";
    constant REG_TRIG_SBIT_HITMAP_VFAT0_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT0_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT1_MSB_ADDR    : std_logic_vector(7 downto 0) := x"b4";
    constant REG_TRIG_SBIT_HITMAP_VFAT1_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT1_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT1_LSB_ADDR    : std_logic_vector(7 downto 0) := x"b5";
    constant REG_TRIG_SBIT_HITMAP_VFAT1_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT1_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT2_MSB_ADDR    : std_logic_vector(7 downto 0) := x"b6";
    constant REG_TRIG_SBIT_HITMAP_VFAT2_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT2_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT2_LSB_ADDR    : std_logic_vector(7 downto 0) := x"b7";
    constant REG_TRIG_SBIT_HITMAP_VFAT2_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT2_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT3_MSB_ADDR    : std_logic_vector(7 downto 0) := x"b8";
    constant REG_TRIG_SBIT_HITMAP_VFAT3_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT3_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT3_LSB_ADDR    : std_logic_vector(7 downto 0) := x"b9";
    constant REG_TRIG_SBIT_HITMAP_VFAT3_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT3_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT4_MSB_ADDR    : std_logic_vector(7 downto 0) := x"ba";
    constant REG_TRIG_SBIT_HITMAP_VFAT4_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT4_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT4_LSB_ADDR    : std_logic_vector(7 downto 0) := x"bb";
    constant REG_TRIG_SBIT_HITMAP_VFAT4_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT4_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT5_MSB_ADDR    : std_logic_vector(7 downto 0) := x"bc";
    constant REG_TRIG_SBIT_HITMAP_VFAT5_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT5_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT5_LSB_ADDR    : std_logic_vector(7 downto 0) := x"bd";
    constant REG_TRIG_SBIT_HITMAP_VFAT5_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT5_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT6_MSB_ADDR    : std_logic_vector(7 downto 0) := x"be";
    constant REG_TRIG_SBIT_HITMAP_VFAT6_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT6_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT6_LSB_ADDR    : std_logic_vector(7 downto 0) := x"bf";
    constant REG_TRIG_SBIT_HITMAP_VFAT6_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT6_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT7_MSB_ADDR    : std_logic_vector(7 downto 0) := x"c0";
    constant REG_TRIG_SBIT_HITMAP_VFAT7_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT7_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT7_LSB_ADDR    : std_logic_vector(7 downto 0) := x"c1";
    constant REG_TRIG_SBIT_HITMAP_VFAT7_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT7_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT8_MSB_ADDR    : std_logic_vector(7 downto 0) := x"c2";
    constant REG_TRIG_SBIT_HITMAP_VFAT8_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT8_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT8_LSB_ADDR    : std_logic_vector(7 downto 0) := x"c3";
    constant REG_TRIG_SBIT_HITMAP_VFAT8_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT8_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT9_MSB_ADDR    : std_logic_vector(7 downto 0) := x"c4";
    constant REG_TRIG_SBIT_HITMAP_VFAT9_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT9_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT9_LSB_ADDR    : std_logic_vector(7 downto 0) := x"c5";
    constant REG_TRIG_SBIT_HITMAP_VFAT9_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT9_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT10_MSB_ADDR    : std_logic_vector(7 downto 0) := x"c6";
    constant REG_TRIG_SBIT_HITMAP_VFAT10_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT10_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT10_LSB_ADDR    : std_logic_vector(7 downto 0) := x"c7";
    constant REG_TRIG_SBIT_HITMAP_VFAT10_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT10_LSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT11_MSB_ADDR    : std_logic_vector(7 downto 0) := x"c8";
    constant REG_TRIG_SBIT_HITMAP_VFAT11_MSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT11_MSB_LSB     : integer := 0;

    constant REG_TRIG_SBIT_HITMAP_VFAT11_LSB_ADDR    : std_logic_vector(7 downto 0) := x"c9";
    constant REG_TRIG_SBIT_HITMAP_VFAT11_LSB_MSB    : integer := 31;
    constant REG_TRIG_SBIT_HITMAP_VFAT11_LSB_LSB     : integer := 0;

    constant REG_TRIG_CTRL_SBIT_SOT_INVALID_BITSKIP_ADDR    : std_logic_vector(7 downto 0) := x"e2";
    constant REG_TRIG_CTRL_SBIT_SOT_INVALID_BITSKIP_MSB    : integer := 11;
    constant REG_TRIG_CTRL_SBIT_SOT_INVALID_BITSKIP_LSB     : integer := 0;


    --============================================================================
    --       >>> CLOCKING Module <<<    base address: 0x00003000
    --
    -- Controls and monitors the status of the Optohybrid clocks
    --============================================================================

    constant REG_CLOCKING_NUM_REGS : integer := 1;
    constant REG_CLOCKING_ADDRESS_MSB : integer := 1;
    constant REG_CLOCKING_ADDRESS_LSB : integer := 0;
    constant REG_CLOCKING_MMCM_LOCKED_ADDR    : std_logic_vector(1 downto 0) := "00";
    constant REG_CLOCKING_MMCM_LOCKED_BIT    : integer := 0;

    constant REG_CLOCKING_MMCM_UNLOCKED_CNT_ADDR    : std_logic_vector(1 downto 0) := "00";
    constant REG_CLOCKING_MMCM_UNLOCKED_CNT_MSB    : integer := 23;
    constant REG_CLOCKING_MMCM_UNLOCKED_CNT_LSB     : integer := 16;


    --============================================================================
    --       >>> GBT Module <<<    base address: 0x00004000
    --
    -- Contains functionality for controlling and monitoring the bidirectional
    -- GBTx to FPGA link
    --============================================================================

    constant REG_GBT_NUM_REGS : integer := 6;
    constant REG_GBT_ADDRESS_MSB : integer := 3;
    constant REG_GBT_ADDRESS_LSB : integer := 0;
    constant REG_GBT_TX_CNT_RESPONSE_SENT_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_GBT_TX_CNT_RESPONSE_SENT_MSB    : integer := 31;
    constant REG_GBT_TX_CNT_RESPONSE_SENT_LSB     : integer := 8;

    constant REG_GBT_TX_TX_READY_ADDR    : std_logic_vector(3 downto 0) := x"1";
    constant REG_GBT_TX_TX_READY_BIT    : integer := 0;

    constant REG_GBT_RX_RX_READY_ADDR    : std_logic_vector(3 downto 0) := x"4";
    constant REG_GBT_RX_RX_READY_BIT    : integer := 0;

    constant REG_GBT_RX_RX_VALID_ADDR    : std_logic_vector(3 downto 0) := x"4";
    constant REG_GBT_RX_RX_VALID_BIT    : integer := 1;

    constant REG_GBT_RX_CNT_REQUEST_RECEIVED_ADDR    : std_logic_vector(3 downto 0) := x"4";
    constant REG_GBT_RX_CNT_REQUEST_RECEIVED_MSB    : integer := 31;
    constant REG_GBT_RX_CNT_REQUEST_RECEIVED_LSB     : integer := 8;

    constant REG_GBT_RX_CNT_LINK_ERR_ADDR    : std_logic_vector(3 downto 0) := x"5";
    constant REG_GBT_RX_CNT_LINK_ERR_MSB    : integer := 23;
    constant REG_GBT_RX_CNT_LINK_ERR_LSB     : integer := 0;

    constant REG_GBT_TTC_FORCE_L1A_ADDR    : std_logic_vector(3 downto 0) := x"5";
    constant REG_GBT_TTC_FORCE_L1A_MSB    : integer := 31;
    constant REG_GBT_TTC_FORCE_L1A_LSB     : integer := 0;

    constant REG_GBT_TTC_FORCE_BC0_ADDR    : std_logic_vector(3 downto 0) := x"6";
    constant REG_GBT_TTC_FORCE_BC0_MSB    : integer := 31;
    constant REG_GBT_TTC_FORCE_BC0_LSB     : integer := 0;

    constant REG_GBT_TTC_FORCE_RESYNC_ADDR    : std_logic_vector(3 downto 0) := x"7";
    constant REG_GBT_TTC_FORCE_RESYNC_MSB    : integer := 31;
    constant REG_GBT_TTC_FORCE_RESYNC_LSB     : integer := 0;


end registers;
