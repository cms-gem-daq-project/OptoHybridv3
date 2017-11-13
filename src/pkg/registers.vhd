library IEEE;
use IEEE.STD_LOGIC_1164.all;

-----> !! This package is auto-generated from an address table file using <repo_root>/scripts/generate_registers.py !! <-----
package registers is

    --============================================================================
    --       >>> OH_CONTROL Module <<<    base address: 0x00000000
    --
    -- Implements various control and monitoring functions of the Optohybrid
    --============================================================================

    constant REG_OH_CONTROL_NUM_REGS : integer := 14;
    constant REG_OH_CONTROL_ADDRESS_MSB : integer := 5;
    constant REG_OH_CONTROL_ADDRESS_LSB : integer := 0;
    constant REG_OH_CONTROL_LOOPBACK_DATA_ADDR    : std_logic_vector(5 downto 0) := "00" & x"0";
    constant REG_OH_CONTROL_LOOPBACK_DATA_MSB    : integer := 31;
    constant REG_OH_CONTROL_LOOPBACK_DATA_LSB     : integer := 0;
    constant REG_OH_CONTROL_LOOPBACK_DATA_DEFAULT : std_logic_vector(31 downto 0) := x"01234567";

    constant REG_OH_CONTROL_RELEASE_DAY_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_OH_CONTROL_RELEASE_DAY_MSB    : integer := 7;
    constant REG_OH_CONTROL_RELEASE_DAY_LSB     : integer := 0;

    constant REG_OH_CONTROL_RELEASE_MONTH_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_OH_CONTROL_RELEASE_MONTH_MSB    : integer := 15;
    constant REG_OH_CONTROL_RELEASE_MONTH_LSB     : integer := 8;

    constant REG_OH_CONTROL_RELEASE_YEAR_ADDR    : std_logic_vector(5 downto 0) := "00" & x"2";
    constant REG_OH_CONTROL_RELEASE_YEAR_MSB    : integer := 31;
    constant REG_OH_CONTROL_RELEASE_YEAR_LSB     : integer := 16;

    constant REG_OH_CONTROL_SEM_CNT_SEM_CRITICAL_ADDR    : std_logic_vector(5 downto 0) := "00" & x"6";
    constant REG_OH_CONTROL_SEM_CNT_SEM_CRITICAL_MSB    : integer := 15;
    constant REG_OH_CONTROL_SEM_CNT_SEM_CRITICAL_LSB     : integer := 0;

    constant REG_OH_CONTROL_SEM_CNT_SEM_CORRECTION_ADDR    : std_logic_vector(5 downto 0) := "00" & x"6";
    constant REG_OH_CONTROL_SEM_CNT_SEM_CORRECTION_MSB    : integer := 31;
    constant REG_OH_CONTROL_SEM_CNT_SEM_CORRECTION_LSB     : integer := 16;

    constant REG_OH_CONTROL_GBT_RX_READY_ADDR    : std_logic_vector(5 downto 0) := "00" & x"8";
    constant REG_OH_CONTROL_GBT_RX_READY_BIT    : integer := 0;

    constant REG_OH_CONTROL_GBT_RX_VALID_ADDR    : std_logic_vector(5 downto 0) := "00" & x"8";
    constant REG_OH_CONTROL_GBT_RX_VALID_BIT    : integer := 1;

    constant REG_OH_CONTROL_GBT_TX_READY_ADDR    : std_logic_vector(5 downto 0) := "00" & x"8";
    constant REG_OH_CONTROL_GBT_TX_READY_BIT    : integer := 2;

    constant REG_OH_CONTROL_VFAT_RESET_ADDR    : std_logic_vector(5 downto 0) := "00" & x"a";
    constant REG_OH_CONTROL_VFAT_RESET_BIT    : integer := 0;
    constant REG_OH_CONTROL_VFAT_RESET_DEFAULT : std_logic := '0';

    constant REG_OH_CONTROL_FMM_DONT_WAIT_ADDR    : std_logic_vector(5 downto 0) := "00" & x"c";
    constant REG_OH_CONTROL_FMM_DONT_WAIT_BIT    : integer := 0;
    constant REG_OH_CONTROL_FMM_DONT_WAIT_DEFAULT : std_logic := '1';

    constant REG_OH_CONTROL_FMM_STOP_TRIGGER_ADDR    : std_logic_vector(5 downto 0) := "00" & x"c";
    constant REG_OH_CONTROL_FMM_STOP_TRIGGER_BIT    : integer := 1;

    constant REG_OH_CONTROL_TTC_BX0_CNT_LOCAL_ADDR    : std_logic_vector(5 downto 0) := "00" & x"e";
    constant REG_OH_CONTROL_TTC_BX0_CNT_LOCAL_MSB    : integer := 23;
    constant REG_OH_CONTROL_TTC_BX0_CNT_LOCAL_LSB     : integer := 0;

    constant REG_OH_CONTROL_TTC_BX0_CNT_TTC_ADDR    : std_logic_vector(5 downto 0) := "00" & x"f";
    constant REG_OH_CONTROL_TTC_BX0_CNT_TTC_MSB    : integer := 23;
    constant REG_OH_CONTROL_TTC_BX0_CNT_TTC_LSB     : integer := 0;

    constant REG_OH_CONTROL_TTC_BXN_CNT_LOCAL_ADDR    : std_logic_vector(5 downto 0) := "01" & x"0";
    constant REG_OH_CONTROL_TTC_BXN_CNT_LOCAL_MSB    : integer := 11;
    constant REG_OH_CONTROL_TTC_BXN_CNT_LOCAL_LSB     : integer := 0;

    constant REG_OH_CONTROL_TTC_BXN_SYNC_ERR_ADDR    : std_logic_vector(5 downto 0) := "01" & x"0";
    constant REG_OH_CONTROL_TTC_BXN_SYNC_ERR_BIT    : integer := 12;

    constant REG_OH_CONTROL_TTC_BX0_SYNC_ERR_ADDR    : std_logic_vector(5 downto 0) := "01" & x"0";
    constant REG_OH_CONTROL_TTC_BX0_SYNC_ERR_BIT    : integer := 13;

    constant REG_OH_CONTROL_TTC_BXN_OFFSET_ADDR    : std_logic_vector(5 downto 0) := "01" & x"0";
    constant REG_OH_CONTROL_TTC_BXN_OFFSET_MSB    : integer := 27;
    constant REG_OH_CONTROL_TTC_BXN_OFFSET_LSB     : integer := 16;
    constant REG_OH_CONTROL_TTC_BXN_OFFSET_DEFAULT : std_logic_vector(27 downto 16) := x"000";

    constant REG_OH_CONTROL_TTC_L1A_CNT_ADDR    : std_logic_vector(5 downto 0) := "01" & x"1";
    constant REG_OH_CONTROL_TTC_L1A_CNT_MSB    : integer := 15;
    constant REG_OH_CONTROL_TTC_L1A_CNT_LSB     : integer := 0;

    constant REG_OH_CONTROL_TTC_BXN_SYNC_ERR_CNT_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_OH_CONTROL_TTC_BXN_SYNC_ERR_CNT_MSB    : integer := 15;
    constant REG_OH_CONTROL_TTC_BXN_SYNC_ERR_CNT_LSB     : integer := 0;

    constant REG_OH_CONTROL_TTC_BX0_SYNC_ERR_CNT_ADDR    : std_logic_vector(5 downto 0) := "01" & x"2";
    constant REG_OH_CONTROL_TTC_BX0_SYNC_ERR_CNT_MSB    : integer := 31;
    constant REG_OH_CONTROL_TTC_BX0_SYNC_ERR_CNT_LSB     : integer := 16;

    constant REG_OH_CONTROL_SBITS_CLUSTER_RATE_ADDR    : std_logic_vector(5 downto 0) := "01" & x"8";
    constant REG_OH_CONTROL_SBITS_CLUSTER_RATE_MSB    : integer := 31;
    constant REG_OH_CONTROL_SBITS_CLUSTER_RATE_LSB     : integer := 0;

    constant REG_OH_CONTROL_HDMI_HDMI_OUTPUT_ADDR    : std_logic_vector(5 downto 0) := "01" & x"c";
    constant REG_OH_CONTROL_HDMI_HDMI_OUTPUT_MSB    : integer := 5;
    constant REG_OH_CONTROL_HDMI_HDMI_OUTPUT_LSB     : integer := 0;

    constant REG_OH_CONTROL_HDMI_SBIT_SEL_MODE_ADDR    : std_logic_vector(5 downto 0) := "01" & x"c";
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_MODE_MSB    : integer := 7;
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_MODE_LSB     : integer := 6;
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_MODE_DEFAULT : std_logic_vector(7 downto 6) := "00";

    constant REG_OH_CONTROL_HDMI_SBIT_SEL_ADDR    : std_logic_vector(5 downto 0) := "01" & x"d";
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_MSB    : integer := 29;
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_LSB     : integer := 0;
    constant REG_OH_CONTROL_HDMI_SBIT_SEL_DEFAULT : std_logic_vector(29 downto 0) := "00" & x"0000000";


    --============================================================================
    --       >>> OH_ADC Module <<<    base address: 0x00001000
    --
    -- Connects to the Virtex-6 XADC
    --============================================================================

    constant REG_OH_ADC_NUM_REGS : integer := 8;
    constant REG_OH_ADC_ADDRESS_MSB : integer := 3;
    constant REG_OH_ADC_ADDRESS_LSB : integer := 0;
    constant REG_OH_ADC_CTRL_OVERTEMP_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_OH_ADC_CTRL_OVERTEMP_BIT    : integer := 0;

    constant REG_OH_ADC_CTRL_VCCAUX_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_OH_ADC_CTRL_VCCAUX_ALARM_BIT    : integer := 1;

    constant REG_OH_ADC_CTRL_VCCINT_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"0";
    constant REG_OH_ADC_CTRL_VCCINT_ALARM_BIT    : integer := 2;

    constant REG_OH_ADC_CTRL_ADR_IN_ADDR    : std_logic_vector(3 downto 0) := x"1";
    constant REG_OH_ADC_CTRL_ADR_IN_MSB    : integer := 6;
    constant REG_OH_ADC_CTRL_ADR_IN_LSB     : integer := 0;
    constant REG_OH_ADC_CTRL_ADR_IN_DEFAULT : std_logic_vector(6 downto 0) := "000" & x"0";

    constant REG_OH_ADC_CTRL_DATA_IN_ADDR    : std_logic_vector(3 downto 0) := x"2";
    constant REG_OH_ADC_CTRL_DATA_IN_MSB    : integer := 15;
    constant REG_OH_ADC_CTRL_DATA_IN_LSB     : integer := 0;
    constant REG_OH_ADC_CTRL_DATA_IN_DEFAULT : std_logic_vector(15 downto 0) := x"0000";

    constant REG_OH_ADC_CTRL_DATA_OUT_ADDR    : std_logic_vector(3 downto 0) := x"3";
    constant REG_OH_ADC_CTRL_DATA_OUT_MSB    : integer := 15;
    constant REG_OH_ADC_CTRL_DATA_OUT_LSB     : integer := 0;

    constant REG_OH_ADC_CTRL_RESET_ADDR    : std_logic_vector(3 downto 0) := x"4";
    constant REG_OH_ADC_CTRL_RESET_BIT    : integer := 0;

    constant REG_OH_ADC_CTRL_WR_EN_ADDR    : std_logic_vector(3 downto 0) := x"5";
    constant REG_OH_ADC_CTRL_WR_EN_BIT    : integer := 0;

    constant REG_OH_ADC_CTRL_ENABLE_ADDR    : std_logic_vector(3 downto 0) := x"6";
    constant REG_OH_ADC_CTRL_ENABLE_BIT    : integer := 0;
    constant REG_OH_ADC_CTRL_ENABLE_DEFAULT : std_logic := '1';

    constant REG_OH_ADC_CTRL_CNT_OVERTEMP_ADDR    : std_logic_vector(3 downto 0) := x"7";
    constant REG_OH_ADC_CTRL_CNT_OVERTEMP_MSB    : integer := 7;
    constant REG_OH_ADC_CTRL_CNT_OVERTEMP_LSB     : integer := 0;

    constant REG_OH_ADC_CTRL_CNT_VCCAUX_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"7";
    constant REG_OH_ADC_CTRL_CNT_VCCAUX_ALARM_MSB    : integer := 15;
    constant REG_OH_ADC_CTRL_CNT_VCCAUX_ALARM_LSB     : integer := 8;

    constant REG_OH_ADC_CTRL_CNT_VCCINT_ALARM_ADDR    : std_logic_vector(3 downto 0) := x"7";
    constant REG_OH_ADC_CTRL_CNT_VCCINT_ALARM_MSB    : integer := 23;
    constant REG_OH_ADC_CTRL_CNT_VCCINT_ALARM_LSB     : integer := 16;


    --============================================================================
    --       >>> OH_TRIG Module <<<    base address: 0x00002000
    --
    -- Connects to the trigger control module
    --============================================================================

    constant REG_OH_TRIG_NUM_REGS : integer := 66;
    constant REG_OH_TRIG_ADDRESS_MSB : integer := 7;
    constant REG_OH_TRIG_ADDRESS_LSB : integer := 0;
    constant REG_OH_TRIG_CTRL_VFAT_MASK_ADDR    : std_logic_vector(7 downto 0) := x"00";
    constant REG_OH_TRIG_CTRL_VFAT_MASK_MSB    : integer := 23;
    constant REG_OH_TRIG_CTRL_VFAT_MASK_LSB     : integer := 0;
    constant REG_OH_TRIG_CTRL_VFAT_MASK_DEFAULT : std_logic_vector(23 downto 0) := x"000000";

    constant REG_OH_TRIG_CTRL_SBIT_DEADTIME_ADDR    : std_logic_vector(7 downto 0) := x"01";
    constant REG_OH_TRIG_CTRL_SBIT_DEADTIME_MSB    : integer := 3;
    constant REG_OH_TRIG_CTRL_SBIT_DEADTIME_LSB     : integer := 0;
    constant REG_OH_TRIG_CTRL_SBIT_DEADTIME_DEFAULT : std_logic_vector(3 downto 0) := x"7";

    constant REG_OH_TRIG_CTRL_ACTIVE_VFATS_ADDR    : std_logic_vector(7 downto 0) := x"02";
    constant REG_OH_TRIG_CTRL_ACTIVE_VFATS_MSB    : integer := 23;
    constant REG_OH_TRIG_CTRL_ACTIVE_VFATS_LSB     : integer := 0;

    constant REG_OH_TRIG_CTRL_CNT_OVERFLOW_ADDR    : std_logic_vector(7 downto 0) := x"03";
    constant REG_OH_TRIG_CTRL_CNT_OVERFLOW_MSB    : integer := 15;
    constant REG_OH_TRIG_CTRL_CNT_OVERFLOW_LSB     : integer := 0;

    constant REG_OH_TRIG_CTRL_SBIT_SOF_ALIGNED_ADDR    : std_logic_vector(7 downto 0) := x"04";
    constant REG_OH_TRIG_CTRL_SBIT_SOF_ALIGNED_MSB    : integer := 23;
    constant REG_OH_TRIG_CTRL_SBIT_SOF_ALIGNED_LSB     : integer := 0;

    constant REG_OH_TRIG_CTRL_SBIT_SOF_UNSTABLE_ADDR    : std_logic_vector(7 downto 0) := x"05";
    constant REG_OH_TRIG_CTRL_SBIT_SOF_UNSTABLE_MSB    : integer := 23;
    constant REG_OH_TRIG_CTRL_SBIT_SOF_UNSTABLE_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT0_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"10";
    constant REG_OH_TRIG_CNT_VFAT0_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT0_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT1_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"11";
    constant REG_OH_TRIG_CNT_VFAT1_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT1_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT2_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"12";
    constant REG_OH_TRIG_CNT_VFAT2_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT2_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT3_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"13";
    constant REG_OH_TRIG_CNT_VFAT3_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT3_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT4_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"14";
    constant REG_OH_TRIG_CNT_VFAT4_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT4_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT5_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"15";
    constant REG_OH_TRIG_CNT_VFAT5_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT5_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT6_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"16";
    constant REG_OH_TRIG_CNT_VFAT6_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT6_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT7_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"17";
    constant REG_OH_TRIG_CNT_VFAT7_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT7_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT8_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"18";
    constant REG_OH_TRIG_CNT_VFAT8_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT8_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT9_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"19";
    constant REG_OH_TRIG_CNT_VFAT9_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT9_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT10_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1a";
    constant REG_OH_TRIG_CNT_VFAT10_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT10_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT11_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1b";
    constant REG_OH_TRIG_CNT_VFAT11_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT11_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT12_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1c";
    constant REG_OH_TRIG_CNT_VFAT12_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT12_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT13_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1d";
    constant REG_OH_TRIG_CNT_VFAT13_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT13_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT14_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1e";
    constant REG_OH_TRIG_CNT_VFAT14_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT14_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT15_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"1f";
    constant REG_OH_TRIG_CNT_VFAT15_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT15_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT16_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"20";
    constant REG_OH_TRIG_CNT_VFAT16_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT16_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT17_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"21";
    constant REG_OH_TRIG_CNT_VFAT17_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT17_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT18_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"22";
    constant REG_OH_TRIG_CNT_VFAT18_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT18_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT19_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"23";
    constant REG_OH_TRIG_CNT_VFAT19_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT19_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT20_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"24";
    constant REG_OH_TRIG_CNT_VFAT20_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT20_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT21_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"25";
    constant REG_OH_TRIG_CNT_VFAT21_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT21_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT22_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"26";
    constant REG_OH_TRIG_CNT_VFAT22_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT22_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_CNT_VFAT23_SBITS_ADDR    : std_logic_vector(7 downto 0) := x"27";
    constant REG_OH_TRIG_CNT_VFAT23_SBITS_MSB    : integer := 15;
    constant REG_OH_TRIG_CNT_VFAT23_SBITS_LSB     : integer := 0;

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"30";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT0_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"31";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT1_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"6";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"32";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"33";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT2_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"34";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT3_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"6";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"35";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT4_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"36";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"c";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"d";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"37";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT5_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"d";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"38";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT6_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"39";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT7_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"3a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"3b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT8_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"3c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT9_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"3d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT10_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"7";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"3e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"7";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"d";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"3f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT11_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"d";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"40";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT12_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"41";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT13_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"42";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"43";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT14_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"44";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT15_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"6";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"45";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT16_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"46";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"47";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT17_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"48";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT18_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"49";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT19_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"4a";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"4b";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT20_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"4c";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT21_BIT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"f";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT0_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT0_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT0_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT1_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT1_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT1_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT2_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT2_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT2_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"4d";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT3_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT3_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT3_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT4_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT4_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT4_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT5_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT5_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT5_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"8";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT6_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT6_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT6_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"7";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT7_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT7_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT22_BIT7_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"7";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT0_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT0_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT0_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT0_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"c";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT1_ADDR    : std_logic_vector(7 downto 0) := x"4e";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT1_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT1_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT1_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"b";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT2_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT2_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT2_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT2_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"b";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT3_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT3_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT3_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT3_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT4_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT4_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT4_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT4_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT5_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT5_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT5_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT5_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT6_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT6_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT6_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT6_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT7_ADDR    : std_logic_vector(7 downto 0) := x"4f";
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT7_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT7_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_TAP_DELAY_VFAT23_BIT7_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"a";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT0_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT1_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT2_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"5";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT3_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT4_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"9";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_ADDR    : std_logic_vector(7 downto 0) := x"50";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT5_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT6_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT7_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT8_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"b";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT9_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT10_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"6";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_ADDR    : std_logic_vector(7 downto 0) := x"51";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT11_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT12_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT12_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT12_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT12_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT13_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT13_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT13_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT13_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT14_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT14_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT14_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT14_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT15_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT15_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT15_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT15_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"b";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT16_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT16_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT16_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT16_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"2";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT17_ADDR    : std_logic_vector(7 downto 0) := x"52";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT17_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT17_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT17_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"3";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT18_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT18_MSB    : integer := 4;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT18_LSB     : integer := 0;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT18_DEFAULT : std_logic_vector(4 downto 0) := '0' & x"b";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT19_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT19_MSB    : integer := 9;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT19_LSB     : integer := 5;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT19_DEFAULT : std_logic_vector(9 downto 5) := '0' & x"4";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT20_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT20_MSB    : integer := 14;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT20_LSB     : integer := 10;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT20_DEFAULT : std_logic_vector(14 downto 10) := '0' & x"1";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT21_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT21_MSB    : integer := 19;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT21_LSB     : integer := 15;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT21_DEFAULT : std_logic_vector(19 downto 15) := '0' & x"c";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT22_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT22_MSB    : integer := 24;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT22_LSB     : integer := 20;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT22_DEFAULT : std_logic_vector(24 downto 20) := '0' & x"0";

    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT23_ADDR    : std_logic_vector(7 downto 0) := x"53";
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT23_MSB    : integer := 29;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT23_LSB     : integer := 25;
    constant REG_OH_TRIG_TIMING_SOT_TAP_DELAY_VFAT23_DEFAULT : std_logic_vector(29 downto 25) := '0' & x"0";


    --============================================================================
    --       >>> OH_CLOCKING Module <<<    base address: 0x00003000
    --
    -- Connects to MMCMs
    --============================================================================

    constant REG_OH_CLOCKING_NUM_REGS : integer := 2;
    constant REG_OH_CLOCKING_ADDRESS_MSB : integer := 15;
    constant REG_OH_CLOCKING_ADDRESS_LSB : integer := 0;
    constant REG_OH_CLOCKING_CLOCKING_LOGIC_MMCM_LOCKED_ADDR    : std_logic_vector(15 downto 0) := x"0000";
    constant REG_OH_CLOCKING_CLOCKING_LOGIC_MMCM_LOCKED_BIT    : integer := 1;

    constant REG_OH_CLOCKING_CLOCKING_GBT_MMCM_UNLOCKED_CNT_ADDR    : std_logic_vector(15 downto 0) := x"0000";
    constant REG_OH_CLOCKING_CLOCKING_GBT_MMCM_UNLOCKED_CNT_MSB    : integer := 23;
    constant REG_OH_CLOCKING_CLOCKING_GBT_MMCM_UNLOCKED_CNT_LSB     : integer := 16;

    constant REG_OH_CLOCKING_CLOCKING_LOGIC_MMCM_UNLOCKED_CNT_ADDR    : std_logic_vector(15 downto 0) := x"0000";
    constant REG_OH_CLOCKING_CLOCKING_LOGIC_MMCM_UNLOCKED_CNT_MSB    : integer := 31;
    constant REG_OH_CLOCKING_CLOCKING_LOGIC_MMCM_UNLOCKED_CNT_LSB     : integer := 24;

    constant REG_OH_CLOCKING_CLOCKING_GBT_MMCM_LOCKED_ADDR    : std_logic_vector(15 downto 0) := x"0002";
    constant REG_OH_CLOCKING_CLOCKING_GBT_MMCM_LOCKED_BIT    : integer := 0;


end registers;
