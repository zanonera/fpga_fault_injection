# Generate EBD File
set_property BITSTREAM.SEU.ESSENTIALBITS yes [current_design]

## Do not use DSP Blocks for the DCT
set_property USE_DSP48 no [get_cells my_design_i/DUT/FIR1]
set_property USE_DSP48 yes [get_cells my_design_i/DUT/FIR2]

## Place My DUT
create_pblock MY_DUT
add_cells_to_pblock [get_pblocks MY_DUT] [get_cells -quiet [list my_design_i/DUT/FIR1]]
resize_pblock [get_pblocks MY_DUT] -add {SLICE_X102Y57:SLICE_X113Y74}
#resize_pblock -pblock MY_DUT -add SLICE_X0Y100:SLICE_X5Y149
set_property DONT_TOUCH true [get_cells my_design_i/DUT/FIR1]
set_property DONT_TOUCH true [get_cells my_design_i/DUT/ROM]
set_property DONT_TOUCH true [get_cells my_design_i/DUT/CHCK]
set_property DONT_TOUCH true [get_cells my_design_i/DUT/FIR2]

## Place My UART
create_pblock MY_UART
add_cells_to_pblock [get_pblocks MY_UART] [get_cells -quiet [list my_design_i/DUT/CHCK my_design_i/UART]]
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
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list sem_bd_wrapper_i/sem_bd_i/processing_system7_0/inst/FCLK_CLK0]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 14 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {my_design_i/Addr[0]} {my_design_i/Addr[1]} {my_design_i/Addr[2]} {my_design_i/Addr[3]} {my_design_i/Addr[4]} {my_design_i/Addr[5]} {my_design_i/Addr[6]} {my_design_i/Addr[7]} {my_design_i/Addr[8]} {my_design_i/Addr[9]} {my_design_i/Addr[10]} {my_design_i/Addr[11]} {my_design_i/Addr[12]} {my_design_i/Addr[13]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 16 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {my_design_i/DUT/Y0[0]} {my_design_i/DUT/Y0[1]} {my_design_i/DUT/Y0[2]} {my_design_i/DUT/Y0[3]} {my_design_i/DUT/Y0[4]} {my_design_i/DUT/Y0[5]} {my_design_i/DUT/Y0[6]} {my_design_i/DUT/Y0[7]} {my_design_i/DUT/Y0[8]} {my_design_i/DUT/Y0[9]} {my_design_i/DUT/Y0[10]} {my_design_i/DUT/Y0[11]} {my_design_i/DUT/Y0[12]} {my_design_i/DUT/Y0[13]} {my_design_i/DUT/Y0[14]} {my_design_i/DUT/Y0[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 8 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {my_design_i/DUT/X[0]} {my_design_i/DUT/X[1]} {my_design_i/DUT/X[2]} {my_design_i/DUT/X[3]} {my_design_i/DUT/X[4]} {my_design_i/DUT/X[5]} {my_design_i/DUT/X[6]} {my_design_i/DUT/X[7]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {my_design_i/ERR[0]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 16 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list {my_design_i/DUT/Y1[0]} {my_design_i/DUT/Y1[1]} {my_design_i/DUT/Y1[2]} {my_design_i/DUT/Y1[3]} {my_design_i/DUT/Y1[4]} {my_design_i/DUT/Y1[5]} {my_design_i/DUT/Y1[6]} {my_design_i/DUT/Y1[7]} {my_design_i/DUT/Y1[8]} {my_design_i/DUT/Y1[9]} {my_design_i/DUT/Y1[10]} {my_design_i/DUT/Y1[11]} {my_design_i/DUT/Y1[12]} {my_design_i/DUT/Y1[13]} {my_design_i/DUT/Y1[14]} {my_design_i/DUT/Y1[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list my_design_i/Read]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list my_design_i/rst]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list my_design_i/status_injection]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets system_clk]
