#include <stdio.h>
#include "xil_io.h"

#include "xparameters.h"
#include "xstatus.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "xuartps_hw.h"
#include "xil_printf.h"

/************************** Constant Definitions *****************************/
#define UARTLITE_DEVICE_ID	XPAR_UARTLITE_0_DEVICE_ID
#define PCFG_SEU_ERR_INT    0x00000020
#define TEST_BUFFER_SIZE    100

int SEMXUartLite_Initialize(XUartLite *InstancePtr, u16 DeviceId)
{
	XUartLite_Config *ConfigPtr;

	/*
	 * Assert validates the input arguments
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	/*
	 * Lookup the device configuration in the configuration table. Use this
	 * configuration info when initializing this component.
	 */
	ConfigPtr = XUartLite_LookupConfig(DeviceId);

	if (ConfigPtr == (XUartLite_Config *)NULL) {
		return XST_DEVICE_NOT_FOUND;
	}
	return XUartLite_CfgInitialize(InstancePtr, ConfigPtr,
					ConfigPtr->RegBaseAddr);
}

int main()
{
	XUartLite UartLite;		/* Instance of the UartLite Device */
	volatile unsigned int ctrl;
	volatile unsigned int value;
	volatile unsigned int reset;
    int Status;
	unsigned int SentCount;
	unsigned int ReceivedCount = 0;
	int Index;
	u8 SendBuffer[TEST_BUFFER_SIZE];	/* Buffer for Transmitting Data */
	u8 RecvBuffer;	/* Buffer for Receiving Data */

    xil_printf("Hello SEM World\n\r");

	/*
	 * Initialize the UartLite driver so that it is ready to use.
	 */
//	Status = SEMXUartLite_Initialize(&UartLite, UARTLITE_DEVICE_ID);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}

	/*
	 * Perform a self-test to ensure that the hardware was built correctly.
	 */
//	Status = XUartLite_SelfTest(&UartLite);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}

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

    u8 i = 0;
    u8 data;

//	while (i<=31) {
//		data = XUartLite_RecvByte(UartLite.RegBaseAddress);
//		xil_printf("%x",data);
//		//XUartPs_SendByte(XPAR_PS7_XADC_0_BASEADDR,data);
//		i++;
//	}

	// Send to Idle Mode
//	SendBuffer[0] = 0x49;
//	SendBuffer[1] = 0x0d;
//	SendBuffer[2] = 0x0a;
//
//	XUartLite_Send(&UartLite,SendBuffer,3);
//
//	// Reset the Core (Accepted only in Idle mode)
//	SendBuffer[0] = 0x52;
//	SendBuffer[1] = 0x20;
//	SendBuffer[2] = 0x30;
//	SendBuffer[3] = 0x30;
//	SendBuffer[4] = 0x0d;
//	SendBuffer[5] = 0x0a;
//
//	XUartLite_Send(&UartLite,SendBuffer,6);
//
//	i = 0;
//
//	while (i<=100) {
//		data = XUartLite_RecvByte(UartLite.RegBaseAddress);
//		xil_printf("%x",data);
//		//XUartPs_SendByte(XPAR_PS7_XADC_0_BASEADDR,data);
//		i++;
//	}

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

