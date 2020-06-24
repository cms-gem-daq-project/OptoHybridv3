#!/usr/bin/env python3

target = "xilinx"
action = "synthesis"

syn_device = "xc6vlx130t"
syn_grade = "-1"
syn_package = "ff1156"
syn_top = "top_optohybrid"
syn_project = "top_optohybrid"
syn_tool = "ise"

files =  [
    "../../src/optohybrid_top.vhd",

    "../../src/control/adc.vhd",
    "../../src/control/control.vhd",
    "../../src/control/device_dna.v",
    "../../src/control/external.v",
    "../../src/control/fmm.v",
    "../../src/control/led_control.v",
    "../../src/control/reset.v",
    "../../src/control/startup.vhd",
    "../../src/control/ttc.v",

    "../../src/gbt/gbt.vhd",
    "../../src/gbt/gbt_link.vhd",
    "../../src/gbt/gbt_link_tmr.vhd",
    "../../src/gbt/gbt_rx.vhd",
    "../../src/gbt/gbt_serdes.vhd",
    "../../src/gbt/gbt_tx.vhd",
    "../../src/gbt/link_request.vhd",
    "../../src/gbt/fifo_a7.vhd",
    "../../src/gbt/to_gbt_ser.vhd",

    "../../src/pkg/hardware_pkg_ge11.vhd",
    "../../src/pkg/ipbus_pkg.vhd",
    "../../src/pkg/registers.vhd",
    "../../src/pkg/types_pkg.vhd",
    "../../src/pkg/version_pkg.vhd",

    "../../src/ip_cores/clocks/clocks.xco",
    "../../src/ip_cores/fifo/fifo.xco",
    "../../src/ip_cores/mgt/mgt.xco",
    "../../src/ip_cores/sem/sem.xco",
    "../../src/ip_cores/xadc/xadc.xco",

    "../../src/cluster_building/consecutive_count.v",
    "../../src/cluster_building/count1536.v",
    "../../src/cluster_building/find_cluster_primaries.v",
    "../../src/cluster_building/find_clusters.vhd",
    "../../src/cluster_building/generated/sorter16.v",
    "../../src/cluster_building/priority384.v",
    "../../src/cluster_building/top_cluster_packer.vhd",
    "../../src/cluster_building/truncate_clusters.v",
    "../../src/cluster_building/x_oneshot.v",

    # Trigger
    "../../src/trigger/active_vfats.vhd",
    "../../src/trigger/channel_to_strip.vhd",
    "../../src/trigger/trigger_data_formatter.vhd",
    "../../src/trigger/trigger_data_phy.vhd",
    "../../src/trigger/sbit_monitor.vhd",
    "../../src/trigger/sbits.vhd",
    "../../src/trigger/sbits_hitmap.vhd",
    "../../src/trigger/trig_alignment/frame_aligner.v",
    "../../src/trigger/trig_alignment/frame_aligner_tmr.vhd",
    "../../src/trigger/trig_alignment/trig_alignment.vhd",
    "../../src/trigger/trigger.vhd",

    # GTP
    "../../src/mgt/gtp/gtp_common.vhd",
    "../../src/mgt/gtp/gtp_common_reset.vhd",
    "../../src/mgt/gtp/gtp_cpll_railing.vhd",
    "../../src/mgt/gtp/gtp_gt.vhd",
    "../../src/mgt/gtp/gtp_sync_block.vhd",
    "../../src/mgt/gtp/gtp_sync_pulse.vhd",
    "../../src/mgt/gtp/gtp_tx_manual_phase_align.vhd",
    "../../src/mgt/gtp/gtp_tx_startup_fsm.vhd",
    "../../src/mgt/mgt_wrapper.vhd",

    # Utils
    "../../src/utils/6b8b.vhd",
    "../../src/utils/6b8b_pkg.vhd",
    "../../src/utils/8b6b.vhd",
    "../../src/utils/dru.vhd",
    "../../src/utils/dru_tmr.vhd",
    "../../src/utils/oversample.vhd",
    "../../src/utils/bitslip.vhd",
    "../../src/utils/clock_strobe.vhd",
    "../../src/utils/clocking.vhd",
    "../../src/utils/counter_snap.vhd",
    "../../src/utils/cylon.v",
    "../../src/utils/err_indicator.v",
    "../../src/utils/fader.v",
    "../../src/utils/iodelay.vhd",
    "../../src/utils/iserdes.vhd",
    "../../src/utils/progress_bar.vhd",
    "../../src/utils/sem_mon.vhd",
    "../../src/utils/synchronizer.vhd",
    "../../src/utils/x_flashsm.v",

    # Wishbone
    "../../src/wb/ipb_switch_tmr.vhd",
    "../../src/wb/ipbus_slave_tmr.vhd",
    "../../src/wb/ipb_switch.vhd",
    "../../src/wb/ipbus_slave.vhd",
    "../../src/wb/wb_switch.vhd",

    # UCF
    "../../src/ucf/gbt.ucf",
    "../../src/ucf/misc_v3b.ucf",
    "../../src/ucf/sbits.ucf"
    ]
