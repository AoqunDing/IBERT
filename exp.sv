`timescale 1ps / 1ps

module exp
#(
    parameter integer D_W     = 32,
    parameter integer FP_BITS = 30
)
(
    input  logic                  clk,
    input  logic                  rst,
    input  logic                  in_valid,
    input  logic                  enable,
    input  logic signed [D_W-1:0] qin,           // exp input

    input  logic signed [D_W-1:0] qb,            // coefficient
    input  logic signed [D_W-1:0] qc,            // coefficient
    input  logic signed [D_W-1:0] qln2,          // coefficient
    input  logic signed [D_W-1:0] qln2_inv,      // coefficient

    output logic                  out_valid,
    output logic signed [D_W-1:0] qout           // exp output
);

endmodule
