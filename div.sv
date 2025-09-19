`timescale 1ps / 1ps

module div
#(
    parameter integer D_W = 32
)
(
    input  logic           clk,
    input  logic           rst,
    input  logic           in_valid,
    input  logic           enable,
    input  logic [D_W-1:0] divisor,
    input  logic [D_W-1:0] dividend,
    output logic [D_W-1:0] quotient,
    output logic           out_valid
);

endmodule
