--------------------------------------------------------------------------------
-- Copyright (c) 1995-2013 Xilinx, Inc.  All rights reserved.
--------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx
-- \   \   \/     Version: P.20131013
--  \   \         Application: netgen
--  /   /         Filename: sem.vhd
-- /___/   /\     Timestamp: Tue Feb 14 16:02:18 2017
-- \   \  /  \ 
--  \___\/\___\
--             
-- Command	: -w -sim -ofmt vhdl C:/Users/Administrator/Documents/firmware/OptoHybridv2/src/ip_cores/tmp/_cg/sem.ngc C:/Users/Administrator/Documents/firmware/OptoHybridv2/src/ip_cores/tmp/_cg/sem.vhd 
-- Device	: 6vlx130tff1156-1
-- Input file	: C:/Users/Administrator/Documents/firmware/OptoHybridv2/src/ip_cores/tmp/_cg/sem.ngc
-- Output file	: C:/Users/Administrator/Documents/firmware/OptoHybridv2/src/ip_cores/tmp/_cg/sem.vhd
-- # of Entities	: 1
-- Design Name	: sem
-- Xilinx	: C:\Xilinx\14.7\ISE_DS\ISE\
--             
-- Purpose:    
--     This VHDL netlist is a verification model and uses simulation 
--     primitives which may not represent the true implementation of the 
--     device, however the netlist is functionally correct and should not 
--     be modified. This file cannot be synthesized and should only be used 
--     with supported simulation tools.
--             
-- Reference:  
--     Command Line Tools User Guide, Chapter 23
--     Synthesis and Simulation Design Guide, Chapter 6
--             
--------------------------------------------------------------------------------


-- synthesis translate_off
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
use UNISIM.VPKG.ALL;

entity sem is
  port (
    monitor_txfull : in STD_LOGIC := 'X'; 
    monitor_rxempty : in STD_LOGIC := 'X'; 
    icap_busy : in STD_LOGIC := 'X'; 
    icap_clk : in STD_LOGIC := 'X'; 
    icap_grant : in STD_LOGIC := 'X'; 
    fecc_crcerr : in STD_LOGIC := 'X'; 
    fecc_eccerr : in STD_LOGIC := 'X'; 
    fecc_eccerrsingle : in STD_LOGIC := 'X'; 
    fecc_syndromevalid : in STD_LOGIC := 'X'; 
    status_heartbeat : out STD_LOGIC; 
    status_initialization : out STD_LOGIC; 
    status_observation : out STD_LOGIC; 
    status_correction : out STD_LOGIC; 
    status_classification : out STD_LOGIC; 
    status_injection : out STD_LOGIC; 
    status_essential : out STD_LOGIC; 
    status_uncorrectable : out STD_LOGIC; 
    monitor_txwrite : out STD_LOGIC; 
    monitor_rxread : out STD_LOGIC; 
    icap_csb : out STD_LOGIC; 
    icap_rdwrb : out STD_LOGIC; 
    icap_request : out STD_LOGIC; 
    monitor_rxdata : in STD_LOGIC_VECTOR ( 7 downto 0 ); 
    icap_o : in STD_LOGIC_VECTOR ( 31 downto 0 ); 
    fecc_syndrome : in STD_LOGIC_VECTOR ( 12 downto 0 ); 
    fecc_far : in STD_LOGIC_VECTOR ( 23 downto 0 ); 
    fecc_synbit : in STD_LOGIC_VECTOR ( 4 downto 0 ); 
    fecc_synword : in STD_LOGIC_VECTOR ( 6 downto 0 ); 
    monitor_txdata : out STD_LOGIC_VECTOR ( 7 downto 0 ); 
    icap_i : out STD_LOGIC_VECTOR ( 31 downto 0 ) 
  );
end sem;

