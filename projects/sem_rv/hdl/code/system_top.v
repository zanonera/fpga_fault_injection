module system_top(

// Block Design - DDR and Stuff
inout [14:0]DDR_addr,
inout [2:0]DDR_ba,
inout DDR_cas_n,
inout DDR_ck_n,
inout DDR_ck_p,
inout DDR_cke,
inout DDR_cs_n,
inout [3:0]DDR_dm,
inout [31:0]DDR_dq,
inout [3:0]DDR_dqs_n,
inout [3:0]DDR_dqs_p,
inout DDR_odt,
inout DDR_ras_n,
inout DDR_reset_n,
inout DDR_we_n,
inout FIXED_IO_ddr_vrn,
inout FIXED_IO_ddr_vrp,
inout [53:0]FIXED_IO_mio,
inout FIXED_IO_ps_clk,
inout FIXED_IO_ps_porb,
inout FIXED_IO_ps_srstb,

// Soft Error Mitigation UART
output sem_uart_txd_o,
input  sem_uart_rxd_i,

// FIR 1 DUT
output dut_uart_txd_o);

wire system_clk;
wire system_rstn;
wire sem_sts_injection;
wire byte_en;
wire [7:0] soc_data_out;

sem_bd_wrapper sem_bd_wrapper_i
   (.DDR_addr(DDR_addr),
    .DDR_ba(DDR_ba),
    .DDR_cas_n(DDR_cas_n),
    .DDR_ck_n(DDR_ck_n),
    .DDR_ck_p(DDR_ck_p),
    .DDR_cke(DDR_cke),
    .DDR_cs_n(DDR_cs_n),
    .DDR_dm(DDR_dm),
    .DDR_dq(DDR_dq),
    .DDR_dqs_n(DDR_dqs_n),
    .DDR_dqs_p(DDR_dqs_p),
    .DDR_odt(DDR_odt),
    .DDR_ras_n(DDR_ras_n),
    .DDR_reset_n(DDR_reset_n),
    .DDR_we_n(DDR_we_n),
    .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
    .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
    .FIXED_IO_mio(FIXED_IO_mio),
    .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
    .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
    .SEM_UART_rxd(sem_uart_rxd_i),
    .SEM_UART_txd(sem_uart_txd_o),
    .SEM_injection_0(sem_sts_injection),
    .axi_clk(system_clk),
    .axi_resetn(system_rstn)
    );
    
 system tiny_soc_i(
	.clk(system_clk),
	.resetn(system_rstn),
	.trap(),
	.out_byte(soc_data_out),
	.out_byte_en(byte_en)
);
    
my_design my_design_i(
    .clk(system_clk),                         // 100MHz FPGA Clock
	.rst(~system_rstn),                       // Reset
	.uart_enable(byte_en),
    .uart_data_in(soc_data_out),
    .uart_data_out(dut_uart_txd_o)            // DUT Serial Output
    ); 

endmodule