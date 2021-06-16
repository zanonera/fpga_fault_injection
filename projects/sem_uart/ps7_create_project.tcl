set project_name sem_uart_project 
set root_dir [file normalize  ./]
set part_name xc7z020clg400-1

set proj_dir $root_dir/sem_uart_project

create_project -force $project_name $proj_dir -part $part_name
set_property board_part tul.com.tw:pynq-z2:part0:1.0 [current_project]

create_bd_design "system"
source sem_uart_bd.tcl
validate_bd_design
regenerate_bd_layout
save_bd_design

make_wrapper -files [get_files ./sem_uart_project/sem_uart_project.srcs/sources_1/bd/system/system.bd] -top
add_files -norecurse ./$project_name/$project_name.srcs/sources_1/bd/system/hdl/system_wrapper.v

set dut_files [list $root_dir/hdl/code/checker.vhd \
                    $root_dir/hdl/code/fir10.vhd \
                    $root_dir/hdl/code/firdff.vhd \
                    $root_dir/hdl/code/inputROM.vhd \
                    $root_dir/hdl/code/my_design.vhd \
                    $root_dir/hdl/code/system_top.v \
                    $root_dir/hdl/code/top.vhd \
                    $root_dir/hdl/code/uart_tx6.vhd]

set_property target_language VHDL [current_project]

foreach element $dut_files {
    add_files -norecurse $element
}

update_compile_order -fileset sources_1
