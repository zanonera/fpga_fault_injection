set_property BITSTREAM.GENERAL.PERFRAMECRC YES [current_design]
set_property BITSTREAM.CONFIG.INITSIGNALSERROR DISABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS false [current_design]

# Generate EBD File
set_property BITSTREAM.SEU.ESSENTIALBITS yes [current_design]

## Place My DUT
create_pblock MY_DUT
add_cells_to_pblock [get_pblocks MY_DUT] [get_cells -quiet [list {tiny_soc_i/picorv32_core/genblk1[0].core_u0}]]
resize_pblock [get_pblocks MY_DUT] -add {SLICE_X54Y66:SLICE_X75Y42}
resize_pblock MY_DUT -add SLICE_X54Y42:SLICE_X71Y66 -remove SLICE_X54Y42:SLICE_X75Y66 -locs keep_all
set_property EXCLUDE_PLACEMENT 1 [get_pblocks MY_DUT]

## Place My UART
create_pblock MY_UART
add_cells_to_pblock [get_pblocks MY_UART] [get_cells -quiet [list my_design_i/UART]]
resize_pblock [get_pblocks MY_UART] -add {SLICE_X106Y90:SLICE_X113Y97}

##RGB LEDs

#set_property -dict { PACKAGE_PIN L15   IOSTANDARD LVCMOS33 } [get_ports { led4_b }]; #IO_L22N_T3_AD7N_35 Sch=led4_b
#set_property -dict { PACKAGE_PIN G17   IOSTANDARD LVCMOS33 } [get_ports { led4_g }]; #IO_L16P_T2_35 Sch=led4_g
#set_property -dict { PACKAGE_PIN N15   IOSTANDARD LVCMOS33 } [get_ports { led4_r }]; #IO_L21P_T3_DQS_AD14P_35 Sch=led4_r
#set_property -dict { PACKAGE_PIN G14   IOSTANDARD LVCMOS33 } [get_ports { led5_b }]; #IO_0_35 Sch=led5_b
#set_property -dict { PACKAGE_PIN L14   IOSTANDARD LVCMOS33 } [get_ports { led5_g }]; #IO_L22P_T3_AD7P_35 Sch=led5_g
#set_property -dict { PACKAGE_PIN M15   IOSTANDARD LVCMOS33 } [get_ports { led5_r }]; #IO_L23N_T3_35 Sch=led5_r

##LEDs

#set_property -dict { PACKAGE_PIN R14   IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=led[0]
#set_property -dict { PACKAGE_PIN P14   IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=led[1]
#set_property -dict { PACKAGE_PIN N16   IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=led[2]
#set_property -dict { PACKAGE_PIN M14   IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L23P_T3_35 Sch=led[3]

##PmodB

set_property -dict {PACKAGE_PIN W14 IOSTANDARD LVCMOS33} [get_ports sem_uart_rxd_i]
set_property -dict {PACKAGE_PIN Y14 IOSTANDARD LVCMOS33} [get_ports sem_uart_txd_o]
set_property -dict {PACKAGE_PIN T11 IOSTANDARD LVCMOS33} [get_ports dut_uart_txd_o]
#set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { jb[3] }]; #IO_L1N_T0_34 Sch=jb_n[2]
#set_property -dict { PACKAGE_PIN V16   IOSTANDARD LVCMOS33 } [get_ports { jb[4] }]; #IO_L18P_T2_34 Sch=jb_p[3]
#set_property -dict { PACKAGE_PIN W16   IOSTANDARD LVCMOS33 } [get_ports { jb[5] }]; #IO_L18N_T2_34 Sch=jb_n[3]
#set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { jb[6] }]; #IO_L4P_T0_34 Sch=jb_p[4]
#set_property -dict { PACKAGE_PIN W13   IOSTANDARD LVCMOS33 } [get_ports { jb[7] }]; #IO_L4N_T0_34 Sch=jb_n[4]




create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 2048 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list sem_bd_wrapper_i/sem_bd_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 32 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[0]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[1]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[2]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[3]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[4]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[5]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[6]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[7]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[8]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[9]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[10]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[11]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[12]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[13]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[14]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[15]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[16]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[17]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[18]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[19]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[20]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[21]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[22]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[23]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[24]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[25]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[26]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[27]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[28]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[29]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[30]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/B[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 32 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[0]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[1]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[2]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[3]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[4]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[5]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[6]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[7]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[8]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[9]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[10]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[11]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[12]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[13]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[14]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[15]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[16]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[17]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[18]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[19]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[20]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[21]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[22]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[23]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[24]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[25]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[26]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[27]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[28]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[29]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[30]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/C[31]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 32 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[0]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[1]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[2]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[3]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[4]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[5]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[6]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[7]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[8]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[9]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[10]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[11]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[12]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[13]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[14]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[15]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[16]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[17]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[18]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[19]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[20]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[21]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[22]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[23]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[24]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[25]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[26]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[27]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[28]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[29]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[30]} {tiny_soc_i/picorv32_core/voter_mem_la_wdata/A[31]}]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets system_clk]
