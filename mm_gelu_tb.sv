`include "names.h"

`timescale 1ps / 1ps
import dims::*;
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
module mm_gelu_tb
`endif
#(
    parameter integer D_W          = 8,
    parameter integer D_W_ACC      = 32,
    parameter integer M1           = 32,
    parameter integer M2           = 768,
    parameter integer M3           = 3072,
    parameter integer N1           = 4,
    parameter integer N2           = 4,
    parameter integer LAYERS       = 12,
    parameter integer MATRIXSIZE_W = 24,
    parameter integer MEM_DEPTH_A  = 6144,
    parameter integer MEM_DEPTH_B  = 147456,
    parameter integer MEM_DEPTH_D  = 6144,
    parameter integer BLOCKS       = 1,
    parameter         BLOCKED_D    = 0,
    parameter integer LAYER        = 0,
    parameter integer REUSE        = 1,
    parameter integer SLICES       = 1
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

reg  [$clog2(LAYERS)-1:0] layer;
reg  [$clog2(SLICES):0]   slice_cntr;

reg                       in_valid_A;
reg  signed [31:0]        in_data_A;
reg                       in_last_A;
wire                      in_ready_A;

reg                       in_valid_W;
reg  signed [31:0]        in_data_W;
reg                       in_last_W;
wire                      in_ready_W;

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

wire                      out_valid;
wire signed [D_W-1:0]     out_data;
wire                      out_last;
reg                       mm_gelu_done;

//input memories
reg  signed [D_W_ACC-1:0] mem_A         [0:REUSE*M1*M2-1];
reg  signed [D_W_ACC-1:0] mem_W         [0:REUSE*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_bias    [0:REUSE*M3-1];
reg  signed [D_W_ACC-1:0] mem_out_m     [0:REUSE-1];
reg  signed [D_W_ACC-1:0] mem_out_e     [0:REUSE-1];

//output memories
reg  signed [D_W_ACC-1:0] mem_G         [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_G_req     [0:REUSE*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_gelu_out  [0:REUSE*M1*M3-1];
reg  signed [D_W-1:0]     mem_out       [0:REUSE*M1*M3-1];

//read addresses
reg [$clog2(REUSE*M1*M2):0] rdaddr_A;
reg [$clog2(REUSE*M2*M3):0] rdaddr_W;
reg [$clog2(REUSE*M3):0]    rdaddr_W_bias;
reg [$clog2(REUSE):0]       rdaddr_out_m;
reg [$clog2(REUSE):0]       rdaddr_out_e;

//write addresses
reg [$clog2(REUSE*M1*M3):0]  wraddr_G;
reg [$clog2(REUSE*M1*M3):0]  wraddr_G_req;
reg [$clog2(REUSE*M1*M3):0]  wraddr_gelu_out;
reg [$clog2(REUSE*M1*M3):0]  wraddr_out;
reg [$clog2(BLOCKS*REUSE):0] done_cntr;

initial begin
    $readmemh({`DIR,"A_out.mem"}, mem_A);
    if (BLOCKS > 1) begin
        $readmemh({`DIR,"W_pp.mem"}, mem_W);
    end else begin
        $readmemh({`DIR,"W.mem"}, mem_W);
    end
    $readmemh({`DIR,"W_bias.mem"}, mem_W_bias);
    $readmemh({`DIR,"out_m.mem"}, mem_out_m);
    $readmemh({`DIR,"out_e.mem"}, mem_out_e);
end

final begin
    $writememh({`DIR,"tb_G.mem"}, mem_G);
    $writememh({`DIR,"tb_G_req.mem"}, mem_G_req);
    $writememh({`DIR,"tb_gelu_out.mem"}, mem_gelu_out);
    $writememh({`DIR,"tb_out.mem"}, mem_out);
end

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
    if (ctime % (M1*M2*32) == 0) begin
        $display("...");
    end
    if (ctime > REP) begin
        $display("Error: Timed out!");
        $finish;
    end
    if (mm_gelu_done) begin
        $finish;
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
        if (rdaddr_A < REUSE*M1*M2-1) begin
            in_valid_A <= 1;
        end

        if (in_valid_A && in_ready_A) begin
            in_data_A <= mem_A[rdaddr_A + 1];
            if (rdaddr_A < REUSE*M1*M2-1) begin
                rdaddr_A <= rdaddr_A + 1;
            end

            if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-2) begin
                in_last_A <= 1;
            end else if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-1) begin
                in_valid_A <= 0;
                in_last_A <= 0;
                $display("Done Sending input A to Top Module at time=%0d", ctime);
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
            end else if (rdaddr_W == (M2*M3)*(rdaddr_W/(M2*M3))+M2*M3-1) begin
                in_valid_W <= 0;
                in_last_W <= 0;
                $display("Done Sending weight W to Top Module at time=%0d", ctime);
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
            end else if (rdaddr_W_bias == M3*(rdaddr_W_bias/M3)+M3-1) begin
                in_valid_W_bias <= 0;
                in_last_W_bias <= 0;
                $display("Done Sending bias W_bias to Top Module at time=%0d", ctime);
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
        if (rdaddr_out_m < REUSE) begin
            in_valid_out_m <= 1;
            in_last_out_m <= 1;
        end

        if (in_valid_out_m && in_ready_out_m) begin
            if (REUSE > 1) begin
                in_data_out_m <= mem_out_m[rdaddr_out_m + 1];
            end
            if (rdaddr_out_m < REUSE) begin
                rdaddr_out_m <= rdaddr_out_m + 1;
            end

            in_valid_out_m <= 0;
            in_last_out_m <= 0;
            $display("Done Sending requantization multiplier out_m to Top Module at time=%0d", ctime);
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
        if (rdaddr_out_e < REUSE) begin
            in_valid_out_e <= 1;
            in_last_out_e <= 1;
        end

        if (in_valid_out_e && in_ready_out_e) begin
            if (REUSE > 1) begin
                in_data_out_e <= mem_out_e[rdaddr_out_e + 1];
            end
            if (rdaddr_out_e < REUSE) begin
                rdaddr_out_e <= rdaddr_out_e + 1;
            end

            in_valid_out_e <= 0;
            in_last_out_e <= 0;
            $display("Done Sending requantization shifter out_e to Top Module at time=%0d", ctime);
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
	    if (mm_gelu_test.G.tvalid == 1'b1 &&
            mm_gelu_test.G.tready == 1'b1) begin
            wraddr_G <= (wraddr_G == REUSE*M1*M3-1) ? 0 : wraddr_G + 1;
            mem_G[wraddr_G] <= mm_gelu_test.G.tdata;
            if (wraddr_G == (M1*M3)*(wraddr_G/(M1*M3))+M1*M3-1) begin
                $display("Done computing G=A*W at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_G_req <= 0;
    end else begin
	    if (mm_gelu_test.G_req.tvalid == 1'b1 &&
            mm_gelu_test.G_req.tready == 1'b1) begin
            wraddr_G_req <= (wraddr_G_req == REUSE*M1*M3-1) ? 0 : wraddr_G_req + 1;
            mem_G_req[wraddr_G_req] <= mm_gelu_test.G_req.tdata;
            if (wraddr_G_req == (M1*M3)*(wraddr_G_req/(M1*M3))+M1*M3-1) begin
                $display("Done computing G Requantization at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_gelu_out <= 0;
    end else begin
	    if (mm_gelu_test.gelu_out.tvalid == 1'b1 &&
            mm_gelu_test.gelu_out.tready == 1'b1) begin
            wraddr_gelu_out <= (wraddr_gelu_out == REUSE*M1*M3-1) ? 0 : wraddr_gelu_out + 1;
            mem_gelu_out[wraddr_gelu_out] <= mm_gelu_test.gelu_out.tdata;
            if (wraddr_gelu_out == (M1*M3)*(wraddr_gelu_out/(M1*M3))+M1*M3-1) begin
                $display("Done computing GELU at time=%0d", ctime);
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
            $display("-- Finished Layer %0d out of %0d at time=%0d.\n###\n", done_cntr + 1, REUSE, ctime);
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE-1) begin
                mm_gelu_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_out <= (wraddr_out == REUSE*M1*M3-1) ? 0 : wraddr_out + 1;
            mem_out[wraddr_out] <= out_data;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        layer <= LAYER;
        slice_cntr <= 0;
    end else begin
        if (out_valid && out_last) begin
            slice_cntr <= slice_cntr + 1;
            $display("Finished Slice %0d out of %0d at time=%0d.", slice_cntr, SLICES, ctime);
            if (slice_cntr == SLICES-1) begin
                slice_cntr <= 0;
                layer <= layer + 1;
                $display("Finished Layer %0d out of %0d at time=%0d.", layer, LAYERS, ctime);
                if (layer == LAYERS-1) begin
                    layer <= 0;
                end
            end
        end
    end
end


axi_stream_if A_if();
assign A_if.tdata = in_data_A;
assign A_if.tlast = in_last_A;
assign in_ready_A = A_if.tready;
assign A_if.tvalid = in_valid_A;

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

axi_stream_if mm_gelu_out_if();
assign out_data = mm_gelu_out_if.tdata;
assign out_last = mm_gelu_out_if.tlast;
assign mm_gelu_out_if.tready = 1'b1;
assign out_valid = mm_gelu_out_if.tvalid;

mm_gelu
`ifndef XIL_TIMING
#(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LAYERS(LAYERS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .BLOCKED_D(BLOCKED_D),
    .REQ_MEM_DEPTH(M3)
)
`endif
mm_gelu_test (
    .clk(clk),
    .fclk(fclk),
    .rst(rst),
    .layer(layer),

    .in_A(A_if),

    .in_W(W_if),
    .in_W_bias(W_bias_if),

    .in_out_m(out_m_if),
    .in_out_e(out_e_if),

    .mm_gelu_out(mm_gelu_out_if),

`ifndef XIL_TIMING
    .mm_dimensions(dimensions_tb)
`else
    .\mm_dimensions[M1] ( dimensions_tb.M1 ),
    .\mm_dimensions[M2] ( dimensions_tb.M2 ),
    .\mm_dimensions[M3] ( dimensions_tb.M3 ),
    .\mm_dimensions[M1xM3dN1] ( dimensions_tb.M1xM3dN1 ),
    .\mm_dimensions[M1dN1] ( dimensions_tb.M1dN1 ),
    .\mm_dimensions[M3dN2] ( dimensions_tb.M3dN2 ),
    .\mm_dimensions[M1xM3dN1xN2] ( dimensions_tb.M1xM3dN1xN2 )
`endif
);

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("mm_gelu.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("mm_gelu.vcd");
            $dumpvars();
        end
    `endif
`endif

endmodule
/* verilator lint_on UNDRIVEN */
