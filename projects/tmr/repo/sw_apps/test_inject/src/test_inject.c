/*
 * MicroBlaze TMR comparator fault injection example.
 *
 * Assumes the hardware has a single 8-bit GPIO TMR Comparator connected to
 * the Pynq Z2 board LEDs, with the comparator AXI-Stream test interfaces
 * connected to MicroBlaze AXI-Stream interface 0.
 *
 * This example test only injects errors between CPU 1 and 2. A complete
 * test should inject errors between all CPUs and the voter checker.
 *
 * Requires optimization -O1 or greater.
 */

#include <stdio.h>
#include <xil_io.h>

#include <xtmr_manager.h>
#include <xtmr_manager_l.h>
#include <xtmr_inject.h>
#include <xtmr_inject_l.h>

#include <xparameters.h>
#include <mb_interface.h>

#define TOTAL_BITS 8


/* Fault injection function declaration.
 *
 * Attributes noinline and noclone are used to ensure that compiler optimization
 * does not inline or clone the function.
 *
 * Requires optimization -O1 or greater to ensure that the function code is
 * optimized, leaving the actual store instruction as the first instruction.
 */
void Xil_Out32_Inject(unsigned int addr, unsigned int data)
  __attribute__((noinline, noclone));

void Xil_Out32_Inject(unsigned int addr, unsigned int data)
{
    *(volatile unsigned int *)(addr) = data;
}

/* Fault injection instruction to replace the actual write data with 0 */
#define SWI_R0_R5 0xF8050000


int main()
{
    XTMR_Manager_Config *Config;
    XTMR_Inject_Config *InjectConfig;
    int bit, bitmask;
    int expected_error_count = 0;
    unsigned int ffr;
    unsigned int result;

    print("---Entering main---\r\n");

    /*
     * Do not generate fatal error when comparator errors are detected
     * by setting Block Fatal Error in the TMR Manager Control Register
     */
    Config = XTMR_Manager_LookupConfig(XPAR_TMR_MANAGER_0_DEVICE_ID);

    XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_CR_OFFSET,
        (1 << XTM_CR_BFR) | (Config->Magic2 << XTM_CR_MAGIC2) | Config->Magic1);

    /*
     * Set up TMR Inject and inject a fault in the GPIO comparator.
     *
     * This also turns on all LEDs on the board.
     */
    InjectConfig = XTMR_Inject_LookupConfig(XPAR_TMR_INJECT_0_DEVICE_ID);

    XTMR_Inject_WriteReg(InjectConfig->RegBaseAddr,
        XTI_AIR_OFFSET, Xil_Out32_Inject);

    XTMR_Inject_WriteReg(InjectConfig->RegBaseAddr, XTI_IIR_OFFSET, SWI_R0_R5);

    XTMR_Inject_WriteReg(InjectConfig->RegBaseAddr, XTI_CR_OFFSET,
        (1 << XTI_CR_INJ) | (1 << XTI_CR_CPU) | InjectConfig->MagicByte);

    bitmask = (1 << TOTAL_BITS) - 1;
    Xil_Out32_Inject(XPAR_GPIO_0_BASEADDR, bitmask);

    /*
     * Get and check status from GPIO comparator by reading from AXI-Stream 0
     */
    getfsl(result, 0);
    if (result != bitmask) {
        xil_printf("ERROR: Expected 0x%02x (found 0x%02x)\r\n",
            bitmask, result);
    }

    /*
     * Test each bit in the GPIO comparator.
     */
    for (bit = 0; bit < TOTAL_BITS; bit++) {
        /* Set up bit to force in GPIO comparator by writing to AXI-Stream 0 */
        bitmask = (1 << bit);
        putfsl(bitmask, 0);

        /* Inject comparison error between processor 1 and 2 in TMR Manager */
        XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_CFIR_OFFSET, 0x1);

        /* Read First Failing register in TMR Manager */
        ffr = XTMR_Manager_ReadReg(Config->RegBaseAddr, XTM_FFR_OFFSET);

        /* Return to nominal state in TMR Manager */
        XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_FFR_OFFSET, 0);
        XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_RFSR_OFFSET, 0);

        /* Check status from GPIO comparator by reading from AXI-Stream 0 */
        getfsl(result, 0);
        if (result != bitmask) {
            xil_printf("ERROR: Expected 0x%02x for bit %d (found 0x%02x)\r\n",
                bitmask, bit, result);
        }

        /* Check for expected error in TMR Manager */
        if (ffr == 0) {
            xil_printf("ERROR: Expected error did not occur for bit %d\r\n",
                bit);
        }

        /* Increment expected error count */
        if (result == bitmask && ffr != 0)
            expected_error_count++;
    }

    /* Restore TMR Comparator to nominal operation in TMR Manager */
    XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_CSCR_OFFSET, 0);

    /* Clear Block Fatal Error in TMR Manager */
    XTMR_Manager_WriteReg(Config->RegBaseAddr, XTM_CR_OFFSET, 0);

    /* Turn off the LEDs */
    Xil_Out32(XPAR_GPIO_0_BASEADDR, 0);

    if (expected_error_count == TOTAL_BITS)
        xil_printf("Found %d injected errors\r\n", expected_error_count);

    print("---Exiting main---\r\n");

    return 0;
}
