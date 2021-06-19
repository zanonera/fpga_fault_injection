set sdk_directory  [lindex $argv 0]
set repo_directory [lindex $argv 1]

setws $sdk_directory
repo -set $repo_directory
createhw -name design_1_wrapper -hwspec $sdk_directory/design_1_wrapper.hdf
createapp -name test_inject -app {TMR Comparator Fault Inject Example} -hwproject design_1_wrapper -proc tmr_0_MB1_microblaze_0
configapp -app test_inject compiler-optimization {Optimize most (-O3)}
projects -build
exit
