set root_dir [file normalize  ./]
set constraints_dir $root_dir/constraints

# Create MicroBlaze Vivado IPI project
source data/bd.tcl
validate_bd_design
save_bd_design

# Triplicate the design and add GPIO Comparator AXI-Stream connection
source data/tmr.tcl

# Import wrapper
import_files -norecurse data/design_1_wrapper.v

# Generate output products
generate_target synthesis [get_files design_1.bd] -quiet

# Insert constraints
add_files -fileset constrs_1 $constraints_dir

# Export hardware
file mkdir project_1/project_1.sdk
write_hwdef -file project_1/project_1.sdk/design_1_wrapper.hdf

# Create software
exec xsct data/xsct.tcl project_1/project_1.sdk repo >& xsct.log

# Associate ELF file with all processors
set elf_filename project_1/project_1.sdk/test_inject/Debug/test_inject.elf
add_files -fileset sources_1 -norecurse -force $elf_filename
add_files -fileset sim_1 -norecurse -force $elf_filename
set_property SCOPED_TO_REF design_1 [get_files -all -of_objects [get_fileset sources_1] $elf_filename]
foreach block {MB1 MB2 MB3} { lappend cells "tmr_0/${block}/microblaze_0" }
set_property SCOPED_TO_CELLS $cells [get_files -all -of_objects [get_fileset sources_1] $elf_filename]

# Build hardware
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
