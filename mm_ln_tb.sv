`include "names.h"
`timescale 1ps / 1ps
import dims::*;
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
`define DIR "\"tb_self/\""

module mm_ln_tb
`endif
#(
    parameter integer D_W               = 8,
    parameter integer D_W_ACC           = 32,
    parameter integer LN_BITS           = 22,
    parameter integer M1                = 32,
    parameter integer M2                = 768,
    parameter integer M3                = 768,
    parameter integer N1                = 4,
    parameter integer N2                = 4,
    parameter integer MATRIXSIZE_W      = 24,
    parameter integer MEM_DEPTH_A       = 6144,
    parameter integer MEM_DEPTH_B       = 147456,
    parameter integer MEM_DEPTH_D       = 6144,
    parameter integer MAT_ADD_MEM_DEPTH = 4096,
    parameter integer BLOCKS            = 1,
    parameter integer REUSE             = 1,
    parameter integer SLICES            = 1
)
(
`ifdef VERILATOR
    input wire clk,
    input wire rst
`endif
);

`ifndef VERILATOR
reg        clk   = 1'b0;
reg        fclk  = 1'b0;
reg  [1:0] rst_r = 2'b11;
wire       rst   = rst_r[0];

always #1 clk  = ~clk;
always #1 fclk = ~fclk;

always @(posedge clk) begin
    rst_r <= rst_r >> 1;
end
`else
wire fclk = clk;
`endif

localparam integer REP = REUSE*M1*M2*M3*SLICES/2;

dimensions dimensions_tb;

assign dimensions_tb.M1                   = M1;
assign dimensions_tb.M2                   = M2;
assign dimensions_tb.M3                   = M3;
assign dimensions_tb.M1xM3                = M1*M3;
assign dimensions_tb.M1xM3dN1             = M1*M3/N1;
assign dimensions_tb.M1dN1                = M1/N1;
assign dimensions_tb.M3dN2                = M3/N2;
assign dimensions_tb.M1xM3dN1xN2          = (M1*M3)/(N1*N2);
assign dimensions_tb.BLOCKS               = BLOCKS;
assign dimensions_tb.BLOCK_WIDTH          = M3/BLOCKS;
assign dimensions_tb.BLOCK_WIDTHdN2       = (M3/BLOCKS)/N2;
assign dimensions_tb.BLOCK_SIZEdN2        = M2*(M3/BLOCKS)/N2;
assign dimensions_tb.M1xBLOCK_WIDTHdN1xN2 = (M1*(M3/BLOCKS))/(N1*N2);
assign dimensions_tb.M1xBLOCK_WIDTHdN1    = (M1*(M3/BLOCKS))/(N1);
assign dimensions_tb.BLOCKS_A             = (M2 == 768)? 12 : 768;       //Assuming BLOCKED_D = 1 and we have 768 BLOCKS for inter layer
assign dimensions_tb.BLOCK_WIDTH_A        = (M2 == 768)? M2/12 : M2/768;

reg                       in_valid_X;
reg  signed [31:0]        in_data_X;
reg                       in_last_X;
wire                      in_ready_X;

reg                       in_valid_W;
reg  signed [31:0]        in_data_W;
reg                       in_last_W;
wire                      in_ready_W;

reg                       in_valid_W_bias;
reg  signed [31:0]        in_data_W_bias;
reg                       in_last_W_bias;
wire                      in_ready_W_bias;

reg                       in_valid_W_m;
reg  signed [31:0]        in_data_W_m;
reg                       in_last_W_m;
wire                      in_ready_W_m;

reg                       in_valid_W_e;
reg  signed [31:0]        in_data_W_e;
reg                       in_last_W_e;
wire                      in_ready_W_e;

reg                       in_valid_R;
reg  signed [31:0]        in_data_R;
reg                       in_last_R;
wire                      in_ready_R;

reg                       in_valid_R_m;
reg  signed [31:0]        in_data_R_m;
reg                       in_last_R_m;
wire                      in_ready_R_m;

reg                       in_valid_R_e;
reg  signed [31:0]        in_data_R_e;
reg                       in_last_R_e;
wire                      in_ready_R_e;

reg                       in_valid_ln_bias;
reg  signed [31:0]        in_data_ln_bias;
reg                       in_last_ln_bias;
wire                      in_ready_ln_bias;

reg                       in_valid_out_m;
reg  signed [31:0]        in_data_out_m;
reg                       in_last_out_m;
wire                      in_ready_out_m;

reg                       in_valid_out_e;
reg  signed [31:0]        in_data_out_e;
reg                       in_last_out_e;
wire                      in_ready_out_e;

wire                      out_valid;
wire signed [D_W-1:0]     out_data;
wire                      out_last;
reg                       mm_ln_done;

// Sequence

reg START_W         = 0;
reg START_R         = 0;
reg START_R_m       = 0;
reg START_R_e       = 0;
reg START_W_bias    = 0;
reg START_W_m       = 0;
reg START_W_e       = 0;
reg START_ln_bias   = 0;
reg START_out_m     = 0;
reg START_out_e     = 0;

//input memories
reg  signed [D_W_ACC-1:0] mem_X         [0:REUSE*M1*M2-1];
reg  signed [D_W_ACC-1:0] mem_W         [0:REUSE*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_R         [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_bias    [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_m       [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_e       [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_R_m       [0:REUSE-1];
reg  signed [D_W_ACC-1:0] mem_R_e       [0:REUSE-1];
reg  signed [D_W_ACC-1:0] mem_ln_bias   [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_m     [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_e     [0:REUSE*M3-1];

//output memories
reg  signed [D_W_ACC-1:0] mem_Y         [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_Y_req     [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_R_req     [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_Z         [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_ln_out    [0:REUSE*M1*M3-1];
reg  signed [D_W-1:0]     mem_out       [0:REUSE*M1*M3-1];

//read addresses
reg [$clog2(REUSE*M1*M2):0] rdaddr_X;
reg [$clog2(REUSE*M2*M3):0] rdaddr_W;
reg [$clog2(REUSE*M1*M3):0] rdaddr_R;
reg [$clog2(REUSE*M3):0]    rdaddr_W_bias;
reg [$clog2(REUSE*M3):0]    rdaddr_W_m;
reg [$clog2(REUSE*M3):0]    rdaddr_W_e;
reg [$clog2(REUSE):0]       rdaddr_R_m;
reg [$clog2(REUSE):0]       rdaddr_R_e;
reg [$clog2(REUSE*M3):0]    rdaddr_ln_bias;
reg [$clog2(REUSE*M3):0]    rdaddr_out_m;
reg [$clog2(REUSE*M3):0]    rdaddr_out_e;

//write addresses
reg [$clog2(REUSE*M1*M3):0] wraddr_Y;
reg [$clog2(REUSE*M1*M3):0] wraddr_Y_req;
reg [$clog2(REUSE*M1*M3):0] wraddr_R_req;
reg [$clog2(REUSE*M1*M3):0] wraddr_Z;
reg [$clog2(REUSE*M1*M3):0] wraddr_ln_out;
reg [$clog2(REUSE*M1*M3):0] wraddr_out;
reg [$clog2(REUSE):0]       done_cntr;

initial begin
    if (M2 == 3072) begin
        $readmemh({`DIR,"G_out.mem"}, mem_X);
        $readmemh({`DIR,"A_out.mem"}, mem_R);
    end else begin
        $readmemh({`DIR,"C.mem"}, mem_X);
        $readmemh({`DIR,"I.mem"}, mem_R);
    end
    if (BLOCKS > 1) begin
        $readmemh({`DIR,"W_pp.mem"}, mem_W);
    end else begin
        $readmemh({`DIR,"W.mem"}, mem_W);
    end
    $readmemh({`DIR,"W_bias.mem"}, mem_W_bias);
    $readmemh({`DIR,"W_m.mem"}, mem_W_m);
    $readmemh({`DIR,"W_e.mem"}, mem_W_e);
    $readmemh({`DIR,"R_m.mem"}, mem_R_m);
    $readmemh({`DIR,"R_e.mem"}, mem_R_e);
    $readmemh({`DIR,"ln_bias.mem"}, mem_ln_bias);
    $readmemh({`DIR,"out_m.mem"}, mem_out_m);
    $readmemh({`DIR,"out_e.mem"}, mem_out_e);
end

final begin
    $writememh({`DIR,"tb_Y.mem"}, mem_Y);
    $writememh({`DIR,"tb_Y_req.mem"}, mem_Y_req);
    $writememh({`DIR,"tb_R_req.mem"}, mem_R_req);
    $writememh({`DIR,"tb_Z.mem"}, mem_Z);
    $writememh({`DIR,"tb_ln_out.mem"}, mem_ln_out);
    $writememh({`DIR,"tb_out.mem"}, mem_out);
end

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
    if (ctime % (M1*M2*8) == 0) begin
        $display("...");
    end
    if (ctime > REP) begin
        $display("Error: Timed out!");
        $finish;
    end
    if (mm_ln_done) begin
        $finish;
    end
end

// ############## //
// Sending Inputs //
// ############## //

always @(posedge clk) begin
    if (rst) begin
        in_valid_X <= 0;
        in_last_X  <= 0;
        rdaddr_X   <= 0;
        in_data_X  <= mem_X[rdaddr_X];
    end else begin
        if (rdaddr_X < REUSE*M1*M2-1) begin
            in_valid_X <= 1;
        end

        if (in_valid_X && in_ready_X) begin
            in_data_X <= mem_X[rdaddr_X + 1];
            if (rdaddr_X < REUSE*M1*M2-1) begin
                rdaddr_X <= rdaddr_X + 1;
            end

            if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-2) begin
                in_last_X <= 1;
                START_W <= 1;
            end else if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-1) begin
                in_valid_X <= 0;
                in_last_X <= 0;
                $display("Done Sending input X to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W <= 0;
        in_last_W  <= 0;
        rdaddr_W   <= 0;
        in_data_W  <= mem_W[rdaddr_W];
    end else if(START_W) begin
        if (rdaddr_W < REUSE*M2*M3-1) begin
            in_valid_W <= 1;
        end

        if (in_valid_W && in_ready_W) begin
            in_data_W <= mem_W[rdaddr_W + 1];
            if (rdaddr_W < REUSE*M2*M3-1) begin
                rdaddr_W <= rdaddr_W + 1;
            end

            if (rdaddr_W == (M2*M3)*(rdaddr_W/(M2*M3))+M2*M3-2) begin
                in_last_W <= 1;
                START_R <= 1;
            end else if (rdaddr_W == (M2*M3)*(rdaddr_W/(M2*M3))+M2*M3-1) begin
                in_valid_W <= 0;
                in_last_W <= 0;
                START_W <= 0;
                $display("Done Sending weight W to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_R <= 0;
        in_last_R  <= 0;
        rdaddr_R   <= 0;
        in_data_R  <= mem_R[rdaddr_R];
    end else if(START_R) begin
        if (rdaddr_R < REUSE*M1*M3-1) begin
            in_valid_R <= 1;
        end

        if (in_valid_R && in_ready_R) begin
            in_data_R <= mem_R[rdaddr_R + 1];
            if (rdaddr_R < REUSE*M1*M3-1) begin
                rdaddr_R <= rdaddr_R + 1;
            end

            if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-2) begin
                in_last_R <= 1;
                START_R_m <= 1;
            end else if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-1) begin
                in_valid_R <= 0;
                in_last_R <= 0;
                START_R <= 0;
                $display("Done Sending residual input R to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_bias <= 0;
        in_last_W_bias  <= 0;
        rdaddr_W_bias   <= 0;
        in_data_W_bias  <= mem_W_bias[rdaddr_W_bias];
    end else if(START_W_bias) begin
        if (rdaddr_W_bias < REUSE*M3-1) begin
            in_valid_W_bias <= 1;
        end

        if (in_valid_W_bias && in_ready_W_bias) begin
            in_data_W_bias <= mem_W_bias[rdaddr_W_bias + 1];
            if (rdaddr_W_bias < REUSE*M3-1) begin
                rdaddr_W_bias <= rdaddr_W_bias + 1;
            end

            if (rdaddr_W_bias == M3*(rdaddr_W_bias/M3)+M3-2) begin
                in_last_W_bias <= 1;
                START_W_m <= 1;
            end else if (rdaddr_W_bias == M3*(rdaddr_W_bias/M3)+M3-1) begin
                in_valid_W_bias <= 0;
                in_last_W_bias <= 0;
                START_W_bias <= 0;
                $display("Done Sending bias W_bias to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_m <= 0;
        in_last_W_m  <= 0;
        rdaddr_W_m   <= 0;
        in_data_W_m  <= mem_W_m[rdaddr_W_m];
    end else if(START_W_m) begin
        if (rdaddr_W_m < REUSE*M3-1) begin
            in_valid_W_m <= 1;
        end

        if (in_valid_W_m && in_ready_W_m) begin
            in_data_W_m <= mem_W_m[rdaddr_W_m + 1];
            if (rdaddr_W_m < REUSE*M3-1) begin
                rdaddr_W_m <= rdaddr_W_m + 1;
            end

            if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-2) begin
                in_last_W_m <= 1;
                START_W_e <= 1;
            end else if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-1) begin
                in_valid_W_m <= 0;
                in_last_W_m <= 0;
                START_W_m <= 0;
                $display("Done Sending requantization multiplier W_m to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_e <= 0;
        in_last_W_e  <= 0;
        rdaddr_W_e   <= 0;
        in_data_W_e  <= mem_W_e[rdaddr_W_e];
    end else if(START_W_e) begin
        if (rdaddr_W_e < REUSE*M3-1) begin
            in_valid_W_e <= 1;
        end

        if (in_valid_W_e && in_ready_W_e) begin
            in_data_W_e <= mem_W_e[rdaddr_W_e + 1];
            if (rdaddr_W_e < REUSE*M3-1) begin
                rdaddr_W_e <= rdaddr_W_e + 1;
            end

            if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-2) begin
                in_last_W_e <= 1;
                START_ln_bias <= 1;
            end else if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-1) begin
                in_valid_W_e <= 0;
                in_last_W_e <= 0;
                START_W_e <= 0;
                $display("Done Sending requantization shifter W_e to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_R_m <= 0;
        in_last_R_m  <= 0;
        rdaddr_R_m   <= 0;
        in_data_R_m  <= mem_R_m[rdaddr_R_m];
    end else if (START_R_m) begin
        if (rdaddr_R_m < REUSE) begin
            in_valid_R_m <= 1;
            in_last_R_m <= 1;
            START_R_e <= 1;
        end

        if (in_valid_R_m && in_ready_R_m) begin
            if (REUSE > 1) begin
                in_data_R_m <= mem_R_m[rdaddr_R_m + 1];
            end
            if (rdaddr_R_m < REUSE) begin
                rdaddr_R_m <= rdaddr_R_m + 1;
            end

            in_valid_R_m <= 0;
            in_last_R_m <= 0;
            START_R_m <= 0;
            $display("Done Sending requantization multiplier R_m to Top Module at time=%0d", ctime);
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_R_e <= 0;
        in_last_R_e  <= 0;
        rdaddr_R_e   <= 0;
        in_data_R_e  <= mem_R_e[rdaddr_R_e];
    end else if (START_R_e) begin
        if (rdaddr_R_e < REUSE) begin
            in_valid_R_e <= 1;
            in_last_R_e <= 1;
            START_W_bias <= 1;
        end

        if (in_valid_R_e && in_ready_R_e) begin
            if (REUSE > 1) begin
                in_data_R_e <= mem_R_e[rdaddr_R_e + 1];
            end
            if (rdaddr_R_e < REUSE) begin
                rdaddr_R_e <= rdaddr_R_e + 1;
            end

            in_valid_R_e <= 0;
            in_last_R_e <= 0;
            START_R_e <= 0;
            $display("Done Sending requantization shifter R_e to Top Module at time=%0d", ctime);
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_ln_bias <= 0;
        in_last_ln_bias  <= 0;
        rdaddr_ln_bias   <= 0;
        in_data_ln_bias  <= mem_ln_bias[rdaddr_ln_bias];
    end else if(START_ln_bias) begin
        if (rdaddr_ln_bias < REUSE*M3-1) begin
            in_valid_ln_bias <= 1;
        end

        if (in_valid_ln_bias && in_ready_ln_bias) begin
            in_data_ln_bias <= mem_ln_bias[rdaddr_ln_bias + 1];
            if (rdaddr_ln_bias < REUSE*M3-1) begin
                rdaddr_ln_bias <= rdaddr_ln_bias + 1;
            end

           if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-2) begin
                in_last_ln_bias <= 1;
                START_out_m <= 1;
            end else if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-1) begin
                in_valid_ln_bias <= 0;
                in_last_ln_bias <= 0;
                START_ln_bias <= 0;
                $display("Done Sending LayerNorm bias ln_bias to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_out_m <= 0;
        in_last_out_m  <= 0;
        rdaddr_out_m   <= 0;
        in_data_out_m  <= mem_out_m[rdaddr_out_m];
    end else if(START_out_m) begin
        if (rdaddr_out_m < REUSE*M3-1) begin
            in_valid_out_m <= 1;
        end

        if (in_valid_out_m && in_ready_out_m) begin
            in_data_out_m <= mem_out_m[rdaddr_out_m + 1];
            if (rdaddr_out_m < REUSE*M3-1) begin
                rdaddr_out_m <= rdaddr_out_m + 1;
            end

            if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-2) begin
                in_last_out_m <= 1;
                START_out_e <= 1;
            end else if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-1) begin
                in_valid_out_m <= 0;
                in_last_out_m <= 0;
                START_out_m <= 0;
                $display("Done Sending requantization multiplier out_m to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_out_e <= 0;
        in_last_out_e  <= 0;
        rdaddr_out_e   <= 0;
        in_data_out_e  <= mem_out_e[rdaddr_out_e];
    end else if(START_out_e) begin
        if (rdaddr_out_e < REUSE*M3-1) begin
            in_valid_out_e <= 1;
        end

        if (in_valid_out_e && in_ready_out_e) begin
            in_data_out_e <= mem_out_e[rdaddr_out_e + 1];
            if (rdaddr_out_e < REUSE*M3-1) begin
                rdaddr_out_e <= rdaddr_out_e + 1;
            end

            if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-2) begin
                in_last_out_e <= 1;
            end else if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-1) begin
                in_valid_out_e <= 0;
                in_last_out_e <= 0;
                START_out_e <= 0;
                $display("Done Sending requantization shifter out_e to Top Module at time=%0d", ctime);
            end
        end
    end
end

// ############### //
// Receive Outputs //
// ############### //

always @(posedge clk) begin
    if (rst) begin
        wraddr_Y <= 0;
    end else begin
        if (mm_ln_test.Y.tvalid == 1'b1 &&
            mm_ln_test.Y.tready == 1'b1) begin
            wraddr_Y <= (wraddr_Y == REUSE*M1*M3-1) ? 0 : wraddr_Y + 1;
            mem_Y[wraddr_Y] <= mm_ln_test.Y.tdata;
            if (wraddr_Y == (M1*M3)*(wraddr_Y/(M1*M3))+M1*M3-1) begin
                $display("Done computing Y=X*W at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Y_req <= 0;
    end else begin
        if (mm_ln_test.Y_req.tvalid == 1'b1 &&
            mm_ln_test.Y_req.tready == 1'b1) begin
            wraddr_Y_req <= (wraddr_Y_req == REUSE*M1*M3-1) ? 0 : wraddr_Y_req + 1;
            mem_Y_req[wraddr_Y_req] <= mm_ln_test.Y_req.tdata;
            if (wraddr_Y_req == (M1*M3)*(wraddr_Y_req/(M1*M3))+M1*M3-1) begin
                $display("Done computing Y Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_R_req <= 0;
    end else begin
        if (mm_ln_test.R_req.tvalid == 1'b1 &&
            mm_ln_test.R_req.tready == 1'b1) begin
            wraddr_R_req <= (wraddr_R_req == REUSE*M1*M3-1) ? 0 : wraddr_R_req + 1;
            mem_R_req[wraddr_R_req] <= mm_ln_test.R_req.tdata;
            if (wraddr_R_req == (M1*M3)*(wraddr_R_req/(M1*M3))+M1*M3-1) begin
                $display("Done computing R Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Z <= 0;
    end else begin
        if (mm_ln_test.Z.tvalid == 1'b1 &&
            mm_ln_test.Z.tready == 1'b1) begin
            wraddr_Z <= (wraddr_Z == REUSE*M1*M3-1) ? 0 : wraddr_Z + 1;
            mem_Z[wraddr_Z] <= mm_ln_test.Z.tdata;
            if (wraddr_Z == (M1*M3)*(wraddr_Z/(M1*M3))+M1*M3-1) begin
                $display("Done computing matrix add Z = Y_req + R_req at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_ln_out <= 0;
    end else begin
        if (mm_ln_test.ln_out.tvalid == 1'b1 &&
            mm_ln_test.ln_out.tready == 1'b1) begin
            wraddr_ln_out <= (wraddr_ln_out == REUSE*M1*M3-1) ? 0 : wraddr_ln_out + 1;
            mem_ln_out[wraddr_ln_out] <= mm_ln_test.ln_out.tdata;
            if (wraddr_ln_out == (M1*M3)*(wraddr_ln_out/(M1*M3))+M1*M3-1) begin
                $display("Done computing LayerNorm at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_out <= 0;
        mm_ln_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_last) begin
            if (REUSE > 1) begin
                $display("-- Finished Layer %0d out of %0d at time=%0d.\n###\n", done_cntr + 1, REUSE, ctime);
            end
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE-1) begin
                mm_ln_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_out <= (wraddr_out == REUSE*M1*M3-1) ? 0 : wraddr_out + 1;
            mem_out[wraddr_out] <= out_data;
        end
    end
end

axi_stream_if X_if();
assign X_if.tdata = in_data_X;
assign X_if.tlast = in_last_X;
assign in_ready_X = X_if.tready;
assign X_if.tvalid = in_valid_X;

axi_stream_if W_if();
assign W_if.tdata = in_data_W;
assign W_if.tlast = in_last_W;
assign in_ready_W = W_if.tready;
assign W_if.tvalid = in_valid_W;

axi_stream_if W_bias_if();
assign W_bias_if.tdata = in_data_W_bias;
assign W_bias_if.tlast = in_last_W_bias;
assign in_ready_W_bias = W_bias_if.tready;
assign W_bias_if.tvalid = in_valid_W_bias;

axi_stream_if W_m_if();
assign W_m_if.tdata = in_data_W_m;
assign W_m_if.tlast = in_last_W_m;
assign in_ready_W_m = W_m_if.tready;
assign W_m_if.tvalid = in_valid_W_m;

axi_stream_if W_e_if();
assign W_e_if.tdata = in_data_W_e;
assign W_e_if.tlast = in_last_W_e;
assign in_ready_W_e = W_e_if.tready;
assign W_e_if.tvalid = in_valid_W_e;

axi_stream_if R_if();
assign R_if.tdata = in_data_R;
assign R_if.tlast = in_last_R;
assign in_ready_R = R_if.tready;
assign R_if.tvalid = in_valid_R;

axi_stream_if R_m_if();
assign R_m_if.tdata = in_data_R_m;
assign R_m_if.tlast = in_last_R_m;
assign in_ready_R_m = R_m_if.tready;
assign R_m_if.tvalid = in_valid_R_m;

axi_stream_if R_e_if();
assign R_e_if.tdata = in_data_R_e;
assign R_e_if.tlast = in_last_R_e;
assign in_ready_R_e = R_e_if.tready;
assign R_e_if.tvalid = in_valid_R_e;

axi_stream_if I_if();
assign I_if.tdata = in_data_R_e;
assign I_if.tlast = in_last_R_e;
assign in_ready_R_e = I_if.tready;
assign I_if.tvalid = in_valid_R_e;

axi_stream_if ln_bias_if();
assign ln_bias_if.tdata = in_data_ln_bias;
assign ln_bias_if.tlast = in_last_ln_bias;
assign in_ready_ln_bias = ln_bias_if.tready;
assign ln_bias_if.tvalid = in_valid_ln_bias;

axi_stream_if out_m_if();
assign out_m_if.tdata = in_data_out_m;
assign out_m_if.tlast = in_last_out_m;
assign in_ready_out_m = out_m_if.tready;
assign out_m_if.tvalid = in_valid_out_m;

axi_stream_if out_e_if();
assign out_e_if.tdata = in_data_out_e;
assign out_e_if.tlast = in_last_out_e;
assign in_ready_out_e = out_e_if.tready;
assign out_e_if.tvalid = in_valid_out_e;

axi_stream_if #(D_W) mm_ln_out_if();
assign out_data = mm_ln_out_if.tdata;
assign out_last = mm_ln_out_if.tlast;
assign mm_ln_out_if.tready = 1'b1;
assign out_valid = mm_ln_out_if.tvalid;

mm_ln
`ifndef XIL_TIMING
#(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LN_BITS(LN_BITS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .BLOCKED_A(1),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .MAT_ADD_MEM_DEPTH(MAT_ADD_MEM_DEPTH),
    .REQ_MEM_DEPTH(M3)
)
`endif
mm_ln_test (
    .clk(clk),
    .fclk(fclk),
    .rst(rst),

    .in_X(X_if),

    .in_W(W_if),
    .in_W_bias(W_bias_if),
    .in_W_m(W_m_if),
    .in_W_e(W_e_if),

    .in_R(R_if),
    .in_R_m(R_m_if),
    .in_R_e(R_e_if),

    .in_ln_bias(ln_bias_if),

    .in_out_m(out_m_if),
    .in_out_e(out_e_if),

    .mm_ln_out(mm_ln_out_if),

`ifndef XIL_TIMING
    .mm_dimensions(dimensions_tb)
`else
    .\mm_dimensions[M1] ( dimensions_tb.M1 ),
    .\mm_dimensions[M2] ( dimensions_tb.M2 ),
    .\mm_dimensions[M3] ( dimensions_tb.M3 ),
    .\mm_dimensions[M1xM3] ( dimensions_tb.M1xM3 ),
    .\mm_dimensions[M1xM3dN1] ( dimensions_tb.M1xM3dN1 ),
    .\mm_dimensions[M1dN1] ( dimensions_tb.M1dN1 ),
    .\mm_dimensions[M3dN2] ( dimensions_tb.M3dN2 ),
    .\mm_dimensions[M1xM3dN1xN2] ( dimensions_tb.M1xM3dN1xN2 )
`endif
);

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("mm_ln.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("mm_ln.vcd");
            $dumpvars(0,mm_ln_tb);
        end
    `endif
`endif

endmodule
/* verilator lint_on UNDRIVEN */
