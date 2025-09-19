`timescale 1ps / 1ps

module mem_write_B
#(
    parameter integer N2           = 4,
    parameter integer MATRIXSIZE_W = 16,
    parameter integer ADDR_W       = 12
)
(
    input  logic                    clk,
    input  logic                    rst,
    input  logic [MATRIXSIZE_W-1:0] M2,
    input  logic [MATRIXSIZE_W-1:0] M3dN2,
    input  logic                    valid_B,
    output logic  [ADDR_W-1:0]       wr_addr_B,
    output logic  [N2-1:0]           activate_B
);

logic [N2-1:0]           activate_B_r;
logic [$clog2(N2)-1:0]   col;
logic [MATRIXSIZE_W-1:0] row;
logic [MATRIXSIZE_W-1:0] offset;
logic [MATRIXSIZE_W-1:0] phase;

always_ff @(posedge clk) begin
    if (rst) begin
        col       <= 0;
        row       <= 0;
        offset    <= 0;
        phase     <= 0;
        wr_addr_B <= 0;
    end else if (valid_B) begin
        col <= col + 1;
        if (col == N2-1) begin
            col <= 0;
            if (phase == M3dN2-1) begin
                offset <= 0;
                phase  <= 0;
                row    <= row + 1;
            end else begin
                offset <= offset + M2;
                phase  <= phase + 1;
            end
        end
        wr_addr_B <= row + offset;
    end
end

integer x;
always_ff @(posedge clk) begin
    if (rst) begin
        activate_B_r <= 1;      // [0,0,...,1]
        activate_B   <= 0;
    end else begin
        activate_B <= activate_B_r;
        if (valid_B) begin
            activate_B_r[0] <= (row == M2-1) && (phase == M3dN2-1) ? 0 : activate_B_r[N2-1];
            for (x = 1; x < N2; x = x + 1) begin
                activate_B_r[x] <= activate_B_r[x-1];
            end
        end
    end
end

endmodule
