set project_name sem_uart_project 
set root_dir [file normalize  ./]
set constraints_dir $root_dir/constraints
set part_name xc7z020clg400-1

set proj_dir $root_dir/sem_uart_project

create_project -force $project_name $proj_dir -part $part_name
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]

create_bd_design "sem_bd"
source sem_uart_bd.tcl
validate_bd_design
regenerate_bd_layout
save_bd_design

make_wrapper -top -files [get_files $proj_dir/${project_name}.srcs/sources_1/bd/sem_bd/sem_bd.bd]
import_files -force -norecurse -fileset sources_1 $proj_dir/${project_name}.srcs/sources_1/bd/sem_bd/hdl/sem_bd_wrapper.v

set dut_files [list $root_dir/hdl/code/my_design.vhd \
                    $root_dir/hdl/code/system_top.v \
                    $root_dir/hdl/code/uart_tx6.vhd \
                    $root_dir/picorv32-tmr/word_voter.v \
                    $root_dir/picorv32-tmr/picorv32.v \
                    $root_dir/picorv32-tmr/picorv32_tmr.v \
                    $root_dir/picorv32-tmr/scripts/vivado/system.v]

set_property target_language VHDL [current_project]

foreach element $dut_files {
    add_files -norecurse $element
}

set_property file_type SystemVerilog [get_files $root_dir/picorv32-tmr/picorv32_tmr.v]
set_property file_type SystemVerilog [get_files $root_dir/picorv32-tmr/word_voter.v]
set_property file_type SystemVerilog [get_files $root_dir/picorv32-tmr/scripts/vivado/system.v]

add_files -fileset constrs_1 $constraints_dir

update_compile_order -fileset sources_1
