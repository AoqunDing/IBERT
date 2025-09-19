
`timescale 1ps / 1ps
/* verilator lint_off UNDRIVEN */

module ibert_mm_ln_tb
#(
    parameter integer D_W               = 8,
    parameter integer D_W_ACC           = 32,
    parameter integer M1                = 32,
    parameter integer M2                = 768,
    parameter integer M3                = 768,
    parameter integer BLOCKS            = 1,
    parameter integer REUSE             = 1,
    parameter integer SLICES            = 1,
    parameter         DIR               = ""
)
(
    input wire clk,
    input wire rst,

    output wire                      in_valid,
    output wire signed [31:0]        in_data,
    input  wire                      in_ready,

    input  wire                      save_Y,
    input  wire signed [31:0]        data_Y,

    input  wire                      save_Y_req,
    input  wire signed [31:0]        data_Y_req,

    input  wire                      save_R_req,
    input  wire signed [31:0]        data_R_req,

    input  wire                      save_Z,
    input  wire signed [31:0]        data_Z,

    input  wire                      save_ln_out,
    input  wire signed [31:0]        data_ln_out,

    input  wire                      out_valid,
    input  wire signed [D_W-1:0]     out_data,
    input  wire                      out_last
);

reg axi_lite_done = 1'b1;

reg                       in_valid_X;
reg  signed [31:0]        in_data_X;
reg                       in_last_X;
reg                       in_ready_X;

reg                       in_valid_W;
reg  signed [31:0]        in_data_W;
reg                       in_last_W;
reg                       in_ready_W;

reg                       in_valid_W_bias;
reg  signed [31:0]        in_data_W_bias;
reg                       in_last_W_bias;
reg                       in_ready_W_bias;

reg                       in_valid_W_m;
reg  signed [31:0]        in_data_W_m;
reg                       in_last_W_m;
reg                       in_ready_W_m;

reg                       in_valid_W_e;
reg  signed [31:0]        in_data_W_e;
reg                       in_last_W_e;
reg                       in_ready_W_e;

reg                       in_valid_R;
reg  signed [31:0]        in_data_R;
reg                       in_last_R;
reg                       in_ready_R;

reg                       in_valid_R_m;
reg  signed [31:0]        in_data_R_m;
reg                       in_last_R_m;
reg                       in_ready_R_m;

reg                       in_valid_R_e;
reg  signed [31:0]        in_data_R_e;
reg                       in_last_R_e;
reg                       in_ready_R_e;

reg                       in_valid_ln_bias;
reg  signed [31:0]        in_data_ln_bias;
reg                       in_last_ln_bias;
reg                       in_ready_ln_bias;

reg                       in_valid_out_m;
reg  signed [31:0]        in_data_out_m;
reg                       in_last_out_m;
reg                       in_ready_out_m;

reg                       in_valid_out_e;
reg  signed [31:0]        in_data_out_e;
reg                       in_last_out_e;
reg                       in_ready_out_e;

//input memories
reg  signed [D_W_ACC-1:0] mem_X         [0:REUSE*SLICES*M1*M2-1];
reg  signed [D_W_ACC-1:0] mem_W         [0:REUSE*SLICES*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_R         [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_bias    [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_m       [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_e       [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_R_m       [0:REUSE*SLICES-1];
reg  signed [D_W_ACC-1:0] mem_R_e       [0:REUSE*SLICES-1];
reg  signed [D_W_ACC-1:0] mem_ln_bias   [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_m     [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_e     [0:REUSE*SLICES*M3-1];

//output memories
reg  signed [D_W_ACC-1:0] mem_Y         [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_Y_req     [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_R_req     [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_Z         [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_ln_out    [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W-1:0]     mem_out       [0:REUSE*SLICES*M1*M3-1];

//read addresses
reg [$clog2(REUSE*SLICES*M1*M2):0] rdaddr_X;
reg [$clog2(REUSE*SLICES*M2*M3):0] rdaddr_W;
reg [$clog2(REUSE*SLICES*M1*M3):0] rdaddr_R;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_W_bias;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_W_m;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_W_e;
reg [$clog2(REUSE*SLICES):0]       rdaddr_R_m;
reg [$clog2(REUSE*SLICES):0]       rdaddr_R_e;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_ln_bias;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_out_m;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_out_e;

//write addresses
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_Y;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_Y_req;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_R_req;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_Z;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_ln_out;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_out;
reg [$clog2(REUSE*SLICES):0]       done_cntr;
reg [$clog2(SLICES):0]             slice_cntr;

reg mm_ln_done;

initial begin
    if (M2 == 3072) begin
        $readmemh({DIR,"G_out.mem"}, mem_X);
        $readmemh({DIR,"A_out.mem"}, mem_R);
    end else begin
        $readmemh({DIR,"C.mem"}, mem_X);
        $readmemh({DIR,"I.mem"}, mem_R);
    end
    if (BLOCKS > 1) begin
        $readmemh({DIR,"W_pp.mem"}, mem_W);
    end else begin
        $readmemh({DIR,"W.mem"}, mem_W);
    end
    $readmemh({DIR,"W_bias.mem"}, mem_W_bias);
    $readmemh({DIR,"W_m.mem"}, mem_W_m);
    $readmemh({DIR,"W_e.mem"}, mem_W_e);
    $readmemh({DIR,"R_m.mem"}, mem_R_m);
    $readmemh({DIR,"R_e.mem"}, mem_R_e);
    $readmemh({DIR,"ln_bias.mem"}, mem_ln_bias);
    $readmemh({DIR,"out_m.mem"}, mem_out_m);
    $readmemh({DIR,"out_e.mem"}, mem_out_e);
end

final begin
    $writememh({DIR,"tb_Y.mem"}, mem_Y);
    $writememh({DIR,"tb_Y_req.mem"}, mem_Y_req);
    $writememh({DIR,"tb_R_req.mem"}, mem_R_req);
    $writememh({DIR,"tb_Z.mem"}, mem_Z);
    $writememh({DIR,"tb_ln_out.mem"}, mem_ln_out);
    $writememh({DIR,"tb_out.mem"}, mem_out);
end

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
end

assign in_valid = (M2 == 768 && in_ready_X)       ? in_valid_X       :
                  (in_ready_W)       ? in_valid_W       :
                  (in_ready_R_m)     ? in_valid_R_m     :
                  (in_ready_R_e)     ? in_valid_R_e     :
                  (M2 == 768 && in_ready_R)       ? in_valid_R       :
                  (in_ready_W_bias)  ? in_valid_W_bias  :
                  (in_ready_W_m)     ? in_valid_W_m     :
                  (in_ready_W_e)     ? in_valid_W_e     :
                  (in_ready_ln_bias) ? in_valid_ln_bias :
                  (in_ready_out_m)   ? in_valid_out_m   :
                  (in_ready_out_e)   ? in_valid_out_e   : 0;

assign in_data = (M2 == 768 && in_valid_X)       ? in_data_X       :
                 (in_valid_W)       ? in_data_W       :
                 (in_valid_R_m)     ? in_data_R_m     :
                 (in_valid_R_e)     ? in_data_R_e     :
                 (M2 == 768 && in_valid_R)       ? in_data_R       :
                 (in_valid_W_bias)  ? in_data_W_bias  :
                 (in_valid_W_m)     ? in_data_W_m     :
                 (in_valid_W_e)     ? in_data_W_e     :
                 (in_valid_ln_bias) ? in_data_ln_bias :
                 (in_valid_out_m)   ? in_data_out_m   :
                 (in_valid_out_e)   ? in_data_out_e   : 0;

always @(posedge clk) begin
    if (rst) begin
        if (M2 == 768) begin
            // in_ready_X <= 1; // mm_ln_axis
            // in_ready_W <= 0; // mm_ln_axis
            in_ready_X <= 0;    // mm_ln_on_axis
            in_ready_W <= 1;    // mm_ln_on_axis
        end else if (M2 == 3072) begin
            in_ready_X <= 0;
            in_ready_W <= 1;
        end
        in_ready_R_m <= 0;
        in_ready_R_e <= 0;
        in_ready_R <= 0;
        in_ready_W_bias <= 0;
        in_ready_W_m <= 0;
        in_ready_W_e <= 0;
        in_ready_ln_bias <= 0;
        in_ready_out_m <= 0;
        in_ready_out_e <= 0;
        slice_cntr <= 0;
    end else begin
        if (in_ready && in_ready_X && in_last_X) begin
            in_ready_X <= 0;
            in_ready_W <= 1;
        end
        if (in_ready && in_ready_W && in_last_W) begin
            in_ready_W <= 0;
            in_ready_R_m <= 1;
        end
        if (in_ready && in_ready_R_m && in_last_R_m) begin
            in_ready_R_m <= 0;
            in_ready_R_e <= 1;
        end
        if (in_ready && in_ready_R_e && in_last_R_e) begin
            in_ready_R_e <= 0;
            if (M2 == 768) begin
                // in_ready_R <= 1;     // mm_ln_axis
                in_ready_W_bias <= 1;   // mm_ln_r_axis
            end else if (M2 == 3072) begin
                in_ready_W_bias <= 1;
            end
        end
        if (M2 == 768 && in_ready && in_ready_R && in_last_R) begin
            in_ready_R <= 0;
            in_ready_W_bias <= 1;
        end
        if (in_ready && in_ready_W_bias && in_last_W_bias) begin
            in_ready_W_bias <= 0;
            in_ready_W_m <= 1;
        end
        if (in_ready && in_ready_W_m && in_last_W_m) begin
            in_ready_W_m <= 0;
            in_ready_W_e <= 1;
        end
        if (in_ready && in_ready_W_e && in_last_W_e) begin
            in_ready_W_e <= 0;
            in_ready_ln_bias <= 1;
        end
        if (in_ready && in_ready_ln_bias && in_last_ln_bias) begin
            in_ready_ln_bias <= 0;
            in_ready_out_m <= 1;
        end
        if (in_ready && in_ready_out_m && in_last_out_m) begin
            in_ready_out_m <= 0;
            in_ready_out_e <= 1;
        end
        if (in_ready && in_ready_out_e && in_last_out_e) begin
            in_ready_out_e <= 0;
            if (SLICES > 1) begin
                slice_cntr <= (slice_cntr == SLICES-1) ? 0 : slice_cntr + 1;
            end
            if (REUSE*SLICES > 1) begin
                if (M2 == 768) begin
                    // in_ready_X <= 1;    // mm_ln_axis
                    in_ready_W <= 1;    // mm_ln_on_axis
                end else if (M2 == 3072) begin
                    in_ready_W <= 1;
                end
            end
        end
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
        if (axi_lite_done) begin
            if (in_ready_X && rdaddr_X < REUSE*SLICES*M1*M2-1) begin
                in_valid_X <= 1;
            end

            if (in_valid_X && in_ready_X && in_ready) begin
                in_data_X <= mem_X[rdaddr_X + 1];
                if (rdaddr_X < REUSE*SLICES*M1*M2-1) begin
                    rdaddr_X <= rdaddr_X + 1;
                end

                if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-2) begin
                    in_last_X <= 1;
                end else if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-1) begin
                    in_valid_X <= 0;
                    in_last_X <= 0;
                    $display("mm_ln: Done Sending input X to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W && rdaddr_W < REUSE*SLICES*M2*M3-1) begin
                in_valid_W <= 1;
            end

            if (in_valid_W && in_ready_W && in_ready) begin
                in_data_W <= mem_W[rdaddr_W + 1];
                if (rdaddr_W < REUSE*SLICES*M2*M3-1) begin
                    rdaddr_W <= rdaddr_W + 1;
                end

                if (rdaddr_W == (M2*M3)*(rdaddr_W/(M2*M3))+M2*M3-2) begin
                    in_last_W <= 1;
                end else if (rdaddr_W == (M2*M3)*(rdaddr_W/(M2*M3))+M2*M3-1) begin
                    in_valid_W <= 0;
                    in_last_W <= 0;
                    $display("mm_ln: Done Sending weight W to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_R && rdaddr_R < REUSE*SLICES*M1*M3-1) begin
                in_valid_R <= 1;
            end

            if (in_valid_R && in_ready_R && in_ready) begin
                in_data_R <= mem_R[rdaddr_R + 1];
                if (rdaddr_R < REUSE*SLICES*M1*M3-1) begin
                    rdaddr_R <= rdaddr_R + 1;
                end

                if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-2) begin
                    in_last_R <= 1;
                end else if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-1) begin
                    in_valid_R <= 0;
                    in_last_R <= 0;
                    $display("mm_ln: Done Sending residual input R to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_bias && rdaddr_W_bias < REUSE*SLICES*M3-1) begin
                in_valid_W_bias <= 1;
            end

            if (in_valid_W_bias && in_ready_W_bias && in_ready) begin
                in_data_W_bias <= mem_W_bias[rdaddr_W_bias + 1];
                if (rdaddr_W_bias < REUSE*SLICES*M3-1) begin
                    rdaddr_W_bias <= rdaddr_W_bias + 1;
                end

                if (rdaddr_W_bias == M3*(rdaddr_W_bias/M3)+M3-2) begin
                    in_last_W_bias <= 1;
                end else if (rdaddr_W_bias == M3*(rdaddr_W_bias/M3)+M3-1) begin
                    in_valid_W_bias <= 0;
                    in_last_W_bias <= 0;
                    $display("mm_ln: Done Sending bias W_bias to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_m && rdaddr_W_m < REUSE*SLICES*M3-1) begin
                in_valid_W_m <= 1;
            end

            if (in_valid_W_m && in_ready_W_m && in_ready) begin
                in_data_W_m <= mem_W_m[rdaddr_W_m + 1];
                if (rdaddr_W_m < REUSE*SLICES*M3-1) begin
                    rdaddr_W_m <= rdaddr_W_m + 1;
                end

                if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-2) begin
                    in_last_W_m <= 1;
                end else if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-1) begin
                    in_valid_W_m <= 0;
                    in_last_W_m <= 0;
                    $display("mm_ln: Done Sending requantization multiplier W_m to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_e && rdaddr_W_e < REUSE*SLICES*M3-1) begin
                in_valid_W_e <= 1;
            end

            if (in_valid_W_e && in_ready_W_e && in_ready) begin
                in_data_W_e <= mem_W_e[rdaddr_W_e + 1];
                if (rdaddr_W_e < REUSE*SLICES*M3-1) begin
                    rdaddr_W_e <= rdaddr_W_e + 1;
                end

                if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-2) begin
                    in_last_W_e <= 1;
                end else if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-1) begin
                    in_valid_W_e <= 0;
                    in_last_W_e <= 0;
                    $display("mm_ln: Done Sending requantization shifter W_e to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_R_m && rdaddr_R_m < REUSE*SLICES) begin
                in_valid_R_m <= 1;
                in_last_R_m <= 1;
            end

            if (in_valid_R_m && in_ready_R_m && in_ready) begin
                if (REUSE*SLICES > 1) begin
                    in_data_R_m <= mem_R_m[rdaddr_R_m + 1];
                end
                if (rdaddr_R_m < REUSE*SLICES) begin
                    rdaddr_R_m <= rdaddr_R_m + 1;
                end

                in_valid_R_m <= 0;
                in_last_R_m <= 0;
                $display("mm_ln: Done Sending requantization multiplier R_m to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_R_e <= 0;
        in_last_R_e  <= 0;
        rdaddr_R_e   <= 0;
        in_data_R_e  <= mem_R_e[rdaddr_R_e];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_R_e && rdaddr_R_e < REUSE*SLICES) begin
                in_valid_R_e <= 1;
                in_last_R_e <= 1;
            end

            if (in_valid_R_e && in_ready_R_e && in_ready) begin
                if (REUSE*SLICES > 1) begin
                    in_data_R_e <= mem_R_e[rdaddr_R_e + 1];
                end
                if (rdaddr_R_e < REUSE*SLICES) begin
                    rdaddr_R_e <= rdaddr_R_e + 1;
                end

                in_valid_R_e <= 0;
                in_last_R_e <= 0;
                $display("mm_ln: Done Sending requantization shifter R_e to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_ln_bias <= 0;
        in_last_ln_bias  <= 0;
        rdaddr_ln_bias   <= 0;
        in_data_ln_bias  <= mem_ln_bias[rdaddr_ln_bias];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_ln_bias && rdaddr_ln_bias < REUSE*SLICES*M3-1) begin
                in_valid_ln_bias <= 1;
            end

            if (in_valid_ln_bias && in_ready_ln_bias && in_ready) begin
                in_data_ln_bias <= mem_ln_bias[rdaddr_ln_bias + 1];
                if (rdaddr_ln_bias < REUSE*SLICES*M3-1) begin
                    rdaddr_ln_bias <= rdaddr_ln_bias + 1;
                end

                if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-2) begin
                    in_last_ln_bias <= 1;
                end else if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-1) begin
                    in_valid_ln_bias <= 0;
                    in_last_ln_bias <= 0;
                    $display("mm_ln: Done Sending LayerNorm bias ln_bias to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_out_m && rdaddr_out_m < REUSE*SLICES*M3-1) begin
                in_valid_out_m <= 1;
            end

            if (in_valid_out_m && in_ready_out_m && in_ready) begin
                in_data_out_m <= mem_out_m[rdaddr_out_m + 1];
                if (rdaddr_out_m < REUSE*SLICES*M3-1) begin
                    rdaddr_out_m <= rdaddr_out_m + 1;
                end

                if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-2) begin
                    in_last_out_m <= 1;
                end else if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-1) begin
                    in_valid_out_m <= 0;
                    in_last_out_m <= 0;
                    $display("mm_ln: Done Sending requantization multiplier out_m to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_out_e && rdaddr_out_e < REUSE*SLICES*M3-1) begin
                in_valid_out_e <= 1;
            end

            if (in_valid_out_e && in_ready_out_e && in_ready) begin
                in_data_out_e <= mem_out_e[rdaddr_out_e + 1];
                if (rdaddr_out_e < REUSE*SLICES*M3-1) begin
                    rdaddr_out_e <= rdaddr_out_e + 1;
                end

                if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-2) begin
                    in_last_out_e <= 1;
                end else if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-1) begin
                    in_valid_out_e <= 0;
                    in_last_out_e <= 0;
                    $display("mm_ln: Done Sending requantization shifter out_e to Top Module at time=%0d", ctime);
                end
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
	    if (save_Y) begin
            wraddr_Y <= (wraddr_Y == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_Y + 1;
            mem_Y[wraddr_Y] <= data_Y;
            if (wraddr_Y == (M1*M3)*(wraddr_Y/(M1*M3))+M1*M3-1) begin
                $display("mm_ln: Done computing Y=X*W at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Y_req <= 0;
    end else begin
	    if (save_Y_req) begin
            wraddr_Y_req <= (wraddr_Y_req == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_Y_req + 1;
            mem_Y_req[wraddr_Y_req] <= data_Y_req;
            if (wraddr_Y_req == (M1*M3)*(wraddr_Y_req/(M1*M3))+M1*M3-1) begin
                $display("mm_ln: Done computing Y Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_R_req <= 0;
    end else begin
	    if (save_R_req) begin
            wraddr_R_req <= (wraddr_R_req == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_R_req + 1;
            mem_R_req[wraddr_R_req] <= data_R_req;
            if (wraddr_R_req == (M1*M3)*(wraddr_R_req/(M1*M3))+M1*M3-1) begin
                $display("mm_ln: Done computing R Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Z <= 0;
    end else begin
	    if (save_Z) begin
            wraddr_Z <= (wraddr_Z == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_Z + 1;
            mem_Z[wraddr_Z] <= data_Z;
            if (wraddr_Z == (M1*M3)*(wraddr_Z/(M1*M3))+M1*M3-1) begin
                $display("mm_ln: Done computing matrix add Z = Y_req + R_req at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_ln_out <= 0;
    end else begin
	    if (save_ln_out) begin
            wraddr_ln_out <= (wraddr_ln_out == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_ln_out + 1;
            mem_ln_out[wraddr_ln_out] <= data_ln_out;
            if (wraddr_ln_out == (M1*M3)*(wraddr_ln_out/(M1*M3))+M1*M3-1) begin
                $display("mm_ln: Done computing LayerNorm at time=%0d", ctime);
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
            $display("mm_ln: -- Finished mm_ln Layer %0d out of %0d at time=%0d.\n###", done_cntr + 1, REUSE*SLICES, ctime);
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE*SLICES-1) begin
                mm_ln_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_out <= (wraddr_out == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_out + 1;
            mem_out[wraddr_out] <= out_data;
        end
    end
end

endmodule
/* verilator lint_on UNDRIVEN */
