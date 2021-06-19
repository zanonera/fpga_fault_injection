# fpga_fault_injection
Xilinx Series 7 Fault Injection tests using SEM IP Core

## This folder
This folder contains the tests for FPGA fault injections using SEM IP Core controlled using AXI Uart Lite

### Files


## Synthesis
* To create the project and run all process until the bitstream generation, just run the following command
```bash
        vivado -mode tcl -source all.tcl
```

## Tools and harware
* Vivado Design Suite (It was used 2018.3)
* Pynq Z2 board based on the xc7z020 FPGA from Xilinx.

## License
This project is licensed under GPLv3 - see the [LICENSE](https://github.com/zanonera/fpga_fault_injection/blob/main/LICENSE) file for details.
