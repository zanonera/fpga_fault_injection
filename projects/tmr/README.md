# fpga_fault_injection
Xilinx Series 7 Fault Injection tests using uBlaze and Triple Modular Redundancy

## This folder
This folder contains the tests for uBlaze fault injections and TMR presented in this Xilinx [forum post](https://forums.xilinx.com/t5/Processor-System-Design-and-AXI/TMR-subsystem-comparator-test/td-p/912178)

The original work from there was modified to be used in a 7 Series Zynq using an Pynq-Z2 Board.

### Files
* Repo folder constains the firmware to be run on uBlaze
* Data folder constains the scripts for projection creation and bitstream generation

## Synthesis
* To create the project and run all process until the bitstream generation, just run the following command
```bash
        vivado -mode batch -source data/all.tcl
```
* To open the firmware workspace, just run the following command
```bash
        xsdk -workspace project_1/project_1.sdk
```

## Tools and harware
* Vivado Design Suite (It was used 2018.3)
* Pynq Z2 board based on the xc7z020 FPGA from Xilinx.
* FT2232H to provide one serial UART, used in test (115200)

## License
This project is licensed under GPLv3 - see the [LICENSE](https://github.com/zanonera/fpga_fault_injection/blob/main/LICENSE) file for details.
