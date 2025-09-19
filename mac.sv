`timescale 1ps / 1ps

module mac
#(
    parameter D_W     = 32,
    parameter D_W_ACC = 32
)
(
    input logic                      clk,
    input logic                      rst,
    input logic                      enable,
    input logic                      initialize,
    input logic signed [D_W-1:0]     a,
    input logic signed [D_W-1:0]     b,
    output logic signed [D_W_ACC-1:0] result
);


endmodule
