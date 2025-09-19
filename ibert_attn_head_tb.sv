
`timescale 1ps / 1ps
/* verilator lint_off UNDRIVEN */

module ibert_attn_head_tb
#(
    parameter integer D_W           = 8,
    parameter integer D_W_ACC       = 32,
    parameter integer M1            = 64,
    parameter integer M2            = 768,
    parameter integer M3            = 64,
    parameter integer HEADS         = 12,
    parameter integer KEEP_A        = 1,
    parameter integer BLOCKS        = 1,
    parameter integer REUSE         = 1,
    parameter integer ONLY_ONCE     = 0,
    parameter         DIR           = ""
)
(
    input wire clk,
    input wire rst,

    output wire                      in_valid,
    output wire signed [31:0]        in_data,
    input  wire                      in_ready,

    input  wire                      save_Q,
    input  wire signed [31:0]        data_Q,

    input  wire                      save_K,
    input  wire signed [31:0]        data_K,

    input  wire                      save_V,
    input  wire signed [31:0]        data_V,

    input  wire                      save_Q_req,
    input  wire signed [31:0]        data_Q_req,

    input  wire                      save_K_req,
    input  wire signed [31:0]        data_K_req,

    input  wire                      save_V_req,
    input  wire signed [31:0]        data_V_req,

    input  wire                      save_S,
    input  wire signed [31:0]        data_S,

    input  wire                      save_softmax_out,
    input  wire signed [31:0]        data_softmax_out,

    input  wire                      save_C,
    input  wire signed [31:0]        data_C,

    input  wire                      out_valid,
    input  wire signed [D_W-1:0]     out_data,
    input  wire                      out_last
);

reg axi_lite_done = 1'b1;

reg                       in_valid_I;
reg  signed [31:0]        in_data_I;
reg                       in_last_I;
reg                       in_ready_I;

reg                       in_valid_W_Q;
reg  signed [31:0]        in_data_W_Q;
reg                       in_last_W_Q;
reg                       in_ready_W_Q;

reg                       in_valid_W_K;
reg  signed [31:0]        in_data_W_K;
reg                       in_last_W_K;
reg                       in_ready_W_K;

reg                       in_valid_W_V;
reg  signed [31:0]        in_data_W_V;
reg                       in_last_W_V;
reg                       in_ready_W_V;

reg                       in_valid_bias_Q;
reg  signed [31:0]        in_data_bias_Q;
reg                       in_last_bias_Q;
reg                       in_ready_bias_Q;

reg                       in_valid_bias_K;
reg  signed [31:0]        in_data_bias_K;
reg                       in_last_bias_K;
reg                       in_ready_bias_K;

reg                       in_valid_bias_V;
reg  signed [31:0]        in_data_bias_V;
reg                       in_last_bias_V;
reg                       in_ready_bias_V;

reg                       in_valid_m_Q;
reg  signed [31:0]        in_data_m_Q;
reg                       in_last_m_Q;
reg                       in_ready_m_Q;

reg                       in_valid_m_K;
reg  signed [31:0]        in_data_m_K;
reg                       in_last_m_K;
reg                       in_ready_m_K;

reg                       in_valid_m_V;
reg  signed [31:0]        in_data_m_V;
reg                       in_last_m_V;
reg                       in_ready_m_V;

reg                       in_valid_e_Q;
reg  signed [31:0]        in_data_e_Q;
reg                       in_last_e_Q;
reg                       in_ready_e_Q;

reg                       in_valid_e_K;
reg  signed [31:0]        in_data_e_K;
reg                       in_last_e_K;
reg                       in_ready_e_K;

reg                       in_valid_e_V;
reg  signed [31:0]        in_data_e_V;
reg                       in_last_e_V;
reg                       in_ready_e_V;

reg                       in_valid_m_C;
reg  signed [31:0]        in_data_m_C;
reg                       in_last_m_C;
reg                       in_ready_m_C;

reg                       in_valid_e_C;
reg  signed [31:0]        in_data_e_C;
reg                       in_last_e_C;
reg                       in_ready_e_C;
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
reg [$clog2(KEEP_A):0]            keep_A_cntr;

reg attn_head_done;

initial begin
    $readmemh({DIR,"I.mem"}, mem_I);
    if (BLOCKS > 1) begin
        $readmemh({DIR,"W_Q_pp.mem"}, mem_W_Q);
        $readmemh({DIR,"W_K_pp.mem"}, mem_W_K);
        $readmemh({DIR,"W_V_pp.mem"}, mem_W_V);
    end else begin
        $readmemh({DIR,"W_Q.mem"}, mem_W_Q);
        $readmemh({DIR,"W_K.mem"}, mem_W_K);
        $readmemh({DIR,"W_V.mem"}, mem_W_V);
    end
    $readmemh({DIR,"bias_Q.mem"}, mem_bias_Q);
    $readmemh({DIR,"bias_K.mem"}, mem_bias_K);
    $readmemh({DIR,"bias_V.mem"}, mem_bias_V);
    $readmemh({DIR,"Q_m.mem"}, mem_m_Q);
    $readmemh({DIR,"K_m.mem"}, mem_m_K);
    $readmemh({DIR,"V_m.mem"}, mem_m_V);
    $readmemh({DIR,"Q_e.mem"}, mem_e_Q);
    $readmemh({DIR,"K_e.mem"}, mem_e_K);
    $readmemh({DIR,"V_e.mem"}, mem_e_V);
    $readmemh({DIR,"C_m.mem"}, mem_m_C);
    $readmemh({DIR,"C_e.mem"}, mem_e_C);
end

final begin
    $writememh({DIR,"tb_Q.mem"}, mem_Q);
    $writememh({DIR,"tb_K.mem"}, mem_K);
    $writememh({DIR,"tb_V.mem"}, mem_V);
    $writememh({DIR,"tb_Q_req.mem"}, mem_Q_req);
    $writememh({DIR,"tb_K_req.mem"}, mem_K_req);
    $writememh({DIR,"tb_V_req.mem"}, mem_V_req);
    $writememh({DIR,"tb_S.mem"}, mem_S);
    $writememh({DIR,"tb_P.mem"}, mem_P);
    $writememh({DIR,"tb_C.mem"}, mem_C);
    $writememh({DIR,"tb_C_req.mem"}, mem_C_req);
end

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
end

assign in_valid = (in_ready_I)       ? in_valid_I       :
                  (in_ready_W_Q)     ? in_valid_W_Q     :
                  (in_ready_bias_Q)  ? in_valid_bias_Q  :
                  (in_ready_m_Q)     ? in_valid_m_Q     :
                  (in_ready_e_Q)     ? in_valid_e_Q     :

                  (in_ready_W_K)     ? in_valid_W_K     :
                  (in_ready_bias_K)  ? in_valid_bias_K  :
                  (in_ready_m_K)     ? in_valid_m_K     :
                  (in_ready_e_K)     ? in_valid_e_K     :

                  (in_ready_W_V)     ? in_valid_W_V     :
                  (in_ready_bias_V)  ? in_valid_bias_V  :
                  (in_ready_m_V)     ? in_valid_m_V     :
                  (in_ready_e_V)     ? in_valid_e_V     :

                  (in_ready_m_C)     ? in_valid_m_C     :
                  (in_ready_e_C)     ? in_valid_e_C     : 0;

assign in_data = (in_valid_I)       ? in_data_I       :
                 (in_valid_W_Q)     ? in_data_W_Q     :
                 (in_valid_bias_Q)  ? in_data_bias_Q  :
                 (in_valid_m_Q)     ? in_data_m_Q     :
                 (in_valid_e_Q)     ? in_data_e_Q     :

                 (in_valid_W_K)     ? in_data_W_K     :
                 (in_valid_bias_K)  ? in_data_bias_K  :
                 (in_valid_m_K)     ? in_data_m_K     :
                 (in_valid_e_K)     ? in_data_e_K     :

                 (in_valid_W_V)     ? in_data_W_V     :
                 (in_valid_bias_V)  ? in_data_bias_V  :
                 (in_valid_m_V)     ? in_data_m_V     :
                 (in_valid_e_V)     ? in_data_e_V     :

                 (in_valid_m_C)     ? in_data_m_C     :
                 (in_valid_e_C)     ? in_data_e_C     : 0;

always @(posedge clk) begin
    if (rst) begin
        in_ready_I <= 1;
        in_ready_W_Q <= 0;
        in_ready_W_K <= 0;
        in_ready_bias_Q <= 0;
        in_ready_m_Q <= 0;
        in_ready_e_Q <= 0;
        in_ready_bias_K <= 0;
        in_ready_m_K <= 0;
        in_ready_e_K <= 0;
        in_ready_W_V <= 0;
        in_ready_bias_V <= 0;
        in_ready_m_V <= 0;
        in_ready_e_V <= 0;
        in_ready_m_C <= 0;
        in_ready_e_C <= 0;
        keep_A_cntr <= 0;
    end else begin
        if (in_ready && in_ready_I && in_last_I) begin
            in_ready_I <= 0;
            in_ready_W_Q <= 1;
        end

        if (in_ready && in_ready_W_Q && in_last_W_Q) begin
            in_ready_W_Q <= 0;
            in_ready_bias_Q <= 1;
        end
        if (in_ready && in_ready_bias_Q && in_last_bias_Q) begin
            in_ready_bias_Q <= 0;
            in_ready_m_Q <= 1;
        end
        if (in_ready && in_ready_m_Q && in_last_m_Q) begin
            in_ready_m_Q <= 0;
            in_ready_e_Q <= 1;
        end
        if (in_ready && in_ready_e_Q && in_last_e_Q) begin
            in_ready_e_Q <= 0;
            in_ready_W_K <= 1;
        end

        if (in_ready && in_ready_W_K && in_last_W_K) begin
            in_ready_W_K <= 0;
            in_ready_bias_K <= 1;
        end
        if (in_ready && in_ready_bias_K && in_last_bias_K) begin
            in_ready_bias_K <= 0;
            in_ready_m_K <= 1;
        end
        if (in_ready && in_ready_m_K && in_last_m_K) begin
            in_ready_m_K <= 0;
            in_ready_e_K <= 1;
        end
        if (in_ready && in_ready_e_K && in_last_e_K) begin
            in_ready_e_K <= 0;
            in_ready_W_V <= 1;
        end

        if (in_ready && in_ready_W_V && in_last_W_V) begin
            in_ready_W_V <= 0;
            in_ready_bias_V <= 1;
        end
        if (in_ready && in_ready_bias_V && in_last_bias_V) begin
            in_ready_bias_V <= 0;
            in_ready_m_V <= 1;
        end
        if (in_ready && in_ready_m_V && in_last_m_V) begin
            in_ready_m_V <= 0;
            in_ready_e_V <= 1;
        end
        if (in_ready && in_ready_e_V && in_last_e_V) begin
            in_ready_e_V <= 0;
            in_ready_m_C <= 1;
        end

        if (in_ready && in_ready_m_C && in_last_m_C) begin
            in_ready_m_C <= 0;
            in_ready_e_C <= 1;
        end
        if (in_ready && in_ready_e_C && in_last_e_C) begin
            in_ready_e_C <= 0;
            if (KEEP_A > 1) begin
                in_ready_W_Q <= 1;
                keep_A_cntr <= keep_A_cntr + 1;
                if (keep_A_cntr == KEEP_A-1) begin
                    keep_A_cntr <= 0;
                    if (ONLY_ONCE == 1) begin
                        in_ready_W_Q <= 1;
                    end else begin
                        in_ready_W_Q <= 0;
                        if (REUSE*HEADS > 1) begin
                            in_ready_I <= 1;
                        end
                    end
                end
            end else begin
                if (REUSE*HEADS > 1) begin
                    in_ready_I <= 1;
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
        in_valid_I <= 0;
        in_last_I  <= 0;
        rdaddr_I   <= 0;
        in_data_I  <= mem_I[rdaddr_I];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_I && rdaddr_I < REUSE*(HEADS/KEEP_A)*M1*M2-1) begin
                in_valid_I <= 1;
            end

            if (in_valid_I && in_ready_I && in_ready) begin
                in_data_I <= mem_I[rdaddr_I + 1];
                if (rdaddr_I < REUSE*(HEADS/KEEP_A)*M1*M2-1) begin
                    rdaddr_I <= rdaddr_I + 1;
                end

                if (rdaddr_I == (M1*M2)*(rdaddr_I/(M1*M2))+M1*M2-2) begin
                    in_last_I <= 1;
                end else if (rdaddr_I == (M1*M2)*(rdaddr_I/(M1*M2))+M1*M2-1) begin
                    in_valid_I <= 0;
                    in_last_I <= 0;
                    $display("attn_head: Done Sending input I to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_Q && rdaddr_W_Q < REUSE*HEADS*M2*M3-1) begin
                in_valid_W_Q <= 1;
            end

            if (in_valid_W_Q && in_ready_W_Q && in_ready) begin
                in_data_W_Q <= mem_W_Q[rdaddr_W_Q + 1];
                if (rdaddr_W_Q < REUSE*HEADS*M2*M3-1) begin
                    rdaddr_W_Q <= rdaddr_W_Q + 1;
                end

                if (rdaddr_W_Q == (M2*M3)*(rdaddr_W_Q/(M2*M3))+M2*M3-2) begin
                    in_last_W_Q <= 1;
                end else if (rdaddr_W_Q == (M2*M3)*(rdaddr_W_Q/(M2*M3))+M2*M3-1) begin
                    in_valid_W_Q <= 0;
                    in_last_W_Q <= 0;
                    $display("attn_head: Done Sending weight W_Q to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_K && rdaddr_W_K < REUSE*HEADS*M2*M3-1) begin
                in_valid_W_K <= 1;
            end

            if (in_valid_W_K && in_ready_W_K && in_ready) begin
                in_data_W_K <= mem_W_K[rdaddr_W_K + 1];
                if (rdaddr_W_K < REUSE*HEADS*M2*M3-1) begin
                    rdaddr_W_K <= rdaddr_W_K + 1;
                end

                if (rdaddr_W_K == (M2*M3)*(rdaddr_W_K/(M2*M3))+M2*M3-2) begin
                    in_last_W_K <= 1;
                end else if (rdaddr_W_K == (M2*M3)*(rdaddr_W_K/(M2*M3))+M2*M3-1) begin
                    in_valid_W_K <= 0;
                    in_last_W_K <= 0;
                    $display("attn_head: Done Sending weight W_K to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_V && rdaddr_W_V < REUSE*HEADS*M2*M3-1) begin
                in_valid_W_V <= 1;
            end

            if (in_valid_W_V && in_ready_W_V && in_ready) begin
                in_data_W_V <= mem_W_V[rdaddr_W_V + 1];
                if (rdaddr_W_V < REUSE*HEADS*M2*M3-1) begin
                    rdaddr_W_V <= rdaddr_W_V + 1;
                end

                if (rdaddr_W_V == (M2*M3)*(rdaddr_W_V/(M2*M3))+M2*M3-2) begin
                    in_last_W_V <= 1;
                end else if (rdaddr_W_V == (M2*M3)*(rdaddr_W_V/(M2*M3))+M2*M3-1) begin
                    in_valid_W_V <= 0;
                    in_last_W_V <= 0;
                    $display("attn_head: Done Sending weight W_V to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_bias_Q && rdaddr_bias_Q < REUSE*HEADS*M3-1) begin
                in_valid_bias_Q <= 1;
            end

            if (in_valid_bias_Q && in_ready_bias_Q && in_ready) begin
                in_data_bias_Q <= mem_bias_Q[rdaddr_bias_Q + 1];
                if (rdaddr_bias_Q < REUSE*HEADS*M3-1) begin
                    rdaddr_bias_Q <= rdaddr_bias_Q + 1;
                end

                if (rdaddr_bias_Q == M3*(rdaddr_bias_Q/M3)+M3-2) begin
                    in_last_bias_Q <= 1;
                end else if (rdaddr_bias_Q == M3*(rdaddr_bias_Q/M3)+M3-1) begin
                    in_valid_bias_Q <= 0;
                    in_last_bias_Q <= 0;
                    $display("attn_head: Done Sending bias bias_Q to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_bias_K && rdaddr_bias_K < REUSE*HEADS*M3-1) begin
                in_valid_bias_K <= 1;
            end

            if (in_valid_bias_K && in_ready_bias_K && in_ready) begin
                in_data_bias_K <= mem_bias_K[rdaddr_bias_K + 1];
                if (rdaddr_bias_K < REUSE*HEADS*M3-1) begin
                    rdaddr_bias_K <= rdaddr_bias_K + 1;
                end

                if (rdaddr_bias_K == M3*(rdaddr_bias_K/M3)+M3-2) begin
                    in_last_bias_K <= 1;
                end else if (rdaddr_bias_K == M3*(rdaddr_bias_K/M3)+M3-1) begin
                    in_valid_bias_K <= 0;
                    in_last_bias_K <= 0;
                    $display("attn_head: Done Sending bias bias_K to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_bias_V && rdaddr_bias_V < REUSE*HEADS*M3-1) begin
                in_valid_bias_V <= 1;
            end

            if (in_valid_bias_V && in_ready_bias_V && in_ready) begin
                in_data_bias_V <= mem_bias_V[rdaddr_bias_V + 1];
                if (rdaddr_bias_V < REUSE*HEADS*M3-1) begin
                    rdaddr_bias_V <= rdaddr_bias_V + 1;
                end

                if (rdaddr_bias_V == M3*(rdaddr_bias_V/M3)+M3-2) begin
                    in_last_bias_V <= 1;
                end else if (rdaddr_bias_V == M3*(rdaddr_bias_V/M3)+M3-1) begin
                    in_valid_bias_V <= 0;
                    in_last_bias_V <= 0;
                    $display("attn_head: Done Sending bias bias_V to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_m_Q && rdaddr_m_Q < REUSE*HEADS*M3-1) begin
                in_valid_m_Q <= 1;
            end

            if (in_valid_m_Q && in_ready_m_Q && in_ready) begin
                in_data_m_Q <= mem_m_Q[rdaddr_m_Q + 1];
                if (rdaddr_m_Q < REUSE*HEADS*M3-1) begin
                    rdaddr_m_Q <= rdaddr_m_Q + 1;
                end

                if (rdaddr_m_Q == M3*(rdaddr_m_Q/M3)+M3-2) begin
                    in_last_m_Q <= 1;
                end else if (rdaddr_m_Q == M3*(rdaddr_m_Q/M3)+M3-1) begin
                    in_valid_m_Q <= 0;
                    in_last_m_Q <= 0;
                    $display("attn_head: Done Sending requantization multiplier m_Q to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_m_K && rdaddr_m_K < REUSE*HEADS*M3-1) begin
                in_valid_m_K <= 1;
            end

            if (in_valid_m_K && in_ready_m_K && in_ready) begin
                in_data_m_K <= mem_m_K[rdaddr_m_K + 1];
                if (rdaddr_m_K < REUSE*HEADS*M3-1) begin
                    rdaddr_m_K <= rdaddr_m_K + 1;
                end

                if (rdaddr_m_K == M3*(rdaddr_m_K/M3)+M3-2) begin
                    in_last_m_K <= 1;
                end else if (rdaddr_m_K == M3*(rdaddr_m_K/M3)+M3-1) begin
                    in_valid_m_K <= 0;
                    in_last_m_K <= 0;
                    $display("attn_head: Done Sending requantization multiplier m_K to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_m_V && rdaddr_m_V < REUSE*HEADS*M3-1) begin
                in_valid_m_V <= 1;
            end

            if (in_valid_m_V && in_ready_m_V && in_ready) begin
                in_data_m_V <= mem_m_V[rdaddr_m_V + 1];
                if (rdaddr_m_V < REUSE*HEADS*M3-1) begin
                    rdaddr_m_V <= rdaddr_m_V + 1;
                end

                if (rdaddr_m_V == M3*(rdaddr_m_V/M3)+M3-2) begin
                    in_last_m_V <= 1;
                end else if (rdaddr_m_V == M3*(rdaddr_m_V/M3)+M3-1) begin
                    in_valid_m_V <= 0;
                    in_last_m_V <= 0;
                    $display("attn_head: Done Sending requantization multiplier m_V to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_e_Q && rdaddr_e_Q < REUSE*HEADS*M3-1) begin
                in_valid_e_Q <= 1;
            end

            if (in_valid_e_Q && in_ready_e_Q && in_ready) begin
                in_data_e_Q <= mem_e_Q[rdaddr_e_Q + 1];
                if (rdaddr_e_Q < REUSE*HEADS*M3-1) begin
                    rdaddr_e_Q <= rdaddr_e_Q + 1;
                end

                if (rdaddr_e_Q == M3*(rdaddr_e_Q/M3)+M3-2) begin
                    in_last_e_Q <= 1;
                end else if (rdaddr_e_Q == M3*(rdaddr_e_Q/M3)+M3-1) begin
                    in_valid_e_Q <= 0;
                    in_last_e_Q <= 0;
                    $display("attn_head: Done Sending requantization shifter e_Q to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_e_K && rdaddr_e_K < REUSE*HEADS*M3-1) begin
                in_valid_e_K <= 1;
            end

            if (in_valid_e_K && in_ready_e_K && in_ready) begin
                in_data_e_K <= mem_e_K[rdaddr_e_K + 1];
                if (rdaddr_e_K < REUSE*HEADS*M3-1) begin
                    rdaddr_e_K <= rdaddr_e_K + 1;
                end

                if (rdaddr_e_K == M3*(rdaddr_e_K/M3)+M3-2) begin
                    in_last_e_K <= 1;
                end else if (rdaddr_e_K == M3*(rdaddr_e_K/M3)+M3-1) begin
                    in_valid_e_K <= 0;
                    in_last_e_K <= 0;
                    $display("attn_head: Done Sending requantization shifter e_K to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_e_V && rdaddr_e_V < REUSE*HEADS*M3-1) begin
                in_valid_e_V <= 1;
            end

            if (in_valid_e_V && in_ready_e_V && in_ready) begin
                in_data_e_V <= mem_e_V[rdaddr_e_V + 1];
                if (rdaddr_e_V < REUSE*HEADS*M3-1) begin
                    rdaddr_e_V <= rdaddr_e_V + 1;
                end

                if (rdaddr_e_V == M3*(rdaddr_e_V/M3)+M3-2) begin
                    in_last_e_V <= 1;
                end else if (rdaddr_e_V == M3*(rdaddr_e_V/M3)+M3-1) begin
                    in_valid_e_V <= 0;
                    in_last_e_V <= 0;
                    $display("attn_head: Done Sending requantization shifter e_V to Top Module at time=%0d", ctime);
                end
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
    end else begin
        if (axi_lite_done) begin
            if (in_ready_m_C && rdaddr_m_C < REUSE*HEADS) begin
                in_valid_m_C <= 1;
                in_last_m_C <= 1;
            end

            if (in_valid_m_C && in_ready_m_C && in_ready) begin
                if (REUSE*HEADS > 1) begin
                    in_data_m_C <= mem_m_C[rdaddr_m_C + 1];
                end
                if (rdaddr_m_C < REUSE*HEADS) begin
                    rdaddr_m_C <= rdaddr_m_C + 1;
                end

                in_valid_m_C <= 0;
                in_last_m_C <= 0;
                $display("attn_head: Done Sending requantization multiplier m_C to Top Module at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_e_C <= 0;
        in_last_e_C  <= 0;
        rdaddr_e_C   <= 0;
        in_data_e_C  <= mem_e_C[rdaddr_e_C];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_e_C && rdaddr_e_C < REUSE*HEADS) begin
                in_valid_e_C <= 1;
                in_last_e_C <= 1;
            end

            if (in_valid_e_C && in_ready_e_C && in_ready) begin
                if (REUSE*HEADS > 1) begin
                    in_data_e_C <= mem_e_C[rdaddr_e_C + 1];
                end
                if (rdaddr_e_C < REUSE*HEADS) begin
                    rdaddr_e_C <= rdaddr_e_C + 1;
                end

                in_valid_e_C <= 0;
                in_last_e_C <= 0;
                $display("attn_head: Done Sending requantization shifter e_C to Top Module at time=%0d", ctime);
            end
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
        if (save_Q) begin
            wraddr_Q <= (wraddr_Q == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_Q + 1;
            mem_Q[wraddr_Q] <= data_Q;
            if (wraddr_Q == (M1*M3)*(wraddr_Q/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done computing Q=I*W_Q at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_K <= 0;
    end else begin
        if (save_K) begin
            wraddr_K <= (wraddr_K == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_K + 1;
            mem_K[wraddr_K] <= data_K;
            if (wraddr_K == (M1*M3)*(wraddr_K/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done computing K=I*W_K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_V <= 0;
    end else begin
        if (save_V) begin
            wraddr_V <= (wraddr_V == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_V + 1;
            mem_V[wraddr_V] <= data_V;
            if (wraddr_V == (M1*M3)*(wraddr_V/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done computing V=I*W_V at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_Q_req <= 0;
    end else begin
        if (save_Q_req) begin
            mem_Q_req[wraddr_Q_req] <= data_Q_req;
            wraddr_Q_req <= (wraddr_Q_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_Q_req + 1;
            if (wraddr_Q_req == (M1*M3)*(wraddr_Q_req/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done Requantizing Q at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_K_req <= 0;
    end else begin
        if (save_K_req) begin
            mem_K_req[wraddr_K_req] <= data_K_req;
            wraddr_K_req <= (wraddr_K_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_K_req + 1;
            if (wraddr_K_req == (M1*M3)*(wraddr_K_req/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done Requantizing K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_V_req <= 0;
    end else begin
        if (save_V_req) begin
            mem_V_req[wraddr_V_req] <= data_V_req;
            wraddr_V_req <= (wraddr_V_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_V_req + 1;
            if (wraddr_V_req == (M1*M3)*(wraddr_V_req/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done Requantizing V at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_S <= 0;
    end else begin
        if (save_S) begin
            wraddr_S <= (wraddr_S == REUSE*HEADS*M1*M1-1) ? 0 : wraddr_S + 1;
            mem_S[wraddr_S] <= data_S;
            if (wraddr_S == (M1*M1)*(wraddr_S/(M1*M1))+M1*M1-1) begin
                $display("attn_head: Done computing S=Q*K at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_P <= 0;
    end else begin
        if (save_softmax_out) begin
            wraddr_P <= (wraddr_P == REUSE*HEADS*M1*M1-1) ? 0 : wraddr_P + 1;
            mem_P[wraddr_P] <= data_softmax_out;
            if (wraddr_P == (M1*M1)*(wraddr_P/(M1*M1))+M1*M1-1) begin
                $display("attn_head: Done computing P=softmax(S) at time=%0d", ctime);
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        wraddr_C <= 0;
    end else begin
        if (save_C) begin
            wraddr_C <= (wraddr_C == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_C + 1;
            mem_C[wraddr_C] <= data_C;
            if (wraddr_C == (M1*M3)*(wraddr_C/(M1*M3))+M1*M3-1) begin
                $display("attn_head: Done computing C=P*V at time=%0d", ctime);
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
                $display("attn_head: -- Finished Head %0d out of %0d at time=%0d.\n###", done_cntr + 1, REUSE*HEADS, ctime);
            end
            done_cntr <= done_cntr + 1;
            if (done_cntr == REUSE*HEADS-1) begin
                attn_head_done <= 1;
            end
        end

        if (out_valid) begin
            wraddr_C_req <= (wraddr_C_req == REUSE*HEADS*M1*M3-1) ? 0 : wraddr_C_req + 1;
            mem_C_req[wraddr_C_req] <= out_data;
        end
    end
end

endmodule
/* verilator lint_off UNDRIVEN */
