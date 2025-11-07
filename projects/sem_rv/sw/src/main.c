#include <stdio.h>
#include "xil_io.h"

#include "xparameters.h"
#include "xstatus.h"
#include "xuartps_hw.h"
#include "xil_printf.h"
#include "sleep.h"

/************************** Constant Definitions *****************************/
#define PCFG_SEU_ERR_INT    0x00000020
#define TEST_BUFFER_SIZE    100

int main()
{
	volatile unsigned int ctrl;
	volatile unsigned int reset;

    xil_printf("Hello SEM World\n\r");

    reset = Xil_In32(0xF8000240);
    xil_printf("RESETS: %08x\n\r",reset);

    Xil_Out32(0xF8000008,0x0000DF0DU);
    Xil_Out32(0xF8000240,0x0000000EU);  // to ensure icap_grant is 0

    ctrl = Xil_In32(0xF8007000);
    xil_printf("PCAP DEVCFG CTRL: %08x\n\r",ctrl);

    Xil_Out32(0xF8007000,(ctrl&(~0x08000000)));

    ctrl = Xil_In32(0xF8007000);
    xil_printf("ICAP DEVCFG CTRL: %08x\n\r",ctrl);

    sleep(5);

    xil_printf("ICAP granted\n\r");
    Xil_Out32(0xF8000240,0x0000000CU);  // icap_grant to 1

    reset = Xil_In32(0xF8000240);
    xil_printf("RESETS: %08x\n\r",reset);

    sleep(10);

    xil_printf("start monitoring\n\r");

    while (1) {
//    	sleep(1);
//    	value = Xil_In32(0xF800700C);
//    	xil_printf("DEVCFG INT_STS: %08x\n\r",value);
//    	if (value&PCFG_SEU_ERR_INT) {
//    		xil_printf("clearing...\n\r");
//    		// to ensure icap_grant is 0
//    	    Xil_Out32(0xF8000240,0x0000000EU);
//    	    reset = Xil_In32(0xF8000240);
//    	    xil_printf("RESETS: %08x\n\r",reset);
//    	    sleep(1);
//    	    // from ICAP to PCAP
//    	    ctrl = Xil_In32(0xF8007000);
//    	    xil_printf("ICAP DEVCFG CTRL: %08x\n\r",ctrl);
//    	    Xil_Out32(0xF8007000,(ctrl|(0x08000000)));
//    	    ctrl = Xil_In32(0xF8007000);
//    	    xil_printf("PCAP DEVCFG CTRL: %08x\n\r",ctrl);
//    	    sleep(1);
//    	    // clear INT_STS
//    	    Xil_Out32(0xF800700C,value);
//    	    // from PCAP to ICAP
//    	    ctrl = Xil_In32(0xF8007000);
//    	    xil_printf("PCAP DEVCFG CTRL: %08x\n\r",ctrl);
//    	    Xil_Out32(0xF8007000,(ctrl&(~0x08000000)));
//    	    ctrl = Xil_In32(0xF8007000);
//    	    xil_printf("ICAP DEVCFG CTRL: %08x\n\r",ctrl);
//    	    // icap_grant to 1
//    	    Xil_Out32(0xF8000240,0x0000000CU);
//    	    reset = Xil_In32(0xF8000240);
//    	    xil_printf("RESETS: %08x\n\r",reset);
//    	    sleep(1);
//    	}
    }

    return 0;
}
