
`timescale 1ps / 1ps
/* verilator lint_off UNDRIVEN */

module ibert_mm_gelu_tb
#(
    parameter integer D_W          = 8,
    parameter integer D_W_ACC      = 32,
    parameter integer M1           = 32,
    parameter integer M2           = 768,
    parameter integer M3           = 3072,
    parameter integer BLOCKS       = 1,
    parameter integer REUSE        = 1,
    parameter integer SLICES       = 1,
    parameter         DIR          = ""
)
(
    input wire clk,
    input wire rst,

    output wire                      in_valid,
    output wire signed [31:0]        in_data,
    input  wire                      in_ready,

    input  wire                      save_G,
    input  wire signed [31:0]        data_G,

    input  wire                      save_G_req,
    input  wire signed [31:0]        data_G_req,

    input  wire                      save_gelu_out,
    input  wire signed [31:0]        data_gelu_out,

    input  wire                      out_valid,
    input  wire signed [D_W-1:0]     out_data,
    input  wire                      out_last
);

reg axi_lite_done = 1'b1;

reg                       in_valid_A;
reg  signed [31:0]        in_data_A;
reg                       in_last_A;
reg                       in_ready_A;

reg                       in_valid_W;
reg  signed [31:0]        in_data_W;
reg                       in_last_W;
reg                       in_ready_W;

reg                       in_valid_W_bias;
reg  signed [31:0]        in_data_W_bias;
reg                       in_last_W_bias;
reg                       in_ready_W_bias;

reg                       in_valid_out_m;
reg  signed [31:0]        in_data_out_m;
reg                       in_last_out_m;
reg                       in_ready_out_m;

reg                       in_valid_out_e;
reg  signed [31:0]        in_data_out_e;
reg                       in_last_out_e;
reg                       in_ready_out_e;

//input memories
reg  signed [D_W_ACC-1:0] mem_A         [0:REUSE*SLICES*M1*M2-1];
reg  signed [D_W_ACC-1:0] mem_W         [0:REUSE*SLICES*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_bias    [0:REUSE*SLICES*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_m     [0:REUSE*SLICES-1];
reg  signed [D_W_ACC-1:0] mem_out_e     [0:REUSE*SLICES-1];

//output memories
reg  signed [D_W_ACC-1:0] mem_G         [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_G_req     [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_gelu_out  [0:REUSE*SLICES*M1*M3-1];
reg  signed [D_W-1:0]     mem_out       [0:REUSE*SLICES*M1*M3-1];

//read addresses
reg [$clog2(REUSE*SLICES*M1*M2):0] rdaddr_A;
reg [$clog2(REUSE*SLICES*M2*M3):0] rdaddr_W;
reg [$clog2(REUSE*SLICES*M3):0]    rdaddr_W_bias;
reg [$clog2(REUSE*SLICES):0]       rdaddr_out_m;
reg [$clog2(REUSE*SLICES):0]       rdaddr_out_e;

//write addresses
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_G;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_G_req;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_gelu_out;
reg [$clog2(REUSE*SLICES*M1*M3):0] wraddr_out;
reg [$clog2(REUSE*SLICES):0]       done_cntr;

reg mm_gelu_done;

initial begin
    $readmemh({DIR,"A_out.mem"}, mem_A);
    if (BLOCKS > 1) begin
        $readmemh({DIR,"W_pp.mem"}, mem_W);
    end else begin
        $readmemh({DIR,"W.mem"}, mem_W);
    end
    $readmemh({DIR,"W_bias.mem"}, mem_W_bias);
    $readmemh({DIR,"out_m.mem"}, mem_out_m);
    $readmemh({DIR,"out_e.mem"}, mem_out_e);
end

final begin
    $writememh({DIR,"tb_G.mem"}, mem_G);
    $writememh({DIR,"tb_G_req.mem"}, mem_G_req);
    $writememh({DIR,"tb_gelu_out.mem"}, mem_gelu_out);
    $writememh({DIR,"tb_out.mem"}, mem_out);
end

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
end

// assign in_valid = (in_ready_A)       ? in_valid_A       :
assign in_valid = (in_ready_W_bias)  ? in_valid_W_bias  :
                  (in_ready_out_m)   ? in_valid_out_m   :
                  (in_ready_out_e)   ? in_valid_out_e   :
                  (in_ready_W)       ? in_valid_W       : 0;

// assign in_data = (in_valid_A)      ? in_data_A      :
assign in_data = (in_valid_W_bias) ? in_data_W_bias :
                 (in_valid_out_m)  ? in_data_out_m  :
                 (in_valid_out_e)  ? in_data_out_e  :
                 (in_valid_W)      ? in_data_W      : 0;

always @(posedge clk) begin
    if (rst) begin
        in_ready_A <= 0;
        in_ready_W_bias <= 1;
        in_ready_out_m <= 0;
        in_ready_out_e <= 0;
        in_ready_W <= 0;
    end else begin
        if (in_ready && in_ready_A && in_last_A) begin
            in_ready_A <= 0;
            in_ready_W_bias <= 1;
        end
        if (in_ready && in_ready_W_bias && in_last_W_bias) begin
            in_ready_W_bias <= 0;
            in_ready_out_m <= 1;
        end
        if (in_ready && in_ready_out_m && in_last_out_m) begin
            in_ready_out_m <= 0;
            in_ready_out_e <= 1;
        end
        if (in_ready && in_ready_out_e && in_last_out_e) begin
            in_ready_out_e <= 0;
            in_ready_W <= 1;
        end
        if (in_ready && in_ready_W && in_last_W) begin
            in_ready_W <= 0;
            if (REUSE*SLICES > 1) begin
                // in_ready_A <= 1;
                in_ready_W_bias <= 1;
            end
        end
    end
end

// ############## //
// Sending Inputs //
// ############## //

always @(posedge clk) begin
    if (rst) begin
        in_valid_A <= 0;
        in_last_A  <= 0;
        rdaddr_A   <= 0;
        in_data_A  <= mem_A[rdaddr_A];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_A && rdaddr_A < REUSE*SLICES*M1*M2-1) begin
                in_valid_A <= 1;
            end

            if (in_valid_A && in_ready_A && in_ready) begin
                in_data_A <= mem_A[rdaddr_A + 1];
                if (rdaddr_A < REUSE*SLICES*M1*M2-1) begin
                    rdaddr_A <= rdaddr_A + 1;
                end

                if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-2) begin
                    in_last_A <= 1;
                end else if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-1) begin
                    in_valid_A <= 0;
                    in_last_A <= 0;
                    $display("mm_gelu: Done Sending input A to Top Module at time=%0d", ctime);
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
                    $display("mm_gelu: Done Sending weight W to Top Module at time=%0d", ctime);
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
                    $display("mm_gelu: Done Sending bias W_bias to Top Module at time=%0d", ctime);
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
            if (in_ready_out_m && rdaddr_out_m < REUSE*SLICES) begin
                in_valid_out_m <= 1;
                in_last_out_m <= 1;
            end

            if (in_valid_out_m && in_ready_out_m && in_ready) begin
                if (REUSE*SLICES > 1) begin
                    in_data_out_m <= mem_out_m[rdaddr_out_m + 1];
                end
                if (rdaddr_out_m < REUSE*SLICES) begin
                    rdaddr_out_m <= rdaddr_out_m + 1;
                end

                in_valid_out_m <= 0;
                in_last_out_m <= 0;
                $display("mm_gelu: Done Sending requantization multiplier out_m to Top Module at time=%0d", ctime);
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
            if (in_ready_out_e && rdaddr_out_e < REUSE*SLICES) begin
                in_valid_out_e <= 1;
                in_last_out_e <= 1;
            end

            if (in_valid_out_e && in_ready_out_e && in_ready) begin
                if (REUSE*SLICES > 1) begin
                    in_data_out_e <= mem_out_e[rdaddr_out_e + 1];
                end
                if (rdaddr_out_e < REUSE*SLICES) begin
                    rdaddr_out_e <= rdaddr_out_e + 1;
                end

                in_valid_out_e <= 0;
                in_last_out_e <= 0;
                $display("mm_gelu: Done Sending requantization shifter out_e to Top Module at time=%0d", ctime);
            end
        end
    end
end

// ############### //
// Receive Outputs //
// ############### //

always @(posedge clk) begin
    if (rst) begin
        wraddr_G <= 0;
    end else begin
	    if (save_G) begin
            wraddr_G <= (wraddr_G == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_G + 1;
            mem_G[wraddr_G] <= data_G;
            if (wraddr_G == (M1*M3)*(wraddr_G/(M1*M3))+M1*M3-1) begin
                $display("mm_gelu: Done computing G=A*W at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_G_req <= 0;
    end else begin
	    if (save_G_req) begin
            wraddr_G_req <= (wraddr_G_req == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_G_req + 1;
            mem_G_req[wraddr_G_req] <= data_G_req;
            if (wraddr_G_req == (M1*M3)*(wraddr_G_req/(M1*M3))+M1*M3-1) begin
                $display("mm_gelu: Done computing G Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_gelu_out <= 0;
    end else begin
	    if (save_gelu_out) begin
            wraddr_gelu_out <= (wraddr_gelu_out == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_gelu_out + 1;
            mem_gelu_out[wraddr_gelu_out] <= data_gelu_out;
            if (wraddr_gelu_out == (M1*M3)*(wraddr_gelu_out/(M1*M3))+M1*M3-1) begin
                $display("mm_gelu: Done computing GELU at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_out <= 0;
        mm_gelu_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_last) begin
            $display("mm_gelu: -- Finished mm_gelu %0d out of %0d at time=%0d.\n###", done_cntr + 1, REUSE*SLICES, ctime);
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE*SLICES-1) begin
                mm_gelu_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_out <= (wraddr_out == REUSE*SLICES*M1*M3-1) ? 0 : wraddr_out + 1;
            mem_out[wraddr_out] <= out_data;
        end
    end
end

endmodule
/* verilator lint_off UNDRIVEN */
