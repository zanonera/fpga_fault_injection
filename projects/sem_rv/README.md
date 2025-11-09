# fpga_fault_injection
Xilinx Series 7 Fault Injection tests using SEM IP Core

## This folder
This folder contains the tests for FPGA fault injections using the [PicoRV32](https://github.com/YosysHQ/picorv32) with Triple Modular Redundancy applied in this [repo](https://github.com/zanonera/picorv32-tmr).

### Files
* The modules of the experimental set-up and UART can be found in the hdl folder. This folder contains the source code for synthesis and simulation
* The TMRed PicoRv32 is a submodule, pointinh to its own repo
* The constraints folder contains the pin-out, bitstream and position of the design entity configuration. This design has a ILA for debug pupose.

## Synthesis
* To create the project and run all process until the bitstream generation, just run the following command
```bash
        vivado -mode tcl -source all.tcl
```

## Tools and harware
* Vivado Design Suite (It was used 2018.3)
* Pynq Z2 board based on the xc7z020 FPGA from Xilinx.
* Automatic configuration memory error-injection ([ACME](http://www.nebrija.es/aries/acme.htm)) tool.
* FT2232H to provide dual serial UART, used in tests

## License
This project is licensed under GPLv3 - see the [LICENSE](https://github.com/zanonera/fpga_fault_injection/blob/main/LICENSE) file for details.
