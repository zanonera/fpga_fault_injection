# Triplicate the design and add GPIO Comparator AXI-Stream connection
validate_bd_design -force
create_bd_cell -type ip -vlnv xilinx.com:ip:tmr_manager tmr_0/tmr_manager_0
apply_bd_automation -rule xilinx.com:bd_rule:tmr -config \
  {bram {Local} brk {1} inject {1} mask {1} mode {TMR} sem_if {None} sem_wd {1} wd {None}} [get_bd_cells tmr_0/tmr_manager_0]

# Set up GPIO board interface
set_property -dict [list CONFIG.GPIO_BOARD_INTERFACE {custom}] [get_bd_cells tmr_0/tmr_voter_GPIO_0]
foreach block {MB1 MB2 MB3} {
  set_property -dict [list CONFIG.GPIO_BOARD_INTERFACE {Custom}] [get_bd_cells tmr_0/${block}/axi_gpio_0]
}

# Add GPIO AXI-Stream connection
foreach block {MB1 MB2 MB3} {
  set_property -dict [list CONFIG.C_FSL_LINKS {1}] [get_bd_cells tmr_0/${block}/microblaze_0]
  set_property -dict [list CONFIG.C_TEST_COMPARATOR {2} CONFIG.C_TEST_LAST_INTERFACE {1}] [get_bd_cells tmr_0/${block}/tmr_comparator_GPIO_0]
  set_property -dict [list CONFIG.C_TEST_COMPARATOR {2}] [get_bd_cells tmr_0/${block}/tmr_manager_0]

  connect_bd_intf_net [get_bd_intf_pins tmr_0/${block}/microblaze_0/M0_AXIS] [get_bd_intf_pins tmr_0/${block}/tmr_comparator_GPIO_0/S_AXIS_TEST]
  connect_bd_intf_net [get_bd_intf_pins tmr_0/${block}/tmr_comparator_GPIO_0/M_AXIS_TEST] [get_bd_intf_pins tmr_0/${block}/microblaze_0/S0_AXIS]
  connect_bd_net [get_bd_pins tmr_0/${block}/LMB_Clk] [get_bd_pins tmr_0/${block}/tmr_comparator_GPIO_0/Clk]
  connect_bd_net [get_bd_pins tmr_0/${block}/ext_reset_in] [get_bd_pins tmr_0/${block}/tmr_comparator_GPIO_0/Rst]
  connect_bd_net [get_bd_pins tmr_0/${block}/tmr_manager_0/Test_Comparator] [get_bd_pins tmr_0/${block}/tmr_comparator_GPIO_0/Test_Comparator]
}

validate_bd_design
save_bd_design
