source ps7_create_project.tcl

launch_runs synth_1 -jobs 4

wait_on_run synth_1

open_run synth_1

launch_runs impl_1 -to_step write_bitstream
wait_on_run impl_1
open_run impl_1

close_project

exit
