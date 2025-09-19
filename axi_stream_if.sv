// verilator lint_off UNDRIVEN

`timescale 1ps / 1ps

interface axi_stream_if #(
    parameter D_W = 32
);

logic signed [D_W-1:0] tdata;
logic                  tlast;
logic                  tvalid;
logic                  tready;

modport axi_in (
    input  tdata,
    input  tlast,
    input  tvalid,
    output tready
);

modport axi_out (
    input  tready,
    output tdata,
    output tlast,
    output tvalid
);

endinterface
