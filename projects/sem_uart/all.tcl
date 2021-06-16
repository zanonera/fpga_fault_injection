source ps7_create_project.tcl

launch_runs synth_1 -jobs 4

wait_on_run synth_1

#opt_design 
place_design 
route_design

write_bitstream

close_project

exit