architecture STRUCTURE of sem is
  signal NlwRenamedSignal_status_heartbeat : STD_LOGIC; 
  signal NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg : STD_LOGIC; 
  signal N0 : STD_LOGIC; 
  signal N1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_5_Q_178 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_4_Q_179 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_4_Q_180 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_3_Q_181 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_3_Q_182 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_2_Q_183 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_2_Q_184 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_1_Q_185 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_1_Q_186 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_0_Q_187 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_0_Q_188 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_7_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_6_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_5_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_4_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_3_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_2_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_1_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result_0_1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_b_ena : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_a : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_b : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_c : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6_PWR_7_o_equal_16_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_16_frame_locate_16_equal_32_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_6_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_24_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_26_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_25_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_275 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_276 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_277 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_sbe_296 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_0_314 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_1_315 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_2_316 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_3_317 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_4_318 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_5_319 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_6_320 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_7_321 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_8_322 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_9_323 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_10_324 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_11_325 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_12_326 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_13_327 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_14_328 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_15_329 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_330 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_flm_386 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_sync_init : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_read_strobe : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101_475 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_9_Q_477 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_8_Q_478 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_7_Q_479 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_6_Q_480 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_5_Q_481 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_4_Q_482 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_3_Q_483 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_2_Q_484 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_2_Q_485 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_1_Q_486 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_0_Q_487 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_0_Q_488 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_sync_init_INV_10_o : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_0_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_1_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_2_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_3_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_4_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_5_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_6_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_7_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_8_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_9_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_10_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc1 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_0_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_1_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_2_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_3_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_4_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_5_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_6_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_7_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_8_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_9_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_10_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc4 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_0_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_1_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_2_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_3_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_4_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_5_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_6_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_7_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_9_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_10_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_11_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_12_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_13_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_14_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_15_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_16_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_18_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_19_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_20_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_21_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_22_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_23_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_24_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_25_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_27_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_28_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_29_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_30_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_31_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_32_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_33_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_34_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_go : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_8_583 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_9_584 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_10_585 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_26_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_35_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_fast_route : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_fast_route : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_out : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_parity : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_parity : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_pulse : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_t_state : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry_value : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_shift_in : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_condition_met : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_invert_arith_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry_in : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_shift_in : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable_value : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_io_initial_decode : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_zero : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_read_active : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_write_active : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_fetch_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_parity : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_push_or_pop_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_move_group : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_update_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_write : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_write : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_flag : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_write : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_zero : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_carry : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_interrupt_ack_internal : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_clean_int : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state : STD_LOGIC; 
  signal N2 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_1_871 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_2_872 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_3_873 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_4_874 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_5_875 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_6_876 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9_877 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_1_878 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_4_879 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_5_880 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_6_881 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_7_882 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_8_883 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_9_884 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_10_885 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_11_886 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_12_887 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_13_888 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_1_889 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_2_890 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5_891 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_6_892 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_7_893 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_8_894 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_9_895 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_10_896 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_11_897 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_12_898 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_1_899 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_2_900 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_3_901 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_4_902 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_5_903 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_6_904 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_7_905 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_8_906 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9_907 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_10_908 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_11_909 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_1_910 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_2_911 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_3_912 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_4_913 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_5_914 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_6_915 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_7_916 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_8_917 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_10_918 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_11_919 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_1_920 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_2_921 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5_922 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_6_923 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_7_924 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_8_925 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_9_926 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_10_927 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_11_928 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_1_929 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_2_930 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_3_931 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_4_932 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_5_933 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_6_934 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_7_935 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_8_936 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_10_937 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_11_938 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port46 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port461_940 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port462_941 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port463_942 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port464_943 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port465_944 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port466_945 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port467_946 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port468_947 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port469_948 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4610_949 : STD_LOGIC; 
  signal N4 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt9 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91_952 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92_953 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_glue_set_954 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_glue_set_955 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_glue_set_956 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_glue_set_957 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_9_glue_set_958 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_8_glue_set_959 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_7_glue_set_960 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_6_glue_set_961 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_5_glue_set_962 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_4_glue_set_963 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_3_glue_set_964 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_2_glue_set_965 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_1_glue_set_966 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_0_glue_set_967 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_rt_968 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_rt_969 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_rt_970 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_rt_971 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_rt_972 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_rt_973 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_rt_974 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_rt_975 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_rt_976 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_rt_977 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_rt_978 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_rt_979 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_rt_980 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_rt_981 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_rt_982 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_rt_983 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_rt_984 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_rt_985 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_rt_986 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_rt_987 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_rt_988 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_7_rt_989 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_16_rt_990 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg_rstpot_991 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_rstpot_992 : STD_LOGIC; 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_rstpot_993 : STD_LOGIC; 
  signal N6 : STD_LOGIC; 
  signal N8 : STD_LOGIC; 
  signal N9 : STD_LOGIC; 
  signal N10 : STD_LOGIC; 
  signal N11 : STD_LOGIC; 
  signal N12 : STD_LOGIC; 
  signal N13 : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOPADOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOPADOP_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_15_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_14_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_13_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_12_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_11_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_10_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_9_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_8_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_7_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_6_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_5_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_4_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_3_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_2_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOPADOP_1_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOPADOP_0_UNCONNECTED : STD_LOGIC; 
  signal NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_storage_DOPADOP_0_UNCONNECTED : STD_LOGIC; 
  signal NlwRenamedSig_OI_monitor_txdata : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal NlwRenamedSig_OI_icap_i : STD_LOGIC_VECTOR ( 31 downto 0 ); 
  signal NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy : STD_LOGIC_VECTOR ( 15 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_lut : STD_LOGIC_VECTOR ( 0 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_Result : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0 : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1 : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_in_port : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_count : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_word_count : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_frame_total : STD_LOGIC_VECTOR ( 16 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_instruction : STD_LOGIC_VECTOR ( 17 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_port_id : STD_LOGIC_VECTOR ( 5 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_address : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd : STD_LOGIC_VECTOR ( 6 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly : STD_LOGIC_VECTOR ( 23 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn : STD_LOGIC_VECTOR ( 12 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry : STD_LOGIC_VECTOR ( 8 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry : STD_LOGIC_VECTOR ( 3 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand : STD_LOGIC_VECTOR ( 7 downto 6 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address : STD_LOGIC_VECTOR ( 4 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data : STD_LOGIC_VECTOR ( 9 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data : STD_LOGIC_VECTOR ( 7 downto 0 ); 
  signal U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy : STD_LOGIC_VECTOR ( 7 downto 0 ); 
begin
  NlwRenamedSignal_status_heartbeat <= fecc_syndromevalid;
  monitor_txdata(7) <= NlwRenamedSig_OI_monitor_txdata(7);
  monitor_txdata(6) <= NlwRenamedSig_OI_monitor_txdata(6);
  monitor_txdata(5) <= NlwRenamedSig_OI_monitor_txdata(5);
  monitor_txdata(4) <= NlwRenamedSig_OI_monitor_txdata(4);
  monitor_txdata(3) <= NlwRenamedSig_OI_monitor_txdata(3);
  monitor_txdata(2) <= NlwRenamedSig_OI_monitor_txdata(2);
  monitor_txdata(1) <= NlwRenamedSig_OI_monitor_txdata(1);
  monitor_txdata(0) <= NlwRenamedSig_OI_monitor_txdata(0);
  icap_i(31) <= NlwRenamedSig_OI_icap_i(31);
  icap_i(30) <= NlwRenamedSig_OI_icap_i(30);
  icap_i(29) <= NlwRenamedSig_OI_icap_i(29);
  icap_i(28) <= NlwRenamedSig_OI_icap_i(28);
  icap_i(27) <= NlwRenamedSig_OI_icap_i(27);
  icap_i(26) <= NlwRenamedSig_OI_icap_i(26);
  icap_i(25) <= NlwRenamedSig_OI_icap_i(25);
  icap_i(24) <= NlwRenamedSig_OI_icap_i(24);
  icap_i(23) <= NlwRenamedSig_OI_icap_i(23);
  icap_i(22) <= NlwRenamedSig_OI_icap_i(22);
  icap_i(21) <= NlwRenamedSig_OI_icap_i(21);
  icap_i(20) <= NlwRenamedSig_OI_icap_i(20);
  icap_i(19) <= NlwRenamedSig_OI_icap_i(19);
  icap_i(18) <= NlwRenamedSig_OI_icap_i(18);
  icap_i(17) <= NlwRenamedSig_OI_icap_i(17);
  icap_i(16) <= NlwRenamedSig_OI_icap_i(16);
  icap_i(15) <= NlwRenamedSig_OI_icap_i(15);
  icap_i(14) <= NlwRenamedSig_OI_icap_i(14);
  icap_i(13) <= NlwRenamedSig_OI_icap_i(13);
  icap_i(12) <= NlwRenamedSig_OI_icap_i(12);
  icap_i(11) <= NlwRenamedSig_OI_icap_i(11);
  icap_i(10) <= NlwRenamedSig_OI_icap_i(10);
  icap_i(9) <= NlwRenamedSig_OI_icap_i(9);
  icap_i(8) <= NlwRenamedSig_OI_icap_i(8);
  icap_i(7) <= NlwRenamedSig_OI_icap_i(7);
  icap_i(6) <= NlwRenamedSig_OI_icap_i(6);
  icap_i(5) <= NlwRenamedSig_OI_icap_i(5);
  icap_i(4) <= NlwRenamedSig_OI_icap_i(4);
  icap_i(3) <= NlwRenamedSig_OI_icap_i(3);
  icap_i(2) <= NlwRenamedSig_OI_icap_i(2);
  icap_i(1) <= NlwRenamedSig_OI_icap_i(1);
  icap_i(0) <= NlwRenamedSig_OI_icap_i(0);
  status_heartbeat <= NlwRenamedSignal_status_heartbeat;
  status_initialization <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(0);
  status_observation <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(1);
  status_correction <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(2);
  status_classification <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(3);
  status_injection <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4);
  status_essential <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(6);
  status_uncorrectable <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(5);
  icap_request <= NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg;
  XST_VCC : VCC
    port map (
      P => N0
    );
  XST_GND : GND
    port map (
      G => N1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_7_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(6),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_7_rt_989,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_7_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_6_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(5),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_rt_968,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_6_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(5),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_rt_968,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_5_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(4),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_rt_969,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_5_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(4),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_rt_969,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_4_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_rt_970,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_4_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(3),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_rt_970,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_3_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_rt_971,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_3_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(2),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_rt_971,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_2_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_rt_972,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_2_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(1),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_rt_972,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_1_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_rt_973,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_1_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(0),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_rt_973,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_0_Q : XORCY
    port map (
      CI => N1,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_lut(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result_0_1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_0_Q : MUXCY
    port map (
      CI => N1,
      DI => N0,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_lut(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_16_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(15),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_16_rt_990,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_15_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(14),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_rt_974,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(14),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_rt_974,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_14_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(13),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_rt_975,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(13),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_rt_975,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_13_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(12),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_rt_976,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(12),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_rt_976,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_12_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(11),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_rt_977,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(11),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_rt_977,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_11_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(10),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_rt_978,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(10),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_rt_978,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_10_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(9),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_rt_979,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(9),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_rt_979,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_9_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(8),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_rt_980,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(8),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_rt_980,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_8_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(7),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_rt_981,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(7),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_rt_981,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_7_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(6),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_rt_982,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(6),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_rt_982,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_6_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(5),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_rt_983,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(5),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_rt_983,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_5_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(4),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_rt_984,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(4),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_rt_984,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_4_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_rt_985,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(3),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_rt_985,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_3_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_rt_986,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(2),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_rt_986,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_2_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_rt_987,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(1),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_rt_987,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_1_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_rt_988,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(0),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_rt_988,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_0_Q : XORCY
    port map (
      CI => N1,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_lut(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Result(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_0_Q : MUXCY
    port map (
      CI => N1,
      DI => N0,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_lut(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_5_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_4_Q_179,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_5_Q_178,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_16_frame_locate_16_equal_32_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_5_Q : LUT4
    generic map(
      INIT => X"9009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_15_329,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_330,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_5_Q_178
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_4_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_3_Q_181,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_4_Q_180,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_4_Q_179
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_4_Q : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_12_326,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_13_327,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_14_328,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_4_Q_180
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_3_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_2_Q_183,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_3_Q_182,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_3_Q_181
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_3_Q : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_9_323,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_10_324,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_11_325,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_3_Q_182
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_2_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_1_Q_185,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_2_Q_184,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_2_Q_183
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_2_Q : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_6_320,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_7_321,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_8_322,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_2_Q_184
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_1_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_0_Q_187,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_1_Q_186,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_1_Q_185
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_1_Q : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_3_317,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_4_318,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_5_319,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_1_Q_186
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_0_Q : MUXCY
    port map (
      CI => N0,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_0_Q_188,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_cy_0_Q_187
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_0_Q : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_0_314,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_1_315,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_2_316,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcompar_frame_count_16_frame_locate_16_equal_32_o_lut_0_Q_188
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_16 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(16),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_15 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(15),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_14 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(14),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_13 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(13),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_12 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(12),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_11 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(11),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_10 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(10),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_9 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(9),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_8 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(8),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_7 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(7),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_6 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(6),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_5 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(5),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_4 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(4),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_3 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(3),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_2 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(2),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_1 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(1),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_0 : FDSE
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result(0),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_7_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_6_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_5_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_4_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_3_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_2_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_1_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_Result_0_1,
      R => NlwRenamedSignal_status_heartbeat,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_flm : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count_16_frame_locate_16_equal_32_o,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_flm_386
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_sbe : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_eccerrsingle,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_sbe_296
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_16 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_0_314
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_1_315
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_3_317
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_4_318
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_2_316
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_5_319
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_6_320
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o,
      D => NlwRenamedSig_OI_monitor_txdata(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_7_321
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_8_322
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_9_323
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_10_324
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_12_326
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_13 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_13_327
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_11_325
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_14 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_14_328
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_15 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o,
      D => NlwRenamedSig_OI_monitor_txdata(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_15_329
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_status_reg_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o,
      D => NlwRenamedSig_OI_monitor_txdata(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_16 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_15 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_14 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_13 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_12 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_11 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_10 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_total_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synword(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synbit(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synbit(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synbit(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synbit(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_synbit(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_12 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(12),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_11 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(11),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(10),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(9),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(8),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event,
      D => fecc_syndrome(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_23 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(23),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(23)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_22 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(22),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(22)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_21 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(21),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(21)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_20 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(20),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(20)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_19 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(19),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(19)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_18 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(18),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(18)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_17 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(17),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(17)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_16 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(16),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_15 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(15),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_14 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(14),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_13 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(13),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_12 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(12),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_11 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(11),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_10 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(10),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_9 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(9),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_8 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(8),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_7 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(7),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_6 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(6),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_5 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(5),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_4 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(4),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_3 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(3),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_2 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(2),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_1 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(1),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap_0 : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => NlwRenamedSignal_status_heartbeat,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(0),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_long_gap : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6_PWR_7_o_equal_16_o,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_23 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(23),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(23)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_22 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(22),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(22)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_21 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(21),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(21)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_20 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(20),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(20)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_19 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(19),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(19)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_18 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(18),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(18)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_17 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(17),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(17)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_16 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(16),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_15 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(15),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_14 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(14),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_13 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(13),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_12 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(12),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_11 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(11),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_10 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(10),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_9 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(9),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_8 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(8),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_7 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(7),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_6 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(6),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_5 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(5),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_4 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(4),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_3 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(3),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(2),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(1),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly_0 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => fecc_far(0),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_10_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_9_Q_477,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_10_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_10_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_9_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_8_Q_478,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_9_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_9_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_9_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_8_Q_478,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_9_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_9_Q_477
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_8_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_7_Q_479,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_8_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_8_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_8_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_7_Q_479,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_8_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_8_Q_478
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_7_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_6_Q_480,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_7_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_7_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_7_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_6_Q_480,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_7_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_7_Q_479
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_6_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_5_Q_481,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_6_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_6_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_6_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_5_Q_481,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_6_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_6_Q_480
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_5_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_4_Q_482,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_5_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_5_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_5_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_4_Q_482,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_5_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_5_Q_481
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_4_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_3_Q_483,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_4_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_4_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_4_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_3_Q_483,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_4_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_4_Q_482
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_3_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_2_Q_484,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_3_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_3_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_3_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_2_Q_484,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_3_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_3_Q_483
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_2_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_1_Q_486,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_2_Q_485,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_2_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_2_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_1_Q_486,
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_2_Q,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_2_Q_485,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_2_Q_484
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_1_Q : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_0_Q_487,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_1_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_1_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_1_Q : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_0_Q_487,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_1_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_1_Q_486
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_xor_0_Q : XORCY
    port map (
      CI => N1,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_0_Q_488,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_0_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_0_Q : MUXCY
    port map (
      CI => N1,
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_0_Q,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_0_Q_488,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_cy_0_Q_487
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_10_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_9_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_8 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_8_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_7 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_7_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_6_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_5_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_4_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_3_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_2_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_7 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_6 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_5 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv,
      D => NlwRenamedSig_OI_monitor_txdata(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_1_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_sta_ptr_10_mux_11_OUT_0_Q,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_8 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv,
      D => NlwRenamedSig_OI_monitor_txdata(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_8_583
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_9 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv,
      D => NlwRenamedSig_OI_monitor_txdata(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_9_584
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_10 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv,
      D => NlwRenamedSig_OI_monitor_txdata(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_10_585
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero_cymux : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero_carry,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero_muxcy : MUXCY
    port map (
      CI => N0,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_xor : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(3),
      LI => N1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_fast_route
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero_lut : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(6),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero_lut : LUT4
    generic map(
      INIT => X"0001"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_zero
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity_xor : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity_carry,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_parity,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity_muxcy : MUXCY
    port map (
      CI => N0,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_parity,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_high : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(8),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_8 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(7),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_8 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(7),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_7 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(6),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_7 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(6),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_6 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(5),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_6 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(5),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_5 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(4),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_5 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(4),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_4 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_4 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(3),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_3 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_3 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(2),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_2 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_2 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(1),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_1 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_1 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(0),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_xor : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_carry,
      LI => N1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_fast_route
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_xor_4 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_xor_3 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_xor_2 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_xor_1 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_xor_0 : XORCY
    port map (
      CI => N1,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_xor_0 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_muxcy_0 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value_carry(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_7 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(6),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_out_xor : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(7),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_invert_arith_carry,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_out
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_6 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(5),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_5 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(4),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_4 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_3 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_2 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_1 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_xor_0 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in,
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in_muxcy : MUXCY
    port map (
      CI => N0,
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry_in,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_high : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(8),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_8 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(7),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_8 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(7),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_7 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(6),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_7 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(6),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_6 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(5),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_6 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(5),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_5 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(4),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_5 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(4),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_4 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(3),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_4 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(3),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_3 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(2),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_3 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(2),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_2 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(1),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_2 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(1),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_1 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(0),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_1 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(0),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_parity_muxcy : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(2),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_parity,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_muxcy_3 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(2),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_muxcy_2 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(1),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_muxcy_1 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(0),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_muxcy_0 : MUXCY
    port map (
      CI => N1,
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address_carry(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_7 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(7),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_6 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(6),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(6),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_5 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(5),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_4 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(4),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_3 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(3),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_2 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(2),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_1 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(1),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5_0 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(0),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_muxcy : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(1),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_muxcy : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(0),
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_carry,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_7 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_6 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(6),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_5 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_4 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_parity_lut : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(6),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_parity
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_3 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_2 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_1 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_or_lut_0 : LUT3
    generic map(
      INIT => X"FE"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_group(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_parity_lut : LUT4
    generic map(
      INIT => X"6996"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_parity
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_7 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(6),
      DI => NlwRenamedSig_OI_monitor_txdata(7),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_6 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(5),
      DI => NlwRenamedSig_OI_monitor_txdata(6),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_5 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(4),
      DI => NlwRenamedSig_OI_monitor_txdata(5),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_4 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(3),
      DI => NlwRenamedSig_OI_monitor_txdata(4),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_3 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(2),
      DI => NlwRenamedSig_OI_monitor_txdata(3),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_2 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(1),
      DI => NlwRenamedSig_OI_monitor_txdata(2),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_1 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(0),
      DI => NlwRenamedSig_OI_monitor_txdata(1),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_muxcy_0 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in,
      DI => NlwRenamedSig_OI_monitor_txdata(0),
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_internal_carry(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_9 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(9),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_8 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(8),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_7 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_4 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_3 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_2 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_value_select_mux_0 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_address(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_value(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_cymux : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_zero_carry,
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_zero,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_zero,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_muxcy : MUXCY
    port map (
      CI => N1,
      DI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_carry,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_carry,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_carry(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_inv : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_lut_4 : LUT4
    generic map(
      INIT => X"A999"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_lut_3 : LUT4
    generic map(
      INIT => X"A999"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_lut_2 : LUT4
    generic map(
      INIT => X"A999"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_lut_1 : LUT4
    generic map(
      INIT => X"A999"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_count_lut_0 : LUT4
    generic map(
      INIT => X"6555"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_push_or_pop_type,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_stack_address(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_inv : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable_lut : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_write,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_invert_enable : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_enable_lut : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_write,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_pulse_lut : LUT4
    generic map(
      INIT => X"0080"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_clean_int,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_pulse
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state_lut : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_t_state
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_7 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => NlwRenamedSig_OI_monitor_txdata(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => NlwRenamedSig_OI_monitor_txdata(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_4 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => NlwRenamedSig_OI_monitor_txdata(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_3 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => NlwRenamedSig_OI_monitor_txdata(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_2 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => NlwRenamedSig_OI_monitor_txdata(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => NlwRenamedSig_OI_monitor_txdata(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_mux_lut_0 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in,
      I2 => NlwRenamedSig_OI_monitor_txdata(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry_lut : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => NlwRenamedSig_OI_monitor_txdata(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry_value
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in_muxf5 : MUXF5
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_shift_in,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_shift_in,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_in
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_shift_in_lut : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag,
      I2 => NlwRenamedSig_OI_monitor_txdata(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_low_shift_in
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_7 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_4 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_3 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_2 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_mux_lut_0 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_group(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_xor_0 : XORCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      LI => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_vector(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_muxcy_0 : MUXCY
    port map (
      CI => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      DI => N1,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector_carry(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_7 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_4 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_3 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_2 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_move_lut : LUT2
    generic map(
      INIT => X"D"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_condition_met,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_valid_to_move
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count_lut : LUT3
    generic map(
      INIT => X"2F"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_condition_met,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_move_group,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_normal_count
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_condition_met_lut : LUT4
    generic map(
      INIT => X"5A3C"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_flag,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_condition_met
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_7 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_out_lut : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_invert_arith_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_6 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(6),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_5 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_4 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_3 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_2 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_1 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_lut_0 : LUT3
    generic map(
      INIT => X"96"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_half_arith(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_in_lut : LUT3
    generic map(
      INIT => X"6C"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry_in
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_7 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(7),
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_6 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_second_operand(6),
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_5 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_4 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_3 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_2 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_1 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_lut_0 : LUT4
    generic map(
      INIT => X"6E8A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable_lut : LUT4
    generic map(
      INIT => X"8000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_write,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_shift_in_lut : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(1),
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_high_shift_in
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_operand_select_mux_0 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_value_lut : LUT3
    generic map(
      INIT => X"04"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_interrupt_ack_internal,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable_value
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_inv : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_carry_lut : LUT2
    generic map(
      INIT => X"3"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_carry,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_io_decode_lut : LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_io_initial_decode
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry_lut : LUT3
    generic map(
      INIT => X"F3"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_zero_lut : LUT3
    generic map(
      INIT => X"3F"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_zero,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shadow_zero
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_read_active_lut : LUT4
    generic map(
      INIT => X"0100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_io_initial_decode,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_read_active
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_write_active_lut : LUT4
    generic map(
      INIT => X"4000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_io_initial_decode,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_write_active
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_fetch_type_lut : LUT4
    generic map(
      INIT => X"0002"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_fetch_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith_lut : LUT3
    generic map(
      INIT => X"1F"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical_lut : LUT4
    generic map(
      INIT => X"FFE2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_type_lut : LUT4
    generic map(
      INIT => X"0400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_type_lut : LUT4
    generic map(
      INIT => X"0145"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_9 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_8 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_7 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_4 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_3 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_2 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_1 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_vector_select_mux_0 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_vector(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_carry_lut : LUT2
    generic map(
      INIT => X"C"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_parity_lut : LUT4
    generic map(
      INIT => X"F3FF"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_parity,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_parity
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_type_lut : LUT4
    generic map(
      INIT => X"41FC"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_push_pop_lut : LUT4
    generic map(
      INIT => X"5400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_push_or_pop_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type_lut : LUT4
    generic map(
      INIT => X"1000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_call_type
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_move_group_lut : LUT4
    generic map(
      INIT => X"7400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_move_group
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_update_lut : LUT4
    generic map(
      INIT => X"EAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_update_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_9 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(9),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_8 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(8),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_7 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_6 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(6),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_5 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(5),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_4 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(4),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_3 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(3),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_2 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(2),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_1 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(1),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_bit_0 : RAM32X1S
    generic map(
      INIT => X"00000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_address(0),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_write_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_7 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_6 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(6),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_5 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(5),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_4 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(4),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_3 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(3),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_2 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(2),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_1 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(1),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_bit_0 : RAM64X1S
    generic map(
      INIT => X"0000000000000000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      A4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      A5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      D => NlwRenamedSig_OI_monitor_txdata(0),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_enable,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_7 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(7),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(7),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_6 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(6),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(6),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_5 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(5),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(5),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_4 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(4),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(4),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_3 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(3),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(3),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_2 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(2),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(2),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_1 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(1),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(1),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_reg_loop_register_bit_0 : RAM16X1D
    generic map(
      INIT => X"0000"
    )
    port map (
      A0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8),
      A1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9),
      A2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10),
      A3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11),
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_alu_result(0),
      DPRA0 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4),
      DPRA1 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5),
      DPRA2 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6),
      DPRA3 => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7),
      WCLK => icap_clk,
      WE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_enable,
      SPO => NlwRenamedSig_OI_monitor_txdata(0),
      DPO => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sy(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_loop_register_bit_4 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_loop_register_bit_3 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_loop_register_bit_2 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_loop_register_bit_1 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_count_loop_register_bit_0 : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_next_stack_address(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_address(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_9 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(9),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_8 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(8),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_7 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(7),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_6 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(6),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_5 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(5),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_4 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(4),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_3 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(3),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(2),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(1),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_flop_0 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_ram_data(0),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_stack_pop_data(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_read_strobe_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_read_active,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_read_strobe
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_write_strobe_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_write_active,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group_flop : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_input_fetch_type,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_group
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry_out,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_7 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_flop_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_value(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_arith,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_arith_result(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_7 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_flop_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_value(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_shift,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_result(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pipeline_bit : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry_value,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shift_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_7 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(7),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(6),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(5),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(4),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(3),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(2),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(1),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_flop_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_value(0),
      R => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_sel_logical,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_logical_result(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_7 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(7),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_6 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(6),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_5 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(5),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_4 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(4),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_3 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(3),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_2 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(2),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_1 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(1),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_flop_0 : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_data(0),
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_store_data(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_write_flop : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_type,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_memory_write
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_write_flop : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_type,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_register_write
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag_flop : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_enable,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_fast_route,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_flag_flop : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_enable,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_fast_route,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_flag
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_write_flop : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_type,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_flag_write
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable_flop : FDRE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_update_enable,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable_value,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_enable
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_zero_flop : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_zero_flag,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_zero
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_carry_flop : FDE
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      CE => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_carry_flag,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_shadow_carry
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_ack_flop : FD
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_interrupt_ack_internal
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_pulse,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_int_capture_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => N1,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_clean_int
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_toggle_flop : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_not_t_state,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_t_state
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o11 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_24_o_6_1 : LUT6
    generic map(
      INIT => X"0002000000000000"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(6),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_24_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1 : LUT6
    generic map(
      INIT => X"0002000000000000"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_6_o_4_1 : LUT6
    generic map(
      INIT => X"0000080000000000"
    )
    port map (
      I0 => NlwRenamedSig_OI_monitor_txdata(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_6_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_monitor_txwrite1 : LUT5
    generic map(
      INIT => X"02000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => monitor_txwrite
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_25_o1 : LUT5
    generic map(
      INIT => X"40000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_25_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_26_o1 : LUT5
    generic map(
      INIT => X"80000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o1_151,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_26_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o2 : LUT3
    generic map(
      INIT => X"10"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o11 : LUT5
    generic map(
      INIT => X"00000004"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_2_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_3_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel_5_1 : LUT4
    generic map(
      INIT => X"0010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction19 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction21 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(10),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(10),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(10)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction31 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(11),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(11),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(11)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(12),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(12)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction51 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(13),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(13)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction61 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(14),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(14)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction71 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(15),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(15)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(16),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(16)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction91 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(17),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(17)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction101 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction111 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction121 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction131 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction141 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction151 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction161 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction171 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(8),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_Mmux_instruction181 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(9),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_instruction(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event1 : LUT3
    generic map(
      INIT => X"08"
    )
    port map (
      I0 => fecc_eccerr,
      I1 => NlwRenamedSignal_status_heartbeat,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_275,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_first_ecc_event
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_wea31 : LUT6
    generic map(
      INIT => X"04000000AEAAAAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_wea41 : LUT6
    generic map(
      INIT => X"40000000EAAAAAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_wea21 : LUT6
    generic map(
      INIT => X"04000000AEAAAAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_wea11 : LUT6
    generic map(
      INIT => X"01000000ABAAAAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_go1 : LUT5
    generic map(
      INIT => X"40000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_go
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc11 : LUT3
    generic map(
      INIT => X"E0"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_read_strobe,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A21 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101_475,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_10_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101_475,
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_8_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A111 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101_475,
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_9_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A11 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_0_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A31 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_1_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_2_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A51 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3),
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_3_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A61 : LUT3
    generic map(
      INIT => X"AC"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4),
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_4_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A71 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_5_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_6_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A91 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_A_7_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_icap_csb11 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_35_Q,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      O => icap_csb
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_icap_rdwrb11 : LUT2
    generic map(
      INIT => X"B"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_26_Q,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      O => icap_rdwrb
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra11 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      I2 => NlwRenamedSig_OI_icap_i(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra21 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3),
      I2 => NlwRenamedSig_OI_icap_i(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra31 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4),
      I2 => NlwRenamedSig_OI_icap_i(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5),
      I2 => NlwRenamedSig_OI_icap_i(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra51 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6),
      I2 => NlwRenamedSig_OI_icap_i(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra61 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7),
      I2 => NlwRenamedSig_OI_icap_i(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra71 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8),
      I2 => NlwRenamedSig_OI_icap_i(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580,
      I2 => NlwRenamedSig_OI_icap_i(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_addra91 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581,
      I2 => NlwRenamedSig_OI_icap_i(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina110 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => icap_o(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_0_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina210 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => icap_o(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_10_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina33 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => icap_o(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_11_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina41 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => icap_o(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_12_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina51 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => icap_o(11),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_13_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina61 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => icap_o(10),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_14_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina71 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => icap_o(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_15_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina81 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => icap_o(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_16_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina91 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => icap_o(23),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_18_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina101 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => icap_o(22),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_19_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina111 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => icap_o(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_1_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina121 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => icap_o(21),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_20_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina131 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => icap_o(20),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_21_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina141 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => icap_o(19),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_22_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina151 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => icap_o(18),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_23_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina161 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => icap_o(17),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_24_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina171 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => icap_o(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_25_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina181 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => icap_o(31),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_27_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina191 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(1),
      I2 => icap_o(30),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_28_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina201 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => icap_o(29),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_29_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina211 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(2),
      I2 => icap_o(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_2_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina221 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => icap_o(28),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_30_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina231 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => icap_o(27),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_31_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina241 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => icap_o(26),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_32_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina251 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => icap_o(25),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_33_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina261 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => icap_o(24),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_34_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina271 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(3),
      I2 => icap_o(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_3_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina281 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(4),
      I2 => icap_o(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_4_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina291 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(5),
      I2 => icap_o(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_5_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina301 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(6),
      I2 => icap_o(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_6_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina311 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(7),
      I2 => icap_o(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_7_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_dina321 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_ctl_ena_586,
      I1 => NlwRenamedSig_OI_monitor_txdata(0),
      I2 => icap_o(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_9_Q
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_monitor_rxread_SW0 : LUT2
    generic map(
      INIT => X"8"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_read_strobe,
      O => N2
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_monitor_rxread : LUT6
    generic map(
      INIT => X"0002000000000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I5 => N2,
      O => monitor_rxread
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_1 : LUT5
    generic map(
      INIT => X"FD75A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(7),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(7),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_1_871
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_2 : LUT6
    generic map(
      INIT => X"5D4D5C4C19091808"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(7),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_276,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_1_871,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_2_872
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_3 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(23),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(23),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(15),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_3_873
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_4 : LUT5
    generic map(
      INIT => X"A8202020"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_3_873,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_4_874
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_5 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(8),
      I3 => NlwRenamedSig_OI_icap_i(24),
      I4 => NlwRenamedSig_OI_icap_i(16),
      I5 => NlwRenamedSig_OI_icap_i(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_5_875
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_6 : LUT6
    generic map(
      INIT => X"AAAACCCCF0F0FF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_5_875,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_6_876
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_10 : LUT6
    generic map(
      INIT => X"5551151144400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_4_874,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_2_872,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9_877,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0),
      I5 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_1_878
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_5 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(16),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_flm_386,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_5_880
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_6 : LUT6
    generic map(
      INIT => X"FFFFFBEAFFFF5140"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(8),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_5_880,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_6_881
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_7 : LUT4
    generic map(
      INIT => X"5410"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => monitor_txfull,
      I3 => monitor_rxdata(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_7_882
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_8 : LUT6
    generic map(
      INIT => X"F7E65544B3A21100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_7_882,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_1_878,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_6_881,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_4_879,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_8_883
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_9 : LUT5
    generic map(
      INIT => X"FD75A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_9_884
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_10 : LUT6
    generic map(
      INIT => X"FFFFFBEAFFFF5140"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_9_884,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_10_885
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_11 : LUT6
    generic map(
      INIT => X"22200200AAAAAAAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_10_885,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(8),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(16),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_11_886
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_12 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(16),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(16),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(8),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_12_887
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_13 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(0),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_12_887,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_13_888
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_14 : LUT6
    generic map(
      INIT => X"5551151144400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_13_888,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_11_886,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_8_883,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(17),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(17),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(9),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_1_889
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_2 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_1_889,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_2_890
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => NlwRenamedSig_OI_icap_i(6),
      I2 => NlwRenamedSig_OI_icap_i(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_6_892
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_7 : LUT6
    generic map(
      INIT => X"AAAAAAAAF7D5A280"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I2 => NlwRenamedSig_OI_icap_i(30),
      I3 => NlwRenamedSig_OI_icap_i(22),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_6_892,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_7_893
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_8 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_7_893,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_8_894
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_9 : LUT6
    generic map(
      INIT => X"1154005411100010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_9_895
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_10 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => monitor_rxempty,
      I2 => monitor_rxdata(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_10_896
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_11 : LUT6
    generic map(
      INIT => X"5554454411100100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(9),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_10_896,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_11_897
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_12 : LUT4
    generic map(
      INIT => X"F5E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_9_895,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_11_897,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_8_894,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_12_898
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_13 : LUT6
    generic map(
      INIT => X"5551151144400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_2_890,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5_891,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_12_898,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(13),
      I3 => NlwRenamedSig_OI_icap_i(29),
      I4 => NlwRenamedSig_OI_icap_i(21),
      I5 => NlwRenamedSig_OI_icap_i(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_1_899
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_2 : LUT6
    generic map(
      INIT => X"AAAAF0F0CCCCFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_1_899,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_2_900
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_3 : LUT5
    generic map(
      INIT => X"5E0E5404"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_3_901
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_4 : LUT6
    generic map(
      INIT => X"5150414011100100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(2),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(10),
      I5 => monitor_rxdata(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_4_902
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_5 : LUT6
    generic map(
      INIT => X"5554111045440100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_3_901,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_4_902,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_2_900,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_5_903
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_6_904
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_7 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(10),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_6_904,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(2),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_7_905
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_8 : LUT6
    generic map(
      INIT => X"A22AA22280088000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(10),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_7_905,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_8_906
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9_907
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_10 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(18),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(18),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(10),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(10),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_10_908
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_11 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9_907,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(2),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(2),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_10_908,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_11_909
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_12 : LUT5
    generic map(
      INIT => X"55554440"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_11_909,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_8_906,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_5_903,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(12),
      I3 => NlwRenamedSig_OI_icap_i(28),
      I4 => NlwRenamedSig_OI_icap_i(20),
      I5 => NlwRenamedSig_OI_icap_i(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_1_910
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_2 : LUT6
    generic map(
      INIT => X"A0A0C0C00000F000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_1_910,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_2_911
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_3 : LUT6
    generic map(
      INIT => X"1154005411100010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_3_912
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_4 : LUT6
    generic map(
      INIT => X"5150414011100100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(11),
      I5 => monitor_rxdata(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_4_913
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_5 : LUT5
    generic map(
      INIT => X"51515140"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_4_913,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_3_912,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_2_911,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_5_914
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_6_915
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_7 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(11),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_6_915,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(3),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_7_916
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_8 : LUT6
    generic map(
      INIT => X"A22AA22280088000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(11),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_7_916,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_8_917
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_10 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(19),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(19),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(11),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(11),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_10_918
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_11 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9_907,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(3),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_10_918,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_11_919
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_12 : LUT5
    generic map(
      INIT => X"55554440"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_11_919,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_8_917,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_3_5_914,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(20),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(20),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(12),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_1_920
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_2 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(4),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_1_920,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_2_921
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_6 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(11),
      I3 => NlwRenamedSig_OI_icap_i(27),
      I4 => NlwRenamedSig_OI_icap_i(19),
      I5 => NlwRenamedSig_OI_icap_i(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_6_923
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_7 : LUT6
    generic map(
      INIT => X"CCCCF0F0AAAAFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_8_583,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_6_923,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_7_924
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_8 : LUT5
    generic map(
      INIT => X"5E0E5404"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_8_925
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_9 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_9_926
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_10 : LUT6
    generic map(
      INIT => X"7632101054101010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_9_926,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_277,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I5 => monitor_rxdata(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_10_927
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_11 : LUT5
    generic map(
      INIT => X"FE54BA10"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_8_925,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_10_927,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_7_924,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_11_928
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_12 : LUT6
    generic map(
      INIT => X"5551151144400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_2_921,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5_922,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_11_928,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_1 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(9),
      I3 => NlwRenamedSig_OI_icap_i(25),
      I4 => NlwRenamedSig_OI_icap_i(17),
      I5 => NlwRenamedSig_OI_icap_i(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_1_929
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_2 : LUT6
    generic map(
      INIT => X"CCCCF0F0AAAAFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_10_585,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_1_929,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_2_930
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_3 : LUT5
    generic map(
      INIT => X"5E0E5404"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_3_931
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_4 : LUT6
    generic map(
      INIT => X"5150414011100100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(6),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(14),
      I5 => monitor_rxdata(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_4_932
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_5 : LUT6
    generic map(
      INIT => X"5554111045440100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_3_931,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_4_932,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_2_930,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_5_933
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_6 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_6_934
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_7 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(14),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_6_934,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(6),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_275,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_7_935
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_8 : LUT6
    generic map(
      INIT => X"A222222280000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => icap_grant,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_7_935,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_8_936
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_10 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(22),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(22),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(14),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_10_937
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_11 : LUT6
    generic map(
      INIT => X"AAA22A2288800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_2_9_907,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(6),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(6),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_10_937,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_11_938
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_12 : LUT5
    generic map(
      INIT => X"55554440"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_11_938,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_8_936,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_6_5_933,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port461 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(21),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(21),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(13),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port46
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port462 : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port461_940
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port463 : LUT6
    generic map(
      INIT => X"9991191188800800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_sbe_296,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(5),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port461_940,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port462_941
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port464 : LUT6
    generic map(
      INIT => X"AA2AA8288A0A8808"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => monitor_rxdata(5),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(5),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port463_942
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port465 : LUT6
    generic map(
      INIT => X"5DFF5D5508FF0800"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port46,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port462_941,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port463_942,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port464_943
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port466 : LUT5
    generic map(
      INIT => X"FD75A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(5),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(5),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port465_944
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port467 : LUT6
    generic map(
      INIT => X"6662262244400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synwd(5),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(5),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port465_944,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port466_945
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port468 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(10),
      I3 => NlwRenamedSig_OI_icap_i(26),
      I4 => NlwRenamedSig_OI_icap_i(18),
      I5 => NlwRenamedSig_OI_icap_i(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port467_946
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port469 : LUT6
    generic map(
      INIT => X"CCCCF0F0AAAAFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_9_584,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port467_946,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port468_947
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4610 : LUT5
    generic map(
      INIT => X"BAAA1000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port468_947,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port469_948
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4611 : LUT6
    generic map(
      INIT => X"BF1FB111AF0FA000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(4),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port466_945,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port464_943,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port469_948,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4610_949
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4612 : LUT2
    generic map(
      INIT => X"4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_Mmux_in_port4610_949,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6_PWR_7_o_equal_16_o_6_SW0 : LUT2
    generic map(
      INIT => X"E"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(5),
      O => N4
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6_PWR_7_o_equal_16_o_6_Q : LUT6
    generic map(
      INIT => X"0002000000000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(2),
      I3 => N4,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_6_PWR_7_o_equal_16_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_10_585,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_8_583,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(2),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt9
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(5),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(6),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr_9_584,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91_952
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt93 : LUT6
    generic map(
      INIT => X"9009000000009009"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(7),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92_953
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt94 : LUT3
    generic map(
      INIT => X"80"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt9,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91_952,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92_953,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_glue_set_954,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_275
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_glue_set_955,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_277
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_glue_set_956,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_276
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_glue_set_957,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_9 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_9_glue_set_958,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(9)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_8 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_8_glue_set_959,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(8)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_7 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_7_glue_set_960,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(7)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_6 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_6_glue_set_961,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(6)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_5 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_5_glue_set_962,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(5)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_4 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_4_glue_set_963,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(4)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_3 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_3_glue_set_964,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(3)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_2 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_2_glue_set_965,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(2)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_1 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_1_glue_set_966,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(1)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_0 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_0_glue_set_967,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_address(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_6_rt_968
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_5_rt_969
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_4_rt_970
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_3_rt_971
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_2_rt_972
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_cy_1_rt_973
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_15_rt_974
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(14),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_14_rt_975
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(13),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_13_rt_976
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(12),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_12_rt_977
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(11),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_11_rt_978
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(10),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_10_rt_979
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(9),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_9_rt_980
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(8),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_8_rt_981
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_7_rt_982
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(6),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_6_rt_983
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(5),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_5_rt_984
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(4),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_4_rt_985
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(3),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_3_rt_986
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_2_rt_987
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_cy_1_rt_988
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_7_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_xor_7_rt_989
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_16_rt : LUT1
    generic map(
      INIT => X"2"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(16),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_xor_16_rt_990
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg_rstpot : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_26_o,
      I1 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg,
      I2 => NlwRenamedSig_OI_monitor_txdata(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg_rstpot_991
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg_rstpot_991,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_ireq_reg
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16 : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_rstpot_992,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_330
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_rstpot : LUT3
    generic map(
      INIT => X"E4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_25_o,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295,
      I2 => NlwRenamedSig_OI_monitor_txdata(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_rstpot_993
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg : FDR
    generic map(
      INIT => '0'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_rstpot_993,
      R => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_bank_sel_reg_295
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_0_Q : LUT6
    generic map(
      INIT => X"1E1EF0F011EEFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_read_strobe,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I3 => NlwRenamedSig_OI_monitor_txdata(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_0_Q_488
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A121 : LUT6
    generic map(
      INIT => X"FFFFFFFFFDFFFFFF"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc4,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_4 : LUT6
    generic map(
      INIT => X"AAAAF0F0CCCCFF00"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_end_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I3 => N6,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_4_879
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh11 : LUT6
    generic map(
      INIT => X"0000000000000010"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(2),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(4),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_0_3_SW0 : LUT6
    generic map(
      INIT => X"FD75B931EC64A820"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(1),
      I2 => NlwRenamedSig_OI_icap_i(15),
      I3 => NlwRenamedSig_OI_icap_i(31),
      I4 => NlwRenamedSig_OI_icap_i(23),
      I5 => NlwRenamedSig_OI_icap_i(7),
      O => N6
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_glue_set : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_long_gap_387,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_6_o,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_277,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_frame_eos_glue_set_955
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_glue_set : LUT3
    generic map(
      INIT => X"BA"
    )
    port map (
      I0 => fecc_crcerr,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_22_o,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_276,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_crc_glue_set_956
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_9_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(9),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(9),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_9_glue_set_958
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_8_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(8),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(8),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_8_glue_set_959
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_7_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(7),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(7),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_7_glue_set_960
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_6_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(6),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(6),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_6_glue_set_961
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_5_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(5),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(5),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_5_glue_set_962
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_4_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_4_glue_set_963
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_3_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_3_glue_set_964
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_2_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(2),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_2_glue_set_965
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_1_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_1_glue_set_966
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_0_glue_set : LUT4
    generic map(
      INIT => X"FFE4"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_enable,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_address(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_inc_pc_value(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_active_interrupt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_kcpsm3_pc_loop_register_bit_0_glue_set_967
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_rstpot : LUT5
    generic map(
      INIT => X"EAAA2AAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_330,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_1_o1,
      I4 => NlwRenamedSig_OI_monitor_txdata(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_frame_locate_16_rstpot_992
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A1011 : LUT6
    generic map(
      INIT => X"FFFFFFFFFFFFDFFF"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc4,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A101_475
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv1 : LUT6
    generic map(
      INIT => X"8000800000008000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0291_inv
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_2_Q : LUT6
    generic map(
      INIT => X"CCCCFF00C6C6F50A"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt,
      I3 => NlwRenamedSig_OI_monitor_txdata(2),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_A12,
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc1,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Mmux_sta_ptr_10_sta_ptr_10_mux_11_OUT_rs_lut_2_Q_485
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_glue_set : LUT4
    generic map(
      INIT => X"7222"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_275,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_ws_pid_5_AND_24_o,
      I2 => NlwRenamedSignal_status_heartbeat,
      I3 => fecc_eccerr,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_ecc_glue_set_954
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv1 : LUT6
    generic map(
      INIT => X"0002000000000000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_dbuf_sel,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc4,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_Sh1,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_port_id(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_write_strobe,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_n0258_inv
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc41 : LUT4
    generic map(
      INIT => X"2AAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt9,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91_952,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92_953,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_inc4
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_glue_set : LUT5
    generic map(
      INIT => X"FFFF2AAA"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_582,
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt9,
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt91_952,
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_halt92_953,
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_go,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_burst_glue_set_957
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5 : MUXF7
    port map (
      I0 => N8,
      I1 => N9,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5_891
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5_F : LUT5
    generic map(
      INIT => X"5E0E5404"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(9),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(1),
      O => N8
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_1_5_G : LUT6
    generic map(
      INIT => X"7773373366622622"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I2 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(1),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(1),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(9),
      O => N9
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5 : MUXF7
    port map (
      I0 => N10,
      I1 => N11,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5_922
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5_F : LUT5
    generic map(
      INIT => X"5E0E5404"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_synbt(4),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(12),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_syn(12),
      O => N10
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_4_5_G : LUT6
    generic map(
      INIT => X"5551151144400400"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => NlwRenamedSig_OI_U0_wrapper_wrapper_genv6_wrapper_controller_status_reg(4),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_dly(4),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_fecc_far_cap(4),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_rdbk_efcr(4),
      O => N11
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9 : MUXF7
    port map (
      I0 => N12,
      I1 => N13,
      S => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(2),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9_877
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9_F : LUT6
    generic map(
      INIT => X"BEAEBAAA14041000"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(7),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(15),
      I5 => U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_6_876,
      O => N12
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_in_port_7_9_G : LUT6
    generic map(
      INIT => X"5150414011100100"
    )
    port map (
      I0 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(1),
      I1 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(3),
      I2 => U0_wrapper_wrapper_genv6_wrapper_controller_pid_reg(0),
      I3 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(7),
      I4 => U0_wrapper_wrapper_genv6_wrapper_controller_frame_total(15),
      I5 => monitor_rxdata(7),
      O => N13
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_init_sync_a : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      D => N1,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_a
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_init_sync_b : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_a,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_b
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_init_sync_c : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_b,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_c
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_init_sync_d : FD
    generic map(
      INIT => '1'
    )
    port map (
      C => icap_clk,
      D => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_c,
      Q => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_lut_0_INV_0 : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_word_count_lut(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_lut_0_INV_0 : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_frame_count(0),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_Mcount_frame_count_lut(0)
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv1_INV_0 : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_word_count(7),
      O => U0_wrapper_wrapper_genv6_wrapper_controller_word_count_7_inv
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_b_ena1_INV_0 : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_ssi_init_c,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_b_ena
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_sync_init_INV_10_o1_INV_0 : INV
    port map (
      I => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      O => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_sync_init_INV_10_o
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18 : RAMB18E1
    generic map(
      INITP_00 => X"76A0CA0FD37D3CCFFFCFFFFF7FFF4D57F76AA832803FD34F4D3F33778FFFFF8F",
      INITP_01 => X"3C15400CBFEFFBFEF3FF3FBCCCFFCCCFEFFBFFFFDBFFFF6FFF4CFCDF3F3DFF5F",
      INITP_02 => X"00000000002D2D28A2D2D23CFFCFED75EA8000A0B580A0AEEEEEEC2D55400333",
      INITP_03 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INITP_05 => X"B4AA0A5ED0A69003000000000000000000000000000000000000000000000000",
      INITP_06 => X"888C88C88C88C88BC302CB2CB3888BFFE30FFE30820FBFDEFFE5DAAAA8BFFCB4",
      INITP_07 => X"EBCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCB00C2FBEFBFA2200EAAEA88A88B4B",
      INIT_00 => X"CF1E0F01401540154015401540154015401540154015C000CF1E0F0040154015",
      INIT_01 => X"40016003505E2002401E401A031B033A001F0330006050674008501B4004C000",
      INIT_02 => X"CB0A0AEC0B020E000F00011300F203AB5C464060600650462001401E0346505E",
      INIT_03 => X"03AE54414F0154414E43CC08CE09CF0ACD08CA09CB0AFCD04D0E01554C08CA09",
      INIT_04 => X"4002405302DE012403AE02E103AB544F40086003402FAF008E01AB008A014053",
      INIT_05 => X"00E1009A015D03564063A0DF032A00EB013000E1009A015D0356405C405C5452",
      INIT_06 => X"5C8540606006548A2020032A508A2004401E4002033A00080330C020032A00EB",
      INIT_07 => X"4F0154824E43CD08CE09CF0ABDC04C0E01554D08CE09CF0A0E000F00011300F0",
      INIT_08 => X"A0BF032A40910330C040032A508E250100EB013000E64074AF008E0140855482",
      INIT_09 => X"03CE03D003CE54A3470267034095000040020321033A000254982020032A0330",
      INIT_0A => X"54BA4708A00000BF03BA03D403E203BC03CE03D003EC54AE4704A00000BF03BA",
      INIT_0B => X"03E6A00003BA03CC03EA03CCA00000D400BF03BA03DC03E403BC03CE03D003EC",
      INIT_0C => X"030460080304600903BC03C803DE03BA03046004030460050304600603BC03C8",
      INIT_0D => X"03BA0304600B03BC03EE03CA03BC0304600A03BC03CE03F4A00003BA03046007",
      INIT_0E => X"A00003BA03CE03E203D0A00003BA03C803DE03CCA00003BA03EA03E403CCA000",
      INIT_0F => X"4C0E015501170B000A04AF00AE00AD009CA04F274E264D254C240A0040F30A04",
      INIT_10 => X"CA01AF00BE60BD509C406609650864070B010A434F0E01554E0E01554D0E0155",
      INIT_11 => X"0159CC0E0159CD0E0159CE0E0159CF0E0159A00001170B010A44A0005D0BEB00",
      INIT_12 => X"A0005D2BE100C001C208020001010043C10AC00901000000A000CA0E0159CB0E",
      INIT_13 => X"1947080809080A080B0E06004B084A084908480805000700C10AC00901000000",
      INIT_14 => X"03BC03EE03CA03BC03051C7003BC03CE03F4A000553647518701553B46208601",
      INIT_15 => X"A000C01400E0A00055592010400CA00055552020400CA000C50103BA03051C60",
      INIT_16 => X"00000000000000000000A000516720014007A000516320104007A000C0070010",
      INIT_17 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_18 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_19 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1D => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1E => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_1F => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_20 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0500040000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"5AF2C0010101A007030002002008030002002010600B620A0300050204EC42E3",
      INIT_2F => X"A00056FC2002400CA000C008C209C30AF0104008C209C30AB350924042EE0106",
      INIT_30 => X"0C0601000C060100A00003FC0316030C03FC0316030C1C00A00057002001400C",
      INIT_31 => X"03BA03EE03DE03C803D6A000813081075B19410AA00001000C0601000C060100",
      INIT_32 => X"A000A01F4000A000A0604000432503D8A00003BC03C003E453284000032DA000",
      INIT_33 => X"03ECC100D100032AA11F11004343032A03BC03CC03D2C100D100032DA1601100",
      INIT_34 => X"A00003590C000382C00A00C4C00B00BBC00900A4A00003BA0304032D03BC03CC",
      INIT_35 => X"03860100008003930F000E000D00A00003590C0DA00003590C10A00003590C07",
      INIT_36 => X"C00900B8437F00C4C00B004FC0090034437F00C4C00B0077C009004CA0000368",
      INIT_37 => X"C00A00C2C00B0037C00900EC037F00C2C00B002FC0090094437F00F4C00B00FF",
      INIT_38 => X"C209023DC20A0204C108C008C2090255C20A0204A00057822080400AA0000382",
      INIT_39 => X"0004A0004F084E084D084C08039FA000CF08CE08CD08CC08039FA000C108C008",
      INIT_3A => X"037403B1A000036E03B1A00003680393A000039903620386A000C0090040C00A",
      INIT_3B => X"43FC015F43FC012043FC010DA00003A86C046D056E060F00038601000020A000",
      INIT_3C => X"43FC014443FC014343FC014243FC014143FC013643FC013343FC013643FC013E",
      INIT_3D => X"43FC014C43FC014B43FC014A43FC014943FC014843FC014743FC014643FC0145",
      INIT_3E => X"43FC015443FC015343FC015243FC015143FC015043FC014F43FC014E43FC014D",
      INIT_3F => X"43FFA000C10D030043FC015A43FC015943FC015843FC015743FC015643FC0155",
      INIT_A => X"00000",
      INIT_B => X"00000",
      INIT_FILE => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "VIRTEX6",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      DOA_REG => 0,
      DOB_REG => 0,
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18
    )
    port map (
      CLKARDCLK => icap_clk,
      CLKBWRCLK => icap_clk,
      ENARDEN => N1,
      ENBWREN => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_b_ena,
      REGCEAREGCE => N1,
      REGCEB => N1,
      RSTRAMARSTRAM => N1,
      RSTRAMB => N1,
      RSTREGARSTREG => N1,
      RSTREGB => N1,
      ADDRARDADDR(13) => N0,
      ADDRARDADDR(12) => N0,
      ADDRARDADDR(11) => N0,
      ADDRARDADDR(10) => N0,
      ADDRARDADDR(9) => N0,
      ADDRARDADDR(8) => N0,
      ADDRARDADDR(7) => N0,
      ADDRARDADDR(6) => N0,
      ADDRARDADDR(5) => N0,
      ADDRARDADDR(4) => N0,
      ADDRARDADDR(3) => N1,
      ADDRARDADDR(2) => N1,
      ADDRARDADDR(1) => N1,
      ADDRARDADDR(0) => N1,
      ADDRBWRADDR(13) => U0_wrapper_wrapper_genv6_wrapper_controller_address(9),
      ADDRBWRADDR(12) => U0_wrapper_wrapper_genv6_wrapper_controller_address(8),
      ADDRBWRADDR(11) => U0_wrapper_wrapper_genv6_wrapper_controller_address(7),
      ADDRBWRADDR(10) => U0_wrapper_wrapper_genv6_wrapper_controller_address(6),
      ADDRBWRADDR(9) => U0_wrapper_wrapper_genv6_wrapper_controller_address(5),
      ADDRBWRADDR(8) => U0_wrapper_wrapper_genv6_wrapper_controller_address(4),
      ADDRBWRADDR(7) => U0_wrapper_wrapper_genv6_wrapper_controller_address(3),
      ADDRBWRADDR(6) => U0_wrapper_wrapper_genv6_wrapper_controller_address(2),
      ADDRBWRADDR(5) => U0_wrapper_wrapper_genv6_wrapper_controller_address(1),
      ADDRBWRADDR(4) => U0_wrapper_wrapper_genv6_wrapper_controller_address(0),
      ADDRBWRADDR(3) => N1,
      ADDRBWRADDR(2) => N1,
      ADDRBWRADDR(1) => N1,
      ADDRBWRADDR(0) => N1,
      DIADI(15) => N0,
      DIADI(14) => N0,
      DIADI(13) => N0,
      DIADI(12) => N0,
      DIADI(11) => N0,
      DIADI(10) => N0,
      DIADI(9) => N0,
      DIADI(8) => N0,
      DIADI(7) => N0,
      DIADI(6) => N0,
      DIADI(5) => N0,
      DIADI(4) => N0,
      DIADI(3) => N0,
      DIADI(2) => N0,
      DIADI(1) => N0,
      DIADI(0) => N0,
      DIBDI(15) => N1,
      DIBDI(14) => N1,
      DIBDI(13) => N1,
      DIBDI(12) => N1,
      DIBDI(11) => N1,
      DIBDI(10) => N1,
      DIBDI(9) => N1,
      DIBDI(8) => N1,
      DIBDI(7) => N1,
      DIBDI(6) => N1,
      DIBDI(5) => N1,
      DIBDI(4) => N1,
      DIBDI(3) => N1,
      DIBDI(2) => N1,
      DIBDI(1) => N1,
      DIBDI(0) => N1,
      DIPADIP(1) => N0,
      DIPADIP(0) => N0,
      DIPBDIP(1) => N1,
      DIPBDIP(0) => N1,
      DOADO(15) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_15_UNCONNECTED,
      DOADO(14) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_14_UNCONNECTED,
      DOADO(13) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_13_UNCONNECTED,
      DOADO(12) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_12_UNCONNECTED,
      DOADO(11) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_11_UNCONNECTED,
      DOADO(10) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_10_UNCONNECTED,
      DOADO(9) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_9_UNCONNECTED,
      DOADO(8) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_8_UNCONNECTED,
      DOADO(7) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_7_UNCONNECTED,
      DOADO(6) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_6_UNCONNECTED,
      DOADO(5) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_5_UNCONNECTED,
      DOADO(4) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_4_UNCONNECTED,
      DOADO(3) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_3_UNCONNECTED,
      DOADO(2) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_2_UNCONNECTED,
      DOADO(1) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_1_UNCONNECTED,
      DOADO(0) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOADO_0_UNCONNECTED,
      DOBDO(15) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(15),
      DOBDO(14) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(14),
      DOBDO(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(13),
      DOBDO(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(12),
      DOBDO(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(11),
      DOBDO(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(10),
      DOBDO(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(9),
      DOBDO(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(8),
      DOBDO(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(7),
      DOBDO(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(6),
      DOBDO(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(5),
      DOBDO(4) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(4),
      DOBDO(3) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(3),
      DOBDO(2) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(2),
      DOBDO(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(1),
      DOBDO(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(0),
      DOPADOP(1) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOPADOP_1_UNCONNECTED,
      DOPADOP(0) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw1_fw1_1024x18_DOPADOP_0_UNCONNECTED,
      DOPBDOP(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(17),
      DOPBDOP(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction1(16),
      WEA(1) => N1,
      WEA(0) => N1,
      WEBWE(3) => N1,
      WEBWE(2) => N1,
      WEBWE(1) => N1,
      WEBWE(0) => N1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18 : RAMB18E1
    generic map(
      INITP_00 => X"CE3E3E3F8D3488FCFFFF7D34F488D374FCFFFF888FFFFF7F0FFF33FF8DDDDF8F",
      INITP_01 => X"CF0FFCFFFAAB7C373CC3D3F7FCBCFD3F7FF7D34F70FDDD22222234A222222823",
      INITP_02 => X"FBFFFFFFFA080CD334E2D2DCB724B3FFCFFFEA03FFF54036AED0FE00034F3CCC",
      INITP_03 => X"D2D28A2667666AAABC3C30030B30C030B0C300C330C0030BFF333FC3FBFFFFFF",
      INITP_04 => X"0000000000000000000000000000000000000000000000000000000000000002",
      INITP_05 => X"B4AA0A5ED0A69003000000000000000000000000000000000000000000000000",
      INITP_06 => X"888C88C88C88C88BC302CB2CB3888BFFE30FFE30820FBFDEFFE5DAAAA8BFFCB4",
      INITP_07 => X"EBCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCB00C2FBEFBFA2200EAAEA88A88B4B",
      INIT_00 => X"CF1E0F01510A40105094400050404002501B4001032DC000CF1E0F000142C000",
      INIT_01 => X"010100800346017E018E401A031B033A001F033000604015401540154015C000",
      INIT_02 => X"E000400401F901F601F901F603560353018801A2017A541D4C93039903620386",
      INIT_03 => X"40020321033A000201F303560353017A018301CE017A0346E0024006E0014005",
      INIT_04 => X"405E5450400E6010C0130080E010E080505020804013547B2080546420404014",
      INIT_05 => X"03BA03D840020321019403BA03EC545D4053405E54574049400D545D2002400C",
      INIT_06 => X"E00300085C734051401A507720204014E012401CE011401B40020321033A0000",
      INIT_07 => X"033A000403BAE0030001407D0087E0030002407D0087E0030004407D00810087",
      INIT_08 => X"4016E009401DE0044017E0054018E0064019A000E00BA01F4014E00A401A4002",
      INIT_09 => X"400FE00D4010E00E4011E00F4012E010E08050B220804013A000E0074015E008",
      INIT_0A => X"400A40CBA00F600C03BC03EA54AF400B50F8400C50F820086010C0130080E00C",
      INIT_0B => X"405240F0019403BA03EC54BF405340F254B9404F400D54F12002400C40F254B2",
      INIT_0C => X"03BA03FC03161100C01F58EF01E7400D02FC03BC54EF4020400D02FC03EA54D1",
      INIT_0D => X"010458EF01E7400D02FC0A00020903BC54EF4020400D02FC03E254F1404E4000",
      INIT_0E => X"03BA4106EE10ED0FEC0EEB0DEA0C54DBC20103FC03161100DA0054E0C10101E0",
      INIT_0F => X"03056C0F03FC0316A10F611003BC03E240020321033A000203BA03E440020321",
      INIT_10 => X"6C0E6B0D6A0C513E2008401E4002033A001003BA03056C0C03056C0D03056C0E",
      INIT_11 => X"CD02CC0101E0E00A5D3E4051A07F10B001E001E001E0E00BA01F10A06E106D0F",
      INIT_12 => X"01F901F6035601C00346593EFFE0FBD0DAC0AE016F026B016A0051342E80CE03",
      INIT_13 => X"033A000001F3035601B103AE02E103AB0346EE06ED05EC044E194D184C1701FD",
      INIT_14 => X"A000554CC00101500024B0002080401EA000033A0001016E0159014840020321",
      INIT_15 => X"400D55612002400C0382C0000000A0005556C20102FFA0005551C101015501FF",
      INIT_16 => X"03C603F2A000C01FA00F401FC0130080400E400E4161400E55662020400C415C",
      INIT_17 => X"03CC03D8A00003BA03DC03E4417C03C203BE03C403F203BE03E003D003EC03BE",
      INIT_18 => X"03EC03D2A00003BC03DC03CA03CE03EA418C03EE03D803E203D8418C03E603C8",
      INIT_19 => X"0335033F03BA03056C0003056C0103056C0203BC03D203E04343A00F401F03BC",
      INIT_1A => X"AEFD03A4010200E003A8CC80CD03AC3FAD7CAEFEAF0103A4010100C0A000018E",
      INIT_1B => X"A00003A80C000D040386010000A003A80C800D050E000F000386010000C003A8",
      INIT_1C => X"010100C0A00003A80C800386010000A003A80C800D000E000F000386010000C0",
      INIT_1D => X"A0000368038601020060036203860102008003A8CC80CF40AC7FADFDAFBF03A4",
      INIT_1E => X"C0F6B80080075DF1C011B800C0E9B80080B9A0000F000E000D000C000B000A06",
      INIT_1F => X"51FD20014007A00051F920104007A000C0070010A000C01400E0A000800AA000",
      INIT_20 => X"000000000000000000000000000000000000000000000000000000000000A000",
      INIT_21 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_22 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_23 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_24 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_25 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_26 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_27 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_28 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_29 => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2A => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2B => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2C => X"0000000000000000000000000000000000000000000000000000000000000000",
      INIT_2D => X"0500040000000000000000000000000000000000000000000000000000000000",
      INIT_2E => X"5AF2C0010101A007030002002008030002002010600B620A0300050204EC42E3",
      INIT_2F => X"A00056FC2002400CA000C008C209C30AF0104008C209C30AB350924042EE0106",
      INIT_30 => X"0C0601000C060100A00003FC0316030C03FC0316030C1C00A00057002001400C",
      INIT_31 => X"03BA03EE03DE03C803D6A000813081075B19410AA00001000C0601000C060100",
      INIT_32 => X"A000A01F4000A000A0604000432503D8A00003BC03C003E453284000032DA000",
      INIT_33 => X"03ECC100D100032AA11F11004343032A03BC03CC03D2C100D100032DA1601100",
      INIT_34 => X"A00003590C000382C00A00C4C00B00BBC00900A4A00003BA0304032D03BC03CC",
      INIT_35 => X"03860100008003930F000E000D00A00003590C0DA00003590C10A00003590C07",
      INIT_36 => X"C00900B8437F00C4C00B004FC0090034437F00C4C00B0077C009004CA0000368",
      INIT_37 => X"C00A00C2C00B0037C00900EC037F00C2C00B002FC0090094437F00F4C00B00FF",
      INIT_38 => X"C209023DC20A0204C108C008C2090255C20A0204A00057822080400AA0000382",
      INIT_39 => X"0004A0004F084E084D084C08039FA000CF08CE08CD08CC08039FA000C108C008",
      INIT_3A => X"037403B1A000036E03B1A00003680393A000039903620386A000C0090040C00A",
      INIT_3B => X"43FC015F43FC012043FC010DA00003A86C046D056E060F00038601000020A000",
      INIT_3C => X"43FC014443FC014343FC014243FC014143FC013643FC013343FC013643FC013E",
      INIT_3D => X"43FC014C43FC014B43FC014A43FC014943FC014843FC014743FC014643FC0145",
      INIT_3E => X"43FC015443FC015343FC015243FC015143FC015043FC014F43FC014E43FC014D",
      INIT_3F => X"43FFA000C10D030043FC015A43FC015943FC015843FC015743FC015643FC0155",
      INIT_A => X"00000",
      INIT_B => X"00000",
      INIT_FILE => "NONE",
      RAM_MODE => "TDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      RSTREG_PRIORITY_A => "REGCE",
      RSTREG_PRIORITY_B => "REGCE",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "VIRTEX6",
      SRVAL_A => X"00000",
      SRVAL_B => X"00000",
      WRITE_MODE_A => "WRITE_FIRST",
      WRITE_MODE_B => "WRITE_FIRST",
      DOA_REG => 0,
      DOB_REG => 0,
      READ_WIDTH_A => 18,
      READ_WIDTH_B => 18,
      WRITE_WIDTH_A => 18,
      WRITE_WIDTH_B => 18
    )
    port map (
      CLKARDCLK => icap_clk,
      CLKBWRCLK => icap_clk,
      ENARDEN => N1,
      ENBWREN => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_b_ena,
      REGCEAREGCE => N1,
      REGCEB => N1,
      RSTRAMARSTRAM => N1,
      RSTRAMB => N1,
      RSTREGARSTREG => N1,
      RSTREGB => N1,
      ADDRARDADDR(13) => N0,
      ADDRARDADDR(12) => N0,
      ADDRARDADDR(11) => N0,
      ADDRARDADDR(10) => N0,
      ADDRARDADDR(9) => N0,
      ADDRARDADDR(8) => N0,
      ADDRARDADDR(7) => N0,
      ADDRARDADDR(6) => N0,
      ADDRARDADDR(5) => N0,
      ADDRARDADDR(4) => N0,
      ADDRARDADDR(3) => N1,
      ADDRARDADDR(2) => N1,
      ADDRARDADDR(1) => N1,
      ADDRARDADDR(0) => N1,
      ADDRBWRADDR(13) => U0_wrapper_wrapper_genv6_wrapper_controller_address(9),
      ADDRBWRADDR(12) => U0_wrapper_wrapper_genv6_wrapper_controller_address(8),
      ADDRBWRADDR(11) => U0_wrapper_wrapper_genv6_wrapper_controller_address(7),
      ADDRBWRADDR(10) => U0_wrapper_wrapper_genv6_wrapper_controller_address(6),
      ADDRBWRADDR(9) => U0_wrapper_wrapper_genv6_wrapper_controller_address(5),
      ADDRBWRADDR(8) => U0_wrapper_wrapper_genv6_wrapper_controller_address(4),
      ADDRBWRADDR(7) => U0_wrapper_wrapper_genv6_wrapper_controller_address(3),
      ADDRBWRADDR(6) => U0_wrapper_wrapper_genv6_wrapper_controller_address(2),
      ADDRBWRADDR(5) => U0_wrapper_wrapper_genv6_wrapper_controller_address(1),
      ADDRBWRADDR(4) => U0_wrapper_wrapper_genv6_wrapper_controller_address(0),
      ADDRBWRADDR(3) => N1,
      ADDRBWRADDR(2) => N1,
      ADDRBWRADDR(1) => N1,
      ADDRBWRADDR(0) => N1,
      DIADI(15) => N0,
      DIADI(14) => N0,
      DIADI(13) => N0,
      DIADI(12) => N0,
      DIADI(11) => N0,
      DIADI(10) => N0,
      DIADI(9) => N0,
      DIADI(8) => N0,
      DIADI(7) => N0,
      DIADI(6) => N0,
      DIADI(5) => N0,
      DIADI(4) => N0,
      DIADI(3) => N0,
      DIADI(2) => N0,
      DIADI(1) => N0,
      DIADI(0) => N0,
      DIBDI(15) => N1,
      DIBDI(14) => N1,
      DIBDI(13) => N1,
      DIBDI(12) => N1,
      DIBDI(11) => N1,
      DIBDI(10) => N1,
      DIBDI(9) => N1,
      DIBDI(8) => N1,
      DIBDI(7) => N1,
      DIBDI(6) => N1,
      DIBDI(5) => N1,
      DIBDI(4) => N1,
      DIBDI(3) => N1,
      DIBDI(2) => N1,
      DIBDI(1) => N1,
      DIBDI(0) => N1,
      DIPADIP(1) => N0,
      DIPADIP(0) => N0,
      DIPBDIP(1) => N1,
      DIPBDIP(0) => N1,
      DOADO(15) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_15_UNCONNECTED,
      DOADO(14) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_14_UNCONNECTED,
      DOADO(13) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_13_UNCONNECTED,
      DOADO(12) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_12_UNCONNECTED,
      DOADO(11) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_11_UNCONNECTED,
      DOADO(10) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_10_UNCONNECTED,
      DOADO(9) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_9_UNCONNECTED,
      DOADO(8) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_8_UNCONNECTED,
      DOADO(7) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_7_UNCONNECTED,
      DOADO(6) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_6_UNCONNECTED,
      DOADO(5) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_5_UNCONNECTED,
      DOADO(4) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_4_UNCONNECTED,
      DOADO(3) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_3_UNCONNECTED,
      DOADO(2) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_2_UNCONNECTED,
      DOADO(1) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_1_UNCONNECTED,
      DOADO(0) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOADO_0_UNCONNECTED,
      DOBDO(15) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(15),
      DOBDO(14) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(14),
      DOBDO(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(13),
      DOBDO(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(12),
      DOBDO(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(11),
      DOBDO(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(10),
      DOBDO(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(9),
      DOBDO(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(8),
      DOBDO(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(7),
      DOBDO(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(6),
      DOBDO(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(5),
      DOBDO(4) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(4),
      DOBDO(3) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(3),
      DOBDO(2) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(2),
      DOBDO(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(1),
      DOBDO(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(0),
      DOPADOP(1) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOPADOP_1_UNCONNECTED,
      DOPADOP(0) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_fw0_fw0_1024x18_DOPADOP_0_UNCONNECTED,
      DOPBDOP(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(17),
      DOPBDOP(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_instrom_instruction0(16),
      WEA(1) => N1,
      WEA(0) => N1,
      WEBWE(3) => N1,
      WEBWE(2) => N1,
      WEBWE(1) => N1,
      WEBWE(0) => N1
    );
  U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_storage : RAMB18E1
    generic map(
      INITP_00 => X"3333333333333333333333333333333333333333333333333333333333333333",
      INITP_01 => X"3333333333333333333333333333333333333333333333333333333333333333",
      INITP_02 => X"3333333333333333B5777F3333F3333333333333333333333333333333333333",
      INITP_03 => X"3333333333333333333333333333333333333333333333333333333333333333",
      INITP_04 => X"33333333333333333F3333FFFFFFFFFFFFF5777F3333F33333F3333333333333",
      INITP_05 => X"77777777777777777777777777777777777777777F3333333333333333333333",
      INITP_06 => X"5555555555555555555577777777777777777777777777777777777777777777",
      INITP_07 => X"F3B5555555555555555555555555555555555555555555555555555555555555",
      INIT_00 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_01 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_02 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_03 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_04 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_05 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_06 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_07 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_08 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_09 => X"1111111111111111111111111111111111111111111111111111111111111111",
      INIT_0A => X"2222222222222222222222222222222222222222222222222222222211111111",
      INIT_0B => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_0C => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_0D => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_0E => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_0F => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_10 => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_11 => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_12 => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_13 => X"2222222222222222222222222222222222222222222222222222222222222222",
      INIT_14 => X"2801800120000000FFFFFFFFDEADDEADDEADDEADDEADDEAD2222222222222222",
      INIT_15 => X"FFFFFFFFADDD02C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2000000020000000",
      INIT_16 => X"20000000000000013000800120000000200000001D1D1D1D3001800120000000",
      INIT_17 => X"DADADADADADADADADADADADADADADADADADADADA500000A23000400020000000",
      INIT_18 => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_19 => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_1A => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_1B => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_1C => X"DADADADADADADADADADADADADADADADAECCCECCCDADADADADADADADADADADADA",
      INIT_1D => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_1E => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_1F => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_20 => X"DADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADADA",
      INIT_21 => X"30ADDD0120000000FFFFFFFF20000000DADADADADADADADADADADADADADADADA",
      INIT_22 => X"200000002000000028ADDD0120000000FFFFFFFF2000000020000000DADADADA",
      INIT_23 => X"DEADDEADDEADDEADFFFFFFFFADDD0440FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_24 => X"DEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEADDEAD",
      INIT_25 => X"20000000FFFFFFFF2000000020000000AA99556620000000FFFFFFFFDEADDEAD",
      INIT_26 => X"2000000020000000480000A22800600020000000200000000000000430008001",
      INIT_27 => X"2000000020000000200000002000000020000000200000002000000020000000",
      INIT_28 => X"2000000020000000200000002000000020000000200000002000000020000000",
      INIT_29 => X"2000000020000000200000002000000020000000200000002000000020000000",
      INIT_2A => X"FFFFFFFFFFFFFFFF200000002000000020000000200000002000000020000000",
      INIT_2B => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_2C => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_2D => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_2E => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_2F => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_30 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_31 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_32 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_33 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_34 => X"FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_35 => X"ADDD02F8ADDD02F4ADDD02F0ADDD02ECFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF",
      INIT_36 => X"ADDD0318ADDD0314ADDD0310ADDD030CADDD0308ADDD0304ADDD0300ADDD02FC",
      INIT_37 => X"ADDD0338ADDD0334ADDD0330ADDD032CADDD0328ADDD0324ADDD0320ADDD031C",
      INIT_38 => X"ADDD0358ADDD0354ADDD0350ADDD034CADDD0348ADDD0344ADDD0340ADDD033C",
      INIT_39 => X"ADDD0378ADDD0374ADDD0370ADDD036CADDD0368ADDD0364ADDD0360ADDD035C",
      INIT_3A => X"ADDD0398ADDD0394ADDD0390ADDD038CADDD0388ADDD0384ADDD0380ADDD037C",
      INIT_3B => X"ADDD03B8ADDD03B4ADDD03B0ADDD03ACADDD03A8ADDD03A4ADDD03A0ADDD039C",
      INIT_3C => X"ADDD03D8ADDD03D4ADDD03D0ADDD03CCADDD03C8ADDD03C4ADDD03C0ADDD03BC",
      INIT_3D => X"ADDD03F8ADDD03F4ADDD03F0ADDD03ECADDD03E8ADDD03E4ADDD03E0ADDD03DC",
      INIT_3E => X"ADDD0418ADDD0414ADDD0410ADDD040CADDD0408ADDD0404ADDD0400ADDD03FC",
      INIT_3F => X"FFFFFFFF20000000FFFFFFFFADDD042CADDD0428ADDD0424ADDD0420ADDD041C",
      INIT_A => X"3FFFF",
      INIT_B => X"3FFFF",
      INIT_FILE => "NONE",
      RAM_MODE => "SDP",
      RDADDR_COLLISION_HWCONFIG => "DELAYED_WRITE",
      RSTREG_PRIORITY_A => "RSTREG",
      RSTREG_PRIORITY_B => "RSTREG",
      SIM_COLLISION_CHECK => "ALL",
      SIM_DEVICE => "VIRTEX6",
      SRVAL_A => X"3FFFF",
      SRVAL_B => X"3FFFF",
      WRITE_MODE_A => "READ_FIRST",
      WRITE_MODE_B => "READ_FIRST",
      DOA_REG => 0,
      DOB_REG => 0,
      READ_WIDTH_A => 36,
      READ_WIDTH_B => 0,
      WRITE_WIDTH_A => 0,
      WRITE_WIDTH_B => 36
    )
    port map (
      CLKARDCLK => icap_clk,
      CLKBWRCLK => icap_clk,
      ENARDEN => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_sync_init_INV_10_o,
      ENBWREN => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_sync_init_INV_10_o,
      REGCEAREGCE => N1,
      REGCEB => N1,
      RSTRAMARSTRAM => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      RSTRAMB => U0_wrapper_wrapper_genv6_wrapper_controller_sync_init,
      RSTREGARSTREG => N1,
      RSTREGB => N1,
      ADDRARDADDR(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_10_581,
      ADDRARDADDR(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr_9_580,
      ADDRARDADDR(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(8),
      ADDRARDADDR(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(7),
      ADDRARDADDR(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(6),
      ADDRARDADDR(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(5),
      ADDRARDADDR(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(4),
      ADDRARDADDR(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(3),
      ADDRARDADDR(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_sta_ptr(2),
      ADDRARDADDR(4) => N1,
      ADDRARDADDR(3) => N1,
      ADDRARDADDR(2) => N1,
      ADDRARDADDR(1) => N1,
      ADDRARDADDR(0) => N1,
      ADDRBWRADDR(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(8),
      ADDRBWRADDR(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(7),
      ADDRBWRADDR(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(6),
      ADDRBWRADDR(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(5),
      ADDRBWRADDR(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(4),
      ADDRBWRADDR(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(3),
      ADDRBWRADDR(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(2),
      ADDRBWRADDR(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(1),
      ADDRBWRADDR(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_addra(0),
      ADDRBWRADDR(4) => N1,
      ADDRBWRADDR(3) => N1,
      ADDRBWRADDR(2) => N1,
      ADDRBWRADDR(1) => N1,
      ADDRBWRADDR(0) => N1,
      DIADI(15) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_16_Q,
      DIADI(14) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_15_Q,
      DIADI(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_14_Q,
      DIADI(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_13_Q,
      DIADI(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_12_Q,
      DIADI(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_11_Q,
      DIADI(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_10_Q,
      DIADI(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_9_Q,
      DIADI(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_7_Q,
      DIADI(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_6_Q,
      DIADI(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_5_Q,
      DIADI(4) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_4_Q,
      DIADI(3) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_3_Q,
      DIADI(2) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_2_Q,
      DIADI(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_1_Q,
      DIADI(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_0_Q,
      DIBDI(15) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_34_Q,
      DIBDI(14) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_33_Q,
      DIBDI(13) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_32_Q,
      DIBDI(12) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_31_Q,
      DIBDI(11) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_30_Q,
      DIBDI(10) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_29_Q,
      DIBDI(9) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_28_Q,
      DIBDI(8) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_27_Q,
      DIBDI(7) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_25_Q,
      DIBDI(6) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_24_Q,
      DIBDI(5) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_23_Q,
      DIBDI(4) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_22_Q,
      DIBDI(3) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_21_Q,
      DIBDI(2) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_20_Q,
      DIBDI(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_19_Q,
      DIBDI(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_dina_18_Q,
      DIPADIP(1) => N0,
      DIPADIP(0) => N0,
      DIPBDIP(1) => N1,
      DIPBDIP(0) => N1,
      DOADO(15) => NlwRenamedSig_OI_icap_i(8),
      DOADO(14) => NlwRenamedSig_OI_icap_i(9),
      DOADO(13) => NlwRenamedSig_OI_icap_i(10),
      DOADO(12) => NlwRenamedSig_OI_icap_i(11),
      DOADO(11) => NlwRenamedSig_OI_icap_i(12),
      DOADO(10) => NlwRenamedSig_OI_icap_i(13),
      DOADO(9) => NlwRenamedSig_OI_icap_i(14),
      DOADO(8) => NlwRenamedSig_OI_icap_i(15),
      DOADO(7) => NlwRenamedSig_OI_icap_i(0),
      DOADO(6) => NlwRenamedSig_OI_icap_i(1),
      DOADO(5) => NlwRenamedSig_OI_icap_i(2),
      DOADO(4) => NlwRenamedSig_OI_icap_i(3),
      DOADO(3) => NlwRenamedSig_OI_icap_i(4),
      DOADO(2) => NlwRenamedSig_OI_icap_i(5),
      DOADO(1) => NlwRenamedSig_OI_icap_i(6),
      DOADO(0) => NlwRenamedSig_OI_icap_i(7),
      DOBDO(15) => NlwRenamedSig_OI_icap_i(24),
      DOBDO(14) => NlwRenamedSig_OI_icap_i(25),
      DOBDO(13) => NlwRenamedSig_OI_icap_i(26),
      DOBDO(12) => NlwRenamedSig_OI_icap_i(27),
      DOBDO(11) => NlwRenamedSig_OI_icap_i(28),
      DOBDO(10) => NlwRenamedSig_OI_icap_i(29),
      DOBDO(9) => NlwRenamedSig_OI_icap_i(30),
      DOBDO(8) => NlwRenamedSig_OI_icap_i(31),
      DOBDO(7) => NlwRenamedSig_OI_icap_i(16),
      DOBDO(6) => NlwRenamedSig_OI_icap_i(17),
      DOBDO(5) => NlwRenamedSig_OI_icap_i(18),
      DOBDO(4) => NlwRenamedSig_OI_icap_i(19),
      DOBDO(3) => NlwRenamedSig_OI_icap_i(20),
      DOBDO(2) => NlwRenamedSig_OI_icap_i(21),
      DOBDO(1) => NlwRenamedSig_OI_icap_i(22),
      DOBDO(0) => NlwRenamedSig_OI_icap_i(23),
      DOPADOP(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_17_Q,
      DOPADOP(0) => NLW_U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_controller_dbuffer_mem_storage_DOPADOP_0_UNCONNECTED,
      DOPBDOP(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_35_Q,
      DOPBDOP(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_doutb_26_Q,
      WEA(1) => N1,
      WEA(0) => N1,
      WEBWE(3) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(3),
      WEBWE(2) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(2),
      WEBWE(1) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(1),
      WEBWE(0) => U0_wrapper_wrapper_genv6_wrapper_controller_controller_dbuffer_wea(0)
    );

end STRUCTURE;

-- synthesis translate_on
