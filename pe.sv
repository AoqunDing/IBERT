`timescale 1ps / 1ps

module pe
#(
    parameter integer D_W     = 8,      // operand data width
    parameter integer D_W_ACC = 32      // accumulator data width
)
(
    input  logic                      clk,
    input  logic                      rst,
    input  logic                      init,
    input  logic signed [D_W-1:0]     in_a,
    input  logic signed [D_W-1:0]     in_b,
    input  logic signed [D_W_ACC-1:0] in_data,
    input  logic                      in_valid,
    output logic  signed [D_W-1:0]     out_a,
    output logic  signed [D_W-1:0]     out_b,
    output logic  signed [D_W_ACC-1:0] out_data,
    output logic                       out_valid
);

// write your code here
logic signed [D_W_ACC-1:0] acc;
logic signed [D_W_ACC-1:0] data_delay;
logic valid_delay;


always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        acc <= '0;
        data_delay <= '0;
        valid_delay <= 0;
        out_data <= '0;
        out_valid <= 0;
        out_a <= '0;
        out_b <= '0;
    end else begin
        acc <= acc + in_a * in_b;
        out_a <= in_a;
        out_b <= in_b;
        data_delay <= in_data;
        valid_delay <= in_valid;
        out_data <= data_delay;
        out_valid <= valid_delay;
        if (init) begin
            //out_valid need to be fixed
            out_data <= acc;
            out_valid <= 1;
            acc <= in_a * in_b;
        end
    end
end

endmodule
