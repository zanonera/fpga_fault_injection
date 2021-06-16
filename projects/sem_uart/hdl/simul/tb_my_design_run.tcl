set project_name tb_my_design_simul 
set root_dir [file normalize  ./]

set sim_files [list $root_dir/tb_my_design.vhd\
                    $root_dir/tb_my_design_behav.wcfg]

set dut_files [list $root_dir/../code/checker.vhd \
                    $root_dir/../code/fir10.vhd \
                    $root_dir/../code/firdff.vhd \
                    $root_dir/../code/inputROM.vhd \
                    $root_dir/../code/my_design.vhd \
                    $root_dir/../code/top.vhd \
                    $root_dir/../code/uart_tx6.vhd]

set proj_dir $root_dir/$project_name
set part_name xc7z020clg400-1

create_project -force $project_name $proj_dir -part $part_name
set_property target_language VHDL [current_project]

foreach element $sim_files {
    add_files -fileset sim_1 -norecurse $element
}
foreach element $dut_files {
    add_files -norecurse $element
}

update_compile_order -fileset sim_1
launch_simulation
log_wave -r *
run 550us
start_gui
