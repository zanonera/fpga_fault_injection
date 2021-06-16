# fpga_fault_injection
Xilinx Series 7 Fault Injection tests using SEM IP Core

## This repository
This repository contains the tests for FPGA fault injections presented in this [repo](https://github.com/LauraRgz/FPGA-Fault-Injection-Tutorial)

The original work from there was modified to be used in a 7 Series Zynq using an Pynq-Z2 Board.

Other addition was a tcl script based project creation and the instantiation of the SEM IP Core from within the Block Design.

### Files
* The modules of the experimental set-up and UART can be found in the hdl folder. This folder contains the source code for synthesis and simulation
* The constraints folder contains the pin-out, bitstream and position of the design entity configuration. This design has a ILA for debug pupose.

## Synthesis
* To create the project and run all process until the bitstream generation, just run the following command
		vivado -mode tcl -source all.tcl

## Tools and harware
* Vivado Design Suite (It was used 2018.3)
* Pynq Z2 board based on the xc7z020 FPGA from Xilinx.
* Automatic configuration memory error-injection ([ACME](http://www.nebrija.es/aries/acme.htm)) tool.
* FT2232H to provide dual serial UART, used in tests

## License
This project is licensed under GPLv3 - see the [LICENSE](https://github.com/LauraRgz/FPGA-Fault-Injection-Tutorial/blob/main/LICENSE.md) file for details.
