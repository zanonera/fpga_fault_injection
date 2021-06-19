//Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2018.2 (lin64) Build 2258646 Thu Jun 14 20:02:38 MDT 2018
//Date        : Thu Nov 29 15:08:01 2018
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (led_8bits_tri_o,
    reset,
    rs232_uart_rxd,
    rs232_uart_txd,
    sysclk);
  output [7:0]led_8bits_tri_o;
  input reset;
  input rs232_uart_rxd;
  output rs232_uart_txd;
  input sysclk;

  wire [7:0]led_8bits_tri_o;
  wire reset;
  wire rs232_uart_baudoutn;
  wire rs232_uart_ddis;
  wire rs232_uart_dtrn;
  wire rs232_uart_out1n;
  wire rs232_uart_out2n;
  wire rs232_uart_rtsn;
  wire rs232_uart_rxd;
  wire rs232_uart_rxrdyn;
  wire rs232_uart_txd;
  wire rs232_uart_txrdyn;
  wire rs232_uart_xout;
  wire sysclk;

  design_1 design_1_i
       (.led_8bits_tri_o(led_8bits_tri_o),
        .reset(reset),
        .rs232_uart_baudoutn(rs232_uart_baudoutn),
        .rs232_uart_ddis(rs232_uart_ddis),
        .rs232_uart_dtrn(rs232_uart_dtrn),
        .rs232_uart_out1n(rs232_uart_out1n),
        .rs232_uart_out2n(rs232_uart_out2n),
        .rs232_uart_rtsn(rs232_uart_rtsn),
        .rs232_uart_rxd(rs232_uart_rxd),
        .rs232_uart_rxrdyn(rs232_uart_rxrdyn),
        .rs232_uart_txd(rs232_uart_txd),
        .rs232_uart_txrdyn(rs232_uart_txrdyn),
        .rs232_uart_xout(rs232_uart_xout),
        .sysclk(sysclk));
endmodule
