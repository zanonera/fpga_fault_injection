
VIVADO_PARENT := $(shell which vivado)
VIVADO_BASE := $(shell dirname $(shell dirname $(VIVADO_PARENT)))
VIVADO = $(VIVADO_BASE)/bin/vivado
XVLOG = $(VIVADO_BASE)/bin/xvlog
XELAB = $(VIVADO_BASE)/bin/xelab
XSIM = $(VIVADO_BASE)/bin/xsim
GLBL = $(VIVADO_BASE)/data/verilog/src/glbl.v
TOOLCHAIN_PREFIX = riscv32-unknown-elf-
FOLDER=./picorv32-tmr/scripts/vivado/

export VIVADO

# work-around for http://svn.clifford.at/handicraft/2016/vivadosig11
export RDI_VERBOSE = False

help:
	@echo ""
	@echo "Simple synthesis tests:"
	@echo "  make synth_area_{small|regular|large}"
	@echo "  make synth_speed"
	@echo ""
	@echo "Example system:"
	@echo "  make synth_system"
	@echo "  make sim_system"
	@echo ""
	@echo "Timing and Utilization Evaluation:"
	@echo "  make table.txt"
	@echo "  make area"
	@echo ""
	@echo "Only a fast Simulation:"
	@echo "  make sim"
	@echo ""

synth_%:
	rm -f $@.log
	$(VIVADO) -nojournal -log $@.log -source ps7_create_project.tcl
	rm -rf .Xil fsm_encoding.os synth_*.backup.log usage_statistics_webtalk.*
	-grep -B4 -A10 'Slice LUTs' $@.log
	-grep -B1 -A9 ^Slack $@.log && echo

synth_system: firmware.hex

sim_system:
	@echo "Using Vivado from: $(VIVADO_BASE)"
	$(XVLOG) system_tb.v synth_system.v
	$(XVLOG) $(GLBL)
	$(XELAB) -s simul_synth --incr --debug all -L unifast_ver -L unisims_ver -R system_tb glbl

sim: firmware.hex
	@echo "Using Vivado from: $(VIVADO_BASE)"
	$(XVLOG) -sv system_tb.v system.v ../../picorv32_tmr.v ../../picorv32.v ../../word_voter.v
	$(XVLOG) $(GLBL)
	$(XELAB) -s simul_sim --incr --debug all -L unifast_ver -L unisims_ver -R system_tb glbl

sim_gui:
	$(XSIM) simul -view simul.wcfg -gui

firmware.hex: $(FOLDER)/firmware.S $(FOLDER)/firmware.c $(FOLDER)/firmware.lds
	$(TOOLCHAIN_PREFIX)gcc -Os -ffreestanding -nostdlib -o $(FOLDER)/firmware.elf $(FOLDER)/firmware.S $(FOLDER)/firmware.c \
		 --std=gnu99 -Wl,-Bstatic,-T,$(FOLDER)/firmware.lds,-Map,$(FOLDER)/firmware.map,--strip-debug -lgcc
	$(TOOLCHAIN_PREFIX)objcopy -O binary $(FOLDER)/firmware.elf $(FOLDER)/firmware.bin
	python3 ./picorv32-tmr/firmware/makehex.py $(FOLDER)/firmware.bin 4096 > $(FOLDER)firmware.hex

clean:
	rm -rf .Xil/ firmware.bin firmware.elf firmware.hex firmware.map synth_*.log
	rm -rf synth_*.mmi synth_*.bit synth_system.v table.txt tab_*/ webtalk.jou
	rm -rf webtalk.log webtalk_*.jou webtalk_*.log xelab.* xsim[._]* xvlog.* vivado*.str simul*.wdb

