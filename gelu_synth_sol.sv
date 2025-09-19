// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.1 (lin64) Build 3526262 Mon Apr 18 15:47:01 MDT 2022
// Date        : Wed Apr 16 15:29:54 2025
// Host        : iccad12 running 64-bit Red Hat Enterprise Linux release 8.10 (Ootpa)
// Command     : write_verilog -force -mode design gelu_synth_sol.sv
// Design      : gelu
// Purpose     : This is a Verilog netlist of the current design or from a specific cell of the design. The output is an
//               IEEE 1364-2001 compliant Verilog HDL file that contains netlist information obtained from the input
//               design files.
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* D_W = "32" *) (* SHIFT = "14" *) 
(* STRUCTURAL_NETLIST = "yes" *)
module gelu
   (clk,
    rst,
    in_valid,
    enable,
    qin,
    qb,
    qc,
    q1,
    out_valid,
    qout);
  input clk;
  input rst;
  input in_valid;
  input enable;
  input [31:0]qin;
  input [31:0]qb;
  input [31:0]qc;
  input [31:0]q1;
  output out_valid;
  output [31:0]qout;

  wire \<const0> ;
  wire \<const1> ;
  wire GND_2;
  wire VCC_2;
  wire clk;
  wire enable;
  wire in_v_r0_reg_r_n_0;
  wire in_v_r1_reg_r_n_0;
  wire in_v_r2_reg_r_n_0;
  wire in_v_r3_reg_r_n_0;
  wire in_v_r4_reg_r_n_0;
  wire in_v_r5_reg_r_n_0;
  wire in_v_r5_reg_srl6___in_v_r5_reg_r_n_0;
  wire in_v_r6_reg_gate_n_0;
  wire in_v_r6_reg_in_v_r6_reg_r_n_0;
  wire in_v_r6_reg_r_n_0;
  wire in_valid;
  wire out_valid;
  wire [31:0]p_0_in;
  wire p_0_in0;
  wire [31:0]q1;
  wire \q1_r3_reg[0]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[10]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[11]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[12]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[13]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[14]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[15]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[16]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[17]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[18]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[19]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[1]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[20]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[21]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[22]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[23]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[24]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[25]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[26]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[27]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[28]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[29]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[2]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[30]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[31]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[3]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[4]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[5]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[6]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[7]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[8]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r3_reg[9]_srl4___in_v_r3_reg_r_n_0 ;
  wire \q1_r4_reg[0]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[10]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[11]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[12]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[13]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[14]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[15]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[16]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[17]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[18]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[19]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[1]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[20]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[21]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[22]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[23]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[24]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[25]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[26]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[27]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[28]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[29]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[2]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[30]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[31]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[3]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[4]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[5]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[6]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[7]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[8]_in_v_r4_reg_r_n_0 ;
  wire \q1_r4_reg[9]_in_v_r4_reg_r_n_0 ;
  wire q1_r4_reg_gate__0_n_0;
  wire q1_r4_reg_gate__10_n_0;
  wire q1_r4_reg_gate__11_n_0;
  wire q1_r4_reg_gate__12_n_0;
  wire q1_r4_reg_gate__13_n_0;
  wire q1_r4_reg_gate__14_n_0;
  wire q1_r4_reg_gate__15_n_0;
  wire q1_r4_reg_gate__16_n_0;
  wire q1_r4_reg_gate__17_n_0;
  wire q1_r4_reg_gate__18_n_0;
  wire q1_r4_reg_gate__19_n_0;
  wire q1_r4_reg_gate__1_n_0;
  wire q1_r4_reg_gate__20_n_0;
  wire q1_r4_reg_gate__21_n_0;
  wire q1_r4_reg_gate__22_n_0;
  wire q1_r4_reg_gate__23_n_0;
  wire q1_r4_reg_gate__24_n_0;
  wire q1_r4_reg_gate__25_n_0;
  wire q1_r4_reg_gate__26_n_0;
  wire q1_r4_reg_gate__27_n_0;
  wire q1_r4_reg_gate__28_n_0;
  wire q1_r4_reg_gate__29_n_0;
  wire q1_r4_reg_gate__2_n_0;
  wire q1_r4_reg_gate__30_n_0;
  wire q1_r4_reg_gate__3_n_0;
  wire q1_r4_reg_gate__4_n_0;
  wire q1_r4_reg_gate__5_n_0;
  wire q1_r4_reg_gate__6_n_0;
  wire q1_r4_reg_gate__7_n_0;
  wire q1_r4_reg_gate__8_n_0;
  wire q1_r4_reg_gate__9_n_0;
  wire q1_r4_reg_gate_n_0;
  wire [31:0]q1_r5;
  wire [29:3]qabs;
  wire [31:1]qabs0;
  wire [31:0]qb;
  wire [31:0]qb_r0;
  wire [31:0]qc;
  wire \qc_r1_reg[0]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[10]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[11]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[12]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[13]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[14]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[15]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[16]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[17]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[18]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[19]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[1]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[20]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[21]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[22]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[23]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[24]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[25]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[26]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[27]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[28]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[29]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[2]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[30]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[31]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[3]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[4]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[5]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[6]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[7]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[8]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r1_reg[9]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qc_r2_reg[0]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[10]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[11]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[12]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[13]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[14]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[15]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[16]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[17]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[18]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[19]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[1]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[20]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[21]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[22]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[23]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[24]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[25]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[26]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[27]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[28]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[29]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[2]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[30]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[31]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[3]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[4]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[5]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[6]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[7]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[8]_in_v_r2_reg_r_n_0 ;
  wire \qc_r2_reg[9]_in_v_r2_reg_r_n_0 ;
  wire qc_r2_reg_gate__0_n_0;
  wire qc_r2_reg_gate__10_n_0;
  wire qc_r2_reg_gate__11_n_0;
  wire qc_r2_reg_gate__12_n_0;
  wire qc_r2_reg_gate__13_n_0;
  wire qc_r2_reg_gate__14_n_0;
  wire qc_r2_reg_gate__15_n_0;
  wire qc_r2_reg_gate__16_n_0;
  wire qc_r2_reg_gate__17_n_0;
  wire qc_r2_reg_gate__18_n_0;
  wire qc_r2_reg_gate__19_n_0;
  wire qc_r2_reg_gate__1_n_0;
  wire qc_r2_reg_gate__20_n_0;
  wire qc_r2_reg_gate__21_n_0;
  wire qc_r2_reg_gate__22_n_0;
  wire qc_r2_reg_gate__23_n_0;
  wire qc_r2_reg_gate__24_n_0;
  wire qc_r2_reg_gate__25_n_0;
  wire qc_r2_reg_gate__26_n_0;
  wire qc_r2_reg_gate__27_n_0;
  wire qc_r2_reg_gate__28_n_0;
  wire qc_r2_reg_gate__29_n_0;
  wire qc_r2_reg_gate__2_n_0;
  wire qc_r2_reg_gate__30_n_0;
  wire qc_r2_reg_gate__3_n_0;
  wire qc_r2_reg_gate__4_n_0;
  wire qc_r2_reg_gate__5_n_0;
  wire qc_r2_reg_gate__6_n_0;
  wire qc_r2_reg_gate__7_n_0;
  wire qc_r2_reg_gate__8_n_0;
  wire qc_r2_reg_gate__9_n_0;
  wire qc_r2_reg_gate_n_0;
  wire [31:0]qc_r3;
  wire [31:14]qerf0;
  wire [30:0]qerf_r5;
  wire \qerf_r5[0]_i_1_n_0 ;
  wire \qerf_r5[10]_i_1_n_0 ;
  wire \qerf_r5[10]_i_3_n_0 ;
  wire \qerf_r5[10]_i_4_n_0 ;
  wire \qerf_r5[10]_i_5_n_0 ;
  wire \qerf_r5[10]_i_6_n_0 ;
  wire \qerf_r5[11]_i_1_n_0 ;
  wire \qerf_r5[12]_i_1_n_0 ;
  wire \qerf_r5[13]_i_1_n_0 ;
  wire \qerf_r5[14]_i_1_n_0 ;
  wire \qerf_r5[14]_i_3_n_0 ;
  wire \qerf_r5[14]_i_4_n_0 ;
  wire \qerf_r5[14]_i_5_n_0 ;
  wire \qerf_r5[14]_i_6_n_0 ;
  wire \qerf_r5[15]_i_1_n_0 ;
  wire \qerf_r5[16]_i_1_n_0 ;
  wire \qerf_r5[1]_i_1_n_0 ;
  wire \qerf_r5[2]_i_10_n_0 ;
  wire \qerf_r5[2]_i_11_n_0 ;
  wire \qerf_r5[2]_i_12_n_0 ;
  wire \qerf_r5[2]_i_14_n_0 ;
  wire \qerf_r5[2]_i_15_n_0 ;
  wire \qerf_r5[2]_i_16_n_0 ;
  wire \qerf_r5[2]_i_17_n_0 ;
  wire \qerf_r5[2]_i_18_n_0 ;
  wire \qerf_r5[2]_i_19_n_0 ;
  wire \qerf_r5[2]_i_1_n_0 ;
  wire \qerf_r5[2]_i_20_n_0 ;
  wire \qerf_r5[2]_i_21_n_0 ;
  wire \qerf_r5[2]_i_22_n_0 ;
  wire \qerf_r5[2]_i_4_n_0 ;
  wire \qerf_r5[2]_i_5_n_0 ;
  wire \qerf_r5[2]_i_6_n_0 ;
  wire \qerf_r5[2]_i_7_n_0 ;
  wire \qerf_r5[2]_i_9_n_0 ;
  wire \qerf_r5[30]_i_3_n_0 ;
  wire \qerf_r5[30]_i_4_n_0 ;
  wire \qerf_r5[30]_i_5_n_0 ;
  wire \qerf_r5[3]_i_1_n_0 ;
  wire \qerf_r5[4]_i_1_n_0 ;
  wire \qerf_r5[5]_i_1_n_0 ;
  wire \qerf_r5[6]_i_1_n_0 ;
  wire \qerf_r5[6]_i_3_n_0 ;
  wire \qerf_r5[6]_i_4_n_0 ;
  wire \qerf_r5[6]_i_5_n_0 ;
  wire \qerf_r5[6]_i_6_n_0 ;
  wire \qerf_r5[7]_i_1_n_0 ;
  wire \qerf_r5[8]_i_1_n_0 ;
  wire \qerf_r5[9]_i_1_n_0 ;
  wire \qerf_r5_reg[10]_i_2_n_0 ;
  wire \qerf_r5_reg[10]_i_2_n_1 ;
  wire \qerf_r5_reg[10]_i_2_n_2 ;
  wire \qerf_r5_reg[10]_i_2_n_3 ;
  wire \qerf_r5_reg[14]_i_2_n_0 ;
  wire \qerf_r5_reg[14]_i_2_n_1 ;
  wire \qerf_r5_reg[14]_i_2_n_2 ;
  wire \qerf_r5_reg[14]_i_2_n_3 ;
  wire \qerf_r5_reg[2]_i_13_n_0 ;
  wire \qerf_r5_reg[2]_i_13_n_1 ;
  wire \qerf_r5_reg[2]_i_13_n_2 ;
  wire \qerf_r5_reg[2]_i_13_n_3 ;
  wire \qerf_r5_reg[2]_i_2_n_0 ;
  wire \qerf_r5_reg[2]_i_2_n_1 ;
  wire \qerf_r5_reg[2]_i_2_n_2 ;
  wire \qerf_r5_reg[2]_i_2_n_3 ;
  wire \qerf_r5_reg[2]_i_3_n_0 ;
  wire \qerf_r5_reg[2]_i_3_n_1 ;
  wire \qerf_r5_reg[2]_i_3_n_2 ;
  wire \qerf_r5_reg[2]_i_3_n_3 ;
  wire \qerf_r5_reg[2]_i_8_n_0 ;
  wire \qerf_r5_reg[2]_i_8_n_1 ;
  wire \qerf_r5_reg[2]_i_8_n_2 ;
  wire \qerf_r5_reg[2]_i_8_n_3 ;
  wire \qerf_r5_reg[30]_i_2_n_2 ;
  wire \qerf_r5_reg[30]_i_2_n_3 ;
  wire \qerf_r5_reg[6]_i_2_n_0 ;
  wire \qerf_r5_reg[6]_i_2_n_1 ;
  wire \qerf_r5_reg[6]_i_2_n_2 ;
  wire \qerf_r5_reg[6]_i_2_n_3 ;
  wire [31:0]qin;
  wire [31:0]qin_r0;
  wire \qin_r2_reg[0]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[10]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[11]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[12]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[13]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[14]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[15]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[16]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[17]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[18]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[19]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[1]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[20]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[21]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[22]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[23]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[24]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[25]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[26]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[27]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[28]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[29]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[2]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[30]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[31]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[3]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[4]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[5]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[6]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[7]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[8]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r2_reg[9]_srl2___in_v_r1_reg_r_n_0 ;
  wire \qin_r3_reg[0]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[10]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[11]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[12]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[13]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[14]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[15]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[16]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[17]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[18]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[19]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[1]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[20]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[21]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[22]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[23]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[24]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[25]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[26]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[27]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[28]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[29]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[2]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[30]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[31]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[3]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[4]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[5]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[6]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[7]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[8]_in_v_r2_reg_r_n_0 ;
  wire \qin_r3_reg[9]_in_v_r2_reg_r_n_0 ;
  wire qin_r3_reg_gate__0_n_0;
  wire qin_r3_reg_gate__10_n_0;
  wire qin_r3_reg_gate__11_n_0;
  wire qin_r3_reg_gate__12_n_0;
  wire qin_r3_reg_gate__13_n_0;
  wire qin_r3_reg_gate__14_n_0;
  wire qin_r3_reg_gate__15_n_0;
  wire qin_r3_reg_gate__16_n_0;
  wire qin_r3_reg_gate__17_n_0;
  wire qin_r3_reg_gate__18_n_0;
  wire qin_r3_reg_gate__19_n_0;
  wire qin_r3_reg_gate__1_n_0;
  wire qin_r3_reg_gate__20_n_0;
  wire qin_r3_reg_gate__21_n_0;
  wire qin_r3_reg_gate__22_n_0;
  wire qin_r3_reg_gate__23_n_0;
  wire qin_r3_reg_gate__24_n_0;
  wire qin_r3_reg_gate__25_n_0;
  wire qin_r3_reg_gate__26_n_0;
  wire qin_r3_reg_gate__27_n_0;
  wire qin_r3_reg_gate__28_n_0;
  wire qin_r3_reg_gate__29_n_0;
  wire qin_r3_reg_gate__2_n_0;
  wire qin_r3_reg_gate__30_n_0;
  wire qin_r3_reg_gate__3_n_0;
  wire qin_r3_reg_gate__4_n_0;
  wire qin_r3_reg_gate__5_n_0;
  wire qin_r3_reg_gate__6_n_0;
  wire qin_r3_reg_gate__7_n_0;
  wire qin_r3_reg_gate__8_n_0;
  wire qin_r3_reg_gate__9_n_0;
  wire qin_r3_reg_gate_n_0;
  wire [31:0]qin_r4;
  wire [31:1]ql_r21;
  wire ql_r30__0_i_10_n_0;
  wire ql_r30__0_i_11_n_0;
  wire ql_r30__0_i_12_n_0;
  wire ql_r30__0_i_13_n_0;
  wire ql_r30__0_i_14_n_0;
  wire ql_r30__0_i_15_n_0;
  wire ql_r30__0_i_16_n_0;
  wire ql_r30__0_i_17_n_0;
  wire ql_r30__0_i_18_n_0;
  wire ql_r30__0_i_19_n_0;
  wire ql_r30__0_i_1_n_0;
  wire ql_r30__0_i_1_n_1;
  wire ql_r30__0_i_1_n_2;
  wire ql_r30__0_i_1_n_3;
  wire ql_r30__0_i_1_n_4;
  wire ql_r30__0_i_1_n_5;
  wire ql_r30__0_i_1_n_6;
  wire ql_r30__0_i_1_n_7;
  wire ql_r30__0_i_2_n_0;
  wire ql_r30__0_i_2_n_1;
  wire ql_r30__0_i_2_n_2;
  wire ql_r30__0_i_2_n_3;
  wire ql_r30__0_i_2_n_4;
  wire ql_r30__0_i_2_n_5;
  wire ql_r30__0_i_2_n_6;
  wire ql_r30__0_i_2_n_7;
  wire ql_r30__0_i_3_n_0;
  wire ql_r30__0_i_3_n_1;
  wire ql_r30__0_i_3_n_2;
  wire ql_r30__0_i_3_n_3;
  wire ql_r30__0_i_3_n_4;
  wire ql_r30__0_i_3_n_5;
  wire ql_r30__0_i_3_n_6;
  wire ql_r30__0_i_3_n_7;
  wire ql_r30__0_i_4_n_0;
  wire ql_r30__0_i_4_n_1;
  wire ql_r30__0_i_4_n_2;
  wire ql_r30__0_i_4_n_3;
  wire ql_r30__0_i_4_n_4;
  wire ql_r30__0_i_4_n_5;
  wire ql_r30__0_i_4_n_6;
  wire ql_r30__0_i_4_n_7;
  wire ql_r30__0_i_5_n_0;
  wire ql_r30__0_i_6_n_0;
  wire ql_r30__0_i_7_n_0;
  wire ql_r30__0_i_8_n_0;
  wire ql_r30__0_i_9_n_0;
  wire ql_r30__0_n_100;
  wire ql_r30__0_n_101;
  wire ql_r30__0_n_102;
  wire ql_r30__0_n_103;
  wire ql_r30__0_n_104;
  wire ql_r30__0_n_105;
  wire ql_r30__0_n_106;
  wire ql_r30__0_n_107;
  wire ql_r30__0_n_108;
  wire ql_r30__0_n_109;
  wire ql_r30__0_n_110;
  wire ql_r30__0_n_111;
  wire ql_r30__0_n_112;
  wire ql_r30__0_n_113;
  wire ql_r30__0_n_114;
  wire ql_r30__0_n_115;
  wire ql_r30__0_n_116;
  wire ql_r30__0_n_117;
  wire ql_r30__0_n_118;
  wire ql_r30__0_n_119;
  wire ql_r30__0_n_120;
  wire ql_r30__0_n_121;
  wire ql_r30__0_n_122;
  wire ql_r30__0_n_123;
  wire ql_r30__0_n_124;
  wire ql_r30__0_n_125;
  wire ql_r30__0_n_126;
  wire ql_r30__0_n_127;
  wire ql_r30__0_n_128;
  wire ql_r30__0_n_129;
  wire ql_r30__0_n_130;
  wire ql_r30__0_n_131;
  wire ql_r30__0_n_132;
  wire ql_r30__0_n_133;
  wire ql_r30__0_n_134;
  wire ql_r30__0_n_135;
  wire ql_r30__0_n_136;
  wire ql_r30__0_n_137;
  wire ql_r30__0_n_138;
  wire ql_r30__0_n_139;
  wire ql_r30__0_n_140;
  wire ql_r30__0_n_141;
  wire ql_r30__0_n_142;
  wire ql_r30__0_n_143;
  wire ql_r30__0_n_144;
  wire ql_r30__0_n_145;
  wire ql_r30__0_n_146;
  wire ql_r30__0_n_147;
  wire ql_r30__0_n_148;
  wire ql_r30__0_n_149;
  wire ql_r30__0_n_150;
  wire ql_r30__0_n_151;
  wire ql_r30__0_n_152;
  wire ql_r30__0_n_153;
  wire ql_r30__0_n_24;
  wire ql_r30__0_n_25;
  wire ql_r30__0_n_26;
  wire ql_r30__0_n_27;
  wire ql_r30__0_n_28;
  wire ql_r30__0_n_29;
  wire ql_r30__0_n_30;
  wire ql_r30__0_n_31;
  wire ql_r30__0_n_32;
  wire ql_r30__0_n_33;
  wire ql_r30__0_n_34;
  wire ql_r30__0_n_35;
  wire ql_r30__0_n_36;
  wire ql_r30__0_n_37;
  wire ql_r30__0_n_38;
  wire ql_r30__0_n_39;
  wire ql_r30__0_n_40;
  wire ql_r30__0_n_41;
  wire ql_r30__0_n_42;
  wire ql_r30__0_n_43;
  wire ql_r30__0_n_44;
  wire ql_r30__0_n_45;
  wire ql_r30__0_n_46;
  wire ql_r30__0_n_47;
  wire ql_r30__0_n_48;
  wire ql_r30__0_n_49;
  wire ql_r30__0_n_50;
  wire ql_r30__0_n_51;
  wire ql_r30__0_n_52;
  wire ql_r30__0_n_53;
  wire ql_r30__0_n_58;
  wire ql_r30__0_n_59;
  wire ql_r30__0_n_60;
  wire ql_r30__0_n_61;
  wire ql_r30__0_n_62;
  wire ql_r30__0_n_63;
  wire ql_r30__0_n_64;
  wire ql_r30__0_n_65;
  wire ql_r30__0_n_66;
  wire ql_r30__0_n_67;
  wire ql_r30__0_n_68;
  wire ql_r30__0_n_69;
  wire ql_r30__0_n_70;
  wire ql_r30__0_n_71;
  wire ql_r30__0_n_72;
  wire ql_r30__0_n_73;
  wire ql_r30__0_n_74;
  wire ql_r30__0_n_75;
  wire ql_r30__0_n_76;
  wire ql_r30__0_n_77;
  wire ql_r30__0_n_78;
  wire ql_r30__0_n_79;
  wire ql_r30__0_n_80;
  wire ql_r30__0_n_81;
  wire ql_r30__0_n_82;
  wire ql_r30__0_n_83;
  wire ql_r30__0_n_84;
  wire ql_r30__0_n_85;
  wire ql_r30__0_n_86;
  wire ql_r30__0_n_87;
  wire ql_r30__0_n_88;
  wire ql_r30__0_n_89;
  wire ql_r30__0_n_90;
  wire ql_r30__0_n_91;
  wire ql_r30__0_n_92;
  wire ql_r30__0_n_93;
  wire ql_r30__0_n_94;
  wire ql_r30__0_n_95;
  wire ql_r30__0_n_96;
  wire ql_r30__0_n_97;
  wire ql_r30__0_n_98;
  wire ql_r30__0_n_99;
  wire ql_r30_i_10_n_0;
  wire ql_r30_i_11_n_0;
  wire ql_r30_i_12_n_0;
  wire ql_r30_i_13_n_0;
  wire ql_r30_i_14_n_0;
  wire ql_r30_i_15_n_0;
  wire ql_r30_i_16_n_0;
  wire ql_r30_i_17_n_0;
  wire ql_r30_i_18_n_0;
  wire ql_r30_i_19_n_0;
  wire ql_r30_i_1_n_1;
  wire ql_r30_i_1_n_2;
  wire ql_r30_i_1_n_3;
  wire ql_r30_i_1_n_4;
  wire ql_r30_i_1_n_5;
  wire ql_r30_i_1_n_6;
  wire ql_r30_i_1_n_7;
  wire ql_r30_i_20_n_0;
  wire ql_r30_i_2_n_0;
  wire ql_r30_i_2_n_1;
  wire ql_r30_i_2_n_2;
  wire ql_r30_i_2_n_3;
  wire ql_r30_i_2_n_4;
  wire ql_r30_i_2_n_5;
  wire ql_r30_i_2_n_6;
  wire ql_r30_i_2_n_7;
  wire ql_r30_i_3_n_0;
  wire ql_r30_i_3_n_1;
  wire ql_r30_i_3_n_2;
  wire ql_r30_i_3_n_3;
  wire ql_r30_i_3_n_4;
  wire ql_r30_i_3_n_5;
  wire ql_r30_i_3_n_6;
  wire ql_r30_i_3_n_7;
  wire ql_r30_i_4_n_0;
  wire ql_r30_i_4_n_1;
  wire ql_r30_i_4_n_2;
  wire ql_r30_i_4_n_3;
  wire ql_r30_i_4_n_4;
  wire ql_r30_i_4_n_5;
  wire ql_r30_i_4_n_6;
  wire ql_r30_i_4_n_7;
  wire ql_r30_i_5_n_0;
  wire ql_r30_i_6_n_0;
  wire ql_r30_i_7_n_0;
  wire ql_r30_i_8_n_0;
  wire ql_r30_i_9_n_0;
  wire ql_r30_n_100;
  wire ql_r30_n_101;
  wire ql_r30_n_102;
  wire ql_r30_n_103;
  wire ql_r30_n_104;
  wire ql_r30_n_105;
  wire ql_r30_n_106;
  wire ql_r30_n_107;
  wire ql_r30_n_108;
  wire ql_r30_n_109;
  wire ql_r30_n_110;
  wire ql_r30_n_111;
  wire ql_r30_n_112;
  wire ql_r30_n_113;
  wire ql_r30_n_114;
  wire ql_r30_n_115;
  wire ql_r30_n_116;
  wire ql_r30_n_117;
  wire ql_r30_n_118;
  wire ql_r30_n_119;
  wire ql_r30_n_120;
  wire ql_r30_n_121;
  wire ql_r30_n_122;
  wire ql_r30_n_123;
  wire ql_r30_n_124;
  wire ql_r30_n_125;
  wire ql_r30_n_126;
  wire ql_r30_n_127;
  wire ql_r30_n_128;
  wire ql_r30_n_129;
  wire ql_r30_n_130;
  wire ql_r30_n_131;
  wire ql_r30_n_132;
  wire ql_r30_n_133;
  wire ql_r30_n_134;
  wire ql_r30_n_135;
  wire ql_r30_n_136;
  wire ql_r30_n_137;
  wire ql_r30_n_138;
  wire ql_r30_n_139;
  wire ql_r30_n_140;
  wire ql_r30_n_141;
  wire ql_r30_n_142;
  wire ql_r30_n_143;
  wire ql_r30_n_144;
  wire ql_r30_n_145;
  wire ql_r30_n_146;
  wire ql_r30_n_147;
  wire ql_r30_n_148;
  wire ql_r30_n_149;
  wire ql_r30_n_150;
  wire ql_r30_n_151;
  wire ql_r30_n_152;
  wire ql_r30_n_153;
  wire ql_r30_n_58;
  wire ql_r30_n_59;
  wire ql_r30_n_60;
  wire ql_r30_n_61;
  wire ql_r30_n_62;
  wire ql_r30_n_63;
  wire ql_r30_n_64;
  wire ql_r30_n_65;
  wire ql_r30_n_66;
  wire ql_r30_n_67;
  wire ql_r30_n_68;
  wire ql_r30_n_69;
  wire ql_r30_n_70;
  wire ql_r30_n_71;
  wire ql_r30_n_72;
  wire ql_r30_n_73;
  wire ql_r30_n_74;
  wire ql_r30_n_75;
  wire ql_r30_n_76;
  wire ql_r30_n_77;
  wire ql_r30_n_78;
  wire ql_r30_n_79;
  wire ql_r30_n_80;
  wire ql_r30_n_81;
  wire ql_r30_n_82;
  wire ql_r30_n_83;
  wire ql_r30_n_84;
  wire ql_r30_n_85;
  wire ql_r30_n_86;
  wire ql_r30_n_87;
  wire ql_r30_n_88;
  wire ql_r30_n_89;
  wire ql_r30_n_90;
  wire ql_r30_n_91;
  wire ql_r30_n_92;
  wire ql_r30_n_93;
  wire ql_r30_n_94;
  wire ql_r30_n_95;
  wire ql_r30_n_96;
  wire ql_r30_n_97;
  wire ql_r30_n_98;
  wire ql_r30_n_99;
  wire \ql_r3_reg[0]__0_n_0 ;
  wire \ql_r3_reg[10]__0_n_0 ;
  wire \ql_r3_reg[11]__0_n_0 ;
  wire \ql_r3_reg[12]__0_n_0 ;
  wire \ql_r3_reg[13]__0_n_0 ;
  wire \ql_r3_reg[14]__0_n_0 ;
  wire \ql_r3_reg[15]__0_n_0 ;
  wire \ql_r3_reg[16]__0_n_0 ;
  wire \ql_r3_reg[1]__0_n_0 ;
  wire \ql_r3_reg[2]__0_n_0 ;
  wire \ql_r3_reg[3]__0_n_0 ;
  wire \ql_r3_reg[4]__0_n_0 ;
  wire \ql_r3_reg[5]__0_n_0 ;
  wire \ql_r3_reg[6]__0_n_0 ;
  wire \ql_r3_reg[7]__0_n_0 ;
  wire \ql_r3_reg[8]__0_n_0 ;
  wire \ql_r3_reg[9]__0_n_0 ;
  wire [31:16]ql_r3_reg__0;
  wire ql_r3_reg_n_100;
  wire ql_r3_reg_n_101;
  wire ql_r3_reg_n_102;
  wire ql_r3_reg_n_103;
  wire ql_r3_reg_n_104;
  wire ql_r3_reg_n_105;
  wire ql_r3_reg_n_58;
  wire ql_r3_reg_n_59;
  wire ql_r3_reg_n_60;
  wire ql_r3_reg_n_61;
  wire ql_r3_reg_n_62;
  wire ql_r3_reg_n_63;
  wire ql_r3_reg_n_64;
  wire ql_r3_reg_n_65;
  wire ql_r3_reg_n_66;
  wire ql_r3_reg_n_67;
  wire ql_r3_reg_n_68;
  wire ql_r3_reg_n_69;
  wire ql_r3_reg_n_70;
  wire ql_r3_reg_n_71;
  wire ql_r3_reg_n_72;
  wire ql_r3_reg_n_73;
  wire ql_r3_reg_n_74;
  wire ql_r3_reg_n_75;
  wire ql_r3_reg_n_76;
  wire ql_r3_reg_n_77;
  wire ql_r3_reg_n_78;
  wire ql_r3_reg_n_79;
  wire ql_r3_reg_n_80;
  wire ql_r3_reg_n_81;
  wire ql_r3_reg_n_82;
  wire ql_r3_reg_n_83;
  wire ql_r3_reg_n_84;
  wire ql_r3_reg_n_85;
  wire ql_r3_reg_n_86;
  wire ql_r3_reg_n_87;
  wire ql_r3_reg_n_88;
  wire ql_r3_reg_n_89;
  wire ql_r3_reg_n_90;
  wire ql_r3_reg_n_91;
  wire ql_r3_reg_n_92;
  wire ql_r3_reg_n_93;
  wire ql_r3_reg_n_94;
  wire ql_r3_reg_n_95;
  wire ql_r3_reg_n_96;
  wire ql_r3_reg_n_97;
  wire ql_r3_reg_n_98;
  wire ql_r3_reg_n_99;
  wire [31:0]ql_r4;
  wire \ql_r4[11]_i_2_n_0 ;
  wire \ql_r4[11]_i_3_n_0 ;
  wire \ql_r4[11]_i_4_n_0 ;
  wire \ql_r4[11]_i_5_n_0 ;
  wire \ql_r4[15]_i_2_n_0 ;
  wire \ql_r4[15]_i_3_n_0 ;
  wire \ql_r4[15]_i_4_n_0 ;
  wire \ql_r4[15]_i_5_n_0 ;
  wire \ql_r4[19]_i_3_n_0 ;
  wire \ql_r4[19]_i_4_n_0 ;
  wire \ql_r4[19]_i_5_n_0 ;
  wire \ql_r4[19]_i_6_n_0 ;
  wire \ql_r4[19]_i_7_n_0 ;
  wire \ql_r4[19]_i_8_n_0 ;
  wire \ql_r4[19]_i_9_n_0 ;
  wire \ql_r4[23]_i_10_n_0 ;
  wire \ql_r4[23]_i_3_n_0 ;
  wire \ql_r4[23]_i_4_n_0 ;
  wire \ql_r4[23]_i_5_n_0 ;
  wire \ql_r4[23]_i_6_n_0 ;
  wire \ql_r4[23]_i_7_n_0 ;
  wire \ql_r4[23]_i_8_n_0 ;
  wire \ql_r4[23]_i_9_n_0 ;
  wire \ql_r4[27]_i_10_n_0 ;
  wire \ql_r4[27]_i_3_n_0 ;
  wire \ql_r4[27]_i_4_n_0 ;
  wire \ql_r4[27]_i_5_n_0 ;
  wire \ql_r4[27]_i_6_n_0 ;
  wire \ql_r4[27]_i_7_n_0 ;
  wire \ql_r4[27]_i_8_n_0 ;
  wire \ql_r4[27]_i_9_n_0 ;
  wire \ql_r4[31]_i_10_n_0 ;
  wire \ql_r4[31]_i_3_n_0 ;
  wire \ql_r4[31]_i_4_n_0 ;
  wire \ql_r4[31]_i_5_n_0 ;
  wire \ql_r4[31]_i_6_n_0 ;
  wire \ql_r4[31]_i_7_n_0 ;
  wire \ql_r4[31]_i_8_n_0 ;
  wire \ql_r4[31]_i_9_n_0 ;
  wire \ql_r4[3]_i_2_n_0 ;
  wire \ql_r4[3]_i_3_n_0 ;
  wire \ql_r4[3]_i_4_n_0 ;
  wire \ql_r4[3]_i_5_n_0 ;
  wire \ql_r4[7]_i_2_n_0 ;
  wire \ql_r4[7]_i_3_n_0 ;
  wire \ql_r4[7]_i_4_n_0 ;
  wire \ql_r4[7]_i_5_n_0 ;
  wire \ql_r4_reg[11]_i_1_n_0 ;
  wire \ql_r4_reg[11]_i_1_n_1 ;
  wire \ql_r4_reg[11]_i_1_n_2 ;
  wire \ql_r4_reg[11]_i_1_n_3 ;
  wire \ql_r4_reg[11]_i_1_n_4 ;
  wire \ql_r4_reg[11]_i_1_n_5 ;
  wire \ql_r4_reg[11]_i_1_n_6 ;
  wire \ql_r4_reg[11]_i_1_n_7 ;
  wire \ql_r4_reg[15]_i_1_n_0 ;
  wire \ql_r4_reg[15]_i_1_n_1 ;
  wire \ql_r4_reg[15]_i_1_n_2 ;
  wire \ql_r4_reg[15]_i_1_n_3 ;
  wire \ql_r4_reg[15]_i_1_n_4 ;
  wire \ql_r4_reg[15]_i_1_n_5 ;
  wire \ql_r4_reg[15]_i_1_n_6 ;
  wire \ql_r4_reg[15]_i_1_n_7 ;
  wire \ql_r4_reg[19]_i_1_n_0 ;
  wire \ql_r4_reg[19]_i_1_n_1 ;
  wire \ql_r4_reg[19]_i_1_n_2 ;
  wire \ql_r4_reg[19]_i_1_n_3 ;
  wire \ql_r4_reg[19]_i_1_n_4 ;
  wire \ql_r4_reg[19]_i_1_n_5 ;
  wire \ql_r4_reg[19]_i_1_n_6 ;
  wire \ql_r4_reg[19]_i_1_n_7 ;
  wire \ql_r4_reg[19]_i_2_n_0 ;
  wire \ql_r4_reg[19]_i_2_n_1 ;
  wire \ql_r4_reg[19]_i_2_n_2 ;
  wire \ql_r4_reg[19]_i_2_n_3 ;
  wire \ql_r4_reg[23]_i_1_n_0 ;
  wire \ql_r4_reg[23]_i_1_n_1 ;
  wire \ql_r4_reg[23]_i_1_n_2 ;
  wire \ql_r4_reg[23]_i_1_n_3 ;
  wire \ql_r4_reg[23]_i_1_n_4 ;
  wire \ql_r4_reg[23]_i_1_n_5 ;
  wire \ql_r4_reg[23]_i_1_n_6 ;
  wire \ql_r4_reg[23]_i_1_n_7 ;
  wire \ql_r4_reg[23]_i_2_n_0 ;
  wire \ql_r4_reg[23]_i_2_n_1 ;
  wire \ql_r4_reg[23]_i_2_n_2 ;
  wire \ql_r4_reg[23]_i_2_n_3 ;
  wire \ql_r4_reg[27]_i_1_n_0 ;
  wire \ql_r4_reg[27]_i_1_n_1 ;
  wire \ql_r4_reg[27]_i_1_n_2 ;
  wire \ql_r4_reg[27]_i_1_n_3 ;
  wire \ql_r4_reg[27]_i_1_n_4 ;
  wire \ql_r4_reg[27]_i_1_n_5 ;
  wire \ql_r4_reg[27]_i_1_n_6 ;
  wire \ql_r4_reg[27]_i_1_n_7 ;
  wire \ql_r4_reg[27]_i_2_n_0 ;
  wire \ql_r4_reg[27]_i_2_n_1 ;
  wire \ql_r4_reg[27]_i_2_n_2 ;
  wire \ql_r4_reg[27]_i_2_n_3 ;
  wire \ql_r4_reg[31]_i_1_n_1 ;
  wire \ql_r4_reg[31]_i_1_n_2 ;
  wire \ql_r4_reg[31]_i_1_n_3 ;
  wire \ql_r4_reg[31]_i_1_n_4 ;
  wire \ql_r4_reg[31]_i_1_n_5 ;
  wire \ql_r4_reg[31]_i_1_n_6 ;
  wire \ql_r4_reg[31]_i_1_n_7 ;
  wire \ql_r4_reg[31]_i_2_n_1 ;
  wire \ql_r4_reg[31]_i_2_n_2 ;
  wire \ql_r4_reg[31]_i_2_n_3 ;
  wire \ql_r4_reg[3]_i_1_n_0 ;
  wire \ql_r4_reg[3]_i_1_n_1 ;
  wire \ql_r4_reg[3]_i_1_n_2 ;
  wire \ql_r4_reg[3]_i_1_n_3 ;
  wire \ql_r4_reg[3]_i_1_n_4 ;
  wire \ql_r4_reg[3]_i_1_n_5 ;
  wire \ql_r4_reg[3]_i_1_n_6 ;
  wire \ql_r4_reg[3]_i_1_n_7 ;
  wire \ql_r4_reg[7]_i_1_n_0 ;
  wire \ql_r4_reg[7]_i_1_n_1 ;
  wire \ql_r4_reg[7]_i_1_n_2 ;
  wire \ql_r4_reg[7]_i_1_n_3 ;
  wire \ql_r4_reg[7]_i_1_n_4 ;
  wire \ql_r4_reg[7]_i_1_n_5 ;
  wire \ql_r4_reg[7]_i_1_n_6 ;
  wire \ql_r4_reg[7]_i_1_n_7 ;
  wire [31:0]qmin_r1;
  wire qmin_r12;
  wire [31:1]qmin_r13;
  wire \qmin_r1[0]_i_1_n_0 ;
  wire \qmin_r1[10]_i_1_n_0 ;
  wire \qmin_r1[11]_i_1_n_0 ;
  wire \qmin_r1[12]_i_10_n_0 ;
  wire \qmin_r1[12]_i_11_n_0 ;
  wire \qmin_r1[12]_i_1_n_0 ;
  wire \qmin_r1[12]_i_4_n_0 ;
  wire \qmin_r1[12]_i_5_n_0 ;
  wire \qmin_r1[12]_i_6_n_0 ;
  wire \qmin_r1[12]_i_7_n_0 ;
  wire \qmin_r1[12]_i_8_n_0 ;
  wire \qmin_r1[12]_i_9_n_0 ;
  wire \qmin_r1[13]_i_1_n_0 ;
  wire \qmin_r1[14]_i_1_n_0 ;
  wire \qmin_r1[15]_i_1_n_0 ;
  wire \qmin_r1[16]_i_10_n_0 ;
  wire \qmin_r1[16]_i_11_n_0 ;
  wire \qmin_r1[16]_i_1_n_0 ;
  wire \qmin_r1[16]_i_4_n_0 ;
  wire \qmin_r1[16]_i_5_n_0 ;
  wire \qmin_r1[16]_i_6_n_0 ;
  wire \qmin_r1[16]_i_7_n_0 ;
  wire \qmin_r1[16]_i_8_n_0 ;
  wire \qmin_r1[16]_i_9_n_0 ;
  wire \qmin_r1[17]_i_1_n_0 ;
  wire \qmin_r1[18]_i_1_n_0 ;
  wire \qmin_r1[19]_i_1_n_0 ;
  wire \qmin_r1[1]_i_1_n_0 ;
  wire \qmin_r1[20]_i_10_n_0 ;
  wire \qmin_r1[20]_i_11_n_0 ;
  wire \qmin_r1[20]_i_1_n_0 ;
  wire \qmin_r1[20]_i_4_n_0 ;
  wire \qmin_r1[20]_i_5_n_0 ;
  wire \qmin_r1[20]_i_6_n_0 ;
  wire \qmin_r1[20]_i_7_n_0 ;
  wire \qmin_r1[20]_i_8_n_0 ;
  wire \qmin_r1[20]_i_9_n_0 ;
  wire \qmin_r1[21]_i_1_n_0 ;
  wire \qmin_r1[22]_i_1_n_0 ;
  wire \qmin_r1[23]_i_1_n_0 ;
  wire \qmin_r1[24]_i_10_n_0 ;
  wire \qmin_r1[24]_i_11_n_0 ;
  wire \qmin_r1[24]_i_1_n_0 ;
  wire \qmin_r1[24]_i_4_n_0 ;
  wire \qmin_r1[24]_i_5_n_0 ;
  wire \qmin_r1[24]_i_6_n_0 ;
  wire \qmin_r1[24]_i_7_n_0 ;
  wire \qmin_r1[24]_i_8_n_0 ;
  wire \qmin_r1[24]_i_9_n_0 ;
  wire \qmin_r1[25]_i_1_n_0 ;
  wire \qmin_r1[26]_i_1_n_0 ;
  wire \qmin_r1[27]_i_1_n_0 ;
  wire \qmin_r1[28]_i_10_n_0 ;
  wire \qmin_r1[28]_i_11_n_0 ;
  wire \qmin_r1[28]_i_1_n_0 ;
  wire \qmin_r1[28]_i_4_n_0 ;
  wire \qmin_r1[28]_i_5_n_0 ;
  wire \qmin_r1[28]_i_6_n_0 ;
  wire \qmin_r1[28]_i_7_n_0 ;
  wire \qmin_r1[28]_i_8_n_0 ;
  wire \qmin_r1[28]_i_9_n_0 ;
  wire \qmin_r1[29]_i_1_n_0 ;
  wire \qmin_r1[2]_i_1_n_0 ;
  wire \qmin_r1[30]_i_1_n_0 ;
  wire \qmin_r1[31]_i_10_n_0 ;
  wire \qmin_r1[31]_i_12_n_0 ;
  wire \qmin_r1[31]_i_13_n_0 ;
  wire \qmin_r1[31]_i_14_n_0 ;
  wire \qmin_r1[31]_i_15_n_0 ;
  wire \qmin_r1[31]_i_16_n_0 ;
  wire \qmin_r1[31]_i_17_n_0 ;
  wire \qmin_r1[31]_i_18_n_0 ;
  wire \qmin_r1[31]_i_19_n_0 ;
  wire \qmin_r1[31]_i_1_n_0 ;
  wire \qmin_r1[31]_i_21_n_0 ;
  wire \qmin_r1[31]_i_22_n_0 ;
  wire \qmin_r1[31]_i_23_n_0 ;
  wire \qmin_r1[31]_i_24_n_0 ;
  wire \qmin_r1[31]_i_25_n_0 ;
  wire \qmin_r1[31]_i_26_n_0 ;
  wire \qmin_r1[31]_i_27_n_0 ;
  wire \qmin_r1[31]_i_28_n_0 ;
  wire \qmin_r1[31]_i_33_n_0 ;
  wire \qmin_r1[31]_i_34_n_0 ;
  wire \qmin_r1[31]_i_35_n_0 ;
  wire \qmin_r1[31]_i_36_n_0 ;
  wire \qmin_r1[31]_i_37_n_0 ;
  wire \qmin_r1[31]_i_38_n_0 ;
  wire \qmin_r1[31]_i_39_n_0 ;
  wire \qmin_r1[31]_i_40_n_0 ;
  wire \qmin_r1[31]_i_45_n_0 ;
  wire \qmin_r1[31]_i_46_n_0 ;
  wire \qmin_r1[31]_i_47_n_0 ;
  wire \qmin_r1[31]_i_48_n_0 ;
  wire \qmin_r1[31]_i_49_n_0 ;
  wire \qmin_r1[31]_i_50_n_0 ;
  wire \qmin_r1[31]_i_51_n_0 ;
  wire \qmin_r1[31]_i_52_n_0 ;
  wire \qmin_r1[31]_i_5_n_0 ;
  wire \qmin_r1[31]_i_6_n_0 ;
  wire \qmin_r1[31]_i_7_n_0 ;
  wire \qmin_r1[31]_i_8_n_0 ;
  wire \qmin_r1[31]_i_9_n_0 ;
  wire \qmin_r1[3]_i_1_n_0 ;
  wire \qmin_r1[4]_i_10_n_0 ;
  wire \qmin_r1[4]_i_11_n_0 ;
  wire \qmin_r1[4]_i_12_n_0 ;
  wire \qmin_r1[4]_i_13_n_0 ;
  wire \qmin_r1[4]_i_1_n_0 ;
  wire \qmin_r1[4]_i_4_n_0 ;
  wire \qmin_r1[4]_i_5_n_0 ;
  wire \qmin_r1[4]_i_6_n_0 ;
  wire \qmin_r1[4]_i_7_n_0 ;
  wire \qmin_r1[4]_i_8_n_0 ;
  wire \qmin_r1[4]_i_9_n_0 ;
  wire \qmin_r1[5]_i_1_n_0 ;
  wire \qmin_r1[6]_i_1_n_0 ;
  wire \qmin_r1[7]_i_1_n_0 ;
  wire \qmin_r1[8]_i_10_n_0 ;
  wire \qmin_r1[8]_i_11_n_0 ;
  wire \qmin_r1[8]_i_1_n_0 ;
  wire \qmin_r1[8]_i_4_n_0 ;
  wire \qmin_r1[8]_i_5_n_0 ;
  wire \qmin_r1[8]_i_6_n_0 ;
  wire \qmin_r1[8]_i_7_n_0 ;
  wire \qmin_r1[8]_i_8_n_0 ;
  wire \qmin_r1[8]_i_9_n_0 ;
  wire \qmin_r1[9]_i_1_n_0 ;
  wire \qmin_r1_reg[12]_i_2_n_0 ;
  wire \qmin_r1_reg[12]_i_2_n_1 ;
  wire \qmin_r1_reg[12]_i_2_n_2 ;
  wire \qmin_r1_reg[12]_i_2_n_3 ;
  wire \qmin_r1_reg[12]_i_3_n_0 ;
  wire \qmin_r1_reg[12]_i_3_n_1 ;
  wire \qmin_r1_reg[12]_i_3_n_2 ;
  wire \qmin_r1_reg[12]_i_3_n_3 ;
  wire \qmin_r1_reg[16]_i_2_n_0 ;
  wire \qmin_r1_reg[16]_i_2_n_1 ;
  wire \qmin_r1_reg[16]_i_2_n_2 ;
  wire \qmin_r1_reg[16]_i_2_n_3 ;
  wire \qmin_r1_reg[16]_i_3_n_0 ;
  wire \qmin_r1_reg[16]_i_3_n_1 ;
  wire \qmin_r1_reg[16]_i_3_n_2 ;
  wire \qmin_r1_reg[16]_i_3_n_3 ;
  wire \qmin_r1_reg[20]_i_2_n_0 ;
  wire \qmin_r1_reg[20]_i_2_n_1 ;
  wire \qmin_r1_reg[20]_i_2_n_2 ;
  wire \qmin_r1_reg[20]_i_2_n_3 ;
  wire \qmin_r1_reg[20]_i_3_n_0 ;
  wire \qmin_r1_reg[20]_i_3_n_1 ;
  wire \qmin_r1_reg[20]_i_3_n_2 ;
  wire \qmin_r1_reg[20]_i_3_n_3 ;
  wire \qmin_r1_reg[24]_i_2_n_0 ;
  wire \qmin_r1_reg[24]_i_2_n_1 ;
  wire \qmin_r1_reg[24]_i_2_n_2 ;
  wire \qmin_r1_reg[24]_i_2_n_3 ;
  wire \qmin_r1_reg[24]_i_3_n_0 ;
  wire \qmin_r1_reg[24]_i_3_n_1 ;
  wire \qmin_r1_reg[24]_i_3_n_2 ;
  wire \qmin_r1_reg[24]_i_3_n_3 ;
  wire \qmin_r1_reg[28]_i_2_n_0 ;
  wire \qmin_r1_reg[28]_i_2_n_1 ;
  wire \qmin_r1_reg[28]_i_2_n_2 ;
  wire \qmin_r1_reg[28]_i_2_n_3 ;
  wire \qmin_r1_reg[28]_i_3_n_0 ;
  wire \qmin_r1_reg[28]_i_3_n_1 ;
  wire \qmin_r1_reg[28]_i_3_n_2 ;
  wire \qmin_r1_reg[28]_i_3_n_3 ;
  wire \qmin_r1_reg[31]_i_11_n_0 ;
  wire \qmin_r1_reg[31]_i_11_n_1 ;
  wire \qmin_r1_reg[31]_i_11_n_2 ;
  wire \qmin_r1_reg[31]_i_11_n_3 ;
  wire \qmin_r1_reg[31]_i_20_n_0 ;
  wire \qmin_r1_reg[31]_i_20_n_1 ;
  wire \qmin_r1_reg[31]_i_20_n_2 ;
  wire \qmin_r1_reg[31]_i_20_n_3 ;
  wire \qmin_r1_reg[31]_i_2_n_2 ;
  wire \qmin_r1_reg[31]_i_2_n_3 ;
  wire \qmin_r1_reg[31]_i_32_n_0 ;
  wire \qmin_r1_reg[31]_i_32_n_1 ;
  wire \qmin_r1_reg[31]_i_32_n_2 ;
  wire \qmin_r1_reg[31]_i_32_n_3 ;
  wire \qmin_r1_reg[31]_i_3_n_2 ;
  wire \qmin_r1_reg[31]_i_3_n_3 ;
  wire \qmin_r1_reg[31]_i_4_n_1 ;
  wire \qmin_r1_reg[31]_i_4_n_2 ;
  wire \qmin_r1_reg[31]_i_4_n_3 ;
  wire \qmin_r1_reg[4]_i_2_n_0 ;
  wire \qmin_r1_reg[4]_i_2_n_1 ;
  wire \qmin_r1_reg[4]_i_2_n_2 ;
  wire \qmin_r1_reg[4]_i_2_n_3 ;
  wire \qmin_r1_reg[4]_i_3_n_0 ;
  wire \qmin_r1_reg[4]_i_3_n_1 ;
  wire \qmin_r1_reg[4]_i_3_n_2 ;
  wire \qmin_r1_reg[4]_i_3_n_3 ;
  wire \qmin_r1_reg[8]_i_2_n_0 ;
  wire \qmin_r1_reg[8]_i_2_n_1 ;
  wire \qmin_r1_reg[8]_i_2_n_2 ;
  wire \qmin_r1_reg[8]_i_2_n_3 ;
  wire \qmin_r1_reg[8]_i_3_n_0 ;
  wire \qmin_r1_reg[8]_i_3_n_1 ;
  wire \qmin_r1_reg[8]_i_3_n_2 ;
  wire \qmin_r1_reg[8]_i_3_n_3 ;
  wire [31:0]qout;
  wire \qout[16]_INST_0_i_1_n_0 ;
  wire \qout[16]_INST_0_i_2_n_0 ;
  wire \qout[16]_INST_0_i_3_n_0 ;
  wire \qout[16]_INST_0_n_0 ;
  wire \qout[16]_INST_0_n_1 ;
  wire \qout[16]_INST_0_n_2 ;
  wire \qout[16]_INST_0_n_3 ;
  wire \qout[20]_INST_0_i_1_n_0 ;
  wire \qout[20]_INST_0_i_2_n_0 ;
  wire \qout[20]_INST_0_i_3_n_0 ;
  wire \qout[20]_INST_0_i_4_n_0 ;
  wire \qout[20]_INST_0_n_0 ;
  wire \qout[20]_INST_0_n_1 ;
  wire \qout[20]_INST_0_n_2 ;
  wire \qout[20]_INST_0_n_3 ;
  wire \qout[24]_INST_0_i_1_n_0 ;
  wire \qout[24]_INST_0_i_2_n_0 ;
  wire \qout[24]_INST_0_i_3_n_0 ;
  wire \qout[24]_INST_0_i_4_n_0 ;
  wire \qout[24]_INST_0_n_0 ;
  wire \qout[24]_INST_0_n_1 ;
  wire \qout[24]_INST_0_n_2 ;
  wire \qout[24]_INST_0_n_3 ;
  wire \qout[28]_INST_0_i_1_n_0 ;
  wire \qout[28]_INST_0_i_2_n_0 ;
  wire \qout[28]_INST_0_i_3_n_0 ;
  wire \qout[28]_INST_0_i_4_n_0 ;
  wire \qout[28]_INST_0_n_1 ;
  wire \qout[28]_INST_0_n_2 ;
  wire \qout[28]_INST_0_n_3 ;
  wire qout_r0__0_n_100;
  wire qout_r0__0_n_101;
  wire qout_r0__0_n_102;
  wire qout_r0__0_n_103;
  wire qout_r0__0_n_104;
  wire qout_r0__0_n_105;
  wire qout_r0__0_n_106;
  wire qout_r0__0_n_107;
  wire qout_r0__0_n_108;
  wire qout_r0__0_n_109;
  wire qout_r0__0_n_110;
  wire qout_r0__0_n_111;
  wire qout_r0__0_n_112;
  wire qout_r0__0_n_113;
  wire qout_r0__0_n_114;
  wire qout_r0__0_n_115;
  wire qout_r0__0_n_116;
  wire qout_r0__0_n_117;
  wire qout_r0__0_n_118;
  wire qout_r0__0_n_119;
  wire qout_r0__0_n_120;
  wire qout_r0__0_n_121;
  wire qout_r0__0_n_122;
  wire qout_r0__0_n_123;
  wire qout_r0__0_n_124;
  wire qout_r0__0_n_125;
  wire qout_r0__0_n_126;
  wire qout_r0__0_n_127;
  wire qout_r0__0_n_128;
  wire qout_r0__0_n_129;
  wire qout_r0__0_n_130;
  wire qout_r0__0_n_131;
  wire qout_r0__0_n_132;
  wire qout_r0__0_n_133;
  wire qout_r0__0_n_134;
  wire qout_r0__0_n_135;
  wire qout_r0__0_n_136;
  wire qout_r0__0_n_137;
  wire qout_r0__0_n_138;
  wire qout_r0__0_n_139;
  wire qout_r0__0_n_140;
  wire qout_r0__0_n_141;
  wire qout_r0__0_n_142;
  wire qout_r0__0_n_143;
  wire qout_r0__0_n_144;
  wire qout_r0__0_n_145;
  wire qout_r0__0_n_146;
  wire qout_r0__0_n_147;
  wire qout_r0__0_n_148;
  wire qout_r0__0_n_149;
  wire qout_r0__0_n_150;
  wire qout_r0__0_n_151;
  wire qout_r0__0_n_152;
  wire qout_r0__0_n_153;
  wire qout_r0__0_n_58;
  wire qout_r0__0_n_59;
  wire qout_r0__0_n_60;
  wire qout_r0__0_n_61;
  wire qout_r0__0_n_62;
  wire qout_r0__0_n_63;
  wire qout_r0__0_n_64;
  wire qout_r0__0_n_65;
  wire qout_r0__0_n_66;
  wire qout_r0__0_n_67;
  wire qout_r0__0_n_68;
  wire qout_r0__0_n_69;
  wire qout_r0__0_n_70;
  wire qout_r0__0_n_71;
  wire qout_r0__0_n_72;
  wire qout_r0__0_n_73;
  wire qout_r0__0_n_74;
  wire qout_r0__0_n_75;
  wire qout_r0__0_n_76;
  wire qout_r0__0_n_77;
  wire qout_r0__0_n_78;
  wire qout_r0__0_n_79;
  wire qout_r0__0_n_80;
  wire qout_r0__0_n_81;
  wire qout_r0__0_n_82;
  wire qout_r0__0_n_83;
  wire qout_r0__0_n_84;
  wire qout_r0__0_n_85;
  wire qout_r0__0_n_86;
  wire qout_r0__0_n_87;
  wire qout_r0__0_n_88;
  wire qout_r0__0_n_89;
  wire qout_r0__0_n_90;
  wire qout_r0__0_n_91;
  wire qout_r0__0_n_92;
  wire qout_r0__0_n_93;
  wire qout_r0__0_n_94;
  wire qout_r0__0_n_95;
  wire qout_r0__0_n_96;
  wire qout_r0__0_n_97;
  wire qout_r0__0_n_98;
  wire qout_r0__0_n_99;
  wire qout_r0_i_10_n_0;
  wire qout_r0_i_11_n_0;
  wire qout_r0_i_12_n_0;
  wire qout_r0_i_13_n_0;
  wire qout_r0_i_14_n_0;
  wire qout_r0_i_15_n_0;
  wire qout_r0_i_16_n_0;
  wire qout_r0_i_17_n_0;
  wire qout_r0_i_18_n_0;
  wire qout_r0_i_19_n_0;
  wire qout_r0_i_1_n_0;
  wire qout_r0_i_1_n_1;
  wire qout_r0_i_1_n_2;
  wire qout_r0_i_1_n_3;
  wire qout_r0_i_20_n_0;
  wire qout_r0_i_21_n_0;
  wire qout_r0_i_22_n_0;
  wire qout_r0_i_23_n_0;
  wire qout_r0_i_24_n_0;
  wire qout_r0_i_25_n_0;
  wire qout_r0_i_2_n_0;
  wire qout_r0_i_2_n_1;
  wire qout_r0_i_2_n_2;
  wire qout_r0_i_2_n_3;
  wire qout_r0_i_3_n_0;
  wire qout_r0_i_3_n_1;
  wire qout_r0_i_3_n_2;
  wire qout_r0_i_3_n_3;
  wire qout_r0_i_4_n_0;
  wire qout_r0_i_4_n_1;
  wire qout_r0_i_4_n_2;
  wire qout_r0_i_4_n_3;
  wire qout_r0_i_5_n_0;
  wire qout_r0_i_5_n_1;
  wire qout_r0_i_5_n_2;
  wire qout_r0_i_5_n_3;
  wire qout_r0_i_6_n_0;
  wire qout_r0_i_7_n_0;
  wire qout_r0_i_8_n_0;
  wire qout_r0_i_9_n_0;
  wire qout_r0_n_100;
  wire qout_r0_n_101;
  wire qout_r0_n_102;
  wire qout_r0_n_103;
  wire qout_r0_n_104;
  wire qout_r0_n_105;
  wire qout_r0_n_106;
  wire qout_r0_n_107;
  wire qout_r0_n_108;
  wire qout_r0_n_109;
  wire qout_r0_n_110;
  wire qout_r0_n_111;
  wire qout_r0_n_112;
  wire qout_r0_n_113;
  wire qout_r0_n_114;
  wire qout_r0_n_115;
  wire qout_r0_n_116;
  wire qout_r0_n_117;
  wire qout_r0_n_118;
  wire qout_r0_n_119;
  wire qout_r0_n_120;
  wire qout_r0_n_121;
  wire qout_r0_n_122;
  wire qout_r0_n_123;
  wire qout_r0_n_124;
  wire qout_r0_n_125;
  wire qout_r0_n_126;
  wire qout_r0_n_127;
  wire qout_r0_n_128;
  wire qout_r0_n_129;
  wire qout_r0_n_130;
  wire qout_r0_n_131;
  wire qout_r0_n_132;
  wire qout_r0_n_133;
  wire qout_r0_n_134;
  wire qout_r0_n_135;
  wire qout_r0_n_136;
  wire qout_r0_n_137;
  wire qout_r0_n_138;
  wire qout_r0_n_139;
  wire qout_r0_n_140;
  wire qout_r0_n_141;
  wire qout_r0_n_142;
  wire qout_r0_n_143;
  wire qout_r0_n_144;
  wire qout_r0_n_145;
  wire qout_r0_n_146;
  wire qout_r0_n_147;
  wire qout_r0_n_148;
  wire qout_r0_n_149;
  wire qout_r0_n_150;
  wire qout_r0_n_151;
  wire qout_r0_n_152;
  wire qout_r0_n_153;
  wire qout_r0_n_58;
  wire qout_r0_n_59;
  wire qout_r0_n_60;
  wire qout_r0_n_61;
  wire qout_r0_n_62;
  wire qout_r0_n_63;
  wire qout_r0_n_64;
  wire qout_r0_n_65;
  wire qout_r0_n_66;
  wire qout_r0_n_67;
  wire qout_r0_n_68;
  wire qout_r0_n_69;
  wire qout_r0_n_70;
  wire qout_r0_n_71;
  wire qout_r0_n_72;
  wire qout_r0_n_73;
  wire qout_r0_n_74;
  wire qout_r0_n_75;
  wire qout_r0_n_76;
  wire qout_r0_n_77;
  wire qout_r0_n_78;
  wire qout_r0_n_79;
  wire qout_r0_n_80;
  wire qout_r0_n_81;
  wire qout_r0_n_82;
  wire qout_r0_n_83;
  wire qout_r0_n_84;
  wire qout_r0_n_85;
  wire qout_r0_n_86;
  wire qout_r0_n_87;
  wire qout_r0_n_88;
  wire qout_r0_n_89;
  wire qout_r0_n_90;
  wire qout_r0_n_91;
  wire qout_r0_n_92;
  wire qout_r0_n_93;
  wire qout_r0_n_94;
  wire qout_r0_n_95;
  wire qout_r0_n_96;
  wire qout_r0_n_97;
  wire qout_r0_n_98;
  wire qout_r0_n_99;
  wire \qout_r_reg[16]__0_n_0 ;
  wire qout_r_reg_i_10_n_0;
  wire qout_r_reg_i_11_n_0;
  wire qout_r_reg_i_12_n_0;
  wire qout_r_reg_i_13_n_0;
  wire qout_r_reg_i_14_n_0;
  wire qout_r_reg_i_15_n_0;
  wire qout_r_reg_i_1_n_1;
  wire qout_r_reg_i_1_n_2;
  wire qout_r_reg_i_1_n_3;
  wire qout_r_reg_i_2_n_0;
  wire qout_r_reg_i_2_n_1;
  wire qout_r_reg_i_2_n_2;
  wire qout_r_reg_i_2_n_3;
  wire qout_r_reg_i_3_n_0;
  wire qout_r_reg_i_3_n_1;
  wire qout_r_reg_i_3_n_2;
  wire qout_r_reg_i_3_n_3;
  wire qout_r_reg_i_4_n_0;
  wire qout_r_reg_i_5_n_0;
  wire qout_r_reg_i_6_n_0;
  wire qout_r_reg_i_7_n_0;
  wire qout_r_reg_i_8_n_0;
  wire qout_r_reg_i_9_n_0;
  wire qout_r_reg_n_100;
  wire qout_r_reg_n_101;
  wire qout_r_reg_n_102;
  wire qout_r_reg_n_103;
  wire qout_r_reg_n_104;
  wire qout_r_reg_n_105;
  wire qout_r_reg_n_58;
  wire qout_r_reg_n_59;
  wire qout_r_reg_n_60;
  wire qout_r_reg_n_61;
  wire qout_r_reg_n_62;
  wire qout_r_reg_n_63;
  wire qout_r_reg_n_64;
  wire qout_r_reg_n_65;
  wire qout_r_reg_n_66;
  wire qout_r_reg_n_67;
  wire qout_r_reg_n_68;
  wire qout_r_reg_n_69;
  wire qout_r_reg_n_70;
  wire qout_r_reg_n_71;
  wire qout_r_reg_n_72;
  wire qout_r_reg_n_73;
  wire qout_r_reg_n_74;
  wire qout_r_reg_n_75;
  wire qout_r_reg_n_76;
  wire qout_r_reg_n_77;
  wire qout_r_reg_n_78;
  wire qout_r_reg_n_79;
  wire qout_r_reg_n_80;
  wire qout_r_reg_n_81;
  wire qout_r_reg_n_82;
  wire qout_r_reg_n_83;
  wire qout_r_reg_n_84;
  wire qout_r_reg_n_85;
  wire qout_r_reg_n_86;
  wire qout_r_reg_n_87;
  wire qout_r_reg_n_88;
  wire qout_r_reg_n_89;
  wire qout_r_reg_n_90;
  wire qout_r_reg_n_91;
  wire qout_r_reg_n_92;
  wire qout_r_reg_n_93;
  wire qout_r_reg_n_94;
  wire qout_r_reg_n_95;
  wire qout_r_reg_n_96;
  wire qout_r_reg_n_97;
  wire qout_r_reg_n_98;
  wire qout_r_reg_n_99;
  wire rst;
  wire [3:0]\NLW_qerf_r5_reg[2]_i_2_O_UNCONNECTED ;

  GND GND
       (.G(\<const0> ));
  GND GND_1
       (.G(GND_2));
  VCC VCC
       (.P(\<const1> ));
  VCC VCC_1
       (.P(VCC_2));
  FDRE #(
    .INIT(1'b0)) 
    done_reg
       (.C(clk),
        .CE(enable),
        .D(in_v_r6_reg_gate_n_0),
        .Q(out_valid),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r0_reg_r
       (.C(clk),
        .CE(enable),
        .D(\<const1> ),
        .Q(in_v_r0_reg_r_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r1_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r0_reg_r_n_0),
        .Q(in_v_r1_reg_r_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r2_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r1_reg_r_n_0),
        .Q(in_v_r2_reg_r_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r3_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r2_reg_r_n_0),
        .Q(in_v_r3_reg_r_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r4_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r3_reg_r_n_0),
        .Q(in_v_r4_reg_r_n_0),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r5_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r4_reg_r_n_0),
        .Q(in_v_r5_reg_r_n_0),
        .R(rst));
  (* srl_name = "in_v_r5_reg_srl6___in_v_r5_reg_r" *) 
  SRL16E #(
    .INIT(16'h0000)) 
    in_v_r5_reg_srl6___in_v_r5_reg_r
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const1> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(in_valid),
        .Q(in_v_r5_reg_srl6___in_v_r5_reg_r_n_0));
  LUT2 #(
    .INIT(4'h8)) 
    in_v_r6_reg_gate
       (.I0(in_v_r6_reg_in_v_r6_reg_r_n_0),
        .I1(in_v_r6_reg_r_n_0),
        .O(in_v_r6_reg_gate_n_0));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r6_reg_in_v_r6_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r5_reg_srl6___in_v_r5_reg_r_n_0),
        .Q(in_v_r6_reg_in_v_r6_reg_r_n_0),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    in_v_r6_reg_r
       (.C(clk),
        .CE(enable),
        .D(in_v_r5_reg_r_n_0),
        .Q(in_v_r6_reg_r_n_0),
        .R(rst));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[0]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[0]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[0]),
        .Q(\q1_r3_reg[0]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[10]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[10]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[10]),
        .Q(\q1_r3_reg[10]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[11]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[11]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[11]),
        .Q(\q1_r3_reg[11]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[12]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[12]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[12]),
        .Q(\q1_r3_reg[12]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[13]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[13]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[13]),
        .Q(\q1_r3_reg[13]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[14]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[14]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[14]),
        .Q(\q1_r3_reg[14]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[15]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[15]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[15]),
        .Q(\q1_r3_reg[15]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[16]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[16]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[16]),
        .Q(\q1_r3_reg[16]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[17]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[17]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[17]),
        .Q(\q1_r3_reg[17]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[18]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[18]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[18]),
        .Q(\q1_r3_reg[18]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[19]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[19]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[19]),
        .Q(\q1_r3_reg[19]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[1]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[1]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[1]),
        .Q(\q1_r3_reg[1]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[20]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[20]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[20]),
        .Q(\q1_r3_reg[20]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[21]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[21]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[21]),
        .Q(\q1_r3_reg[21]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[22]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[22]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[22]),
        .Q(\q1_r3_reg[22]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[23]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[23]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[23]),
        .Q(\q1_r3_reg[23]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[24]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[24]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[24]),
        .Q(\q1_r3_reg[24]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[25]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[25]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[25]),
        .Q(\q1_r3_reg[25]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[26]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[26]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[26]),
        .Q(\q1_r3_reg[26]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[27]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[27]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[27]),
        .Q(\q1_r3_reg[27]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[28]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[28]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[28]),
        .Q(\q1_r3_reg[28]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[29]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[29]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[29]),
        .Q(\q1_r3_reg[29]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[2]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[2]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[2]),
        .Q(\q1_r3_reg[2]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[30]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[30]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[30]),
        .Q(\q1_r3_reg[30]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[31]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[31]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[31]),
        .Q(\q1_r3_reg[31]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[3]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[3]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[3]),
        .Q(\q1_r3_reg[3]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[4]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[4]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[4]),
        .Q(\q1_r3_reg[4]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[5]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[5]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[5]),
        .Q(\q1_r3_reg[5]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[6]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[6]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[6]),
        .Q(\q1_r3_reg[6]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[7]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[7]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[7]),
        .Q(\q1_r3_reg[7]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[8]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[8]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[8]),
        .Q(\q1_r3_reg[8]_srl4___in_v_r3_reg_r_n_0 ));
  (* srl_bus_name = "\q1_r3_reg " *) 
  (* srl_name = "\q1_r3_reg[9]_srl4___in_v_r3_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \q1_r3_reg[9]_srl4___in_v_r3_reg_r 
       (.A0(\<const1> ),
        .A1(\<const1> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(q1[9]),
        .Q(\q1_r3_reg[9]_srl4___in_v_r3_reg_r_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[0]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[0]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[0]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[10]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[10]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[10]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[11]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[11]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[11]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[12]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[12]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[12]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[13]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[13]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[13]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[14]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[14]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[14]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[15]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[15]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[15]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[16]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[16]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[16]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[17]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[17]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[17]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[18]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[18]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[18]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[19]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[19]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[19]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[1]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[1]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[1]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[20]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[20]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[20]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[21]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[21]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[21]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[22]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[22]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[22]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[23]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[23]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[23]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[24]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[24]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[24]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[25]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[25]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[25]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[26]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[26]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[26]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[27]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[27]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[27]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[28]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[28]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[28]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[29]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[29]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[29]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[2]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[2]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[2]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[30]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[30]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[30]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[31]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[31]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[31]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[3]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[3]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[3]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[4]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[4]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[4]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[5]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[5]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[5]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[6]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[6]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[6]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[7]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[7]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[7]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[8]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[8]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[8]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r4_reg[9]_in_v_r4_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\q1_r3_reg[9]_srl4___in_v_r3_reg_r_n_0 ),
        .Q(\q1_r4_reg[9]_in_v_r4_reg_r_n_0 ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate
       (.I0(\q1_r4_reg[31]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate_n_0));
  (* SOFT_HLUTNM = "soft_lutpair16" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__0
       (.I0(\q1_r4_reg[30]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__1
       (.I0(\q1_r4_reg[29]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__10
       (.I0(\q1_r4_reg[20]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__11
       (.I0(\q1_r4_reg[19]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair22" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__12
       (.I0(\q1_r4_reg[18]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__13
       (.I0(\q1_r4_reg[17]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair23" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__14
       (.I0(\q1_r4_reg[16]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__15
       (.I0(\q1_r4_reg[15]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair24" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__16
       (.I0(\q1_r4_reg[14]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__17
       (.I0(\q1_r4_reg[13]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair25" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__18
       (.I0(\q1_r4_reg[12]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__19
       (.I0(\q1_r4_reg[11]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__19_n_0));
  (* SOFT_HLUTNM = "soft_lutpair17" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__2
       (.I0(\q1_r4_reg[28]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair26" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__20
       (.I0(\q1_r4_reg[10]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__21
       (.I0(\q1_r4_reg[9]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__21_n_0));
  (* SOFT_HLUTNM = "soft_lutpair27" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__22
       (.I0(\q1_r4_reg[8]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__22_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__23
       (.I0(\q1_r4_reg[7]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair28" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__24
       (.I0(\q1_r4_reg[6]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__25
       (.I0(\q1_r4_reg[5]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair29" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__26
       (.I0(\q1_r4_reg[4]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__27
       (.I0(\q1_r4_reg[3]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair30" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__28
       (.I0(\q1_r4_reg[2]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__29
       (.I0(\q1_r4_reg[1]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__29_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__3
       (.I0(\q1_r4_reg[27]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair31" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__30
       (.I0(\q1_r4_reg[0]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__30_n_0));
  (* SOFT_HLUTNM = "soft_lutpair18" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__4
       (.I0(\q1_r4_reg[26]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__5
       (.I0(\q1_r4_reg[25]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair19" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__6
       (.I0(\q1_r4_reg[24]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__7
       (.I0(\q1_r4_reg[23]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair20" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__8
       (.I0(\q1_r4_reg[22]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair21" *) 
  LUT2 #(
    .INIT(4'h8)) 
    q1_r4_reg_gate__9
       (.I0(\q1_r4_reg[21]_in_v_r4_reg_r_n_0 ),
        .I1(in_v_r4_reg_r_n_0),
        .O(q1_r4_reg_gate__9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__30_n_0),
        .Q(q1_r5[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__20_n_0),
        .Q(q1_r5[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__19_n_0),
        .Q(q1_r5[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__18_n_0),
        .Q(q1_r5[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__17_n_0),
        .Q(q1_r5[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__16_n_0),
        .Q(q1_r5[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__15_n_0),
        .Q(q1_r5[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__14_n_0),
        .Q(q1_r5[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__13_n_0),
        .Q(q1_r5[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__12_n_0),
        .Q(q1_r5[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__11_n_0),
        .Q(q1_r5[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__29_n_0),
        .Q(q1_r5[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__10_n_0),
        .Q(q1_r5[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__9_n_0),
        .Q(q1_r5[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__8_n_0),
        .Q(q1_r5[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__7_n_0),
        .Q(q1_r5[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__6_n_0),
        .Q(q1_r5[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__5_n_0),
        .Q(q1_r5[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__4_n_0),
        .Q(q1_r5[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__3_n_0),
        .Q(q1_r5[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__2_n_0),
        .Q(q1_r5[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__1_n_0),
        .Q(q1_r5[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__28_n_0),
        .Q(q1_r5[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__0_n_0),
        .Q(q1_r5[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate_n_0),
        .Q(q1_r5[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__27_n_0),
        .Q(q1_r5[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__26_n_0),
        .Q(q1_r5[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__25_n_0),
        .Q(q1_r5[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__24_n_0),
        .Q(q1_r5[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__23_n_0),
        .Q(q1_r5[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__22_n_0),
        .Q(q1_r5[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \q1_r5_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(q1_r4_reg_gate__21_n_0),
        .Q(q1_r5[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(qb[0]),
        .Q(qb_r0[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(qb[10]),
        .Q(qb_r0[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(qb[11]),
        .Q(qb_r0[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(qb[12]),
        .Q(qb_r0[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(qb[13]),
        .Q(qb_r0[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(qb[14]),
        .Q(qb_r0[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(qb[15]),
        .Q(qb_r0[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(qb[16]),
        .Q(qb_r0[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(qb[17]),
        .Q(qb_r0[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(qb[18]),
        .Q(qb_r0[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(qb[19]),
        .Q(qb_r0[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(qb[1]),
        .Q(qb_r0[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(qb[20]),
        .Q(qb_r0[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(qb[21]),
        .Q(qb_r0[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(qb[22]),
        .Q(qb_r0[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(qb[23]),
        .Q(qb_r0[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(qb[24]),
        .Q(qb_r0[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(qb[25]),
        .Q(qb_r0[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(qb[26]),
        .Q(qb_r0[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(qb[27]),
        .Q(qb_r0[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(qb[28]),
        .Q(qb_r0[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(qb[29]),
        .Q(qb_r0[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(qb[2]),
        .Q(qb_r0[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(qb[30]),
        .Q(qb_r0[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(qb[31]),
        .Q(qb_r0[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(qb[3]),
        .Q(qb_r0[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(qb[4]),
        .Q(qb_r0[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(qb[5]),
        .Q(qb_r0[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(qb[6]),
        .Q(qb_r0[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(qb[7]),
        .Q(qb_r0[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(qb[8]),
        .Q(qb_r0[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r0_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(qb[9]),
        .Q(qb_r0[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[0]),
        .Q(ql_r21[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[10]),
        .Q(ql_r21[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[11]),
        .Q(ql_r21[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[12]),
        .Q(ql_r21[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[13]),
        .Q(ql_r21[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[14]),
        .Q(ql_r21[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[15]),
        .Q(ql_r21[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[16]),
        .Q(ql_r21[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[17]),
        .Q(ql_r21[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[18]),
        .Q(ql_r21[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[19]),
        .Q(ql_r21[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[1]),
        .Q(ql_r21[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[20]),
        .Q(ql_r21[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[21]),
        .Q(ql_r21[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[22]),
        .Q(ql_r21[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[23]),
        .Q(ql_r21[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[24]),
        .Q(ql_r21[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[25]),
        .Q(ql_r21[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[26]),
        .Q(ql_r21[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[27]),
        .Q(ql_r21[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[28]),
        .Q(ql_r21[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[29]),
        .Q(ql_r21[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[2]),
        .Q(ql_r21[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[30]),
        .Q(ql_r21[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[3]),
        .Q(ql_r21[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[4]),
        .Q(ql_r21[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[5]),
        .Q(ql_r21[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[6]),
        .Q(ql_r21[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[7]),
        .Q(ql_r21[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[8]),
        .Q(ql_r21[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qb_r1_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(qb_r0[9]),
        .Q(ql_r21[10]),
        .R(rst));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[0]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[0]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[0]),
        .Q(\qc_r1_reg[0]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[10]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[10]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[10]),
        .Q(\qc_r1_reg[10]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[11]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[11]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[11]),
        .Q(\qc_r1_reg[11]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[12]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[12]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[12]),
        .Q(\qc_r1_reg[12]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[13]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[13]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[13]),
        .Q(\qc_r1_reg[13]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[14]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[14]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[14]),
        .Q(\qc_r1_reg[14]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[15]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[15]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[15]),
        .Q(\qc_r1_reg[15]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[16]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[16]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[16]),
        .Q(\qc_r1_reg[16]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[17]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[17]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[17]),
        .Q(\qc_r1_reg[17]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[18]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[18]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[18]),
        .Q(\qc_r1_reg[18]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[19]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[19]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[19]),
        .Q(\qc_r1_reg[19]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[1]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[1]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[1]),
        .Q(\qc_r1_reg[1]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[20]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[20]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[20]),
        .Q(\qc_r1_reg[20]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[21]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[21]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[21]),
        .Q(\qc_r1_reg[21]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[22]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[22]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[22]),
        .Q(\qc_r1_reg[22]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[23]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[23]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[23]),
        .Q(\qc_r1_reg[23]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[24]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[24]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[24]),
        .Q(\qc_r1_reg[24]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[25]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[25]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[25]),
        .Q(\qc_r1_reg[25]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[26]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[26]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[26]),
        .Q(\qc_r1_reg[26]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[27]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[27]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[27]),
        .Q(\qc_r1_reg[27]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[28]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[28]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[28]),
        .Q(\qc_r1_reg[28]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[29]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[29]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[29]),
        .Q(\qc_r1_reg[29]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[2]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[2]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[2]),
        .Q(\qc_r1_reg[2]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[30]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[30]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[30]),
        .Q(\qc_r1_reg[30]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[31]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[31]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[31]),
        .Q(\qc_r1_reg[31]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[3]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[3]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[3]),
        .Q(\qc_r1_reg[3]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[4]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[4]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[4]),
        .Q(\qc_r1_reg[4]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[5]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[5]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[5]),
        .Q(\qc_r1_reg[5]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[6]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[6]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[6]),
        .Q(\qc_r1_reg[6]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[7]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[7]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[7]),
        .Q(\qc_r1_reg[7]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[8]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[8]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[8]),
        .Q(\qc_r1_reg[8]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qc_r1_reg " *) 
  (* srl_name = "\qc_r1_reg[9]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qc_r1_reg[9]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qc[9]),
        .Q(\qc_r1_reg[9]_srl2___in_v_r1_reg_r_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[0]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[0]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[0]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[10]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[10]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[10]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[11]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[11]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[11]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[12]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[12]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[12]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[13]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[13]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[13]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[14]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[14]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[14]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[15]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[15]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[15]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[16]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[16]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[16]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[17]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[17]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[17]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[18]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[18]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[18]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[19]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[19]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[19]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[1]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[1]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[1]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[20]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[20]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[20]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[21]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[21]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[21]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[22]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[22]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[22]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[23]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[23]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[23]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[24]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[24]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[24]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[25]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[25]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[25]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[26]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[26]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[26]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[27]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[27]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[27]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[28]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[28]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[28]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[29]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[29]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[29]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[2]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[2]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[2]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[30]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[30]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[30]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[31]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[31]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[31]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[3]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[3]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[3]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[4]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[4]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[4]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[5]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[5]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[5]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[6]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[6]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[6]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[7]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[7]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[7]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[8]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[8]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[8]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r2_reg[9]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qc_r1_reg[9]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qc_r2_reg[9]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate
       (.I0(\qc_r2_reg[31]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate_n_0));
  (* SOFT_HLUTNM = "soft_lutpair48" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__0
       (.I0(\qc_r2_reg[30]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__1
       (.I0(\qc_r2_reg[29]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__10
       (.I0(\qc_r2_reg[20]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__11
       (.I0(\qc_r2_reg[19]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair54" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__12
       (.I0(\qc_r2_reg[18]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__13
       (.I0(\qc_r2_reg[17]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair55" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__14
       (.I0(\qc_r2_reg[16]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__15
       (.I0(\qc_r2_reg[15]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair56" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__16
       (.I0(\qc_r2_reg[14]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__17
       (.I0(\qc_r2_reg[13]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair57" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__18
       (.I0(\qc_r2_reg[12]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__19
       (.I0(\qc_r2_reg[11]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__19_n_0));
  (* SOFT_HLUTNM = "soft_lutpair49" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__2
       (.I0(\qc_r2_reg[28]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair58" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__20
       (.I0(\qc_r2_reg[10]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__21
       (.I0(\qc_r2_reg[9]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__21_n_0));
  (* SOFT_HLUTNM = "soft_lutpair59" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__22
       (.I0(\qc_r2_reg[8]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__22_n_0));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__23
       (.I0(\qc_r2_reg[7]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair60" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__24
       (.I0(\qc_r2_reg[6]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__25
       (.I0(\qc_r2_reg[5]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair61" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__26
       (.I0(\qc_r2_reg[4]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__27
       (.I0(\qc_r2_reg[3]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair62" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__28
       (.I0(\qc_r2_reg[2]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__29
       (.I0(\qc_r2_reg[1]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__29_n_0));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__3
       (.I0(\qc_r2_reg[27]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair63" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__30
       (.I0(\qc_r2_reg[0]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__30_n_0));
  (* SOFT_HLUTNM = "soft_lutpair50" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__4
       (.I0(\qc_r2_reg[26]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__5
       (.I0(\qc_r2_reg[25]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair51" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__6
       (.I0(\qc_r2_reg[24]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__7
       (.I0(\qc_r2_reg[23]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair52" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__8
       (.I0(\qc_r2_reg[22]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair53" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qc_r2_reg_gate__9
       (.I0(\qc_r2_reg[21]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qc_r2_reg_gate__9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__30_n_0),
        .Q(qc_r3[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__20_n_0),
        .Q(qc_r3[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__19_n_0),
        .Q(qc_r3[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__18_n_0),
        .Q(qc_r3[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__17_n_0),
        .Q(qc_r3[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__16_n_0),
        .Q(qc_r3[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__15_n_0),
        .Q(qc_r3[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__14_n_0),
        .Q(qc_r3[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__13_n_0),
        .Q(qc_r3[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__12_n_0),
        .Q(qc_r3[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__11_n_0),
        .Q(qc_r3[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__29_n_0),
        .Q(qc_r3[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__10_n_0),
        .Q(qc_r3[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__9_n_0),
        .Q(qc_r3[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__8_n_0),
        .Q(qc_r3[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__7_n_0),
        .Q(qc_r3[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__6_n_0),
        .Q(qc_r3[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__5_n_0),
        .Q(qc_r3[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__4_n_0),
        .Q(qc_r3[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__3_n_0),
        .Q(qc_r3[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__2_n_0),
        .Q(qc_r3[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__1_n_0),
        .Q(qc_r3[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__28_n_0),
        .Q(qc_r3[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__0_n_0),
        .Q(qc_r3[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate_n_0),
        .Q(qc_r3[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__27_n_0),
        .Q(qc_r3[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__26_n_0),
        .Q(qc_r3[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__25_n_0),
        .Q(qc_r3[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__24_n_0),
        .Q(qc_r3[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__23_n_0),
        .Q(qc_r3[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__22_n_0),
        .Q(qc_r3[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qc_r3_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(qc_r2_reg_gate__21_n_0),
        .Q(qc_r3[9]),
        .R(rst));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[0]_i_1 
       (.I0(qerf0[14]),
        .I1(qin_r4[31]),
        .I2(ql_r4[14]),
        .O(\qerf_r5[0]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[10]_i_1 
       (.I0(qerf0[24]),
        .I1(qin_r4[31]),
        .I2(ql_r4[24]),
        .O(\qerf_r5[10]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[10]_i_3 
       (.I0(ql_r4[24]),
        .O(\qerf_r5[10]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[10]_i_4 
       (.I0(ql_r4[23]),
        .O(\qerf_r5[10]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[10]_i_5 
       (.I0(ql_r4[22]),
        .O(\qerf_r5[10]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[10]_i_6 
       (.I0(ql_r4[21]),
        .O(\qerf_r5[10]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[11]_i_1 
       (.I0(qerf0[25]),
        .I1(qin_r4[31]),
        .I2(ql_r4[25]),
        .O(\qerf_r5[11]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[12]_i_1 
       (.I0(qerf0[26]),
        .I1(qin_r4[31]),
        .I2(ql_r4[26]),
        .O(\qerf_r5[12]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[13]_i_1 
       (.I0(qerf0[27]),
        .I1(qin_r4[31]),
        .I2(ql_r4[27]),
        .O(\qerf_r5[13]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair9" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[14]_i_1 
       (.I0(qerf0[28]),
        .I1(qin_r4[31]),
        .I2(ql_r4[28]),
        .O(\qerf_r5[14]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[14]_i_3 
       (.I0(ql_r4[28]),
        .O(\qerf_r5[14]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[14]_i_4 
       (.I0(ql_r4[27]),
        .O(\qerf_r5[14]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[14]_i_5 
       (.I0(ql_r4[26]),
        .O(\qerf_r5[14]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[14]_i_6 
       (.I0(ql_r4[25]),
        .O(\qerf_r5[14]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair8" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[15]_i_1 
       (.I0(qerf0[29]),
        .I1(qin_r4[31]),
        .I2(ql_r4[29]),
        .O(\qerf_r5[15]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[16]_i_1 
       (.I0(qerf0[30]),
        .I1(qin_r4[31]),
        .I2(ql_r4[30]),
        .O(\qerf_r5[16]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[1]_i_1 
       (.I0(qerf0[15]),
        .I1(qin_r4[31]),
        .I2(ql_r4[15]),
        .O(\qerf_r5[1]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair15" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[2]_i_1 
       (.I0(qerf0[16]),
        .I1(qin_r4[31]),
        .I2(ql_r4[16]),
        .O(\qerf_r5[2]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_10 
       (.I0(ql_r4[11]),
        .O(\qerf_r5[2]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_11 
       (.I0(ql_r4[10]),
        .O(\qerf_r5[2]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_12 
       (.I0(ql_r4[9]),
        .O(\qerf_r5[2]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_14 
       (.I0(ql_r4[8]),
        .O(\qerf_r5[2]_i_14_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_15 
       (.I0(ql_r4[7]),
        .O(\qerf_r5[2]_i_15_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_16 
       (.I0(ql_r4[6]),
        .O(\qerf_r5[2]_i_16_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_17 
       (.I0(ql_r4[5]),
        .O(\qerf_r5[2]_i_17_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_18 
       (.I0(ql_r4[0]),
        .O(\qerf_r5[2]_i_18_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_19 
       (.I0(ql_r4[4]),
        .O(\qerf_r5[2]_i_19_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_20 
       (.I0(ql_r4[3]),
        .O(\qerf_r5[2]_i_20_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_21 
       (.I0(ql_r4[2]),
        .O(\qerf_r5[2]_i_21_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_22 
       (.I0(ql_r4[1]),
        .O(\qerf_r5[2]_i_22_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_4 
       (.I0(ql_r4[16]),
        .O(\qerf_r5[2]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_5 
       (.I0(ql_r4[15]),
        .O(\qerf_r5[2]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_6 
       (.I0(ql_r4[14]),
        .O(\qerf_r5[2]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_7 
       (.I0(ql_r4[13]),
        .O(\qerf_r5[2]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[2]_i_9 
       (.I0(ql_r4[12]),
        .O(\qerf_r5[2]_i_9_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair7" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[30]_i_1 
       (.I0(qerf0[31]),
        .I1(qin_r4[31]),
        .I2(ql_r4[31]),
        .O(p_0_in0));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[30]_i_3 
       (.I0(ql_r4[31]),
        .O(\qerf_r5[30]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[30]_i_4 
       (.I0(ql_r4[30]),
        .O(\qerf_r5[30]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[30]_i_5 
       (.I0(ql_r4[29]),
        .O(\qerf_r5[30]_i_5_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair14" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[3]_i_1 
       (.I0(qerf0[17]),
        .I1(qin_r4[31]),
        .I2(ql_r4[17]),
        .O(\qerf_r5[3]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[4]_i_1 
       (.I0(qerf0[18]),
        .I1(qin_r4[31]),
        .I2(ql_r4[18]),
        .O(\qerf_r5[4]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[5]_i_1 
       (.I0(qerf0[19]),
        .I1(qin_r4[31]),
        .I2(ql_r4[19]),
        .O(\qerf_r5[5]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair13" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[6]_i_1 
       (.I0(qerf0[20]),
        .I1(qin_r4[31]),
        .I2(ql_r4[20]),
        .O(\qerf_r5[6]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[6]_i_3 
       (.I0(ql_r4[20]),
        .O(\qerf_r5[6]_i_3_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[6]_i_4 
       (.I0(ql_r4[19]),
        .O(\qerf_r5[6]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[6]_i_5 
       (.I0(ql_r4[18]),
        .O(\qerf_r5[6]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qerf_r5[6]_i_6 
       (.I0(ql_r4[17]),
        .O(\qerf_r5[6]_i_6_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair12" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[7]_i_1 
       (.I0(qerf0[21]),
        .I1(qin_r4[31]),
        .I2(ql_r4[21]),
        .O(\qerf_r5[7]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair10" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[8]_i_1 
       (.I0(qerf0[22]),
        .I1(qin_r4[31]),
        .I2(ql_r4[22]),
        .O(\qerf_r5[8]_i_1_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair11" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qerf_r5[9]_i_1 
       (.I0(qerf0[23]),
        .I1(qin_r4[31]),
        .I2(ql_r4[23]),
        .O(\qerf_r5[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[0]_i_1_n_0 ),
        .Q(qerf_r5[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[10]_i_1_n_0 ),
        .Q(qerf_r5[10]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[10]_i_2 
       (.CI(\qerf_r5_reg[6]_i_2_n_0 ),
        .CO({\qerf_r5_reg[10]_i_2_n_0 ,\qerf_r5_reg[10]_i_2_n_1 ,\qerf_r5_reg[10]_i_2_n_2 ,\qerf_r5_reg[10]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qerf0[24:21]),
        .S({\qerf_r5[10]_i_3_n_0 ,\qerf_r5[10]_i_4_n_0 ,\qerf_r5[10]_i_5_n_0 ,\qerf_r5[10]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[11]_i_1_n_0 ),
        .Q(qerf_r5[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[12]_i_1_n_0 ),
        .Q(qerf_r5[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[13]_i_1_n_0 ),
        .Q(qerf_r5[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[14]_i_1_n_0 ),
        .Q(qerf_r5[14]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[14]_i_2 
       (.CI(\qerf_r5_reg[10]_i_2_n_0 ),
        .CO({\qerf_r5_reg[14]_i_2_n_0 ,\qerf_r5_reg[14]_i_2_n_1 ,\qerf_r5_reg[14]_i_2_n_2 ,\qerf_r5_reg[14]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qerf0[28:25]),
        .S({\qerf_r5[14]_i_3_n_0 ,\qerf_r5[14]_i_4_n_0 ,\qerf_r5[14]_i_5_n_0 ,\qerf_r5[14]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[15]_i_1_n_0 ),
        .Q(qerf_r5[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[16]_i_1_n_0 ),
        .Q(qerf_r5[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[1]_i_1_n_0 ),
        .Q(qerf_r5[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[2]_i_1_n_0 ),
        .Q(qerf_r5[2]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[2]_i_13 
       (.CI(\<const0> ),
        .CO({\qerf_r5_reg[2]_i_13_n_0 ,\qerf_r5_reg[2]_i_13_n_1 ,\qerf_r5_reg[2]_i_13_n_2 ,\qerf_r5_reg[2]_i_13_n_3 }),
        .CYINIT(\qerf_r5[2]_i_18_n_0 ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\qerf_r5[2]_i_19_n_0 ,\qerf_r5[2]_i_20_n_0 ,\qerf_r5[2]_i_21_n_0 ,\qerf_r5[2]_i_22_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[2]_i_2 
       (.CI(\qerf_r5_reg[2]_i_3_n_0 ),
        .CO({\qerf_r5_reg[2]_i_2_n_0 ,\qerf_r5_reg[2]_i_2_n_1 ,\qerf_r5_reg[2]_i_2_n_2 ,\qerf_r5_reg[2]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O({qerf0[16:14],\NLW_qerf_r5_reg[2]_i_2_O_UNCONNECTED [0]}),
        .S({\qerf_r5[2]_i_4_n_0 ,\qerf_r5[2]_i_5_n_0 ,\qerf_r5[2]_i_6_n_0 ,\qerf_r5[2]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[2]_i_3 
       (.CI(\qerf_r5_reg[2]_i_8_n_0 ),
        .CO({\qerf_r5_reg[2]_i_3_n_0 ,\qerf_r5_reg[2]_i_3_n_1 ,\qerf_r5_reg[2]_i_3_n_2 ,\qerf_r5_reg[2]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\qerf_r5[2]_i_9_n_0 ,\qerf_r5[2]_i_10_n_0 ,\qerf_r5[2]_i_11_n_0 ,\qerf_r5[2]_i_12_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[2]_i_8 
       (.CI(\qerf_r5_reg[2]_i_13_n_0 ),
        .CO({\qerf_r5_reg[2]_i_8_n_0 ,\qerf_r5_reg[2]_i_8_n_1 ,\qerf_r5_reg[2]_i_8_n_2 ,\qerf_r5_reg[2]_i_8_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .S({\qerf_r5[2]_i_14_n_0 ,\qerf_r5[2]_i_15_n_0 ,\qerf_r5[2]_i_16_n_0 ,\qerf_r5[2]_i_17_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(p_0_in0),
        .Q(qerf_r5[30]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[30]_i_2 
       (.CI(\qerf_r5_reg[14]_i_2_n_0 ),
        .CO({\qerf_r5_reg[30]_i_2_n_2 ,\qerf_r5_reg[30]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qerf0[31:29]),
        .S({\<const0> ,\qerf_r5[30]_i_3_n_0 ,\qerf_r5[30]_i_4_n_0 ,\qerf_r5[30]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[3]_i_1_n_0 ),
        .Q(qerf_r5[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[4]_i_1_n_0 ),
        .Q(qerf_r5[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[5]_i_1_n_0 ),
        .Q(qerf_r5[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[6]_i_1_n_0 ),
        .Q(qerf_r5[6]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qerf_r5_reg[6]_i_2 
       (.CI(\qerf_r5_reg[2]_i_2_n_0 ),
        .CO({\qerf_r5_reg[6]_i_2_n_0 ,\qerf_r5_reg[6]_i_2_n_1 ,\qerf_r5_reg[6]_i_2_n_2 ,\qerf_r5_reg[6]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qerf0[20:17]),
        .S({\qerf_r5[6]_i_3_n_0 ,\qerf_r5[6]_i_4_n_0 ,\qerf_r5[6]_i_5_n_0 ,\qerf_r5[6]_i_6_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[7]_i_1_n_0 ),
        .Q(qerf_r5[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[8]_i_1_n_0 ),
        .Q(qerf_r5[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qerf_r5_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(\qerf_r5[9]_i_1_n_0 ),
        .Q(qerf_r5[9]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(qin[0]),
        .Q(qin_r0[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(qin[10]),
        .Q(qin_r0[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(qin[11]),
        .Q(qin_r0[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(qin[12]),
        .Q(qin_r0[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(qin[13]),
        .Q(qin_r0[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(qin[14]),
        .Q(qin_r0[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(qin[15]),
        .Q(qin_r0[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(qin[16]),
        .Q(qin_r0[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(qin[17]),
        .Q(qin_r0[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(qin[18]),
        .Q(qin_r0[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(qin[19]),
        .Q(qin_r0[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(qin[1]),
        .Q(qin_r0[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(qin[20]),
        .Q(qin_r0[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(qin[21]),
        .Q(qin_r0[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(qin[22]),
        .Q(qin_r0[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(qin[23]),
        .Q(qin_r0[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(qin[24]),
        .Q(qin_r0[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(qin[25]),
        .Q(qin_r0[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(qin[26]),
        .Q(qin_r0[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(qin[27]),
        .Q(qin_r0[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(qin[28]),
        .Q(qin_r0[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(qin[29]),
        .Q(qin_r0[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(qin[2]),
        .Q(qin_r0[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(qin[30]),
        .Q(qin_r0[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(qin[31]),
        .Q(qin_r0[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(qin[3]),
        .Q(qin_r0[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(qin[4]),
        .Q(qin_r0[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(qin[5]),
        .Q(qin_r0[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(qin[6]),
        .Q(qin_r0[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(qin[7]),
        .Q(qin_r0[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(qin[8]),
        .Q(qin_r0[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r0_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(qin[9]),
        .Q(qin_r0[9]),
        .R(rst));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[0]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[0]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[0]),
        .Q(\qin_r2_reg[0]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[10]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[10]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[10]),
        .Q(\qin_r2_reg[10]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[11]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[11]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[11]),
        .Q(\qin_r2_reg[11]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[12]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[12]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[12]),
        .Q(\qin_r2_reg[12]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[13]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[13]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[13]),
        .Q(\qin_r2_reg[13]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[14]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[14]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[14]),
        .Q(\qin_r2_reg[14]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[15]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[15]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[15]),
        .Q(\qin_r2_reg[15]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[16]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[16]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[16]),
        .Q(\qin_r2_reg[16]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[17]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[17]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[17]),
        .Q(\qin_r2_reg[17]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[18]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[18]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[18]),
        .Q(\qin_r2_reg[18]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[19]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[19]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[19]),
        .Q(\qin_r2_reg[19]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[1]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[1]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[1]),
        .Q(\qin_r2_reg[1]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[20]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[20]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[20]),
        .Q(\qin_r2_reg[20]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[21]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[21]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[21]),
        .Q(\qin_r2_reg[21]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[22]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[22]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[22]),
        .Q(\qin_r2_reg[22]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[23]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[23]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[23]),
        .Q(\qin_r2_reg[23]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[24]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[24]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[24]),
        .Q(\qin_r2_reg[24]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[25]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[25]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[25]),
        .Q(\qin_r2_reg[25]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[26]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[26]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[26]),
        .Q(\qin_r2_reg[26]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[27]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[27]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[27]),
        .Q(\qin_r2_reg[27]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[28]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[28]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[28]),
        .Q(\qin_r2_reg[28]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[29]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[29]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[29]),
        .Q(\qin_r2_reg[29]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[2]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[2]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[2]),
        .Q(\qin_r2_reg[2]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[30]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[30]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[30]),
        .Q(\qin_r2_reg[30]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[31]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[31]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[31]),
        .Q(\qin_r2_reg[31]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[3]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[3]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[3]),
        .Q(\qin_r2_reg[3]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[4]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[4]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[4]),
        .Q(\qin_r2_reg[4]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[5]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[5]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[5]),
        .Q(\qin_r2_reg[5]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[6]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[6]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[6]),
        .Q(\qin_r2_reg[6]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[7]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[7]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[7]),
        .Q(\qin_r2_reg[7]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[8]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[8]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[8]),
        .Q(\qin_r2_reg[8]_srl2___in_v_r1_reg_r_n_0 ));
  (* srl_bus_name = "\qin_r2_reg " *) 
  (* srl_name = "\qin_r2_reg[9]_srl2___in_v_r1_reg_r " *) 
  SRL16E #(
    .INIT(16'h0000)) 
    \qin_r2_reg[9]_srl2___in_v_r1_reg_r 
       (.A0(\<const1> ),
        .A1(\<const0> ),
        .A2(\<const0> ),
        .A3(\<const0> ),
        .CE(enable),
        .CLK(clk),
        .D(qin_r0[9]),
        .Q(\qin_r2_reg[9]_srl2___in_v_r1_reg_r_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[0]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[0]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[0]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[10]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[10]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[10]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[11]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[11]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[11]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[12]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[12]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[12]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[13]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[13]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[13]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[14]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[14]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[14]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[15]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[15]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[15]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[16]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[16]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[16]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[17]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[17]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[17]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[18]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[18]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[18]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[19]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[19]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[19]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[1]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[1]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[1]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[20]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[20]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[20]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[21]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[21]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[21]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[22]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[22]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[22]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[23]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[23]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[23]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[24]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[24]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[24]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[25]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[25]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[25]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[26]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[26]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[26]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[27]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[27]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[27]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[28]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[28]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[28]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[29]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[29]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[29]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[2]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[2]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[2]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[30]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[30]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[30]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[31]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[31]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[31]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[3]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[3]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[3]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[4]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[4]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[4]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[5]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[5]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[5]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[6]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[6]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[6]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[7]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[7]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[7]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[8]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[8]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[8]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r3_reg[9]_in_v_r2_reg_r 
       (.C(clk),
        .CE(enable),
        .D(\qin_r2_reg[9]_srl2___in_v_r1_reg_r_n_0 ),
        .Q(\qin_r3_reg[9]_in_v_r2_reg_r_n_0 ),
        .R(\<const0> ));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate
       (.I0(\qin_r3_reg[31]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate_n_0));
  (* SOFT_HLUTNM = "soft_lutpair32" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__0
       (.I0(\qin_r3_reg[30]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__0_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__1
       (.I0(\qin_r3_reg[29]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__1_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__10
       (.I0(\qin_r3_reg[20]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__10_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__11
       (.I0(\qin_r3_reg[19]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__11_n_0));
  (* SOFT_HLUTNM = "soft_lutpair38" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__12
       (.I0(\qin_r3_reg[18]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__12_n_0));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__13
       (.I0(\qin_r3_reg[17]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__13_n_0));
  (* SOFT_HLUTNM = "soft_lutpair39" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__14
       (.I0(\qin_r3_reg[16]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__14_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__15
       (.I0(\qin_r3_reg[15]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__15_n_0));
  (* SOFT_HLUTNM = "soft_lutpair40" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__16
       (.I0(\qin_r3_reg[14]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__16_n_0));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__17
       (.I0(\qin_r3_reg[13]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__17_n_0));
  (* SOFT_HLUTNM = "soft_lutpair41" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__18
       (.I0(\qin_r3_reg[12]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__18_n_0));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__19
       (.I0(\qin_r3_reg[11]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__19_n_0));
  (* SOFT_HLUTNM = "soft_lutpair33" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__2
       (.I0(\qin_r3_reg[28]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__2_n_0));
  (* SOFT_HLUTNM = "soft_lutpair42" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__20
       (.I0(\qin_r3_reg[10]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__20_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__21
       (.I0(\qin_r3_reg[9]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__21_n_0));
  (* SOFT_HLUTNM = "soft_lutpair43" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__22
       (.I0(\qin_r3_reg[8]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__22_n_0));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__23
       (.I0(\qin_r3_reg[7]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__23_n_0));
  (* SOFT_HLUTNM = "soft_lutpair44" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__24
       (.I0(\qin_r3_reg[6]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__24_n_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__25
       (.I0(\qin_r3_reg[5]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__25_n_0));
  (* SOFT_HLUTNM = "soft_lutpair45" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__26
       (.I0(\qin_r3_reg[4]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__26_n_0));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__27
       (.I0(\qin_r3_reg[3]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__27_n_0));
  (* SOFT_HLUTNM = "soft_lutpair46" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__28
       (.I0(\qin_r3_reg[2]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__28_n_0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__29
       (.I0(\qin_r3_reg[1]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__29_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__3
       (.I0(\qin_r3_reg[27]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__3_n_0));
  (* SOFT_HLUTNM = "soft_lutpair47" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__30
       (.I0(\qin_r3_reg[0]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__30_n_0));
  (* SOFT_HLUTNM = "soft_lutpair34" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__4
       (.I0(\qin_r3_reg[26]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__4_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__5
       (.I0(\qin_r3_reg[25]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__5_n_0));
  (* SOFT_HLUTNM = "soft_lutpair35" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__6
       (.I0(\qin_r3_reg[24]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__6_n_0));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__7
       (.I0(\qin_r3_reg[23]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__7_n_0));
  (* SOFT_HLUTNM = "soft_lutpair36" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__8
       (.I0(\qin_r3_reg[22]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__8_n_0));
  (* SOFT_HLUTNM = "soft_lutpair37" *) 
  LUT2 #(
    .INIT(4'h8)) 
    qin_r3_reg_gate__9
       (.I0(\qin_r3_reg[21]_in_v_r2_reg_r_n_0 ),
        .I1(in_v_r2_reg_r_n_0),
        .O(qin_r3_reg_gate__9_n_0));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__30_n_0),
        .Q(qin_r4[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__20_n_0),
        .Q(qin_r4[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__19_n_0),
        .Q(qin_r4[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__18_n_0),
        .Q(qin_r4[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__17_n_0),
        .Q(qin_r4[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__16_n_0),
        .Q(qin_r4[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__15_n_0),
        .Q(qin_r4[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__14_n_0),
        .Q(qin_r4[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__13_n_0),
        .Q(qin_r4[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__12_n_0),
        .Q(qin_r4[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__11_n_0),
        .Q(qin_r4[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__29_n_0),
        .Q(qin_r4[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__10_n_0),
        .Q(qin_r4[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__9_n_0),
        .Q(qin_r4[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__8_n_0),
        .Q(qin_r4[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__7_n_0),
        .Q(qin_r4[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__6_n_0),
        .Q(qin_r4[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__5_n_0),
        .Q(qin_r4[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__4_n_0),
        .Q(qin_r4[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__3_n_0),
        .Q(qin_r4[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__2_n_0),
        .Q(qin_r4[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__1_n_0),
        .Q(qin_r4[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__28_n_0),
        .Q(qin_r4[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__0_n_0),
        .Q(qin_r4[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate_n_0),
        .Q(qin_r4[31]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__27_n_0),
        .Q(qin_r4[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__26_n_0),
        .Q(qin_r4[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__25_n_0),
        .Q(qin_r4[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__24_n_0),
        .Q(qin_r4[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__23_n_0),
        .Q(qin_r4[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__22_n_0),
        .Q(qin_r4[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qin_r4_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(qin_r3_reg_gate__21_n_0),
        .Q(qin_r4[9]),
        .R(rst));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 15x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(2),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(2),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    ql_r30
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\qmin_r1[16]_i_1_n_0 ,\qmin_r1[15]_i_1_n_0 ,\qmin_r1[14]_i_1_n_0 ,\qmin_r1[13]_i_1_n_0 ,\qmin_r1[12]_i_1_n_0 ,\qmin_r1[11]_i_1_n_0 ,\qmin_r1[10]_i_1_n_0 ,\qmin_r1[9]_i_1_n_0 ,\qmin_r1[8]_i_1_n_0 ,\qmin_r1[7]_i_1_n_0 ,\qmin_r1[6]_i_1_n_0 ,\qmin_r1[5]_i_1_n_0 ,\qmin_r1[4]_i_1_n_0 ,\qmin_r1[3]_i_1_n_0 ,\qmin_r1[2]_i_1_n_0 ,\qmin_r1[1]_i_1_n_0 ,\qmin_r1[0]_i_1_n_0 }),
        .ACIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({ql_r30_i_1_n_4,ql_r30_i_1_n_4,ql_r30_i_1_n_4,ql_r30_i_1_n_4,ql_r30_i_1_n_5,ql_r30_i_1_n_6,ql_r30_i_1_n_7,ql_r30_i_2_n_4,ql_r30_i_2_n_5,ql_r30_i_2_n_6,ql_r30_i_2_n_7,ql_r30_i_3_n_4,ql_r30_i_3_n_5,ql_r30_i_3_n_6,ql_r30_i_3_n_7,ql_r30_i_4_n_4,ql_r30_i_4_n_5,ql_r30_i_4_n_6}),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(enable),
        .CEA2(enable),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(\<const0> ),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(enable),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({ql_r30_n_58,ql_r30_n_59,ql_r30_n_60,ql_r30_n_61,ql_r30_n_62,ql_r30_n_63,ql_r30_n_64,ql_r30_n_65,ql_r30_n_66,ql_r30_n_67,ql_r30_n_68,ql_r30_n_69,ql_r30_n_70,ql_r30_n_71,ql_r30_n_72,ql_r30_n_73,ql_r30_n_74,ql_r30_n_75,ql_r30_n_76,ql_r30_n_77,ql_r30_n_78,ql_r30_n_79,ql_r30_n_80,ql_r30_n_81,ql_r30_n_82,ql_r30_n_83,ql_r30_n_84,ql_r30_n_85,ql_r30_n_86,ql_r30_n_87,ql_r30_n_88,ql_r30_n_89,ql_r30_n_90,ql_r30_n_91,ql_r30_n_92,ql_r30_n_93,ql_r30_n_94,ql_r30_n_95,ql_r30_n_96,ql_r30_n_97,ql_r30_n_98,ql_r30_n_99,ql_r30_n_100,ql_r30_n_101,ql_r30_n_102,ql_r30_n_103,ql_r30_n_104,ql_r30_n_105}),
        .PCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .PCOUT({ql_r30_n_106,ql_r30_n_107,ql_r30_n_108,ql_r30_n_109,ql_r30_n_110,ql_r30_n_111,ql_r30_n_112,ql_r30_n_113,ql_r30_n_114,ql_r30_n_115,ql_r30_n_116,ql_r30_n_117,ql_r30_n_118,ql_r30_n_119,ql_r30_n_120,ql_r30_n_121,ql_r30_n_122,ql_r30_n_123,ql_r30_n_124,ql_r30_n_125,ql_r30_n_126,ql_r30_n_127,ql_r30_n_128,ql_r30_n_129,ql_r30_n_130,ql_r30_n_131,ql_r30_n_132,ql_r30_n_133,ql_r30_n_134,ql_r30_n_135,ql_r30_n_136,ql_r30_n_137,ql_r30_n_138,ql_r30_n_139,ql_r30_n_140,ql_r30_n_141,ql_r30_n_142,ql_r30_n_143,ql_r30_n_144,ql_r30_n_145,ql_r30_n_146,ql_r30_n_147,ql_r30_n_148,ql_r30_n_149,ql_r30_n_150,ql_r30_n_151,ql_r30_n_152,ql_r30_n_153}),
        .RSTA(rst),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(rst));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(1),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(1),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(2),
    .BREG(2),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    ql_r30__0
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,ql_r30_i_4_n_7,ql_r30__0_i_1_n_4,ql_r30__0_i_1_n_5,ql_r30__0_i_1_n_6,ql_r30__0_i_1_n_7,ql_r30__0_i_2_n_4,ql_r30__0_i_2_n_5,ql_r30__0_i_2_n_6,ql_r30__0_i_2_n_7,ql_r30__0_i_3_n_4,ql_r30__0_i_3_n_5,ql_r30__0_i_3_n_6,ql_r30__0_i_3_n_7,ql_r30__0_i_4_n_4,ql_r30__0_i_4_n_5,ql_r30__0_i_4_n_6,ql_r30__0_i_4_n_7}),
        .ACIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ACOUT({ql_r30__0_n_24,ql_r30__0_n_25,ql_r30__0_n_26,ql_r30__0_n_27,ql_r30__0_n_28,ql_r30__0_n_29,ql_r30__0_n_30,ql_r30__0_n_31,ql_r30__0_n_32,ql_r30__0_n_33,ql_r30__0_n_34,ql_r30__0_n_35,ql_r30__0_n_36,ql_r30__0_n_37,ql_r30__0_n_38,ql_r30__0_n_39,ql_r30__0_n_40,ql_r30__0_n_41,ql_r30__0_n_42,ql_r30__0_n_43,ql_r30__0_n_44,ql_r30__0_n_45,ql_r30__0_n_46,ql_r30__0_n_47,ql_r30__0_n_48,ql_r30__0_n_49,ql_r30__0_n_50,ql_r30__0_n_51,ql_r30__0_n_52,ql_r30__0_n_53}),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({\<const0> ,\qmin_r1[16]_i_1_n_0 ,\qmin_r1[15]_i_1_n_0 ,\qmin_r1[14]_i_1_n_0 ,\qmin_r1[13]_i_1_n_0 ,\qmin_r1[12]_i_1_n_0 ,\qmin_r1[11]_i_1_n_0 ,\qmin_r1[10]_i_1_n_0 ,\qmin_r1[9]_i_1_n_0 ,\qmin_r1[8]_i_1_n_0 ,\qmin_r1[7]_i_1_n_0 ,\qmin_r1[6]_i_1_n_0 ,\qmin_r1[5]_i_1_n_0 ,\qmin_r1[4]_i_1_n_0 ,\qmin_r1[3]_i_1_n_0 ,\qmin_r1[2]_i_1_n_0 ,\qmin_r1[1]_i_1_n_0 ,\qmin_r1[0]_i_1_n_0 }),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(\<const0> ),
        .CEA2(enable),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(enable),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(\<const0> ),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({ql_r30__0_n_58,ql_r30__0_n_59,ql_r30__0_n_60,ql_r30__0_n_61,ql_r30__0_n_62,ql_r30__0_n_63,ql_r30__0_n_64,ql_r30__0_n_65,ql_r30__0_n_66,ql_r30__0_n_67,ql_r30__0_n_68,ql_r30__0_n_69,ql_r30__0_n_70,ql_r30__0_n_71,ql_r30__0_n_72,ql_r30__0_n_73,ql_r30__0_n_74,ql_r30__0_n_75,ql_r30__0_n_76,ql_r30__0_n_77,ql_r30__0_n_78,ql_r30__0_n_79,ql_r30__0_n_80,ql_r30__0_n_81,ql_r30__0_n_82,ql_r30__0_n_83,ql_r30__0_n_84,ql_r30__0_n_85,ql_r30__0_n_86,ql_r30__0_n_87,ql_r30__0_n_88,ql_r30__0_n_89,ql_r30__0_n_90,ql_r30__0_n_91,ql_r30__0_n_92,ql_r30__0_n_93,ql_r30__0_n_94,ql_r30__0_n_95,ql_r30__0_n_96,ql_r30__0_n_97,ql_r30__0_n_98,ql_r30__0_n_99,ql_r30__0_n_100,ql_r30__0_n_101,ql_r30__0_n_102,ql_r30__0_n_103,ql_r30__0_n_104,ql_r30__0_n_105}),
        .PCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .PCOUT({ql_r30__0_n_106,ql_r30__0_n_107,ql_r30__0_n_108,ql_r30__0_n_109,ql_r30__0_n_110,ql_r30__0_n_111,ql_r30__0_n_112,ql_r30__0_n_113,ql_r30__0_n_114,ql_r30__0_n_115,ql_r30__0_n_116,ql_r30__0_n_117,ql_r30__0_n_118,ql_r30__0_n_119,ql_r30__0_n_120,ql_r30__0_n_121,ql_r30__0_n_122,ql_r30__0_n_123,ql_r30__0_n_124,ql_r30__0_n_125,ql_r30__0_n_126,ql_r30__0_n_127,ql_r30__0_n_128,ql_r30__0_n_129,ql_r30__0_n_130,ql_r30__0_n_131,ql_r30__0_n_132,ql_r30__0_n_133,ql_r30__0_n_134,ql_r30__0_n_135,ql_r30__0_n_136,ql_r30__0_n_137,ql_r30__0_n_138,ql_r30__0_n_139,ql_r30__0_n_140,ql_r30__0_n_141,ql_r30__0_n_142,ql_r30__0_n_143,ql_r30__0_n_144,ql_r30__0_n_145,ql_r30__0_n_146,ql_r30__0_n_147,ql_r30__0_n_148,ql_r30__0_n_149,ql_r30__0_n_150,ql_r30__0_n_151,ql_r30__0_n_152,ql_r30__0_n_153}),
        .RSTA(rst),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(\<const0> ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30__0_i_1
       (.CI(ql_r30__0_i_2_n_0),
        .CO({ql_r30__0_i_1_n_0,ql_r30__0_i_1_n_1,ql_r30__0_i_1_n_2,ql_r30__0_i_1_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[15:12]),
        .O({ql_r30__0_i_1_n_4,ql_r30__0_i_1_n_5,ql_r30__0_i_1_n_6,ql_r30__0_i_1_n_7}),
        .S({ql_r30__0_i_5_n_0,ql_r30__0_i_6_n_0,ql_r30__0_i_7_n_0,ql_r30__0_i_8_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_10
       (.I0(qmin_r1[10]),
        .I1(ql_r21[10]),
        .O(ql_r30__0_i_10_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_11
       (.I0(qmin_r1[9]),
        .I1(ql_r21[9]),
        .O(ql_r30__0_i_11_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_12
       (.I0(qmin_r1[8]),
        .I1(ql_r21[8]),
        .O(ql_r30__0_i_12_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_13
       (.I0(qmin_r1[7]),
        .I1(ql_r21[7]),
        .O(ql_r30__0_i_13_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_14
       (.I0(qmin_r1[6]),
        .I1(ql_r21[6]),
        .O(ql_r30__0_i_14_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_15
       (.I0(qmin_r1[5]),
        .I1(ql_r21[5]),
        .O(ql_r30__0_i_15_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_16
       (.I0(qmin_r1[4]),
        .I1(ql_r21[4]),
        .O(ql_r30__0_i_16_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_17
       (.I0(qmin_r1[3]),
        .I1(ql_r21[3]),
        .O(ql_r30__0_i_17_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_18
       (.I0(qmin_r1[2]),
        .I1(ql_r21[2]),
        .O(ql_r30__0_i_18_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_19
       (.I0(qmin_r1[1]),
        .I1(ql_r21[1]),
        .O(ql_r30__0_i_19_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30__0_i_2
       (.CI(ql_r30__0_i_3_n_0),
        .CO({ql_r30__0_i_2_n_0,ql_r30__0_i_2_n_1,ql_r30__0_i_2_n_2,ql_r30__0_i_2_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[11:8]),
        .O({ql_r30__0_i_2_n_4,ql_r30__0_i_2_n_5,ql_r30__0_i_2_n_6,ql_r30__0_i_2_n_7}),
        .S({ql_r30__0_i_9_n_0,ql_r30__0_i_10_n_0,ql_r30__0_i_11_n_0,ql_r30__0_i_12_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30__0_i_3
       (.CI(ql_r30__0_i_4_n_0),
        .CO({ql_r30__0_i_3_n_0,ql_r30__0_i_3_n_1,ql_r30__0_i_3_n_2,ql_r30__0_i_3_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[7:4]),
        .O({ql_r30__0_i_3_n_4,ql_r30__0_i_3_n_5,ql_r30__0_i_3_n_6,ql_r30__0_i_3_n_7}),
        .S({ql_r30__0_i_13_n_0,ql_r30__0_i_14_n_0,ql_r30__0_i_15_n_0,ql_r30__0_i_16_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30__0_i_4
       (.CI(\<const0> ),
        .CO({ql_r30__0_i_4_n_0,ql_r30__0_i_4_n_1,ql_r30__0_i_4_n_2,ql_r30__0_i_4_n_3}),
        .CYINIT(\<const0> ),
        .DI({qmin_r1[3:1],\<const0> }),
        .O({ql_r30__0_i_4_n_4,ql_r30__0_i_4_n_5,ql_r30__0_i_4_n_6,ql_r30__0_i_4_n_7}),
        .S({ql_r30__0_i_17_n_0,ql_r30__0_i_18_n_0,ql_r30__0_i_19_n_0,qmin_r1[0]}));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_5
       (.I0(qmin_r1[15]),
        .I1(ql_r21[15]),
        .O(ql_r30__0_i_5_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_6
       (.I0(qmin_r1[14]),
        .I1(ql_r21[14]),
        .O(ql_r30__0_i_6_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_7
       (.I0(qmin_r1[13]),
        .I1(ql_r21[13]),
        .O(ql_r30__0_i_7_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_8
       (.I0(qmin_r1[12]),
        .I1(ql_r21[12]),
        .O(ql_r30__0_i_8_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30__0_i_9
       (.I0(qmin_r1[11]),
        .I1(ql_r21[11]),
        .O(ql_r30__0_i_9_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30_i_1
       (.CI(ql_r30_i_2_n_0),
        .CO({ql_r30_i_1_n_1,ql_r30_i_1_n_2,ql_r30_i_1_n_3}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,qmin_r1[30:28]}),
        .O({ql_r30_i_1_n_4,ql_r30_i_1_n_5,ql_r30_i_1_n_6,ql_r30_i_1_n_7}),
        .S({ql_r30_i_5_n_0,ql_r30_i_6_n_0,ql_r30_i_7_n_0,ql_r30_i_8_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_10
       (.I0(qmin_r1[26]),
        .I1(ql_r21[26]),
        .O(ql_r30_i_10_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_11
       (.I0(qmin_r1[25]),
        .I1(ql_r21[25]),
        .O(ql_r30_i_11_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_12
       (.I0(qmin_r1[24]),
        .I1(ql_r21[24]),
        .O(ql_r30_i_12_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_13
       (.I0(qmin_r1[23]),
        .I1(ql_r21[23]),
        .O(ql_r30_i_13_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_14
       (.I0(qmin_r1[22]),
        .I1(ql_r21[22]),
        .O(ql_r30_i_14_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_15
       (.I0(qmin_r1[21]),
        .I1(ql_r21[21]),
        .O(ql_r30_i_15_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_16
       (.I0(qmin_r1[20]),
        .I1(ql_r21[20]),
        .O(ql_r30_i_16_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_17
       (.I0(qmin_r1[19]),
        .I1(ql_r21[19]),
        .O(ql_r30_i_17_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_18
       (.I0(qmin_r1[18]),
        .I1(ql_r21[18]),
        .O(ql_r30_i_18_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_19
       (.I0(qmin_r1[17]),
        .I1(ql_r21[17]),
        .O(ql_r30_i_19_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30_i_2
       (.CI(ql_r30_i_3_n_0),
        .CO({ql_r30_i_2_n_0,ql_r30_i_2_n_1,ql_r30_i_2_n_2,ql_r30_i_2_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[27:24]),
        .O({ql_r30_i_2_n_4,ql_r30_i_2_n_5,ql_r30_i_2_n_6,ql_r30_i_2_n_7}),
        .S({ql_r30_i_9_n_0,ql_r30_i_10_n_0,ql_r30_i_11_n_0,ql_r30_i_12_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_20
       (.I0(qmin_r1[16]),
        .I1(ql_r21[16]),
        .O(ql_r30_i_20_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30_i_3
       (.CI(ql_r30_i_4_n_0),
        .CO({ql_r30_i_3_n_0,ql_r30_i_3_n_1,ql_r30_i_3_n_2,ql_r30_i_3_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[23:20]),
        .O({ql_r30_i_3_n_4,ql_r30_i_3_n_5,ql_r30_i_3_n_6,ql_r30_i_3_n_7}),
        .S({ql_r30_i_13_n_0,ql_r30_i_14_n_0,ql_r30_i_15_n_0,ql_r30_i_16_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 ql_r30_i_4
       (.CI(ql_r30__0_i_1_n_0),
        .CO({ql_r30_i_4_n_0,ql_r30_i_4_n_1,ql_r30_i_4_n_2,ql_r30_i_4_n_3}),
        .CYINIT(\<const0> ),
        .DI(qmin_r1[19:16]),
        .O({ql_r30_i_4_n_4,ql_r30_i_4_n_5,ql_r30_i_4_n_6,ql_r30_i_4_n_7}),
        .S({ql_r30_i_17_n_0,ql_r30_i_18_n_0,ql_r30_i_19_n_0,ql_r30_i_20_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_5
       (.I0(qmin_r1[31]),
        .I1(ql_r21[31]),
        .O(ql_r30_i_5_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_6
       (.I0(qmin_r1[30]),
        .I1(ql_r21[30]),
        .O(ql_r30_i_6_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_7
       (.I0(qmin_r1[29]),
        .I1(ql_r21[29]),
        .O(ql_r30_i_7_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_8
       (.I0(qmin_r1[28]),
        .I1(ql_r21[28]),
        .O(ql_r30_i_8_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    ql_r30_i_9
       (.I0(qmin_r1[27]),
        .I1(ql_r21[27]),
        .O(ql_r30_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x15 4}}" *) 
  DSP48E1 #(
    .ACASCREG(0),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(0),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("CASCADE"),
    .BCASCREG(2),
    .BREG(2),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    ql_r3_reg
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ACIN({ql_r30__0_n_24,ql_r30__0_n_25,ql_r30__0_n_26,ql_r30__0_n_27,ql_r30__0_n_28,ql_r30__0_n_29,ql_r30__0_n_30,ql_r30__0_n_31,ql_r30__0_n_32,ql_r30__0_n_33,ql_r30__0_n_34,ql_r30__0_n_35,ql_r30__0_n_36,ql_r30__0_n_37,ql_r30__0_n_38,ql_r30__0_n_39,ql_r30__0_n_40,ql_r30__0_n_41,ql_r30__0_n_42,ql_r30__0_n_43,ql_r30__0_n_44,ql_r30__0_n_45,ql_r30__0_n_46,ql_r30__0_n_47,ql_r30__0_n_48,ql_r30__0_n_49,ql_r30__0_n_50,ql_r30__0_n_51,ql_r30__0_n_52,ql_r30__0_n_53}),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({\qmin_r1[31]_i_1_n_0 ,\qmin_r1[31]_i_1_n_0 ,\qmin_r1[31]_i_1_n_0 ,\qmin_r1[31]_i_1_n_0 ,\qmin_r1[30]_i_1_n_0 ,\qmin_r1[29]_i_1_n_0 ,\qmin_r1[28]_i_1_n_0 ,\qmin_r1[27]_i_1_n_0 ,\qmin_r1[26]_i_1_n_0 ,\qmin_r1[25]_i_1_n_0 ,\qmin_r1[24]_i_1_n_0 ,\qmin_r1[23]_i_1_n_0 ,\qmin_r1[22]_i_1_n_0 ,\qmin_r1[21]_i_1_n_0 ,\qmin_r1[20]_i_1_n_0 ,\qmin_r1[19]_i_1_n_0 ,\qmin_r1[18]_i_1_n_0 ,\qmin_r1[17]_i_1_n_0 }),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(\<const0> ),
        .CEA2(\<const0> ),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(enable),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(enable),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const1> ,\<const0> ,\<const1> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({ql_r3_reg_n_58,ql_r3_reg_n_59,ql_r3_reg_n_60,ql_r3_reg_n_61,ql_r3_reg_n_62,ql_r3_reg_n_63,ql_r3_reg_n_64,ql_r3_reg_n_65,ql_r3_reg_n_66,ql_r3_reg_n_67,ql_r3_reg_n_68,ql_r3_reg_n_69,ql_r3_reg_n_70,ql_r3_reg_n_71,ql_r3_reg_n_72,ql_r3_reg_n_73,ql_r3_reg_n_74,ql_r3_reg_n_75,ql_r3_reg_n_76,ql_r3_reg_n_77,ql_r3_reg_n_78,ql_r3_reg_n_79,ql_r3_reg_n_80,ql_r3_reg_n_81,ql_r3_reg_n_82,ql_r3_reg_n_83,ql_r3_reg_n_84,ql_r3_reg_n_85,ql_r3_reg_n_86,ql_r3_reg_n_87,ql_r3_reg_n_88,ql_r3_reg_n_89,ql_r3_reg_n_90,ql_r3_reg_n_91,ql_r3_reg_n_92,ql_r3_reg_n_93,ql_r3_reg_n_94,ql_r3_reg_n_95,ql_r3_reg_n_96,ql_r3_reg_n_97,ql_r3_reg_n_98,ql_r3_reg_n_99,ql_r3_reg_n_100,ql_r3_reg_n_101,ql_r3_reg_n_102,ql_r3_reg_n_103,ql_r3_reg_n_104,ql_r3_reg_n_105}),
        .PCIN({ql_r30__0_n_106,ql_r30__0_n_107,ql_r30__0_n_108,ql_r30__0_n_109,ql_r30__0_n_110,ql_r30__0_n_111,ql_r30__0_n_112,ql_r30__0_n_113,ql_r30__0_n_114,ql_r30__0_n_115,ql_r30__0_n_116,ql_r30__0_n_117,ql_r30__0_n_118,ql_r30__0_n_119,ql_r30__0_n_120,ql_r30__0_n_121,ql_r30__0_n_122,ql_r30__0_n_123,ql_r30__0_n_124,ql_r30__0_n_125,ql_r30__0_n_126,ql_r30__0_n_127,ql_r30__0_n_128,ql_r30__0_n_129,ql_r30__0_n_130,ql_r30__0_n_131,ql_r30__0_n_132,ql_r30__0_n_133,ql_r30__0_n_134,ql_r30__0_n_135,ql_r30__0_n_136,ql_r30__0_n_137,ql_r30__0_n_138,ql_r30__0_n_139,ql_r30__0_n_140,ql_r30__0_n_141,ql_r30__0_n_142,ql_r30__0_n_143,ql_r30__0_n_144,ql_r30__0_n_145,ql_r30__0_n_146,ql_r30__0_n_147,ql_r30__0_n_148,ql_r30__0_n_149,ql_r30__0_n_150,ql_r30__0_n_151,ql_r30__0_n_152,ql_r30__0_n_153}),
        .RSTA(\<const0> ),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[0]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_105),
        .Q(\ql_r3_reg[0]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[10]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_95),
        .Q(\ql_r3_reg[10]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[11]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_94),
        .Q(\ql_r3_reg[11]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[12]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_93),
        .Q(\ql_r3_reg[12]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[13]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_92),
        .Q(\ql_r3_reg[13]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[14]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_91),
        .Q(\ql_r3_reg[14]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[15]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_90),
        .Q(\ql_r3_reg[15]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[16]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_89),
        .Q(\ql_r3_reg[16]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[1]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_104),
        .Q(\ql_r3_reg[1]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[2]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_103),
        .Q(\ql_r3_reg[2]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[3]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_102),
        .Q(\ql_r3_reg[3]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[4]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_101),
        .Q(\ql_r3_reg[4]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[5]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_100),
        .Q(\ql_r3_reg[5]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[6]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_99),
        .Q(\ql_r3_reg[6]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[7]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_98),
        .Q(\ql_r3_reg[7]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[8]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_97),
        .Q(\ql_r3_reg[8]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r3_reg[9]__0 
       (.C(clk),
        .CE(enable),
        .D(ql_r30__0_n_96),
        .Q(\ql_r3_reg[9]__0_n_0 ),
        .R(rst));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[11]_i_2 
       (.I0(\ql_r3_reg[11]__0_n_0 ),
        .I1(qc_r3[11]),
        .O(\ql_r4[11]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[11]_i_3 
       (.I0(\ql_r3_reg[10]__0_n_0 ),
        .I1(qc_r3[10]),
        .O(\ql_r4[11]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[11]_i_4 
       (.I0(\ql_r3_reg[9]__0_n_0 ),
        .I1(qc_r3[9]),
        .O(\ql_r4[11]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[11]_i_5 
       (.I0(\ql_r3_reg[8]__0_n_0 ),
        .I1(qc_r3[8]),
        .O(\ql_r4[11]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[15]_i_2 
       (.I0(\ql_r3_reg[15]__0_n_0 ),
        .I1(qc_r3[15]),
        .O(\ql_r4[15]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[15]_i_3 
       (.I0(\ql_r3_reg[14]__0_n_0 ),
        .I1(qc_r3[14]),
        .O(\ql_r4[15]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[15]_i_4 
       (.I0(\ql_r3_reg[13]__0_n_0 ),
        .I1(qc_r3[13]),
        .O(\ql_r4[15]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[15]_i_5 
       (.I0(\ql_r3_reg[12]__0_n_0 ),
        .I1(qc_r3[12]),
        .O(\ql_r4[15]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_3 
       (.I0(ql_r3_reg__0[19]),
        .I1(qc_r3[19]),
        .O(\ql_r4[19]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_4 
       (.I0(ql_r3_reg__0[18]),
        .I1(qc_r3[18]),
        .O(\ql_r4[19]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_5 
       (.I0(ql_r3_reg__0[17]),
        .I1(qc_r3[17]),
        .O(\ql_r4[19]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_6 
       (.I0(ql_r3_reg__0[16]),
        .I1(qc_r3[16]),
        .O(\ql_r4[19]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_7 
       (.I0(ql_r3_reg_n_103),
        .I1(ql_r30_n_103),
        .O(\ql_r4[19]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_8 
       (.I0(ql_r3_reg_n_104),
        .I1(ql_r30_n_104),
        .O(\ql_r4[19]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[19]_i_9 
       (.I0(ql_r3_reg_n_105),
        .I1(ql_r30_n_105),
        .O(\ql_r4[19]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_10 
       (.I0(ql_r3_reg_n_102),
        .I1(ql_r30_n_102),
        .O(\ql_r4[23]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_3 
       (.I0(ql_r3_reg__0[23]),
        .I1(qc_r3[23]),
        .O(\ql_r4[23]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_4 
       (.I0(ql_r3_reg__0[22]),
        .I1(qc_r3[22]),
        .O(\ql_r4[23]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_5 
       (.I0(ql_r3_reg__0[21]),
        .I1(qc_r3[21]),
        .O(\ql_r4[23]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_6 
       (.I0(ql_r3_reg__0[20]),
        .I1(qc_r3[20]),
        .O(\ql_r4[23]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_7 
       (.I0(ql_r3_reg_n_99),
        .I1(ql_r30_n_99),
        .O(\ql_r4[23]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_8 
       (.I0(ql_r3_reg_n_100),
        .I1(ql_r30_n_100),
        .O(\ql_r4[23]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[23]_i_9 
       (.I0(ql_r3_reg_n_101),
        .I1(ql_r30_n_101),
        .O(\ql_r4[23]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_10 
       (.I0(ql_r3_reg_n_98),
        .I1(ql_r30_n_98),
        .O(\ql_r4[27]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_3 
       (.I0(ql_r3_reg__0[27]),
        .I1(qc_r3[27]),
        .O(\ql_r4[27]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_4 
       (.I0(ql_r3_reg__0[26]),
        .I1(qc_r3[26]),
        .O(\ql_r4[27]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_5 
       (.I0(ql_r3_reg__0[25]),
        .I1(qc_r3[25]),
        .O(\ql_r4[27]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_6 
       (.I0(ql_r3_reg__0[24]),
        .I1(qc_r3[24]),
        .O(\ql_r4[27]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_7 
       (.I0(ql_r3_reg_n_95),
        .I1(ql_r30_n_95),
        .O(\ql_r4[27]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_8 
       (.I0(ql_r3_reg_n_96),
        .I1(ql_r30_n_96),
        .O(\ql_r4[27]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[27]_i_9 
       (.I0(ql_r3_reg_n_97),
        .I1(ql_r30_n_97),
        .O(\ql_r4[27]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_10 
       (.I0(ql_r3_reg_n_94),
        .I1(ql_r30_n_94),
        .O(\ql_r4[31]_i_10_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_3 
       (.I0(ql_r3_reg__0[31]),
        .I1(qc_r3[31]),
        .O(\ql_r4[31]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_4 
       (.I0(ql_r3_reg__0[30]),
        .I1(qc_r3[30]),
        .O(\ql_r4[31]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_5 
       (.I0(ql_r3_reg__0[29]),
        .I1(qc_r3[29]),
        .O(\ql_r4[31]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_6 
       (.I0(ql_r3_reg__0[28]),
        .I1(qc_r3[28]),
        .O(\ql_r4[31]_i_6_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_7 
       (.I0(ql_r3_reg_n_91),
        .I1(ql_r30_n_91),
        .O(\ql_r4[31]_i_7_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_8 
       (.I0(ql_r3_reg_n_92),
        .I1(ql_r30_n_92),
        .O(\ql_r4[31]_i_8_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[31]_i_9 
       (.I0(ql_r3_reg_n_93),
        .I1(ql_r30_n_93),
        .O(\ql_r4[31]_i_9_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[3]_i_2 
       (.I0(\ql_r3_reg[3]__0_n_0 ),
        .I1(qc_r3[3]),
        .O(\ql_r4[3]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[3]_i_3 
       (.I0(\ql_r3_reg[2]__0_n_0 ),
        .I1(qc_r3[2]),
        .O(\ql_r4[3]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[3]_i_4 
       (.I0(\ql_r3_reg[1]__0_n_0 ),
        .I1(qc_r3[1]),
        .O(\ql_r4[3]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[3]_i_5 
       (.I0(\ql_r3_reg[0]__0_n_0 ),
        .I1(qc_r3[0]),
        .O(\ql_r4[3]_i_5_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[7]_i_2 
       (.I0(\ql_r3_reg[7]__0_n_0 ),
        .I1(qc_r3[7]),
        .O(\ql_r4[7]_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[7]_i_3 
       (.I0(\ql_r3_reg[6]__0_n_0 ),
        .I1(qc_r3[6]),
        .O(\ql_r4[7]_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[7]_i_4 
       (.I0(\ql_r3_reg[5]__0_n_0 ),
        .I1(qc_r3[5]),
        .O(\ql_r4[7]_i_4_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \ql_r4[7]_i_5 
       (.I0(\ql_r3_reg[4]__0_n_0 ),
        .I1(qc_r3[4]),
        .O(\ql_r4[7]_i_5_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[3]_i_1_n_7 ),
        .Q(ql_r4[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[11]_i_1_n_5 ),
        .Q(ql_r4[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[11]_i_1_n_4 ),
        .Q(ql_r4[11]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[11]_i_1 
       (.CI(\ql_r4_reg[7]_i_1_n_0 ),
        .CO({\ql_r4_reg[11]_i_1_n_0 ,\ql_r4_reg[11]_i_1_n_1 ,\ql_r4_reg[11]_i_1_n_2 ,\ql_r4_reg[11]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\ql_r3_reg[11]__0_n_0 ,\ql_r3_reg[10]__0_n_0 ,\ql_r3_reg[9]__0_n_0 ,\ql_r3_reg[8]__0_n_0 }),
        .O({\ql_r4_reg[11]_i_1_n_4 ,\ql_r4_reg[11]_i_1_n_5 ,\ql_r4_reg[11]_i_1_n_6 ,\ql_r4_reg[11]_i_1_n_7 }),
        .S({\ql_r4[11]_i_2_n_0 ,\ql_r4[11]_i_3_n_0 ,\ql_r4[11]_i_4_n_0 ,\ql_r4[11]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[15]_i_1_n_7 ),
        .Q(ql_r4[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[15]_i_1_n_6 ),
        .Q(ql_r4[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[15]_i_1_n_5 ),
        .Q(ql_r4[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[15]_i_1_n_4 ),
        .Q(ql_r4[15]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[15]_i_1 
       (.CI(\ql_r4_reg[11]_i_1_n_0 ),
        .CO({\ql_r4_reg[15]_i_1_n_0 ,\ql_r4_reg[15]_i_1_n_1 ,\ql_r4_reg[15]_i_1_n_2 ,\ql_r4_reg[15]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\ql_r3_reg[15]__0_n_0 ,\ql_r3_reg[14]__0_n_0 ,\ql_r3_reg[13]__0_n_0 ,\ql_r3_reg[12]__0_n_0 }),
        .O({\ql_r4_reg[15]_i_1_n_4 ,\ql_r4_reg[15]_i_1_n_5 ,\ql_r4_reg[15]_i_1_n_6 ,\ql_r4_reg[15]_i_1_n_7 }),
        .S({\ql_r4[15]_i_2_n_0 ,\ql_r4[15]_i_3_n_0 ,\ql_r4[15]_i_4_n_0 ,\ql_r4[15]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[19]_i_1_n_7 ),
        .Q(ql_r4[16]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[19]_i_1_n_6 ),
        .Q(ql_r4[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[19]_i_1_n_5 ),
        .Q(ql_r4[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[19]_i_1_n_4 ),
        .Q(ql_r4[19]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[19]_i_1 
       (.CI(\ql_r4_reg[15]_i_1_n_0 ),
        .CO({\ql_r4_reg[19]_i_1_n_0 ,\ql_r4_reg[19]_i_1_n_1 ,\ql_r4_reg[19]_i_1_n_2 ,\ql_r4_reg[19]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI(ql_r3_reg__0[19:16]),
        .O({\ql_r4_reg[19]_i_1_n_4 ,\ql_r4_reg[19]_i_1_n_5 ,\ql_r4_reg[19]_i_1_n_6 ,\ql_r4_reg[19]_i_1_n_7 }),
        .S({\ql_r4[19]_i_3_n_0 ,\ql_r4[19]_i_4_n_0 ,\ql_r4[19]_i_5_n_0 ,\ql_r4[19]_i_6_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[19]_i_2 
       (.CI(\<const0> ),
        .CO({\ql_r4_reg[19]_i_2_n_0 ,\ql_r4_reg[19]_i_2_n_1 ,\ql_r4_reg[19]_i_2_n_2 ,\ql_r4_reg[19]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({ql_r3_reg_n_103,ql_r3_reg_n_104,ql_r3_reg_n_105,\<const0> }),
        .O(ql_r3_reg__0[19:16]),
        .S({\ql_r4[19]_i_7_n_0 ,\ql_r4[19]_i_8_n_0 ,\ql_r4[19]_i_9_n_0 ,\ql_r3_reg[16]__0_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[3]_i_1_n_6 ),
        .Q(ql_r4[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[23]_i_1_n_7 ),
        .Q(ql_r4[20]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[23]_i_1_n_6 ),
        .Q(ql_r4[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[23]_i_1_n_5 ),
        .Q(ql_r4[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[23]_i_1_n_4 ),
        .Q(ql_r4[23]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[23]_i_1 
       (.CI(\ql_r4_reg[19]_i_1_n_0 ),
        .CO({\ql_r4_reg[23]_i_1_n_0 ,\ql_r4_reg[23]_i_1_n_1 ,\ql_r4_reg[23]_i_1_n_2 ,\ql_r4_reg[23]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI(ql_r3_reg__0[23:20]),
        .O({\ql_r4_reg[23]_i_1_n_4 ,\ql_r4_reg[23]_i_1_n_5 ,\ql_r4_reg[23]_i_1_n_6 ,\ql_r4_reg[23]_i_1_n_7 }),
        .S({\ql_r4[23]_i_3_n_0 ,\ql_r4[23]_i_4_n_0 ,\ql_r4[23]_i_5_n_0 ,\ql_r4[23]_i_6_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[23]_i_2 
       (.CI(\ql_r4_reg[19]_i_2_n_0 ),
        .CO({\ql_r4_reg[23]_i_2_n_0 ,\ql_r4_reg[23]_i_2_n_1 ,\ql_r4_reg[23]_i_2_n_2 ,\ql_r4_reg[23]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({ql_r3_reg_n_99,ql_r3_reg_n_100,ql_r3_reg_n_101,ql_r3_reg_n_102}),
        .O(ql_r3_reg__0[23:20]),
        .S({\ql_r4[23]_i_7_n_0 ,\ql_r4[23]_i_8_n_0 ,\ql_r4[23]_i_9_n_0 ,\ql_r4[23]_i_10_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[27]_i_1_n_7 ),
        .Q(ql_r4[24]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[27]_i_1_n_6 ),
        .Q(ql_r4[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[27]_i_1_n_5 ),
        .Q(ql_r4[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[27]_i_1_n_4 ),
        .Q(ql_r4[27]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[27]_i_1 
       (.CI(\ql_r4_reg[23]_i_1_n_0 ),
        .CO({\ql_r4_reg[27]_i_1_n_0 ,\ql_r4_reg[27]_i_1_n_1 ,\ql_r4_reg[27]_i_1_n_2 ,\ql_r4_reg[27]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI(ql_r3_reg__0[27:24]),
        .O({\ql_r4_reg[27]_i_1_n_4 ,\ql_r4_reg[27]_i_1_n_5 ,\ql_r4_reg[27]_i_1_n_6 ,\ql_r4_reg[27]_i_1_n_7 }),
        .S({\ql_r4[27]_i_3_n_0 ,\ql_r4[27]_i_4_n_0 ,\ql_r4[27]_i_5_n_0 ,\ql_r4[27]_i_6_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[27]_i_2 
       (.CI(\ql_r4_reg[23]_i_2_n_0 ),
        .CO({\ql_r4_reg[27]_i_2_n_0 ,\ql_r4_reg[27]_i_2_n_1 ,\ql_r4_reg[27]_i_2_n_2 ,\ql_r4_reg[27]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({ql_r3_reg_n_95,ql_r3_reg_n_96,ql_r3_reg_n_97,ql_r3_reg_n_98}),
        .O(ql_r3_reg__0[27:24]),
        .S({\ql_r4[27]_i_7_n_0 ,\ql_r4[27]_i_8_n_0 ,\ql_r4[27]_i_9_n_0 ,\ql_r4[27]_i_10_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[31]_i_1_n_7 ),
        .Q(ql_r4[28]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[31]_i_1_n_6 ),
        .Q(ql_r4[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[3]_i_1_n_5 ),
        .Q(ql_r4[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[31]_i_1_n_5 ),
        .Q(ql_r4[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[31]_i_1_n_4 ),
        .Q(ql_r4[31]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[31]_i_1 
       (.CI(\ql_r4_reg[27]_i_1_n_0 ),
        .CO({\ql_r4_reg[31]_i_1_n_1 ,\ql_r4_reg[31]_i_1_n_2 ,\ql_r4_reg[31]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,ql_r3_reg__0[30:28]}),
        .O({\ql_r4_reg[31]_i_1_n_4 ,\ql_r4_reg[31]_i_1_n_5 ,\ql_r4_reg[31]_i_1_n_6 ,\ql_r4_reg[31]_i_1_n_7 }),
        .S({\ql_r4[31]_i_3_n_0 ,\ql_r4[31]_i_4_n_0 ,\ql_r4[31]_i_5_n_0 ,\ql_r4[31]_i_6_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[31]_i_2 
       (.CI(\ql_r4_reg[27]_i_2_n_0 ),
        .CO({\ql_r4_reg[31]_i_2_n_1 ,\ql_r4_reg[31]_i_2_n_2 ,\ql_r4_reg[31]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,ql_r3_reg_n_92,ql_r3_reg_n_93,ql_r3_reg_n_94}),
        .O(ql_r3_reg__0[31:28]),
        .S({\ql_r4[31]_i_7_n_0 ,\ql_r4[31]_i_8_n_0 ,\ql_r4[31]_i_9_n_0 ,\ql_r4[31]_i_10_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[3]_i_1_n_4 ),
        .Q(ql_r4[3]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[3]_i_1 
       (.CI(\<const0> ),
        .CO({\ql_r4_reg[3]_i_1_n_0 ,\ql_r4_reg[3]_i_1_n_1 ,\ql_r4_reg[3]_i_1_n_2 ,\ql_r4_reg[3]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\ql_r3_reg[3]__0_n_0 ,\ql_r3_reg[2]__0_n_0 ,\ql_r3_reg[1]__0_n_0 ,\ql_r3_reg[0]__0_n_0 }),
        .O({\ql_r4_reg[3]_i_1_n_4 ,\ql_r4_reg[3]_i_1_n_5 ,\ql_r4_reg[3]_i_1_n_6 ,\ql_r4_reg[3]_i_1_n_7 }),
        .S({\ql_r4[3]_i_2_n_0 ,\ql_r4[3]_i_3_n_0 ,\ql_r4[3]_i_4_n_0 ,\ql_r4[3]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[7]_i_1_n_7 ),
        .Q(ql_r4[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[7]_i_1_n_6 ),
        .Q(ql_r4[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[7]_i_1_n_5 ),
        .Q(ql_r4[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[7]_i_1_n_4 ),
        .Q(ql_r4[7]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \ql_r4_reg[7]_i_1 
       (.CI(\ql_r4_reg[3]_i_1_n_0 ),
        .CO({\ql_r4_reg[7]_i_1_n_0 ,\ql_r4_reg[7]_i_1_n_1 ,\ql_r4_reg[7]_i_1_n_2 ,\ql_r4_reg[7]_i_1_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\ql_r3_reg[7]__0_n_0 ,\ql_r3_reg[6]__0_n_0 ,\ql_r3_reg[5]__0_n_0 ,\ql_r3_reg[4]__0_n_0 }),
        .O({\ql_r4_reg[7]_i_1_n_4 ,\ql_r4_reg[7]_i_1_n_5 ,\ql_r4_reg[7]_i_1_n_6 ,\ql_r4_reg[7]_i_1_n_7 }),
        .S({\ql_r4[7]_i_2_n_0 ,\ql_r4[7]_i_3_n_0 ,\ql_r4[7]_i_4_n_0 ,\ql_r4[7]_i_5_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[11]_i_1_n_7 ),
        .Q(ql_r4[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \ql_r4_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(\ql_r4_reg[11]_i_1_n_6 ),
        .Q(ql_r4[9]),
        .R(rst));
  LUT3 #(
    .INIT(8'hAC)) 
    \qmin_r1[0]_i_1 
       (.I0(qin_r0[0]),
        .I1(qb_r0[0]),
        .I2(qmin_r12),
        .O(\qmin_r1[0]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[10]_i_1 
       (.I0(qabs0[10]),
        .I1(qin_r0[31]),
        .I2(qin_r0[10]),
        .I3(qmin_r13[10]),
        .I4(qmin_r12),
        .O(\qmin_r1[10]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[11]_i_1 
       (.I0(qabs0[11]),
        .I1(qin_r0[31]),
        .I2(qin_r0[11]),
        .I3(qmin_r13[11]),
        .I4(qmin_r12),
        .O(\qmin_r1[11]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[12]_i_1 
       (.I0(qabs0[12]),
        .I1(qin_r0[31]),
        .I2(qin_r0[12]),
        .I3(qmin_r13[12]),
        .I4(qmin_r12),
        .O(\qmin_r1[12]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_10 
       (.I0(qb_r0[10]),
        .O(\qmin_r1[12]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_11 
       (.I0(qb_r0[9]),
        .O(\qmin_r1[12]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_4 
       (.I0(qin_r0[12]),
        .O(\qmin_r1[12]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_5 
       (.I0(qin_r0[11]),
        .O(\qmin_r1[12]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_6 
       (.I0(qin_r0[10]),
        .O(\qmin_r1[12]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_7 
       (.I0(qin_r0[9]),
        .O(\qmin_r1[12]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_8 
       (.I0(qb_r0[12]),
        .O(\qmin_r1[12]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[12]_i_9 
       (.I0(qb_r0[11]),
        .O(\qmin_r1[12]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[13]_i_1 
       (.I0(qabs0[13]),
        .I1(qin_r0[31]),
        .I2(qin_r0[13]),
        .I3(qmin_r13[13]),
        .I4(qmin_r12),
        .O(\qmin_r1[13]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[14]_i_1 
       (.I0(qabs0[14]),
        .I1(qin_r0[31]),
        .I2(qin_r0[14]),
        .I3(qmin_r13[14]),
        .I4(qmin_r12),
        .O(\qmin_r1[14]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[15]_i_1 
       (.I0(qabs0[15]),
        .I1(qin_r0[31]),
        .I2(qin_r0[15]),
        .I3(qmin_r13[15]),
        .I4(qmin_r12),
        .O(\qmin_r1[15]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[16]_i_1 
       (.I0(qabs0[16]),
        .I1(qin_r0[31]),
        .I2(qin_r0[16]),
        .I3(qmin_r13[16]),
        .I4(qmin_r12),
        .O(\qmin_r1[16]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_10 
       (.I0(qb_r0[14]),
        .O(\qmin_r1[16]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_11 
       (.I0(qb_r0[13]),
        .O(\qmin_r1[16]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_4 
       (.I0(qin_r0[16]),
        .O(\qmin_r1[16]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_5 
       (.I0(qin_r0[15]),
        .O(\qmin_r1[16]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_6 
       (.I0(qin_r0[14]),
        .O(\qmin_r1[16]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_7 
       (.I0(qin_r0[13]),
        .O(\qmin_r1[16]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_8 
       (.I0(qb_r0[16]),
        .O(\qmin_r1[16]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[16]_i_9 
       (.I0(qb_r0[15]),
        .O(\qmin_r1[16]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[17]_i_1 
       (.I0(qabs0[17]),
        .I1(qin_r0[31]),
        .I2(qin_r0[17]),
        .I3(qmin_r13[17]),
        .I4(qmin_r12),
        .O(\qmin_r1[17]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[18]_i_1 
       (.I0(qabs0[18]),
        .I1(qin_r0[31]),
        .I2(qin_r0[18]),
        .I3(qmin_r13[18]),
        .I4(qmin_r12),
        .O(\qmin_r1[18]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[19]_i_1 
       (.I0(qabs0[19]),
        .I1(qin_r0[31]),
        .I2(qin_r0[19]),
        .I3(qmin_r13[19]),
        .I4(qmin_r12),
        .O(\qmin_r1[19]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[1]_i_1 
       (.I0(qabs0[1]),
        .I1(qin_r0[31]),
        .I2(qin_r0[1]),
        .I3(qmin_r13[1]),
        .I4(qmin_r12),
        .O(\qmin_r1[1]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[20]_i_1 
       (.I0(qabs0[20]),
        .I1(qin_r0[31]),
        .I2(qin_r0[20]),
        .I3(qmin_r13[20]),
        .I4(qmin_r12),
        .O(\qmin_r1[20]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_10 
       (.I0(qb_r0[18]),
        .O(\qmin_r1[20]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_11 
       (.I0(qb_r0[17]),
        .O(\qmin_r1[20]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_4 
       (.I0(qin_r0[20]),
        .O(\qmin_r1[20]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_5 
       (.I0(qin_r0[19]),
        .O(\qmin_r1[20]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_6 
       (.I0(qin_r0[18]),
        .O(\qmin_r1[20]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_7 
       (.I0(qin_r0[17]),
        .O(\qmin_r1[20]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_8 
       (.I0(qb_r0[20]),
        .O(\qmin_r1[20]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[20]_i_9 
       (.I0(qb_r0[19]),
        .O(\qmin_r1[20]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[21]_i_1 
       (.I0(qabs0[21]),
        .I1(qin_r0[31]),
        .I2(qin_r0[21]),
        .I3(qmin_r13[21]),
        .I4(qmin_r12),
        .O(\qmin_r1[21]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[22]_i_1 
       (.I0(qabs0[22]),
        .I1(qin_r0[31]),
        .I2(qin_r0[22]),
        .I3(qmin_r13[22]),
        .I4(qmin_r12),
        .O(\qmin_r1[22]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[23]_i_1 
       (.I0(qabs0[23]),
        .I1(qin_r0[31]),
        .I2(qin_r0[23]),
        .I3(qmin_r13[23]),
        .I4(qmin_r12),
        .O(\qmin_r1[23]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[24]_i_1 
       (.I0(qabs0[24]),
        .I1(qin_r0[31]),
        .I2(qin_r0[24]),
        .I3(qmin_r13[24]),
        .I4(qmin_r12),
        .O(\qmin_r1[24]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_10 
       (.I0(qb_r0[22]),
        .O(\qmin_r1[24]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_11 
       (.I0(qb_r0[21]),
        .O(\qmin_r1[24]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_4 
       (.I0(qin_r0[24]),
        .O(\qmin_r1[24]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_5 
       (.I0(qin_r0[23]),
        .O(\qmin_r1[24]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_6 
       (.I0(qin_r0[22]),
        .O(\qmin_r1[24]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_7 
       (.I0(qin_r0[21]),
        .O(\qmin_r1[24]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_8 
       (.I0(qb_r0[24]),
        .O(\qmin_r1[24]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[24]_i_9 
       (.I0(qb_r0[23]),
        .O(\qmin_r1[24]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[25]_i_1 
       (.I0(qabs0[25]),
        .I1(qin_r0[31]),
        .I2(qin_r0[25]),
        .I3(qmin_r13[25]),
        .I4(qmin_r12),
        .O(\qmin_r1[25]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[26]_i_1 
       (.I0(qabs0[26]),
        .I1(qin_r0[31]),
        .I2(qin_r0[26]),
        .I3(qmin_r13[26]),
        .I4(qmin_r12),
        .O(\qmin_r1[26]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[27]_i_1 
       (.I0(qabs0[27]),
        .I1(qin_r0[31]),
        .I2(qin_r0[27]),
        .I3(qmin_r13[27]),
        .I4(qmin_r12),
        .O(\qmin_r1[27]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[28]_i_1 
       (.I0(qabs0[28]),
        .I1(qin_r0[31]),
        .I2(qin_r0[28]),
        .I3(qmin_r13[28]),
        .I4(qmin_r12),
        .O(\qmin_r1[28]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_10 
       (.I0(qb_r0[26]),
        .O(\qmin_r1[28]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_11 
       (.I0(qb_r0[25]),
        .O(\qmin_r1[28]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_4 
       (.I0(qin_r0[28]),
        .O(\qmin_r1[28]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_5 
       (.I0(qin_r0[27]),
        .O(\qmin_r1[28]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_6 
       (.I0(qin_r0[26]),
        .O(\qmin_r1[28]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_7 
       (.I0(qin_r0[25]),
        .O(\qmin_r1[28]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_8 
       (.I0(qb_r0[28]),
        .O(\qmin_r1[28]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[28]_i_9 
       (.I0(qb_r0[27]),
        .O(\qmin_r1[28]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[29]_i_1 
       (.I0(qabs0[29]),
        .I1(qin_r0[31]),
        .I2(qin_r0[29]),
        .I3(qmin_r13[29]),
        .I4(qmin_r12),
        .O(\qmin_r1[29]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[2]_i_1 
       (.I0(qabs0[2]),
        .I1(qin_r0[31]),
        .I2(qin_r0[2]),
        .I3(qmin_r13[2]),
        .I4(qmin_r12),
        .O(\qmin_r1[2]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[30]_i_1 
       (.I0(qabs0[30]),
        .I1(qin_r0[31]),
        .I2(qin_r0[30]),
        .I3(qmin_r13[30]),
        .I4(qmin_r12),
        .O(\qmin_r1[30]_i_1_n_0 ));
  LUT4 #(
    .INIT(16'h88F0)) 
    \qmin_r1[31]_i_1 
       (.I0(qin_r0[31]),
        .I1(qabs0[31]),
        .I2(qmin_r13[31]),
        .I3(qmin_r12),
        .O(\qmin_r1[31]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_10 
       (.I0(qb_r0[29]),
        .O(\qmin_r1[31]_i_10_n_0 ));
  LUT6 #(
    .INIT(64'h0AFF0022000A0022)) 
    \qmin_r1[31]_i_12 
       (.I0(qmin_r13[30]),
        .I1(qin_r0[30]),
        .I2(qabs0[30]),
        .I3(qmin_r13[31]),
        .I4(qin_r0[31]),
        .I5(qabs0[31]),
        .O(\qmin_r1[31]_i_12_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_13 
       (.I0(qmin_r13[28]),
        .I1(qin_r0[28]),
        .I2(qin_r0[31]),
        .I3(qabs0[28]),
        .I4(qabs[29]),
        .I5(qmin_r13[29]),
        .O(\qmin_r1[31]_i_13_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_14 
       (.I0(qmin_r13[26]),
        .I1(qin_r0[26]),
        .I2(qin_r0[31]),
        .I3(qabs0[26]),
        .I4(qabs[27]),
        .I5(qmin_r13[27]),
        .O(\qmin_r1[31]_i_14_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_15 
       (.I0(qmin_r13[24]),
        .I1(qin_r0[24]),
        .I2(qin_r0[31]),
        .I3(qabs0[24]),
        .I4(qabs[25]),
        .I5(qmin_r13[25]),
        .O(\qmin_r1[31]_i_15_n_0 ));
  LUT6 #(
    .INIT(64'h9900000000A599A5)) 
    \qmin_r1[31]_i_16 
       (.I0(qmin_r13[30]),
        .I1(qabs0[30]),
        .I2(qin_r0[30]),
        .I3(qin_r0[31]),
        .I4(qabs0[31]),
        .I5(qmin_r13[31]),
        .O(\qmin_r1[31]_i_16_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_17 
       (.I0(qmin_r13[28]),
        .I1(qabs0[28]),
        .I2(qin_r0[31]),
        .I3(qin_r0[28]),
        .I4(qmin_r13[29]),
        .I5(qabs[29]),
        .O(\qmin_r1[31]_i_17_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_18 
       (.I0(qmin_r13[26]),
        .I1(qabs0[26]),
        .I2(qin_r0[31]),
        .I3(qin_r0[26]),
        .I4(qmin_r13[27]),
        .I5(qabs[27]),
        .O(\qmin_r1[31]_i_18_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_19 
       (.I0(qmin_r13[24]),
        .I1(qabs0[24]),
        .I2(qin_r0[31]),
        .I3(qin_r0[24]),
        .I4(qmin_r13[25]),
        .I5(qabs[25]),
        .O(\qmin_r1[31]_i_19_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_21 
       (.I0(qmin_r13[22]),
        .I1(qin_r0[22]),
        .I2(qin_r0[31]),
        .I3(qabs0[22]),
        .I4(qabs[23]),
        .I5(qmin_r13[23]),
        .O(\qmin_r1[31]_i_21_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_22 
       (.I0(qmin_r13[20]),
        .I1(qin_r0[20]),
        .I2(qin_r0[31]),
        .I3(qabs0[20]),
        .I4(qabs[21]),
        .I5(qmin_r13[21]),
        .O(\qmin_r1[31]_i_22_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_23 
       (.I0(qmin_r13[18]),
        .I1(qin_r0[18]),
        .I2(qin_r0[31]),
        .I3(qabs0[18]),
        .I4(qabs[19]),
        .I5(qmin_r13[19]),
        .O(\qmin_r1[31]_i_23_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_24 
       (.I0(qmin_r13[16]),
        .I1(qin_r0[16]),
        .I2(qin_r0[31]),
        .I3(qabs0[16]),
        .I4(qabs[17]),
        .I5(qmin_r13[17]),
        .O(\qmin_r1[31]_i_24_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_25 
       (.I0(qmin_r13[22]),
        .I1(qabs0[22]),
        .I2(qin_r0[31]),
        .I3(qin_r0[22]),
        .I4(qmin_r13[23]),
        .I5(qabs[23]),
        .O(\qmin_r1[31]_i_25_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_26 
       (.I0(qmin_r13[20]),
        .I1(qabs0[20]),
        .I2(qin_r0[31]),
        .I3(qin_r0[20]),
        .I4(qmin_r13[21]),
        .I5(qabs[21]),
        .O(\qmin_r1[31]_i_26_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_27 
       (.I0(qmin_r13[18]),
        .I1(qabs0[18]),
        .I2(qin_r0[31]),
        .I3(qin_r0[18]),
        .I4(qmin_r13[19]),
        .I5(qabs[19]),
        .O(\qmin_r1[31]_i_27_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_28 
       (.I0(qmin_r13[16]),
        .I1(qabs0[16]),
        .I2(qin_r0[31]),
        .I3(qin_r0[16]),
        .I4(qmin_r13[17]),
        .I5(qabs[17]),
        .O(\qmin_r1[31]_i_28_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_29 
       (.I0(qabs0[29]),
        .I1(qin_r0[31]),
        .I2(qin_r0[29]),
        .O(qabs[29]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_30 
       (.I0(qabs0[27]),
        .I1(qin_r0[31]),
        .I2(qin_r0[27]),
        .O(qabs[27]));
  (* SOFT_HLUTNM = "soft_lutpair0" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_31 
       (.I0(qabs0[25]),
        .I1(qin_r0[31]),
        .I2(qin_r0[25]),
        .O(qabs[25]));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_33 
       (.I0(qmin_r13[14]),
        .I1(qin_r0[14]),
        .I2(qin_r0[31]),
        .I3(qabs0[14]),
        .I4(qabs[15]),
        .I5(qmin_r13[15]),
        .O(\qmin_r1[31]_i_33_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_34 
       (.I0(qmin_r13[12]),
        .I1(qin_r0[12]),
        .I2(qin_r0[31]),
        .I3(qabs0[12]),
        .I4(qabs[13]),
        .I5(qmin_r13[13]),
        .O(\qmin_r1[31]_i_34_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_35 
       (.I0(qmin_r13[10]),
        .I1(qin_r0[10]),
        .I2(qin_r0[31]),
        .I3(qabs0[10]),
        .I4(qabs[11]),
        .I5(qmin_r13[11]),
        .O(\qmin_r1[31]_i_35_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_36 
       (.I0(qmin_r13[8]),
        .I1(qin_r0[8]),
        .I2(qin_r0[31]),
        .I3(qabs0[8]),
        .I4(qabs[9]),
        .I5(qmin_r13[9]),
        .O(\qmin_r1[31]_i_36_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_37 
       (.I0(qmin_r13[14]),
        .I1(qabs0[14]),
        .I2(qin_r0[31]),
        .I3(qin_r0[14]),
        .I4(qmin_r13[15]),
        .I5(qabs[15]),
        .O(\qmin_r1[31]_i_37_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_38 
       (.I0(qmin_r13[12]),
        .I1(qabs0[12]),
        .I2(qin_r0[31]),
        .I3(qin_r0[12]),
        .I4(qmin_r13[13]),
        .I5(qabs[13]),
        .O(\qmin_r1[31]_i_38_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_39 
       (.I0(qmin_r13[10]),
        .I1(qabs0[10]),
        .I2(qin_r0[31]),
        .I3(qin_r0[10]),
        .I4(qmin_r13[11]),
        .I5(qabs[11]),
        .O(\qmin_r1[31]_i_39_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_40 
       (.I0(qmin_r13[8]),
        .I1(qabs0[8]),
        .I2(qin_r0[31]),
        .I3(qin_r0[8]),
        .I4(qmin_r13[9]),
        .I5(qabs[9]),
        .O(\qmin_r1[31]_i_40_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_41 
       (.I0(qabs0[23]),
        .I1(qin_r0[31]),
        .I2(qin_r0[23]),
        .O(qabs[23]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_42 
       (.I0(qabs0[21]),
        .I1(qin_r0[31]),
        .I2(qin_r0[21]),
        .O(qabs[21]));
  (* SOFT_HLUTNM = "soft_lutpair1" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_43 
       (.I0(qabs0[19]),
        .I1(qin_r0[31]),
        .I2(qin_r0[19]),
        .O(qabs[19]));
  (* SOFT_HLUTNM = "soft_lutpair2" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_44 
       (.I0(qabs0[17]),
        .I1(qin_r0[31]),
        .I2(qin_r0[17]),
        .O(qabs[17]));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_45 
       (.I0(qmin_r13[6]),
        .I1(qin_r0[6]),
        .I2(qin_r0[31]),
        .I3(qabs0[6]),
        .I4(qabs[7]),
        .I5(qmin_r13[7]),
        .O(\qmin_r1[31]_i_45_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_46 
       (.I0(qmin_r13[4]),
        .I1(qin_r0[4]),
        .I2(qin_r0[31]),
        .I3(qabs0[4]),
        .I4(qabs[5]),
        .I5(qmin_r13[5]),
        .O(\qmin_r1[31]_i_46_n_0 ));
  LUT6 #(
    .INIT(64'h02A2FFFF000002A2)) 
    \qmin_r1[31]_i_47 
       (.I0(qmin_r13[2]),
        .I1(qin_r0[2]),
        .I2(qin_r0[31]),
        .I3(qabs0[2]),
        .I4(qabs[3]),
        .I5(qmin_r13[3]),
        .O(\qmin_r1[31]_i_47_n_0 ));
  LUT6 #(
    .INIT(64'h2F222FFF02000222)) 
    \qmin_r1[31]_i_48 
       (.I0(qb_r0[0]),
        .I1(qin_r0[0]),
        .I2(qabs0[1]),
        .I3(qin_r0[31]),
        .I4(qin_r0[1]),
        .I5(qmin_r13[1]),
        .O(\qmin_r1[31]_i_48_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_49 
       (.I0(qmin_r13[6]),
        .I1(qabs0[6]),
        .I2(qin_r0[31]),
        .I3(qin_r0[6]),
        .I4(qmin_r13[7]),
        .I5(qabs[7]),
        .O(\qmin_r1[31]_i_49_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_5 
       (.I0(qin_r0[31]),
        .O(\qmin_r1[31]_i_5_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_50 
       (.I0(qmin_r13[4]),
        .I1(qabs0[4]),
        .I2(qin_r0[31]),
        .I3(qin_r0[4]),
        .I4(qmin_r13[5]),
        .I5(qabs[5]),
        .O(\qmin_r1[31]_i_50_n_0 ));
  LUT6 #(
    .INIT(64'h9A95000000009A95)) 
    \qmin_r1[31]_i_51 
       (.I0(qmin_r13[2]),
        .I1(qabs0[2]),
        .I2(qin_r0[31]),
        .I3(qin_r0[2]),
        .I4(qmin_r13[3]),
        .I5(qabs[3]),
        .O(\qmin_r1[31]_i_51_n_0 ));
  LUT6 #(
    .INIT(64'h9009909090090909)) 
    \qmin_r1[31]_i_52 
       (.I0(qb_r0[0]),
        .I1(qin_r0[0]),
        .I2(qmin_r13[1]),
        .I3(qabs0[1]),
        .I4(qin_r0[31]),
        .I5(qin_r0[1]),
        .O(\qmin_r1[31]_i_52_n_0 ));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_53 
       (.I0(qabs0[15]),
        .I1(qin_r0[31]),
        .I2(qin_r0[15]),
        .O(qabs[15]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_54 
       (.I0(qabs0[13]),
        .I1(qin_r0[31]),
        .I2(qin_r0[13]),
        .O(qabs[13]));
  (* SOFT_HLUTNM = "soft_lutpair3" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_55 
       (.I0(qabs0[11]),
        .I1(qin_r0[31]),
        .I2(qin_r0[11]),
        .O(qabs[11]));
  (* SOFT_HLUTNM = "soft_lutpair4" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_56 
       (.I0(qabs0[9]),
        .I1(qin_r0[31]),
        .I2(qin_r0[9]),
        .O(qabs[9]));
  (* SOFT_HLUTNM = "soft_lutpair5" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_57 
       (.I0(qabs0[7]),
        .I1(qin_r0[31]),
        .I2(qin_r0[7]),
        .O(qabs[7]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_58 
       (.I0(qabs0[5]),
        .I1(qin_r0[31]),
        .I2(qin_r0[5]),
        .O(qabs[5]));
  (* SOFT_HLUTNM = "soft_lutpair6" *) 
  LUT3 #(
    .INIT(8'hB8)) 
    \qmin_r1[31]_i_59 
       (.I0(qabs0[3]),
        .I1(qin_r0[31]),
        .I2(qin_r0[3]),
        .O(qabs[3]));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_6 
       (.I0(qin_r0[30]),
        .O(\qmin_r1[31]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_7 
       (.I0(qin_r0[29]),
        .O(\qmin_r1[31]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_8 
       (.I0(qb_r0[31]),
        .O(\qmin_r1[31]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[31]_i_9 
       (.I0(qb_r0[30]),
        .O(\qmin_r1[31]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[3]_i_1 
       (.I0(qabs0[3]),
        .I1(qin_r0[31]),
        .I2(qin_r0[3]),
        .I3(qmin_r13[3]),
        .I4(qmin_r12),
        .O(\qmin_r1[3]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[4]_i_1 
       (.I0(qabs0[4]),
        .I1(qin_r0[31]),
        .I2(qin_r0[4]),
        .I3(qmin_r13[4]),
        .I4(qmin_r12),
        .O(\qmin_r1[4]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_10 
       (.I0(qb_r0[4]),
        .O(\qmin_r1[4]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_11 
       (.I0(qb_r0[3]),
        .O(\qmin_r1[4]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_12 
       (.I0(qb_r0[2]),
        .O(\qmin_r1[4]_i_12_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_13 
       (.I0(qb_r0[1]),
        .O(\qmin_r1[4]_i_13_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_4 
       (.I0(qin_r0[0]),
        .O(\qmin_r1[4]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_5 
       (.I0(qin_r0[4]),
        .O(\qmin_r1[4]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_6 
       (.I0(qin_r0[3]),
        .O(\qmin_r1[4]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_7 
       (.I0(qin_r0[2]),
        .O(\qmin_r1[4]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_8 
       (.I0(qin_r0[1]),
        .O(\qmin_r1[4]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[4]_i_9 
       (.I0(qb_r0[0]),
        .O(\qmin_r1[4]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[5]_i_1 
       (.I0(qabs0[5]),
        .I1(qin_r0[31]),
        .I2(qin_r0[5]),
        .I3(qmin_r13[5]),
        .I4(qmin_r12),
        .O(\qmin_r1[5]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[6]_i_1 
       (.I0(qabs0[6]),
        .I1(qin_r0[31]),
        .I2(qin_r0[6]),
        .I3(qmin_r13[6]),
        .I4(qmin_r12),
        .O(\qmin_r1[6]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[7]_i_1 
       (.I0(qabs0[7]),
        .I1(qin_r0[31]),
        .I2(qin_r0[7]),
        .I3(qmin_r13[7]),
        .I4(qmin_r12),
        .O(\qmin_r1[7]_i_1_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[8]_i_1 
       (.I0(qabs0[8]),
        .I1(qin_r0[31]),
        .I2(qin_r0[8]),
        .I3(qmin_r13[8]),
        .I4(qmin_r12),
        .O(\qmin_r1[8]_i_1_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_10 
       (.I0(qb_r0[6]),
        .O(\qmin_r1[8]_i_10_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_11 
       (.I0(qb_r0[5]),
        .O(\qmin_r1[8]_i_11_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_4 
       (.I0(qin_r0[8]),
        .O(\qmin_r1[8]_i_4_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_5 
       (.I0(qin_r0[7]),
        .O(\qmin_r1[8]_i_5_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_6 
       (.I0(qin_r0[6]),
        .O(\qmin_r1[8]_i_6_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_7 
       (.I0(qin_r0[5]),
        .O(\qmin_r1[8]_i_7_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_8 
       (.I0(qb_r0[8]),
        .O(\qmin_r1[8]_i_8_n_0 ));
  LUT1 #(
    .INIT(2'h1)) 
    \qmin_r1[8]_i_9 
       (.I0(qb_r0[7]),
        .O(\qmin_r1[8]_i_9_n_0 ));
  LUT5 #(
    .INIT(32'hB8B8FF00)) 
    \qmin_r1[9]_i_1 
       (.I0(qabs0[9]),
        .I1(qin_r0[31]),
        .I2(qin_r0[9]),
        .I3(qmin_r13[9]),
        .I4(qmin_r12),
        .O(\qmin_r1[9]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[0] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[0]_i_1_n_0 ),
        .Q(qmin_r1[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[10] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[10]_i_1_n_0 ),
        .Q(qmin_r1[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[11] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[11]_i_1_n_0 ),
        .Q(qmin_r1[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[12] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[12]_i_1_n_0 ),
        .Q(qmin_r1[12]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[12]_i_2 
       (.CI(\qmin_r1_reg[8]_i_2_n_0 ),
        .CO({\qmin_r1_reg[12]_i_2_n_0 ,\qmin_r1_reg[12]_i_2_n_1 ,\qmin_r1_reg[12]_i_2_n_2 ,\qmin_r1_reg[12]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[12:9]),
        .S({\qmin_r1[12]_i_4_n_0 ,\qmin_r1[12]_i_5_n_0 ,\qmin_r1[12]_i_6_n_0 ,\qmin_r1[12]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[12]_i_3 
       (.CI(\qmin_r1_reg[8]_i_3_n_0 ),
        .CO({\qmin_r1_reg[12]_i_3_n_0 ,\qmin_r1_reg[12]_i_3_n_1 ,\qmin_r1_reg[12]_i_3_n_2 ,\qmin_r1_reg[12]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[12:9]),
        .S({\qmin_r1[12]_i_8_n_0 ,\qmin_r1[12]_i_9_n_0 ,\qmin_r1[12]_i_10_n_0 ,\qmin_r1[12]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[13] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[13]_i_1_n_0 ),
        .Q(qmin_r1[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[14] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[14]_i_1_n_0 ),
        .Q(qmin_r1[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[15] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[15]_i_1_n_0 ),
        .Q(qmin_r1[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[16] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[16]_i_1_n_0 ),
        .Q(qmin_r1[16]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[16]_i_2 
       (.CI(\qmin_r1_reg[12]_i_2_n_0 ),
        .CO({\qmin_r1_reg[16]_i_2_n_0 ,\qmin_r1_reg[16]_i_2_n_1 ,\qmin_r1_reg[16]_i_2_n_2 ,\qmin_r1_reg[16]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[16:13]),
        .S({\qmin_r1[16]_i_4_n_0 ,\qmin_r1[16]_i_5_n_0 ,\qmin_r1[16]_i_6_n_0 ,\qmin_r1[16]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[16]_i_3 
       (.CI(\qmin_r1_reg[12]_i_3_n_0 ),
        .CO({\qmin_r1_reg[16]_i_3_n_0 ,\qmin_r1_reg[16]_i_3_n_1 ,\qmin_r1_reg[16]_i_3_n_2 ,\qmin_r1_reg[16]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[16:13]),
        .S({\qmin_r1[16]_i_8_n_0 ,\qmin_r1[16]_i_9_n_0 ,\qmin_r1[16]_i_10_n_0 ,\qmin_r1[16]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[17] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[17]_i_1_n_0 ),
        .Q(qmin_r1[17]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[18] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[18]_i_1_n_0 ),
        .Q(qmin_r1[18]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[19] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[19]_i_1_n_0 ),
        .Q(qmin_r1[19]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[1] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[1]_i_1_n_0 ),
        .Q(qmin_r1[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[20] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[20]_i_1_n_0 ),
        .Q(qmin_r1[20]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[20]_i_2 
       (.CI(\qmin_r1_reg[16]_i_2_n_0 ),
        .CO({\qmin_r1_reg[20]_i_2_n_0 ,\qmin_r1_reg[20]_i_2_n_1 ,\qmin_r1_reg[20]_i_2_n_2 ,\qmin_r1_reg[20]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[20:17]),
        .S({\qmin_r1[20]_i_4_n_0 ,\qmin_r1[20]_i_5_n_0 ,\qmin_r1[20]_i_6_n_0 ,\qmin_r1[20]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[20]_i_3 
       (.CI(\qmin_r1_reg[16]_i_3_n_0 ),
        .CO({\qmin_r1_reg[20]_i_3_n_0 ,\qmin_r1_reg[20]_i_3_n_1 ,\qmin_r1_reg[20]_i_3_n_2 ,\qmin_r1_reg[20]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[20:17]),
        .S({\qmin_r1[20]_i_8_n_0 ,\qmin_r1[20]_i_9_n_0 ,\qmin_r1[20]_i_10_n_0 ,\qmin_r1[20]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[21] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[21]_i_1_n_0 ),
        .Q(qmin_r1[21]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[22] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[22]_i_1_n_0 ),
        .Q(qmin_r1[22]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[23] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[23]_i_1_n_0 ),
        .Q(qmin_r1[23]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[24] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[24]_i_1_n_0 ),
        .Q(qmin_r1[24]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[24]_i_2 
       (.CI(\qmin_r1_reg[20]_i_2_n_0 ),
        .CO({\qmin_r1_reg[24]_i_2_n_0 ,\qmin_r1_reg[24]_i_2_n_1 ,\qmin_r1_reg[24]_i_2_n_2 ,\qmin_r1_reg[24]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[24:21]),
        .S({\qmin_r1[24]_i_4_n_0 ,\qmin_r1[24]_i_5_n_0 ,\qmin_r1[24]_i_6_n_0 ,\qmin_r1[24]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[24]_i_3 
       (.CI(\qmin_r1_reg[20]_i_3_n_0 ),
        .CO({\qmin_r1_reg[24]_i_3_n_0 ,\qmin_r1_reg[24]_i_3_n_1 ,\qmin_r1_reg[24]_i_3_n_2 ,\qmin_r1_reg[24]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[24:21]),
        .S({\qmin_r1[24]_i_8_n_0 ,\qmin_r1[24]_i_9_n_0 ,\qmin_r1[24]_i_10_n_0 ,\qmin_r1[24]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[25] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[25]_i_1_n_0 ),
        .Q(qmin_r1[25]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[26] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[26]_i_1_n_0 ),
        .Q(qmin_r1[26]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[27] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[27]_i_1_n_0 ),
        .Q(qmin_r1[27]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[28] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[28]_i_1_n_0 ),
        .Q(qmin_r1[28]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[28]_i_2 
       (.CI(\qmin_r1_reg[24]_i_2_n_0 ),
        .CO({\qmin_r1_reg[28]_i_2_n_0 ,\qmin_r1_reg[28]_i_2_n_1 ,\qmin_r1_reg[28]_i_2_n_2 ,\qmin_r1_reg[28]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[28:25]),
        .S({\qmin_r1[28]_i_4_n_0 ,\qmin_r1[28]_i_5_n_0 ,\qmin_r1[28]_i_6_n_0 ,\qmin_r1[28]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[28]_i_3 
       (.CI(\qmin_r1_reg[24]_i_3_n_0 ),
        .CO({\qmin_r1_reg[28]_i_3_n_0 ,\qmin_r1_reg[28]_i_3_n_1 ,\qmin_r1_reg[28]_i_3_n_2 ,\qmin_r1_reg[28]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[28:25]),
        .S({\qmin_r1[28]_i_8_n_0 ,\qmin_r1[28]_i_9_n_0 ,\qmin_r1[28]_i_10_n_0 ,\qmin_r1[28]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[29] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[29]_i_1_n_0 ),
        .Q(qmin_r1[29]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[2] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[2]_i_1_n_0 ),
        .Q(qmin_r1[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[30] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[30]_i_1_n_0 ),
        .Q(qmin_r1[30]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[31] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[31]_i_1_n_0 ),
        .Q(qmin_r1[31]),
        .R(rst));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \qmin_r1_reg[31]_i_11 
       (.CI(\qmin_r1_reg[31]_i_20_n_0 ),
        .CO({\qmin_r1_reg[31]_i_11_n_0 ,\qmin_r1_reg[31]_i_11_n_1 ,\qmin_r1_reg[31]_i_11_n_2 ,\qmin_r1_reg[31]_i_11_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\qmin_r1[31]_i_21_n_0 ,\qmin_r1[31]_i_22_n_0 ,\qmin_r1[31]_i_23_n_0 ,\qmin_r1[31]_i_24_n_0 }),
        .S({\qmin_r1[31]_i_25_n_0 ,\qmin_r1[31]_i_26_n_0 ,\qmin_r1[31]_i_27_n_0 ,\qmin_r1[31]_i_28_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[31]_i_2 
       (.CI(\qmin_r1_reg[28]_i_2_n_0 ),
        .CO({\qmin_r1_reg[31]_i_2_n_2 ,\qmin_r1_reg[31]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[31:29]),
        .S({\<const0> ,\qmin_r1[31]_i_5_n_0 ,\qmin_r1[31]_i_6_n_0 ,\qmin_r1[31]_i_7_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \qmin_r1_reg[31]_i_20 
       (.CI(\qmin_r1_reg[31]_i_32_n_0 ),
        .CO({\qmin_r1_reg[31]_i_20_n_0 ,\qmin_r1_reg[31]_i_20_n_1 ,\qmin_r1_reg[31]_i_20_n_2 ,\qmin_r1_reg[31]_i_20_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\qmin_r1[31]_i_33_n_0 ,\qmin_r1[31]_i_34_n_0 ,\qmin_r1[31]_i_35_n_0 ,\qmin_r1[31]_i_36_n_0 }),
        .S({\qmin_r1[31]_i_37_n_0 ,\qmin_r1[31]_i_38_n_0 ,\qmin_r1[31]_i_39_n_0 ,\qmin_r1[31]_i_40_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[31]_i_3 
       (.CI(\qmin_r1_reg[28]_i_3_n_0 ),
        .CO({\qmin_r1_reg[31]_i_3_n_2 ,\qmin_r1_reg[31]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[31:29]),
        .S({\<const0> ,\qmin_r1[31]_i_8_n_0 ,\qmin_r1[31]_i_9_n_0 ,\qmin_r1[31]_i_10_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \qmin_r1_reg[31]_i_32 
       (.CI(\<const0> ),
        .CO({\qmin_r1_reg[31]_i_32_n_0 ,\qmin_r1_reg[31]_i_32_n_1 ,\qmin_r1_reg[31]_i_32_n_2 ,\qmin_r1_reg[31]_i_32_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\qmin_r1[31]_i_45_n_0 ,\qmin_r1[31]_i_46_n_0 ,\qmin_r1[31]_i_47_n_0 ,\qmin_r1[31]_i_48_n_0 }),
        .S({\qmin_r1[31]_i_49_n_0 ,\qmin_r1[31]_i_50_n_0 ,\qmin_r1[31]_i_51_n_0 ,\qmin_r1[31]_i_52_n_0 }));
  (* COMPARATOR_THRESHOLD = "11" *) 
  CARRY4 \qmin_r1_reg[31]_i_4 
       (.CI(\qmin_r1_reg[31]_i_11_n_0 ),
        .CO({qmin_r12,\qmin_r1_reg[31]_i_4_n_1 ,\qmin_r1_reg[31]_i_4_n_2 ,\qmin_r1_reg[31]_i_4_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\qmin_r1[31]_i_12_n_0 ,\qmin_r1[31]_i_13_n_0 ,\qmin_r1[31]_i_14_n_0 ,\qmin_r1[31]_i_15_n_0 }),
        .S({\qmin_r1[31]_i_16_n_0 ,\qmin_r1[31]_i_17_n_0 ,\qmin_r1[31]_i_18_n_0 ,\qmin_r1[31]_i_19_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[3] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[3]_i_1_n_0 ),
        .Q(qmin_r1[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[4] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[4]_i_1_n_0 ),
        .Q(qmin_r1[4]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[4]_i_2 
       (.CI(\<const0> ),
        .CO({\qmin_r1_reg[4]_i_2_n_0 ,\qmin_r1_reg[4]_i_2_n_1 ,\qmin_r1_reg[4]_i_2_n_2 ,\qmin_r1_reg[4]_i_2_n_3 }),
        .CYINIT(\qmin_r1[4]_i_4_n_0 ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[4:1]),
        .S({\qmin_r1[4]_i_5_n_0 ,\qmin_r1[4]_i_6_n_0 ,\qmin_r1[4]_i_7_n_0 ,\qmin_r1[4]_i_8_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[4]_i_3 
       (.CI(\<const0> ),
        .CO({\qmin_r1_reg[4]_i_3_n_0 ,\qmin_r1_reg[4]_i_3_n_1 ,\qmin_r1_reg[4]_i_3_n_2 ,\qmin_r1_reg[4]_i_3_n_3 }),
        .CYINIT(\qmin_r1[4]_i_9_n_0 ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[4:1]),
        .S({\qmin_r1[4]_i_10_n_0 ,\qmin_r1[4]_i_11_n_0 ,\qmin_r1[4]_i_12_n_0 ,\qmin_r1[4]_i_13_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[5] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[5]_i_1_n_0 ),
        .Q(qmin_r1[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[6] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[6]_i_1_n_0 ),
        .Q(qmin_r1[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[7] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[7]_i_1_n_0 ),
        .Q(qmin_r1[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[8] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[8]_i_1_n_0 ),
        .Q(qmin_r1[8]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[8]_i_2 
       (.CI(\qmin_r1_reg[4]_i_2_n_0 ),
        .CO({\qmin_r1_reg[8]_i_2_n_0 ,\qmin_r1_reg[8]_i_2_n_1 ,\qmin_r1_reg[8]_i_2_n_2 ,\qmin_r1_reg[8]_i_2_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qabs0[8:5]),
        .S({\qmin_r1[8]_i_4_n_0 ,\qmin_r1[8]_i_5_n_0 ,\qmin_r1[8]_i_6_n_0 ,\qmin_r1[8]_i_7_n_0 }));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qmin_r1_reg[8]_i_3 
       (.CI(\qmin_r1_reg[4]_i_3_n_0 ),
        .CO({\qmin_r1_reg[8]_i_3_n_0 ,\qmin_r1_reg[8]_i_3_n_1 ,\qmin_r1_reg[8]_i_3_n_2 ,\qmin_r1_reg[8]_i_3_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .O(qmin_r13[8:5]),
        .S({\qmin_r1[8]_i_8_n_0 ,\qmin_r1[8]_i_9_n_0 ,\qmin_r1[8]_i_10_n_0 ,\qmin_r1[8]_i_11_n_0 }));
  FDRE #(
    .INIT(1'b0)) 
    \qmin_r1_reg[9] 
       (.C(clk),
        .CE(enable),
        .D(\qmin_r1[9]_i_1_n_0 ),
        .Q(qmin_r1[9]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qout[16]_INST_0 
       (.CI(\<const0> ),
        .CO({\qout[16]_INST_0_n_0 ,\qout[16]_INST_0_n_1 ,\qout[16]_INST_0_n_2 ,\qout[16]_INST_0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({qout_r_reg_n_103,qout_r_reg_n_104,qout_r_reg_n_105,\<const0> }),
        .O(qout[19:16]),
        .S({\qout[16]_INST_0_i_1_n_0 ,\qout[16]_INST_0_i_2_n_0 ,\qout[16]_INST_0_i_3_n_0 ,\qout_r_reg[16]__0_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[16]_INST_0_i_1 
       (.I0(qout_r_reg_n_103),
        .I1(qout_r0_n_103),
        .O(\qout[16]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[16]_INST_0_i_2 
       (.I0(qout_r_reg_n_104),
        .I1(qout_r0_n_104),
        .O(\qout[16]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[16]_INST_0_i_3 
       (.I0(qout_r_reg_n_105),
        .I1(qout_r0_n_105),
        .O(\qout[16]_INST_0_i_3_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qout[20]_INST_0 
       (.CI(\qout[16]_INST_0_n_0 ),
        .CO({\qout[20]_INST_0_n_0 ,\qout[20]_INST_0_n_1 ,\qout[20]_INST_0_n_2 ,\qout[20]_INST_0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({qout_r_reg_n_99,qout_r_reg_n_100,qout_r_reg_n_101,qout_r_reg_n_102}),
        .O(qout[23:20]),
        .S({\qout[20]_INST_0_i_1_n_0 ,\qout[20]_INST_0_i_2_n_0 ,\qout[20]_INST_0_i_3_n_0 ,\qout[20]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[20]_INST_0_i_1 
       (.I0(qout_r_reg_n_99),
        .I1(qout_r0_n_99),
        .O(\qout[20]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[20]_INST_0_i_2 
       (.I0(qout_r_reg_n_100),
        .I1(qout_r0_n_100),
        .O(\qout[20]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[20]_INST_0_i_3 
       (.I0(qout_r_reg_n_101),
        .I1(qout_r0_n_101),
        .O(\qout[20]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[20]_INST_0_i_4 
       (.I0(qout_r_reg_n_102),
        .I1(qout_r0_n_102),
        .O(\qout[20]_INST_0_i_4_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qout[24]_INST_0 
       (.CI(\qout[20]_INST_0_n_0 ),
        .CO({\qout[24]_INST_0_n_0 ,\qout[24]_INST_0_n_1 ,\qout[24]_INST_0_n_2 ,\qout[24]_INST_0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({qout_r_reg_n_95,qout_r_reg_n_96,qout_r_reg_n_97,qout_r_reg_n_98}),
        .O(qout[27:24]),
        .S({\qout[24]_INST_0_i_1_n_0 ,\qout[24]_INST_0_i_2_n_0 ,\qout[24]_INST_0_i_3_n_0 ,\qout[24]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[24]_INST_0_i_1 
       (.I0(qout_r_reg_n_95),
        .I1(qout_r0_n_95),
        .O(\qout[24]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[24]_INST_0_i_2 
       (.I0(qout_r_reg_n_96),
        .I1(qout_r0_n_96),
        .O(\qout[24]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[24]_INST_0_i_3 
       (.I0(qout_r_reg_n_97),
        .I1(qout_r0_n_97),
        .O(\qout[24]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[24]_INST_0_i_4 
       (.I0(qout_r_reg_n_98),
        .I1(qout_r0_n_98),
        .O(\qout[24]_INST_0_i_4_n_0 ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 \qout[28]_INST_0 
       (.CI(\qout[24]_INST_0_n_0 ),
        .CO({\qout[28]_INST_0_n_1 ,\qout[28]_INST_0_n_2 ,\qout[28]_INST_0_n_3 }),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,qout_r_reg_n_92,qout_r_reg_n_93,qout_r_reg_n_94}),
        .O(qout[31:28]),
        .S({\qout[28]_INST_0_i_1_n_0 ,\qout[28]_INST_0_i_2_n_0 ,\qout[28]_INST_0_i_3_n_0 ,\qout[28]_INST_0_i_4_n_0 }));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[28]_INST_0_i_1 
       (.I0(qout_r_reg_n_91),
        .I1(qout_r0_n_91),
        .O(\qout[28]_INST_0_i_1_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[28]_INST_0_i_2 
       (.I0(qout_r_reg_n_92),
        .I1(qout_r0_n_92),
        .O(\qout[28]_INST_0_i_2_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[28]_INST_0_i_3 
       (.I0(qout_r_reg_n_93),
        .I1(qout_r0_n_93),
        .O(\qout[28]_INST_0_i_3_n_0 ));
  LUT2 #(
    .INIT(4'h6)) 
    \qout[28]_INST_0_i_4 
       (.I0(qout_r_reg_n_94),
        .I1(qout_r0_n_94),
        .O(\qout[28]_INST_0_i_4_n_0 ));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 15x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(1),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(1),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(2),
    .BREG(2),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    qout_r0
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,p_0_in[16:0]}),
        .ACIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({qin_r4[31],qin_r4[31],qin_r4[31],qin_r4[31:17]}),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(\<const0> ),
        .CEA2(enable),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(enable),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(enable),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({qout_r0_n_58,qout_r0_n_59,qout_r0_n_60,qout_r0_n_61,qout_r0_n_62,qout_r0_n_63,qout_r0_n_64,qout_r0_n_65,qout_r0_n_66,qout_r0_n_67,qout_r0_n_68,qout_r0_n_69,qout_r0_n_70,qout_r0_n_71,qout_r0_n_72,qout_r0_n_73,qout_r0_n_74,qout_r0_n_75,qout_r0_n_76,qout_r0_n_77,qout_r0_n_78,qout_r0_n_79,qout_r0_n_80,qout_r0_n_81,qout_r0_n_82,qout_r0_n_83,qout_r0_n_84,qout_r0_n_85,qout_r0_n_86,qout_r0_n_87,qout_r0_n_88,qout_r0_n_89,qout_r0_n_90,qout_r0_n_91,qout_r0_n_92,qout_r0_n_93,qout_r0_n_94,qout_r0_n_95,qout_r0_n_96,qout_r0_n_97,qout_r0_n_98,qout_r0_n_99,qout_r0_n_100,qout_r0_n_101,qout_r0_n_102,qout_r0_n_103,qout_r0_n_104,qout_r0_n_105}),
        .PCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .PCOUT({qout_r0_n_106,qout_r0_n_107,qout_r0_n_108,qout_r0_n_109,qout_r0_n_110,qout_r0_n_111,qout_r0_n_112,qout_r0_n_113,qout_r0_n_114,qout_r0_n_115,qout_r0_n_116,qout_r0_n_117,qout_r0_n_118,qout_r0_n_119,qout_r0_n_120,qout_r0_n_121,qout_r0_n_122,qout_r0_n_123,qout_r0_n_124,qout_r0_n_125,qout_r0_n_126,qout_r0_n_127,qout_r0_n_128,qout_r0_n_129,qout_r0_n_130,qout_r0_n_131,qout_r0_n_132,qout_r0_n_133,qout_r0_n_134,qout_r0_n_135,qout_r0_n_136,qout_r0_n_137,qout_r0_n_138,qout_r0_n_139,qout_r0_n_140,qout_r0_n_141,qout_r0_n_142,qout_r0_n_143,qout_r0_n_144,qout_r0_n_145,qout_r0_n_146,qout_r0_n_147,qout_r0_n_148,qout_r0_n_149,qout_r0_n_150,qout_r0_n_151,qout_r0_n_152,qout_r0_n_153}),
        .RSTA(rst),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(rst));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x18 4}}" *) 
  DSP48E1 #(
    .ACASCREG(2),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(2),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(0),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    qout_r0__0
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,qin_r4[16:0]}),
        .ACIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({\<const0> ,p_0_in[16:0]}),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(enable),
        .CEA2(enable),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(\<const0> ),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(\<const0> ),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({qout_r0__0_n_58,qout_r0__0_n_59,qout_r0__0_n_60,qout_r0__0_n_61,qout_r0__0_n_62,qout_r0__0_n_63,qout_r0__0_n_64,qout_r0__0_n_65,qout_r0__0_n_66,qout_r0__0_n_67,qout_r0__0_n_68,qout_r0__0_n_69,qout_r0__0_n_70,qout_r0__0_n_71,qout_r0__0_n_72,qout_r0__0_n_73,qout_r0__0_n_74,qout_r0__0_n_75,qout_r0__0_n_76,qout_r0__0_n_77,qout_r0__0_n_78,qout_r0__0_n_79,qout_r0__0_n_80,qout_r0__0_n_81,qout_r0__0_n_82,qout_r0__0_n_83,qout_r0__0_n_84,qout_r0__0_n_85,qout_r0__0_n_86,qout_r0__0_n_87,qout_r0__0_n_88,qout_r0__0_n_89,qout_r0__0_n_90,qout_r0__0_n_91,qout_r0__0_n_92,qout_r0__0_n_93,qout_r0__0_n_94,qout_r0__0_n_95,qout_r0__0_n_96,qout_r0__0_n_97,qout_r0__0_n_98,qout_r0__0_n_99,qout_r0__0_n_100,qout_r0__0_n_101,qout_r0__0_n_102,qout_r0__0_n_103,qout_r0__0_n_104,qout_r0__0_n_105}),
        .PCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .PCOUT({qout_r0__0_n_106,qout_r0__0_n_107,qout_r0__0_n_108,qout_r0__0_n_109,qout_r0__0_n_110,qout_r0__0_n_111,qout_r0__0_n_112,qout_r0__0_n_113,qout_r0__0_n_114,qout_r0__0_n_115,qout_r0__0_n_116,qout_r0__0_n_117,qout_r0__0_n_118,qout_r0__0_n_119,qout_r0__0_n_120,qout_r0__0_n_121,qout_r0__0_n_122,qout_r0__0_n_123,qout_r0__0_n_124,qout_r0__0_n_125,qout_r0__0_n_126,qout_r0__0_n_127,qout_r0__0_n_128,qout_r0__0_n_129,qout_r0__0_n_130,qout_r0__0_n_131,qout_r0__0_n_132,qout_r0__0_n_133,qout_r0__0_n_134,qout_r0__0_n_135,qout_r0__0_n_136,qout_r0__0_n_137,qout_r0__0_n_138,qout_r0__0_n_139,qout_r0__0_n_140,qout_r0__0_n_141,qout_r0__0_n_142,qout_r0__0_n_143,qout_r0__0_n_144,qout_r0__0_n_145,qout_r0__0_n_146,qout_r0__0_n_147,qout_r0__0_n_148,qout_r0__0_n_149,qout_r0__0_n_150,qout_r0__0_n_151,qout_r0__0_n_152,qout_r0__0_n_153}),
        .RSTA(rst),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(\<const0> ));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r0_i_1
       (.CI(qout_r0_i_2_n_0),
        .CO({qout_r0_i_1_n_0,qout_r0_i_1_n_1,qout_r0_i_1_n_2,qout_r0_i_1_n_3}),
        .CYINIT(\<const0> ),
        .DI({qerf_r5[30],qerf_r5[30],qerf_r5[30],qerf_r5[16]}),
        .O(p_0_in[19:16]),
        .S({qout_r0_i_6_n_0,qout_r0_i_7_n_0,qout_r0_i_8_n_0,qout_r0_i_9_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_10
       (.I0(qerf_r5[15]),
        .I1(q1_r5[15]),
        .O(qout_r0_i_10_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_11
       (.I0(qerf_r5[14]),
        .I1(q1_r5[14]),
        .O(qout_r0_i_11_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_12
       (.I0(qerf_r5[13]),
        .I1(q1_r5[13]),
        .O(qout_r0_i_12_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_13
       (.I0(qerf_r5[12]),
        .I1(q1_r5[12]),
        .O(qout_r0_i_13_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_14
       (.I0(qerf_r5[11]),
        .I1(q1_r5[11]),
        .O(qout_r0_i_14_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_15
       (.I0(qerf_r5[10]),
        .I1(q1_r5[10]),
        .O(qout_r0_i_15_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_16
       (.I0(qerf_r5[9]),
        .I1(q1_r5[9]),
        .O(qout_r0_i_16_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_17
       (.I0(qerf_r5[8]),
        .I1(q1_r5[8]),
        .O(qout_r0_i_17_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_18
       (.I0(qerf_r5[7]),
        .I1(q1_r5[7]),
        .O(qout_r0_i_18_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_19
       (.I0(qerf_r5[6]),
        .I1(q1_r5[6]),
        .O(qout_r0_i_19_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r0_i_2
       (.CI(qout_r0_i_3_n_0),
        .CO({qout_r0_i_2_n_0,qout_r0_i_2_n_1,qout_r0_i_2_n_2,qout_r0_i_2_n_3}),
        .CYINIT(\<const0> ),
        .DI(qerf_r5[15:12]),
        .O(p_0_in[15:12]),
        .S({qout_r0_i_10_n_0,qout_r0_i_11_n_0,qout_r0_i_12_n_0,qout_r0_i_13_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_20
       (.I0(qerf_r5[5]),
        .I1(q1_r5[5]),
        .O(qout_r0_i_20_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_21
       (.I0(qerf_r5[4]),
        .I1(q1_r5[4]),
        .O(qout_r0_i_21_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_22
       (.I0(qerf_r5[3]),
        .I1(q1_r5[3]),
        .O(qout_r0_i_22_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_23
       (.I0(qerf_r5[2]),
        .I1(q1_r5[2]),
        .O(qout_r0_i_23_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_24
       (.I0(qerf_r5[1]),
        .I1(q1_r5[1]),
        .O(qout_r0_i_24_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_25
       (.I0(qerf_r5[0]),
        .I1(q1_r5[0]),
        .O(qout_r0_i_25_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r0_i_3
       (.CI(qout_r0_i_4_n_0),
        .CO({qout_r0_i_3_n_0,qout_r0_i_3_n_1,qout_r0_i_3_n_2,qout_r0_i_3_n_3}),
        .CYINIT(\<const0> ),
        .DI(qerf_r5[11:8]),
        .O(p_0_in[11:8]),
        .S({qout_r0_i_14_n_0,qout_r0_i_15_n_0,qout_r0_i_16_n_0,qout_r0_i_17_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r0_i_4
       (.CI(qout_r0_i_5_n_0),
        .CO({qout_r0_i_4_n_0,qout_r0_i_4_n_1,qout_r0_i_4_n_2,qout_r0_i_4_n_3}),
        .CYINIT(\<const0> ),
        .DI(qerf_r5[7:4]),
        .O(p_0_in[7:4]),
        .S({qout_r0_i_18_n_0,qout_r0_i_19_n_0,qout_r0_i_20_n_0,qout_r0_i_21_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r0_i_5
       (.CI(\<const0> ),
        .CO({qout_r0_i_5_n_0,qout_r0_i_5_n_1,qout_r0_i_5_n_2,qout_r0_i_5_n_3}),
        .CYINIT(\<const0> ),
        .DI(qerf_r5[3:0]),
        .O(p_0_in[3:0]),
        .S({qout_r0_i_22_n_0,qout_r0_i_23_n_0,qout_r0_i_24_n_0,qout_r0_i_25_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_6
       (.I0(qerf_r5[30]),
        .I1(q1_r5[19]),
        .O(qout_r0_i_6_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_7
       (.I0(qerf_r5[30]),
        .I1(q1_r5[18]),
        .O(qout_r0_i_7_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_8
       (.I0(qerf_r5[30]),
        .I1(q1_r5[17]),
        .O(qout_r0_i_8_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r0_i_9
       (.I0(qerf_r5[16]),
        .I1(q1_r5[16]),
        .O(qout_r0_i_9_n_0));
  (* METHODOLOGY_DRC_VIOS = "{SYNTH-10 {cell *THIS*} {string 18x15 4}}" *) 
  DSP48E1 #(
    .ACASCREG(2),
    .ADREG(1),
    .ALUMODEREG(0),
    .AREG(2),
    .AUTORESET_PATDET("NO_RESET"),
    .A_INPUT("DIRECT"),
    .BCASCREG(1),
    .BREG(1),
    .B_INPUT("DIRECT"),
    .CARRYINREG(0),
    .CARRYINSELREG(0),
    .CREG(1),
    .DREG(1),
    .INMODEREG(0),
    .MASK(48'h3FFFFFFFFFFF),
    .MREG(0),
    .OPMODEREG(0),
    .PATTERN(48'h000000000000),
    .PREG(1),
    .SEL_MASK("MASK"),
    .SEL_PATTERN("PATTERN"),
    .USE_DPORT("FALSE"),
    .USE_MULT("MULTIPLY"),
    .USE_PATTERN_DETECT("NO_PATDET"),
    .USE_SIMD("ONE48")) 
    qout_r_reg
       (.A({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,qin_r4[16:0]}),
        .ACIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .ALUMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .B({p_0_in[31],p_0_in[31],p_0_in[31],p_0_in[31:17]}),
        .BCIN({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .C({VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2,VCC_2}),
        .CARRYCASCIN(\<const0> ),
        .CARRYIN(\<const0> ),
        .CARRYINSEL({\<const0> ,\<const0> ,\<const0> }),
        .CEA1(enable),
        .CEA2(enable),
        .CEAD(\<const0> ),
        .CEALUMODE(\<const0> ),
        .CEB1(\<const0> ),
        .CEB2(enable),
        .CEC(\<const0> ),
        .CECARRYIN(\<const0> ),
        .CECTRL(\<const0> ),
        .CED(\<const0> ),
        .CEINMODE(\<const0> ),
        .CEM(\<const0> ),
        .CEP(enable),
        .CLK(clk),
        .D({GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2,GND_2}),
        .INMODE({\<const0> ,\<const0> ,\<const0> ,\<const0> ,\<const0> }),
        .MULTSIGNIN(\<const0> ),
        .OPMODE({\<const1> ,\<const0> ,\<const1> ,\<const0> ,\<const1> ,\<const0> ,\<const1> }),
        .P({qout_r_reg_n_58,qout_r_reg_n_59,qout_r_reg_n_60,qout_r_reg_n_61,qout_r_reg_n_62,qout_r_reg_n_63,qout_r_reg_n_64,qout_r_reg_n_65,qout_r_reg_n_66,qout_r_reg_n_67,qout_r_reg_n_68,qout_r_reg_n_69,qout_r_reg_n_70,qout_r_reg_n_71,qout_r_reg_n_72,qout_r_reg_n_73,qout_r_reg_n_74,qout_r_reg_n_75,qout_r_reg_n_76,qout_r_reg_n_77,qout_r_reg_n_78,qout_r_reg_n_79,qout_r_reg_n_80,qout_r_reg_n_81,qout_r_reg_n_82,qout_r_reg_n_83,qout_r_reg_n_84,qout_r_reg_n_85,qout_r_reg_n_86,qout_r_reg_n_87,qout_r_reg_n_88,qout_r_reg_n_89,qout_r_reg_n_90,qout_r_reg_n_91,qout_r_reg_n_92,qout_r_reg_n_93,qout_r_reg_n_94,qout_r_reg_n_95,qout_r_reg_n_96,qout_r_reg_n_97,qout_r_reg_n_98,qout_r_reg_n_99,qout_r_reg_n_100,qout_r_reg_n_101,qout_r_reg_n_102,qout_r_reg_n_103,qout_r_reg_n_104,qout_r_reg_n_105}),
        .PCIN({qout_r0__0_n_106,qout_r0__0_n_107,qout_r0__0_n_108,qout_r0__0_n_109,qout_r0__0_n_110,qout_r0__0_n_111,qout_r0__0_n_112,qout_r0__0_n_113,qout_r0__0_n_114,qout_r0__0_n_115,qout_r0__0_n_116,qout_r0__0_n_117,qout_r0__0_n_118,qout_r0__0_n_119,qout_r0__0_n_120,qout_r0__0_n_121,qout_r0__0_n_122,qout_r0__0_n_123,qout_r0__0_n_124,qout_r0__0_n_125,qout_r0__0_n_126,qout_r0__0_n_127,qout_r0__0_n_128,qout_r0__0_n_129,qout_r0__0_n_130,qout_r0__0_n_131,qout_r0__0_n_132,qout_r0__0_n_133,qout_r0__0_n_134,qout_r0__0_n_135,qout_r0__0_n_136,qout_r0__0_n_137,qout_r0__0_n_138,qout_r0__0_n_139,qout_r0__0_n_140,qout_r0__0_n_141,qout_r0__0_n_142,qout_r0__0_n_143,qout_r0__0_n_144,qout_r0__0_n_145,qout_r0__0_n_146,qout_r0__0_n_147,qout_r0__0_n_148,qout_r0__0_n_149,qout_r0__0_n_150,qout_r0__0_n_151,qout_r0__0_n_152,qout_r0__0_n_153}),
        .RSTA(rst),
        .RSTALLCARRYIN(\<const0> ),
        .RSTALUMODE(\<const0> ),
        .RSTB(rst),
        .RSTC(\<const0> ),
        .RSTCTRL(\<const0> ),
        .RSTD(\<const0> ),
        .RSTINMODE(\<const0> ),
        .RSTM(\<const0> ),
        .RSTP(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[0]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_105),
        .Q(qout[0]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[10]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_95),
        .Q(qout[10]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[11]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_94),
        .Q(qout[11]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[12]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_93),
        .Q(qout[12]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[13]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_92),
        .Q(qout[13]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[14]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_91),
        .Q(qout[14]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[15]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_90),
        .Q(qout[15]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[16]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_89),
        .Q(\qout_r_reg[16]__0_n_0 ),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[1]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_104),
        .Q(qout[1]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[2]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_103),
        .Q(qout[2]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[3]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_102),
        .Q(qout[3]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[4]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_101),
        .Q(qout[4]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[5]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_100),
        .Q(qout[5]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[6]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_99),
        .Q(qout[6]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[7]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_98),
        .Q(qout[7]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[8]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_97),
        .Q(qout[8]),
        .R(rst));
  FDRE #(
    .INIT(1'b0)) 
    \qout_r_reg[9]__0 
       (.C(clk),
        .CE(enable),
        .D(qout_r0__0_n_96),
        .Q(qout[9]),
        .R(rst));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r_reg_i_1
       (.CI(qout_r_reg_i_2_n_0),
        .CO({qout_r_reg_i_1_n_1,qout_r_reg_i_1_n_2,qout_r_reg_i_1_n_3}),
        .CYINIT(\<const0> ),
        .DI({\<const0> ,qerf_r5[30],qerf_r5[30],qerf_r5[30]}),
        .O(p_0_in[31:28]),
        .S({qout_r_reg_i_4_n_0,qout_r_reg_i_5_n_0,qout_r_reg_i_6_n_0,qout_r_reg_i_7_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_10
       (.I0(qerf_r5[30]),
        .I1(q1_r5[25]),
        .O(qout_r_reg_i_10_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_11
       (.I0(qerf_r5[30]),
        .I1(q1_r5[24]),
        .O(qout_r_reg_i_11_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_12
       (.I0(qerf_r5[30]),
        .I1(q1_r5[23]),
        .O(qout_r_reg_i_12_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_13
       (.I0(qerf_r5[30]),
        .I1(q1_r5[22]),
        .O(qout_r_reg_i_13_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_14
       (.I0(qerf_r5[30]),
        .I1(q1_r5[21]),
        .O(qout_r_reg_i_14_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_15
       (.I0(qerf_r5[30]),
        .I1(q1_r5[20]),
        .O(qout_r_reg_i_15_n_0));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r_reg_i_2
       (.CI(qout_r_reg_i_3_n_0),
        .CO({qout_r_reg_i_2_n_0,qout_r_reg_i_2_n_1,qout_r_reg_i_2_n_2,qout_r_reg_i_2_n_3}),
        .CYINIT(\<const0> ),
        .DI({qerf_r5[30],qerf_r5[30],qerf_r5[30],qerf_r5[30]}),
        .O(p_0_in[27:24]),
        .S({qout_r_reg_i_8_n_0,qout_r_reg_i_9_n_0,qout_r_reg_i_10_n_0,qout_r_reg_i_11_n_0}));
  (* ADDER_THRESHOLD = "35" *) 
  CARRY4 qout_r_reg_i_3
       (.CI(qout_r0_i_1_n_0),
        .CO({qout_r_reg_i_3_n_0,qout_r_reg_i_3_n_1,qout_r_reg_i_3_n_2,qout_r_reg_i_3_n_3}),
        .CYINIT(\<const0> ),
        .DI({qerf_r5[30],qerf_r5[30],qerf_r5[30],qerf_r5[30]}),
        .O(p_0_in[23:20]),
        .S({qout_r_reg_i_12_n_0,qout_r_reg_i_13_n_0,qout_r_reg_i_14_n_0,qout_r_reg_i_15_n_0}));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_4
       (.I0(qerf_r5[30]),
        .I1(q1_r5[31]),
        .O(qout_r_reg_i_4_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_5
       (.I0(qerf_r5[30]),
        .I1(q1_r5[30]),
        .O(qout_r_reg_i_5_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_6
       (.I0(qerf_r5[30]),
        .I1(q1_r5[29]),
        .O(qout_r_reg_i_6_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_7
       (.I0(qerf_r5[30]),
        .I1(q1_r5[28]),
        .O(qout_r_reg_i_7_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_8
       (.I0(qerf_r5[30]),
        .I1(q1_r5[27]),
        .O(qout_r_reg_i_8_n_0));
  LUT2 #(
    .INIT(4'h6)) 
    qout_r_reg_i_9
       (.I0(qerf_r5[30]),
        .I1(q1_r5[26]),
        .O(qout_r_reg_i_9_n_0));
endmodule
