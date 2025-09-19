`include "names.h"

`timescale 1ps / 1ps
import dims::*;
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
module attn_head_tb
`endif
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer M1            = 64,
    parameter integer M2            = 768,
    parameter integer M3            = 64,
    parameter integer N1            = 4,
    parameter integer N2            = 4,
    parameter integer sN1           = 4,
    parameter integer sN2           = 4,
    parameter integer LAYERS        = 12,
    parameter integer HEADS         = 12,
    parameter integer MATRIXSIZE_W  = 24,
    parameter integer KEEP_A        = 1,
    parameter integer MEM_DEPTH_A   = 6144,
    parameter integer MEM_DEPTH_B   = 12288,
    parameter integer MEM_DEPTH_D   = 512,
    parameter integer MEM_DEPTH_Q   = 4096,
    parameter integer MEM_DEPTH_K   = 4096,
    parameter integer MEM_DEPTH_S   = 4096,
    parameter integer LAYER         = 0,
    parameter integer BLOCKS        = 1,
    parameter integer REUSE         = 1
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

localparam integer REP = REUSE*HEADS*M1*M2*M3;

dimensions dimensions_tb;

assign dimensions_tb.M1                   = M1;
assign dimensions_tb.M2                   = M2;
assign dimensions_tb.M3                   = M3;
assign dimensions_tb.M1xM3dN1             = M1*M3/N1;
assign dimensions_tb.M1dN1                = M1/N1;
assign dimensions_tb.M3dN2                = M3/N2;
assign dimensions_tb.M1xM3dN1xN2          = (M1*M3)/(N1*N2);
assign dimensions_tb.M1xM1dN1             = (M1*M1)/N1;
assign dimensions_tb.M1xM1dN1xN1          = (M1*M1)/(N1*N1);
assign dimensions_tb.BLOCKS               = BLOCKS;
assign dimensions_tb.BLOCK_WIDTH          = M3/BLOCKS;
assign dimensions_tb.BLOCK_WIDTHdN2       = (M3/BLOCKS)/N2;
assign dimensions_tb.BLOCK_SIZEdN2        = M2*(M3/BLOCKS)/N2;
assign dimensions_tb.M1xBLOCK_WIDTHdN1xN2 = (M1*(M3/BLOCKS))/(N1*N2);
assign dimensions_tb.M1xBLOCK_WIDTHdN1    = (M1*(M3/BLOCKS))/(N1);

logic [$clog2(LAYERS)-1:0]  layer = 0;
logic [$clog2(HEADS):0]     head_cntr;

logic                       in_valid_I;
logic  signed [31:0]        in_data_I;
logic                       in_last_I;
logic                      in_ready_I;

logic                       in_valid_W_Q;
logic  signed [31:0]        in_data_W_Q;
logic                       in_last_W_Q;
logic                      in_ready_W_Q;

logic                       in_valid_W_K;
logic  signed [31:0]        in_data_W_K;
logic                       in_last_W_K;
logic                      in_ready_W_K;

logic                       in_valid_W_V;
logic  signed [31:0]        in_data_W_V;
logic                       in_last_W_V;
logic                      in_ready_W_V;

logic                       in_valid_bias_Q;
logic  signed [31:0]        in_data_bias_Q;
logic                       in_last_bias_Q;
logic                      in_ready_bias_Q;

logic                       in_valid_bias_K;
logic  signed [31:0]        in_data_bias_K;
logic                       in_last_bias_K;
logic                      in_ready_bias_K;

logic                       in_valid_bias_V;
logic  signed [31:0]        in_data_bias_V;
logic                       in_last_bias_V;
logic                      in_ready_bias_V;

logic                       in_valid_m_Q;
logic  signed [31:0]        in_data_m_Q;
logic                       in_last_m_Q;
logic                      in_ready_m_Q;

logic                       in_valid_m_K;
logic  signed [31:0]        in_data_m_K;
logic                       in_last_m_K;
logic                      in_ready_m_K;

logic                       in_valid_m_V;
logic  signed [31:0]        in_data_m_V;
logic                       in_last_m_V;
logic                      in_ready_m_V;

logic                       in_valid_e_Q;
logic  signed [31:0]        in_data_e_Q;
logic                       in_last_e_Q;
logic                      in_ready_e_Q;

logic                       in_valid_e_K;
logic  signed [31:0]        in_data_e_K;
logic                       in_last_e_K;
logic                      in_ready_e_K;

logic                       in_valid_e_V;
logic  signed [31:0]        in_data_e_V;
logic                       in_last_e_V;
logic                      in_ready_e_V;

logic                       in_valid_m_C;
logic  signed [31:0]        in_data_m_C;
logic                       in_last_m_C;
logic                      in_ready_m_C;

logic                       in_valid_e_C;
logic  signed [31:0]        in_data_e_C;
logic                       in_last_e_C;
logic                      in_ready_e_C;

logic                      out_valid;
logic signed [31:0]        out_data;
logic signed [31:0]        out_data_stream;
logic                      out_last;
logic                       attn_head_done;

//input memories
reg  signed [D_W_ACC-1:0] mem_I           [0:REUSE*HEADS*M1*M2-1];
reg  signed [D_W_ACC-1:0] mem_W_Q         [0:REUSE*HEADS*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_K         [0:REUSE*HEADS*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_W_V         [0:REUSE*HEADS*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_bias_Q      [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_bias_K      [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_bias_V      [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_m_Q         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_m_K         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_m_V         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_e_Q         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_e_K         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_e_V         [0:REUSE*HEADS*M3-1];
reg  signed [D_W_ACC-1:0] mem_m_C         [0:REUSE*HEADS-1];
reg  signed [D_W_ACC-1:0] mem_e_C         [0:REUSE*HEADS-1];

//output memories
reg  signed [D_W_ACC-1:0] mem_Q           [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_Q_req       [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_K           [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_K_req       [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_V           [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_V_req       [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_S           [0:REUSE*HEADS*M1*M1-1];
reg  signed [D_W_ACC-1:0] mem_P           [0:REUSE*HEADS*M1*M1-1];
reg  signed [D_W_ACC-1:0] mem_C           [0:REUSE*HEADS*M1*M3-1];
reg  signed [D_W_ACC-1:0] mem_C_req       [0:REUSE*HEADS*M1*M3-1];

//read addresses
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_I;
reg [$clog2(REUSE*HEADS*M2*M3):0] rdaddr_W_Q;
reg [$clog2(REUSE*HEADS*M2*M3):0] rdaddr_W_K;
reg [$clog2(REUSE*HEADS*M2*M3):0] rdaddr_W_V;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_bias_Q;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_bias_K;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_bias_V;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_m_Q;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_m_K;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_m_V;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_e_Q;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_e_K;
reg [$clog2(REUSE*HEADS*M1*M2):0] rdaddr_e_V;
reg [$clog2(REUSE*HEADS):0]       rdaddr_m_C;
reg [$clog2(REUSE*HEADS):0]       rdaddr_e_C;

//write addresses
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_Q;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_Q_req;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_K;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_K_req;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_V;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_V_req;
reg [$clog2(REUSE*HEADS*M1*M1):0] wraddr_S;
reg [$clog2(REUSE*HEADS*M1*M1):0] wraddr_P;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_C;
reg [$clog2(REUSE*HEADS*M1*M3):0] wraddr_C_req;
reg [$clog2(REUSE*HEADS):0]       done_cntr;

// Sequence
reg START_W_Q    = 1'b0;
reg START_bias_Q = 1'b0;
reg START_m_Q    = 1'b0;
reg START_e_Q    = 1'b0;
reg START_W_K    = 1'b0;
reg START_bias_K = 1'b0;
reg START_m_K    = 1'b0;
reg START_e_K    = 1'b0;
reg START_W_V    = 1'b0;
reg START_bias_V = 1'b0;
reg START_m_V    = 1'b0;
reg START_e_V    = 1'b0;
reg START_m_C    = 1'b0;
reg START_e_C    = 1'b0;

initial begin
    $readmemh({`DIR,"I.mem"}, mem_I);
    if (BLOCKS > 1) begin
        $readmemh({`DIR,"W_Q_pp.mem"}, mem_W_Q);
        $readmemh({`DIR,"W_K_pp.mem"}, mem_W_K);
        $readmemh({`DIR,"W_V_pp.mem"}, mem_W_V);
    end else begin
        $readmemh({`DIR,"W_Q.mem"}, mem_W_Q);
        $readmemh({`DIR,"W_K.mem"}, mem_W_K);
        $readmemh({`DIR,"W_V.mem"}, mem_W_V);
    end
    $readmemh({`DIR,"bias_Q.mem"}, mem_bias_Q);
    $readmemh({`DIR,"bias_K.mem"}, mem_bias_K);
    $readmemh({`DIR,"bias_V.mem"}, mem_bias_V);
    $readmemh({`DIR,"Q_m.mem"}, mem_m_Q);
    $readmemh({`DIR,"K_m.mem"}, mem_m_K);
    $readmemh({`DIR,"V_m.mem"}, mem_m_V);
    $readmemh({`DIR,"Q_e.mem"}, mem_e_Q);
    $readmemh({`DIR,"K_e.mem"}, mem_e_K);
    $readmemh({`DIR,"V_e.mem"}, mem_e_V);
    $readmemh({`DIR,"C_m.mem"}, mem_m_C);
    $readmemh({`DIR,"C_e.mem"}, mem_e_C);
end

final begin
    $writememh({`DIR,"tb_Q.mem"}, mem_Q);
    $writememh({`DIR,"tb_K.mem"}, mem_K);
    $writememh({`DIR,"tb_V.mem"}, mem_V);
    $writememh({`DIR,"tb_Q_req.mem"}, mem_Q_req);
    $writememh({`DIR,"tb_K_req.mem"}, mem_K_req);
    $writememh({`DIR,"tb_V_req.mem"}, mem_V_req);
    $writememh({`DIR,"tb_S.mem"}, mem_S);
    $writememh({`DIR,"tb_P.mem"}, mem_P);
    $writememh({`DIR,"tb_C.mem"}, mem_C);
    $writememh({`DIR,"tb_C_req.mem"}, mem_C_req);
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
    if (attn_head_done) begin
        $display("Done Requantizing C at time=%0d", ctime);
        $finish;
    end
end

// ############## //
// Sending Inputs //
// ############## //

always @(posedge clk) begin
    if (rst) begin
        in_valid_I <= 0;
        in_last_I  <= 0;
        rdaddr_I   <= 0;
        in_data_I  <= mem_I[rdaddr_I];
    end else begin
        if (rdaddr_I < REUSE*(HEADS/KEEP_A)*M1*M2-1) begin
            in_valid_I <= 1;
        end

        if (in_valid_I && in_ready_I) begin
            in_data_I <= mem_I[rdaddr_I + 1];
            if (rdaddr_I < REUSE*(HEADS/KEEP_A)*M1*M2-1) begin
                rdaddr_I <= rdaddr_I + 1;
            end

            if (rdaddr_I == (M1*M2)*(rdaddr_I/(M1*M2))+M1*M2-2) begin
                in_last_I <= 1;
                START_W_Q <= 1;
            end else if (rdaddr_I == (M1*M2)*(rdaddr_I/(M1*M2))+M1*M2-1) begin
                in_valid_I <= 0;
                in_last_I <= 0;
                $display("Done Sending input I to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_Q <= 0;
        in_last_W_Q  <= 0;
        rdaddr_W_Q   <= 0;
        in_data_W_Q  <= mem_W_Q[rdaddr_W_Q];
    end else if(START_W_Q)begin
        if (rdaddr_W_Q < REUSE*HEADS*M2*M3-1) begin
            in_valid_W_Q <= 1;
        end

        if (in_valid_W_Q && in_ready_W_Q) begin
            in_data_W_Q <= mem_W_Q[rdaddr_W_Q + 1];
            if (rdaddr_W_Q < REUSE*HEADS*M2*M3-1) begin
                rdaddr_W_Q <= rdaddr_W_Q + 1;
            end

            if (rdaddr_W_Q == (M2*M3)*(rdaddr_W_Q/(M2*M3))+M2*M3-2) begin
                in_last_W_Q <= 1;
                START_bias_Q <= 1;
            end else if (rdaddr_W_Q == (M2*M3)*(rdaddr_W_Q/(M2*M3))+M2*M3-1) begin
                in_valid_W_Q <= 0;
                in_last_W_Q <= 0;
                START_W_Q <= 0;
                $display("Done Sending weight W_Q to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_K <= 0;
        in_last_W_K  <= 0;
        rdaddr_W_K   <= 0;
        in_data_W_K  <= mem_W_K[rdaddr_W_K];
    end else if (START_W_K) begin
        if (rdaddr_W_K < REUSE*HEADS*M2*M3-1) begin
            in_valid_W_K <= 1;
        end

        if (in_valid_W_K && in_ready_W_K) begin
            in_data_W_K <= mem_W_K[rdaddr_W_K + 1];
            if (rdaddr_W_K < REUSE*HEADS*M2*M3-1) begin
                rdaddr_W_K <= rdaddr_W_K + 1;
            end

            if (rdaddr_W_K == (M2*M3)*(rdaddr_W_K/(M2*M3))+M2*M3-2) begin
                in_last_W_K <= 1;
                START_bias_K <= 1;
            end else if (rdaddr_W_K == (M2*M3)*(rdaddr_W_K/(M2*M3))+M2*M3-1) begin
                in_valid_W_K <= 0;
                in_last_W_K <= 0;
                START_W_K <= 0;
                $display("Done Sending weight W_K to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_V <= 0;
        in_last_W_V  <= 0;
        rdaddr_W_V   <= 0;
        in_data_W_V  <= mem_W_V[rdaddr_W_V];
    end else if (START_W_V) begin
        if (rdaddr_W_V < REUSE*HEADS*M2*M3-1) begin
            in_valid_W_V <= 1;
        end

        if (in_valid_W_V && in_ready_W_V) begin
            in_data_W_V <= mem_W_V[rdaddr_W_V + 1];
            if (rdaddr_W_V < REUSE*HEADS*M2*M3-1) begin
                rdaddr_W_V <= rdaddr_W_V + 1;
            end

            if (rdaddr_W_V == (M2*M3)*(rdaddr_W_V/(M2*M3))+M2*M3-2) begin
                in_last_W_V <= 1;
                START_bias_V <= 1;
            end else if (rdaddr_W_V == (M2*M3)*(rdaddr_W_V/(M2*M3))+M2*M3-1) begin
                in_valid_W_V <= 0;
                in_last_W_V <= 0;
                START_W_V <= 0;
                $display("Done Sending weight W_V to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_bias_Q <= 0;
        in_last_bias_Q  <= 0;
        rdaddr_bias_Q   <= 0;
        in_data_bias_Q  <= mem_bias_Q[rdaddr_bias_Q];
    end else if(START_bias_Q) begin
        if (rdaddr_bias_Q < REUSE*HEADS*M3-1) begin
            in_valid_bias_Q <= 1;
        end

        if (in_valid_bias_Q && in_ready_bias_Q) begin
            in_data_bias_Q <= mem_bias_Q[rdaddr_bias_Q + 1];
            if (rdaddr_bias_Q < REUSE*HEADS*M3-1) begin
                rdaddr_bias_Q <= rdaddr_bias_Q + 1;
            end

            if (rdaddr_bias_Q == M3*(rdaddr_bias_Q/M3)+M3-2) begin
                in_last_bias_Q <= 1;
                START_m_Q <= 1;
            end else if (rdaddr_bias_Q == M3*(rdaddr_bias_Q/M3)+M3-1) begin
                in_valid_bias_Q <= 0;
                in_last_bias_Q <= 0;
                START_bias_Q <= 0;
                $display("Done Sending bias bias_Q to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_bias_K <= 0;
        in_last_bias_K  <= 0;
        rdaddr_bias_K   <= 0;
        in_data_bias_K  <= mem_bias_K[rdaddr_bias_K];
    end else if(START_bias_K) begin
        if (rdaddr_bias_K < REUSE*HEADS*M3-1) begin
            in_valid_bias_K <= 1;
        end

        if (in_valid_bias_K && in_ready_bias_K) begin
            in_data_bias_K <= mem_bias_K[rdaddr_bias_K + 1];
            if (rdaddr_bias_K < REUSE*HEADS*M3-1) begin
                rdaddr_bias_K <= rdaddr_bias_K + 1;
            end

            if (rdaddr_bias_K == M3*(rdaddr_bias_K/M3)+M3-2) begin
                in_last_bias_K <= 1;
                START_m_K <= 1;
            end else if (rdaddr_bias_K == M3*(rdaddr_bias_K/M3)+M3-1) begin
                in_valid_bias_K <= 0;
                in_last_bias_K <= 0;
                START_bias_K <= 0;
                $display("Done Sending bias bias_K to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_bias_V <= 0;
        in_last_bias_V  <= 0;
        rdaddr_bias_V   <= 0;
        in_data_bias_V  <= mem_bias_V[rdaddr_bias_V];
    end else if(START_bias_V)begin
        if (rdaddr_bias_V < REUSE*HEADS*M3-1) begin
            in_valid_bias_V <= 1;
        end

        if (in_valid_bias_V && in_ready_bias_V) begin
            in_data_bias_V <= mem_bias_V[rdaddr_bias_V + 1];
            if (rdaddr_bias_V < REUSE*HEADS*M3-1) begin
                rdaddr_bias_V <= rdaddr_bias_V + 1;
            end

            if (rdaddr_bias_V == M3*(rdaddr_bias_V/M3)+M3-2) begin
                in_last_bias_V <= 1;
                START_m_V <= 1;
            end else if (rdaddr_bias_V == M3*(rdaddr_bias_V/M3)+M3-1) begin
                in_valid_bias_V <= 0;
                in_last_bias_V <= 0;
                START_bias_V <= 0;
                $display("Done Sending bias bias_V to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_m_Q <= 0;
        in_last_m_Q  <= 0;
        rdaddr_m_Q   <= 0;
        in_data_m_Q  <= mem_m_Q[rdaddr_m_Q];
    end else if(START_m_Q)begin
        if (rdaddr_m_Q < REUSE*HEADS*M3-1) begin
            in_valid_m_Q <= 1;
        end

        if (in_valid_m_Q && in_ready_m_Q) begin
            in_data_m_Q <= mem_m_Q[rdaddr_m_Q + 1];
            if (rdaddr_m_Q < REUSE*HEADS*M3-1) begin
                rdaddr_m_Q <= rdaddr_m_Q + 1;
            end

            if (rdaddr_m_Q == M3*(rdaddr_m_Q/M3)+M3-2) begin
                in_last_m_Q <= 1;
                START_e_Q <= 1;
            end else if (rdaddr_m_Q == M3*(rdaddr_m_Q/M3)+M3-1) begin
                in_valid_m_Q <= 0;
                in_last_m_Q <= 0;
                START_m_Q <= 0;
                $display("Done Sending requantization multiplier m_Q to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_m_K <= 0;
        in_last_m_K  <= 0;
        rdaddr_m_K   <= 0;
        in_data_m_K  <= mem_m_K[rdaddr_m_K];
    end else if (START_m_K) begin
        if (rdaddr_m_K < REUSE*HEADS*M3-1) begin
            in_valid_m_K <= 1;
        end

        if (in_valid_m_K && in_ready_m_K) begin
            in_data_m_K <= mem_m_K[rdaddr_m_K + 1];
            if (rdaddr_m_K < REUSE*HEADS*M3-1) begin
                rdaddr_m_K <= rdaddr_m_K + 1;
            end

            if (rdaddr_m_K == M3*(rdaddr_m_K/M3)+M3-2) begin
                in_last_m_K <= 1;
                START_e_K <= 1;
            end else if (rdaddr_m_K == M3*(rdaddr_m_K/M3)+M3-1) begin
                in_valid_m_K <= 0;
                in_last_m_K <= 0;
                START_m_K <= 0;
                $display("Done Sending requantization multiplier m_K to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_m_V <= 0;
        in_last_m_V  <= 0;
        rdaddr_m_V   <= 0;
        in_data_m_V  <= mem_m_V[rdaddr_m_V];
    end else if(START_m_V) begin
        if (rdaddr_m_V < REUSE*HEADS*M3-1) begin
            in_valid_m_V <= 1;
        end

        if (in_valid_m_V && in_ready_m_V) begin
            in_data_m_V <= mem_m_V[rdaddr_m_V + 1];
            if (rdaddr_m_V < REUSE*HEADS*M3-1) begin
                rdaddr_m_V <= rdaddr_m_V + 1;
            end

            if (rdaddr_m_V == M3*(rdaddr_m_V/M3)+M3-2) begin
                in_last_m_V <= 1;
                START_e_V <= 1;
            end else if (rdaddr_m_V == M3*(rdaddr_m_V/M3)+M3-1) begin
                in_valid_m_V <= 0;
                in_last_m_V <= 0;
                START_m_V <= 0;
                $display("Done Sending requantization multiplier m_V to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_e_Q <= 0;
        in_last_e_Q  <= 0;
        rdaddr_e_Q   <= 0;
        in_data_e_Q  <= mem_e_Q[rdaddr_e_Q];
    end else if(START_e_Q)begin
        if (rdaddr_e_Q < REUSE*HEADS*M3-1) begin
            in_valid_e_Q <= 1;
        end

        if (in_valid_e_Q && in_ready_e_Q) begin
            in_data_e_Q <= mem_e_Q[rdaddr_e_Q + 1];
            if (rdaddr_e_Q < REUSE*HEADS*M3-1) begin
                rdaddr_e_Q <= rdaddr_e_Q + 1;
            end

            if (rdaddr_e_Q == M3*(rdaddr_e_Q/M3)+M3-2) begin
                in_last_e_Q <= 1;
                START_W_K <= 1;
            end else if (rdaddr_e_Q == M3*(rdaddr_e_Q/M3)+M3-1) begin
                in_valid_e_Q <= 0;
                in_last_e_Q <= 0;
                START_e_Q <= 0;
                $display("Done Sending requantization shifter e_Q to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_e_K <= 0;
        in_last_e_K  <= 0;
        rdaddr_e_K   <= 0;
        in_data_e_K  <= mem_e_K[rdaddr_e_K];
    end else if(START_e_K) begin
        if (rdaddr_e_K < REUSE*HEADS*M3-1) begin
            in_valid_e_K <= 1;
        end

        if (in_valid_e_K && in_ready_e_K) begin
            in_data_e_K <= mem_e_K[rdaddr_e_K + 1];
            if (rdaddr_e_K < REUSE*HEADS*M3-1) begin
                rdaddr_e_K <= rdaddr_e_K + 1;
            end

            if (rdaddr_e_K == M3*(rdaddr_e_K/M3)+M3-2) begin
                in_last_e_K <= 1;
                START_W_V <= 1;
            end else if (rdaddr_e_K == M3*(rdaddr_e_K/M3)+M3-1) begin
                in_valid_e_K <= 0;
                in_last_e_K <= 0;
                START_e_K <= 0;
                $display("Done Sending requantization shifter e_K to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_e_V <= 0;
        in_last_e_V  <= 0;
        rdaddr_e_V   <= 0;
        in_data_e_V  <= mem_e_V[rdaddr_e_V];
    end else if(START_e_V) begin
        if (rdaddr_e_V < REUSE*HEADS*M3-1) begin
            in_valid_e_V <= 1;
        end

        if (in_valid_e_V && in_ready_e_V) begin
            in_data_e_V <= mem_e_V[rdaddr_e_V + 1];
            if (rdaddr_e_V < REUSE*HEADS*M3-1) begin
                rdaddr_e_V <= rdaddr_e_V + 1;
            end

            if (rdaddr_e_V == M3*(rdaddr_e_V/M3)+M3-2) begin
                in_last_e_V <= 1;
                START_m_C <= 1;
            end else if (rdaddr_e_V == M3*(rdaddr_e_V/M3)+M3-1) begin
                in_valid_e_V <= 0;
                in_last_e_V <= 0;
                START_e_V <= 0;
                $display("Done Sending requantization shifter e_V to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_m_C <= 0;
        in_last_m_C  <= 0;
        rdaddr_m_C   <= 0;
        in_data_m_C  <= mem_m_C[rdaddr_m_C];
    end else if(START_m_C)begin
        if (rdaddr_m_C < REUSE*HEADS) begin
            in_valid_m_C <= 1;
            in_last_m_C <= 1;
            START_e_C <= 1;
        end

        if (in_valid_m_C && in_ready_m_C) begin
            if (REUSE*HEADS > 1) begin
                in_data_m_C <= mem_m_C[rdaddr_m_C + 1];
            end
            if (rdaddr_m_C < REUSE*HEADS) begin
                rdaddr_m_C <= rdaddr_m_C + 1;
            end

            in_valid_m_C <= 0;
            in_last_m_C <= 0;
            START_m_C <= 0;
            $display("Done Sending requantization multiplier m_C to Top Module at time=%0d", ctime);
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_e_C <= 0;
        in_last_e_C  <= 0;
        rdaddr_e_C   <= 0;
        in_data_e_C  <= mem_e_C[rdaddr_e_C];
    end else if(START_e_C)begin
        if (rdaddr_e_C < REUSE*HEADS) begin
            in_valid_e_C <= 1;
            in_last_e_C <= 1;
            START_W_Q <= 1;
        end

        if (in_valid_e_C && in_ready_e_C) begin
            if (REUSE*HEADS > 1) begin
                in_data_e_C <= mem_e_C[rdaddr_e_C + 1];
            end
            if (rdaddr_e_C < REUSE*HEADS) begin
                rdaddr_e_C <= rdaddr_e_C + 1;
            end

            in_valid_e_C <= 0;
            in_last_e_C <= 0;
            START_e_C <= 0;
            $display("Done Sending requantization shifter e_C to Top Module at time=%0d", ctime);
        end
    end
end

// ############### //
// Receive Outputs //
// ############### //

always @(posedge clk) begin
    if (rst) begin
        wraddr_Q <= 0;
    end else begin
        if (attn_head_test.QKV.tvalid == 1'b1 &&
            attn_head_test.QKV.tready == 1'b1 &&
            attn_head_test.fsm_inst.out_next_state == 2'b01) begin
            wraddr_Q <= (wraddr_Q == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_Q + 1;
            mem_Q[wraddr_Q] <= attn_head_test.QKV.tdata;
            if (wraddr_Q == (M1*M3)*(wraddr_Q/(M1*M3))+M1*M3-1) begin
                $display("Done computing Q=I*W_Q at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_K <= 0;
    end else begin
        if (attn_head_test.QKV.tvalid == 1'b1 &&
            attn_head_test.QKV.tready == 1'b1 &&
            attn_head_test.fsm_inst.out_next_state == 2'b10) begin
            wraddr_K <= (wraddr_K == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_K + 1;
            mem_K[wraddr_K] <= attn_head_test.QKV.tdata;
            if (wraddr_K == (M1*M3)*(wraddr_K/(M1*M3))+M1*M3-1) begin
                $display("Done computing K=I*W_K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_V <= 0;
    end else begin
        if (attn_head_test.QKV.tvalid == 1'b1 &&
            attn_head_test.QKV.tready == 1'b1 &&
            attn_head_test.fsm_inst.out_next_state == 2'b11) begin
            wraddr_V <= (wraddr_V == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_V + 1;
            mem_V[wraddr_V] <= attn_head_test.QKV.tdata;
            if (wraddr_V == (M1*M3)*(wraddr_V/(M1*M3))+M1*M3-1) begin
                $display("Done computing V=I*W_V at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Q_req <= 0;
    end else begin
        if (attn_head_test.Q_req.tvalid == 1'b1 &&
            attn_head_test.Q_req.tready == 1'b1) begin
            mem_Q_req[wraddr_Q_req] <= attn_head_test.Q_req.tdata;
            wraddr_Q_req <= (wraddr_Q_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_Q_req + 1;
            if (wraddr_Q_req == (M1*M3)*(wraddr_Q_req/(M1*M3))+M1*M3-1) begin
                $display("Done Requantizing Q at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_K_req <= 0;
    end else begin
        if (attn_head_test.K_req.tvalid == 1'b1 &&
            attn_head_test.K_req.tready == 1'b1) begin
            mem_K_req[wraddr_K_req] <= attn_head_test.K_req.tdata;
            wraddr_K_req <= (wraddr_K_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_K_req + 1;
            if (wraddr_K_req == (M1*M3)*(wraddr_K_req/(M1*M3))+M1*M3-1) begin
                $display("Done Requantizing K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_V_req <= 0;
    end else begin
        if (attn_head_test.V_req.tvalid == 1'b1 &&
            attn_head_test.V_req.tready == 1'b1) begin
            mem_V_req[wraddr_V_req] <= attn_head_test.V_req.tdata;
            wraddr_V_req <= (wraddr_V_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_V_req + 1;
            if (wraddr_V_req == (M1*M3)*(wraddr_V_req/(M1*M3))+M1*M3-1) begin
                $display("Done Requantizing V at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_S <= 0;
    end else begin
        if (attn_head_test.S.tvalid == 1'b1 &&
            attn_head_test.S.tready == 1'b1) begin
            wraddr_S <= (wraddr_S == REUSE*HEADS*M1*M1-1) ? 0 : wraddr_S + 1;
            mem_S[wraddr_S] <= attn_head_test.S.tdata;
            if (wraddr_S == (M1*M1)*(wraddr_S/(M1*M1))+M1*M1-1) begin
                $display("Done computing S=Q*K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_P <= 0;
    end else begin
        if (attn_head_test.softmax_out.tvalid == 1'b1 &&
            attn_head_test.softmax_out.tready == 1'b1) begin
            wraddr_P <= (wraddr_P == REUSE*HEADS*M1*M1-1) ? 0 : wraddr_P + 1;
            mem_P[wraddr_P] <= attn_head_test.softmax_out.tdata;
            if (wraddr_P == (M1*M1)*(wraddr_P/(M1*M1))+M1*M1-1) begin
                $display("Done computing P=softmax(S) at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_C <= 0;
    end else begin
        if (attn_head_test.C.tvalid == 1'b1 &&
            attn_head_test.C.tready == 1'b1) begin
            wraddr_C <= (wraddr_C == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_C + 1;
            mem_C[wraddr_C] <= attn_head_test.C.tdata;
            if (wraddr_C == (M1*M3)*(wraddr_C/(M1*M3))+M1*M3-1) begin
                $display("Done computing C=P*V at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_C_req <= 0;
        attn_head_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_last) begin
            if (REUSE*HEADS > 1) begin
                $display("-- Finished Head %0d out of %0d at time=%0d.\n###\n", done_cntr + 1, REUSE*HEADS, ctime);
            end
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE*HEADS-1) begin
                attn_head_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_C_req <= (wraddr_C_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_C_req + 1;
            mem_C_req[wraddr_C_req] <= out_data_stream;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        layer <= LAYER;
        head_cntr <= 0;
    end else begin
        if (out_valid && out_last) begin
            head_cntr <= head_cntr + 1;
            if (head_cntr == HEADS-1) begin
                head_cntr <= 0;
                layer <= layer + 1;
                if (layer == LAYERS-1) begin
                    layer <= 0;
                end
            end
        end
    end
end

axi_stream_if I_if();
assign I_if.tdata = in_data_I;
assign I_if.tlast = in_last_I;
assign in_ready_I = I_if.tready;
assign I_if.tvalid = in_valid_I;

axi_stream_if W_Q_if();
assign W_Q_if.tdata = in_data_W_Q;
assign W_Q_if.tlast = in_last_W_Q;
assign in_ready_W_Q = W_Q_if.tready;
assign W_Q_if.tvalid = in_valid_W_Q;

axi_stream_if W_K_if();
assign W_K_if.tdata = in_data_W_K;
assign W_K_if.tlast = in_last_W_K;
assign in_ready_W_K = W_K_if.tready;
assign W_K_if.tvalid = in_valid_W_K;

axi_stream_if W_V_if();
assign W_V_if.tdata = in_data_W_V;
assign W_V_if.tlast = in_last_W_V;
assign in_ready_W_V = W_V_if.tready;
assign W_V_if.tvalid = in_valid_W_V;

axi_stream_if bias_Q_if();
assign bias_Q_if.tdata = in_data_bias_Q;
assign bias_Q_if.tlast = in_last_bias_Q;
assign in_ready_bias_Q = bias_Q_if.tready;
assign bias_Q_if.tvalid = in_valid_bias_Q;

axi_stream_if bias_K_if();
assign bias_K_if.tdata = in_data_bias_K;
assign bias_K_if.tlast = in_last_bias_K;
assign in_ready_bias_K = bias_K_if.tready;
assign bias_K_if.tvalid = in_valid_bias_K;

axi_stream_if bias_V_if();
assign bias_V_if.tdata = in_data_bias_V;
assign bias_V_if.tlast = in_last_bias_V;
assign in_ready_bias_V = bias_V_if.tready;
assign bias_V_if.tvalid = in_valid_bias_V;

axi_stream_if m_Q_if();
assign m_Q_if.tdata = in_data_m_Q;
assign m_Q_if.tlast = in_last_m_Q;
assign in_ready_m_Q = m_Q_if.tready;
assign m_Q_if.tvalid = in_valid_m_Q;

axi_stream_if m_K_if();
assign m_K_if.tdata = in_data_m_K;
assign m_K_if.tlast = in_last_m_K;
assign in_ready_m_K = m_K_if.tready;
assign m_K_if.tvalid = in_valid_m_K;

axi_stream_if m_V_if();
assign m_V_if.tdata = in_data_m_V;
assign m_V_if.tlast = in_last_m_V;
assign in_ready_m_V = m_V_if.tready;
assign m_V_if.tvalid = in_valid_m_V;

axi_stream_if e_Q_if();
assign e_Q_if.tdata = in_data_e_Q;
assign e_Q_if.tlast = in_last_e_Q;
assign in_ready_e_Q = e_Q_if.tready;
assign e_Q_if.tvalid = in_valid_e_Q;

axi_stream_if e_K_if();
assign e_K_if.tdata = in_data_e_K;
assign e_K_if.tlast = in_last_e_K;
assign in_ready_e_K = e_K_if.tready;
assign e_K_if.tvalid = in_valid_e_K;

axi_stream_if e_V_if();
assign e_V_if.tdata = in_data_e_V;
assign e_V_if.tlast = in_last_e_V;
assign in_ready_e_V = e_V_if.tready;
assign e_V_if.tvalid = in_valid_e_V;

axi_stream_if m_C_if();
assign m_C_if.tdata = in_data_m_C;
assign m_C_if.tlast = in_last_m_C;
assign in_ready_m_C = m_C_if.tready;
assign m_C_if.tvalid = in_valid_m_C;

axi_stream_if e_C_if();
assign e_C_if.tdata = in_data_e_C;
assign e_C_if.tlast = in_last_e_C;
assign in_ready_e_C = e_C_if.tready;
assign e_C_if.tvalid = in_valid_e_C;

axi_stream_if attn_head_out_if();
`ifdef VERILATOR
assign out_data_stream = attn_head_out_if.tdata;
`else
assign out_data_stream[D_W-1:0] = attn_head_out_if.tdata;
assign out_data_stream[D_W_ACC-1:D_W] = {(D_W_ACC-D_W){out_data_stream[D_W-1]}};
`endif
assign out_last = attn_head_out_if.tlast;
assign out_valid = attn_head_out_if.tvalid;
assign attn_head_out_if.tready = 1;

attn_head
`ifndef XIL_TIMING
#(
    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .N1            (N1),
    .N2            (N2),
    .sN1           (sN1),
    .sN2           (sN2),
    .LAYERS        (LAYERS),
    .SOFTMAX_N     (M1),
    .MATRIXSIZE_W  (MATRIXSIZE_W),
    .KEEP_A        (KEEP_A),
    .MEM_DEPTH_A   (MEM_DEPTH_A),
    .MEM_DEPTH_B   (MEM_DEPTH_B),
    .MEM_DEPTH_D   (MEM_DEPTH_D),
    .MEM_DEPTH_Q   (MEM_DEPTH_Q),
    .MEM_DEPTH_K   (MEM_DEPTH_K),
    .MEM_DEPTH_S   (MEM_DEPTH_S),
    .REQ_MEM_DEPTH (M3)
)
`endif
attn_head_test (
    .clk(clk),
    .fclk(clk),
    .rst(rst),
    .layer(layer),

    .in_I(I_if),

    .in_W_Q(W_Q_if),
    .in_W_K(W_K_if),
    .in_W_V(W_V_if),

    .in_bias_Q(bias_Q_if),
    .in_bias_K(bias_K_if),
    .in_bias_V(bias_V_if),

    .in_m_Q(m_Q_if),
    .in_m_K(m_K_if),
    .in_m_V(m_V_if),

    .in_e_Q(e_Q_if),
    .in_e_K(e_K_if),
    .in_e_V(e_V_if),

    .in_m_C(m_C_if),
    .in_e_C(e_C_if),

    .attn_head_out(attn_head_out_if),

`ifndef XIL_TIMING
    .mm_dimensions(dimensions_tb)
`else
    .\mm_dimensions[M1] ( dimensions_tb.M1 ),
    .\mm_dimensions[M2] ( dimensions_tb.M2 ),
    .\mm_dimensions[M3] ( dimensions_tb.M3 ),
    .\mm_dimensions[M1xM3dN1] ( dimensions_tb.M1xM3dN1 ),
    .\mm_dimensions[M1dN1] ( dimensions_tb.M1dN1 ),
    .\mm_dimensions[M3dN2] ( dimensions_tb.M3dN2 ),
    .\mm_dimensions[M1xM3dN1xN2] ( dimensions_tb.M1xM3dN1xN2 ),
    .\mm_dimensions[M1xM2] ( dimensions_tb.M1xM2 ),
    .\mm_dimensions[M1xM1dN1] ( dimensions_tb.M1xM1dN1 ),
    .\mm_dimensions[M1dN2] ( dimensions_tb.M1dN2 )
`endif
);

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("attn_head.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("attn_head.vcd");
            $dumpvars();
        end
    `endif
`endif

endmodule
/* verilator lint_off UNDRIVEN */
