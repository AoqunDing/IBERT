`include "names.h"
`timescale 1ps / 1ps
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
module mm_ln_axi_tb
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

always #50000 clk  = ~clk;
always #20000 fclk = ~fclk;

always @(posedge clk) begin
    rst_r <= rst_r >> 1;
end
`else
wire fclk = clk;
`endif

localparam integer REP = REUSE*M1*M2*M3*SLICES/2;
localparam integer C_S_AXI_AXILITES_DATA_WIDTH  = 32;
localparam integer C_S_AXI_AXILITES_ADDR_WIDTH  = 8;
localparam integer C_S_AXI_DATA_WIDTH           = 32;
localparam integer C_S_AXI_AXILITES_WSTRB_WIDTH = (32 / 8);
localparam integer C_S_AXI_WSTRB_WIDTH          = (32 / 8);

localparam
    ADDR_A_V_DATA_0 = 8'h10,
    ADDR_B_V_DATA_0 = 8'h18,
    ADDR_C_V_DATA_0 = 8'h20,
    ADDR_D_V_DATA_0 = 8'h28,
    ADDR_E_V_DATA_0 = 8'h30,
    ADDR_F_V_DATA_0 = 8'h38,
    ADDR_G_V_DATA_0 = 8'h40,
    ADDR_H_V_DATA_0 = 8'h48,
    ADDR_I_V_DATA_0 = 8'h50,
    ADDR_J_V_DATA_0 = 8'h58,
    ADDR_K_V_DATA_0 = 8'h60,
    ADDR_L_V_DATA_0 = 8'h68,
    ADDR_M_V_DATA_0 = 8'h70,
    ADDR_N_V_DATA_0 = 8'h78,
    ADDR_O_V_DATA_0 = 8'h80,
    ADDR_P_V_DATA_0 = 8'h88,
    ADDR_Q_V_DATA_0 = 8'h90,
    ADDR_R_V_DATA_0 = 8'h98,
    ADDR_S_V_DATA_0 = 8'ha0,
    ADDR_T_V_DATA_0 = 8'ha8,
    DONE_ADDR       = 8'hff;

localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1                   = M1;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M2                   = M2;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M3                   = M3;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM2                = M1*M2;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M2xM3                = M2*M3;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM1dN1             = M1*M1/N1;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM3                = M1*M3;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM3dN1             = M1*M3/N1;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1dN1                = M1/N1;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M3dN2                = M3/N2;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM3dN1xN2          = (M1*M3)/(N1*N2);
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xM1dN1xN1          = (M1*M1)/(N1*N1);
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _BLOCKS               = BLOCKS;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _BLOCK_WIDTH          = M3/BLOCKS;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _BLOCK_WIDTHdN2       = (M3/BLOCKS)/N2;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _BLOCK_SIZEdN2        = M2*(M3/BLOCKS)/N2;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xBLOCK_WIDTHdN1xN2 = (M1*(M3/BLOCKS))/(N1*N2);
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _M1xBLOCK_WIDTHdN1    = (M1*(M3/BLOCKS))/(N1);
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _HEAD                 = 0;
localparam [C_S_AXI_AXILITES_DATA_WIDTH-1:0] _LAYER                = 0;

reg                                       s_axi_AXILiteS_AWVALID;
wire                                      s_axi_AXILiteS_AWREADY;
reg  [C_S_AXI_AXILITES_ADDR_WIDTH - 1:0]  s_axi_AXILiteS_AWADDR;
reg                                       s_axi_AXILiteS_WVALID;
wire                                      s_axi_AXILiteS_WREADY;
reg  [C_S_AXI_AXILITES_DATA_WIDTH - 1:0]  s_axi_AXILiteS_WDATA;
reg  [C_S_AXI_AXILITES_WSTRB_WIDTH - 1:0] s_axi_AXILiteS_WSTRB = {C_S_AXI_AXILITES_WSTRB_WIDTH{1'b1}};
reg                                       s_axi_AXILiteS_ARVALID;
wire                                      s_axi_AXILiteS_ARREADY;
reg  [C_S_AXI_AXILITES_ADDR_WIDTH - 1:0]  s_axi_AXILiteS_ARADDR;
wire                                      s_axi_AXILiteS_RVALID;
reg                                       s_axi_AXILiteS_RREADY;
wire [C_S_AXI_AXILITES_DATA_WIDTH - 1:0]  s_axi_AXILiteS_RDATA;
wire [1:0]                                s_axi_AXILiteS_RRESP;
wire                                      s_axi_AXILiteS_BVALID;
reg                                       s_axi_AXILiteS_BREADY = 1'b1;
wire [1:0]                                s_axi_AXILiteS_BRESP;

reg axi_lite_done;

wire                      in_valid;
wire signed [31:0]        in_data;
reg                       in_last;
wire                      in_ready;

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

wire                      out_valid;
wire signed [D_W-1:0]     out_data;
wire signed [31:0]        out_data_stream;
wire                      out_last;
reg                       mm_ln_done;

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

// axi lite
always @(posedge clk) begin
    if (rst) begin
        s_axi_AXILiteS_AWVALID <= 0;
        s_axi_AXILiteS_WVALID <= 0;
        axi_lite_done <= 0;
    end else begin
        s_axi_AXILiteS_AWVALID <= 1;
        s_axi_AXILiteS_WVALID <= 1;
        axi_lite_done <= 0;
        if (s_axi_AXILiteS_AWADDR == DONE_ADDR) begin
            s_axi_AXILiteS_AWVALID <= 0;
            s_axi_AXILiteS_WVALID <= 0;
            axi_lite_done <= 1;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        s_axi_AXILiteS_AWADDR <= ADDR_A_V_DATA_0;
    end else begin
        if (s_axi_AXILiteS_AWVALID && s_axi_AXILiteS_AWREADY) begin
            case (s_axi_AXILiteS_AWADDR)
                ADDR_A_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_B_V_DATA_0;
                end
                ADDR_B_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_C_V_DATA_0;
                end
                ADDR_C_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_D_V_DATA_0;
                end
                ADDR_D_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_E_V_DATA_0;
                end
                ADDR_E_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_F_V_DATA_0;
                end
                ADDR_F_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_G_V_DATA_0;
                end
                ADDR_G_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_H_V_DATA_0;
                end
                ADDR_H_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_I_V_DATA_0;
                end
                ADDR_I_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_J_V_DATA_0;
                end
                ADDR_J_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_K_V_DATA_0;
                end
                ADDR_K_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_L_V_DATA_0;
                end
                ADDR_L_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_M_V_DATA_0;
                end
                ADDR_M_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_N_V_DATA_0;
                end
                ADDR_N_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_O_V_DATA_0;
                end
                ADDR_O_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_P_V_DATA_0;
                end
                ADDR_P_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_Q_V_DATA_0;
                end
                ADDR_Q_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_R_V_DATA_0;
                end
                ADDR_R_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_S_V_DATA_0;
                end
                ADDR_S_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= ADDR_T_V_DATA_0;
                end
                ADDR_T_V_DATA_0: begin
                    s_axi_AXILiteS_AWADDR <= DONE_ADDR;
                end
                DONE_ADDR: begin
                    s_axi_AXILiteS_AWADDR <= DONE_ADDR;
                end
                default: begin
                    s_axi_AXILiteS_AWADDR <= DONE_ADDR;
                end
            endcase
        end 
    end
end

always @(posedge clk) begin
    if (rst) begin
        s_axi_AXILiteS_WDATA <= _M1;
    end else begin
        if (s_axi_AXILiteS_WVALID && s_axi_AXILiteS_WREADY) begin
            case (s_axi_AXILiteS_AWADDR)
                ADDR_A_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1;
                end
                ADDR_B_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M2;
                end
                ADDR_C_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M3;
                end
                ADDR_D_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM2;
                end
                ADDR_E_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M2xM3;
                end
                ADDR_F_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM1dN1;
                end
                ADDR_G_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM3;
                end
                ADDR_H_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM3dN1;
                end
                ADDR_I_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1dN1;
                end
                ADDR_J_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M3dN2;
                end
                ADDR_K_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM3dN1xN2;
                end
                ADDR_L_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xM1dN1xN1;
                end
                ADDR_M_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _BLOCKS;
                end
                ADDR_N_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _BLOCK_WIDTH;
                end
                ADDR_O_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _BLOCK_WIDTHdN2;
                end
                ADDR_P_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _BLOCK_SIZEdN2;
                end
                ADDR_Q_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xBLOCK_WIDTHdN1xN2;
                end
                ADDR_R_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _M1xBLOCK_WIDTHdN1;
                end
                ADDR_S_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _HEAD;
                end
                ADDR_T_V_DATA_0: begin
                    s_axi_AXILiteS_WDATA <= _LAYER;
                end
                DONE_ADDR: begin
                    s_axi_AXILiteS_WDATA <= 0;
                end
                default: begin
                    s_axi_AXILiteS_WDATA <= 0;
                end
            endcase
        end
    end
end

assign in_valid = (in_ready_X)       ? in_valid_X       :
                  (in_ready_W)       ? in_valid_W       :
                  (in_ready_R_m)     ? in_valid_R_m     :
                  (in_ready_R_e)     ? in_valid_R_e     :
                  (in_ready_R)       ? in_valid_R       :
                  (in_ready_W_bias)  ? in_valid_W_bias  :
                  (in_ready_W_m)     ? in_valid_W_m     :
                  (in_ready_W_e)     ? in_valid_W_e     :
                  (in_ready_ln_bias) ? in_valid_ln_bias :
                  (in_ready_out_m)   ? in_valid_out_m   :
                  (in_ready_out_e)   ? in_valid_out_e   : 0;

assign in_data = (in_valid_X)       ? in_data_X       :
                 (in_valid_W)       ? in_data_W       :
                 (in_valid_R_m)     ? in_data_R_m     :
                 (in_valid_R_e)     ? in_data_R_e     :
                 (in_valid_R)       ? in_data_R       :
                 (in_valid_W_bias)  ? in_data_W_bias  :
                 (in_valid_W_m)     ? in_data_W_m     :
                 (in_valid_W_e)     ? in_data_W_e     :
                 (in_valid_ln_bias) ? in_data_ln_bias :
                 (in_valid_out_m)   ? in_data_out_m   :
                 (in_valid_out_e)   ? in_data_out_e   : 0;

always @(posedge clk) begin
    if (rst) begin
        in_ready_X <= 1;
        in_ready_W <= 0;
        in_ready_R_m <= 0;
        in_ready_R_e <= 0;
        in_ready_R <= 0;
        in_ready_W_bias <= 0;
        in_ready_W_m <= 0;
        in_ready_W_e <= 0;
        in_ready_ln_bias <= 0;
        in_ready_out_m <= 0;
        in_ready_out_e <= 0;
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
            in_ready_R <= 1;
        end
        if (in_ready && in_ready_R && in_last_R) begin
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
            if (REUSE > 1) begin
                in_ready_X <= 1;
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
            if (in_ready_X && rdaddr_X < REUSE*M1*M2-1) begin
                in_valid_X <= 1;
            end

            if (in_valid_X && in_ready_X && in_ready) begin
                in_data_X <= mem_X[rdaddr_X + 1];
                if (rdaddr_X < REUSE*M1*M2-1) begin
                    rdaddr_X <= rdaddr_X + 1;
                end

                if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-2) begin
                    in_last_X <= 1;
                end else if (rdaddr_X == (M1*M2)*(rdaddr_X/(M1*M2))+M1*M2-1) begin
                    in_valid_X <= 0;
                    in_last_X <= 0;
                    $display("Done Sending input X to Top Module at time=%0d", ctime);
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
            if (in_ready_W && rdaddr_W < REUSE*M2*M3-1) begin
                in_valid_W <= 1;
            end

            if (in_valid_W && in_ready_W && in_ready) begin
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
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_R <= 0;
        in_last_R  <= 0;
        rdaddr_R   <= 0;
        in_data_R  <= mem_R[rdaddr_R];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_R && rdaddr_R < REUSE*M1*M3-1) begin
                in_valid_R <= 1;
            end

            if (in_valid_R && in_ready_R && in_ready) begin
                in_data_R <= mem_R[rdaddr_R + 1];
                if (rdaddr_R < REUSE*M1*M3-1) begin
                    rdaddr_R <= rdaddr_R + 1;
                end

                if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-2) begin
                    in_last_R <= 1;
                end else if (rdaddr_R == (M1*M3)*(rdaddr_R/(M1*M3))+M1*M3-1) begin
                    in_valid_R <= 0;
                    in_last_R <= 0;
                    $display("Done Sending residual input R to Top Module at time=%0d", ctime);
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
            if (in_ready_W_bias && rdaddr_W_bias < REUSE*M3-1) begin
                in_valid_W_bias <= 1;
            end

            if (in_valid_W_bias && in_ready_W_bias && in_ready) begin
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
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_W_m <= 0;
        in_last_W_m  <= 0;
        rdaddr_W_m   <= 0;
        in_data_W_m  <= mem_W_m[rdaddr_W_m];
    end else begin
        if (axi_lite_done) begin
            if (in_ready_W_m && rdaddr_W_m < REUSE*M3-1) begin
                in_valid_W_m <= 1;
            end

            if (in_valid_W_m && in_ready_W_m && in_ready) begin
                in_data_W_m <= mem_W_m[rdaddr_W_m + 1];
                if (rdaddr_W_m < REUSE*M3-1) begin
                    rdaddr_W_m <= rdaddr_W_m + 1;
                end

                if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-2) begin
                    in_last_W_m <= 1;
                end else if (rdaddr_W_m == M3*(rdaddr_W_m/M3)+M3-1) begin
                    in_valid_W_m <= 0;
                    in_last_W_m <= 0;
                    $display("Done Sending requantization multiplier W_m to Top Module at time=%0d", ctime);
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
            if (in_ready_W_e && rdaddr_W_e < REUSE*M3-1) begin
                in_valid_W_e <= 1;
            end

            if (in_valid_W_e && in_ready_W_e && in_ready) begin
                in_data_W_e <= mem_W_e[rdaddr_W_e + 1];
                if (rdaddr_W_e < REUSE*M3-1) begin
                    rdaddr_W_e <= rdaddr_W_e + 1;
                end

                if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-2) begin
                    in_last_W_e <= 1;
                end else if (rdaddr_W_e == M3*(rdaddr_W_e/M3)+M3-1) begin
                    in_valid_W_e <= 0;
                    in_last_W_e <= 0;
                    $display("Done Sending requantization shifter W_e to Top Module at time=%0d", ctime);
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
            if (in_ready_R_m && rdaddr_R_m < REUSE) begin
                in_valid_R_m <= 1;
                in_last_R_m <= 1;
            end

            if (in_valid_R_m && in_ready_R_m && in_ready) begin
                if (REUSE > 1) begin
                    in_data_R_m <= mem_R_m[rdaddr_R_m + 1];
                end
                if (rdaddr_R_m < REUSE) begin
                    rdaddr_R_m <= rdaddr_R_m + 1;
                end

                in_valid_R_m <= 0;
                in_last_R_m <= 0;
                $display("Done Sending requantization multiplier R_m to Top Module at time=%0d", ctime);
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
            if (in_ready_R_e && rdaddr_R_e < REUSE) begin
                in_valid_R_e <= 1;
                in_last_R_e <= 1;
            end

            if (in_valid_R_e && in_ready_R_e && in_ready) begin
                if (REUSE > 1) begin
                    in_data_R_e <= mem_R_e[rdaddr_R_e + 1];
                end
                if (rdaddr_R_e < REUSE) begin
                    rdaddr_R_e <= rdaddr_R_e + 1;
                end

                in_valid_R_e <= 0;
                in_last_R_e <= 0;
                $display("Done Sending requantization shifter R_e to Top Module at time=%0d", ctime);
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
            if (in_ready_ln_bias && rdaddr_ln_bias < REUSE*M3-1) begin
                in_valid_ln_bias <= 1;
            end

            if (in_valid_ln_bias && in_ready_ln_bias && in_ready) begin
                in_data_ln_bias <= mem_ln_bias[rdaddr_ln_bias + 1];
                if (rdaddr_ln_bias < REUSE*M3-1) begin
                    rdaddr_ln_bias <= rdaddr_ln_bias + 1;
                end

                if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-2) begin
                    in_last_ln_bias <= 1;
                end else if (rdaddr_ln_bias == M3*(rdaddr_ln_bias/M3)+M3-1) begin
                    in_valid_ln_bias <= 0;
                    in_last_ln_bias <= 0;
                    $display("Done Sending LayerNorm bias ln_bias to Top Module at time=%0d", ctime);
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
            if (in_ready_out_m && rdaddr_out_m < REUSE*M3-1) begin
                in_valid_out_m <= 1;
            end

            if (in_valid_out_m && in_ready_out_m && in_ready) begin
                in_data_out_m <= mem_out_m[rdaddr_out_m + 1];
                if (rdaddr_out_m < REUSE*M3-1) begin
                    rdaddr_out_m <= rdaddr_out_m + 1;
                end

                if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-2) begin
                    in_last_out_m <= 1;
                end else if (rdaddr_out_m == M3*(rdaddr_out_m/M3)+M3-1) begin
                    in_valid_out_m <= 0;
                    in_last_out_m <= 0;
                    $display("Done Sending requantization multiplier out_m to Top Module at time=%0d", ctime);
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
            if (in_ready_out_e && rdaddr_out_e < REUSE*M3-1) begin
                in_valid_out_e <= 1;
            end

            if (in_valid_out_e && in_ready_out_e && in_ready) begin
                in_data_out_e <= mem_out_e[rdaddr_out_e + 1];
                if (rdaddr_out_e < REUSE*M3-1) begin
                    rdaddr_out_e <= rdaddr_out_e + 1;
                end

                if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-2) begin
                    in_last_out_e <= 1;
                end else if (rdaddr_out_e == M3*(rdaddr_out_e/M3)+M3-1) begin
                    in_valid_out_e <= 0;
                    in_last_out_e <= 0;
                    $display("Done Sending requantization shifter out_e to Top Module at time=%0d", ctime);
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
	    if (mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mm_Y.m_axis_mm2s_tvalid == 1'b1 &&
            mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mm_Y.m_axis_mm2s_tready == 1'b1) begin
            wraddr_Y <= (wraddr_Y == REUSE*M1*M3-1) ? 0 : wraddr_Y + 1;
            mem_Y[wraddr_Y] <= mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mm_Y.m_axis_mm2s_tdata;
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
	    if (mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_Y.out_tvalid == 1'b1 &&
            mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_Y.out_tready == 1'b1) begin
            wraddr_Y_req <= (wraddr_Y_req == REUSE*M1*M3-1) ? 0 : wraddr_Y_req + 1;
            mem_Y_req[wraddr_Y_req] <= mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_Y.out_tdata;
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
	    if (mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_R.out_tvalid == 1'b1 &&
            mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_R.out_tready == 1'b1) begin
            wraddr_R_req <= (wraddr_R_req == REUSE*M1*M3-1) ? 0 : wraddr_R_req + 1;
            mem_R_req[wraddr_R_req] <= mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`requant_R.out_tdata;
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
	    if (mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mat_add_Z.out_tvalid_Z == 1'b1 &&
            mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mat_add_Z.out_tready_Z == 1'b1) begin
            wraddr_Z <= (wraddr_Z == REUSE*M1*M3-1) ? 0 : wraddr_Z + 1;
            mem_Z[wraddr_Z] <= mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`mat_add_Z.out_tdata_Z;
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
	    if (mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`layer_norm_top.qout_tvalid == 1'b1 &&
            mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`layer_norm_top.qout_tready == 1'b1) begin
            wraddr_ln_out <= (wraddr_ln_out == REUSE*M1*M3-1) ? 0 : wraddr_ln_out + 1;
            mem_ln_out[wraddr_ln_out] <= mm_ln_axi_test.mm_ln_wrap_inst.mm_ln_inst.`layer_norm_top.qout_tdata;
            if (wraddr_ln_out == (M1*M3)*(wraddr_ln_out/(M1*M3))+M1*M3-1) begin
                $display("Done computing LayerNorm at time=%0d", ctime);
            end
        end
    end
end

assign out_data = out_data_stream[D_W-1:0];

always @(posedge clk) begin
    if (rst) begin
        wraddr_out <= 0;
        mm_ln_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_last) begin
            $display("-- Finished Layer %0d out of %0d at time=%0d.\n###\n", done_cntr + 1, REUSE, ctime);
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

mm_ln_axi
`ifndef XIL_TIMING
#(
    .D_W(D_W),
    .D_W_ACC(D_W_ACC),
    .LN_BITS(LN_BITS),
    .N1(N1),
    .N2(N2),
    .MATRIXSIZE_W(MATRIXSIZE_W),
    .MEM_DEPTH_A(MEM_DEPTH_A),
    .MEM_DEPTH_B(MEM_DEPTH_B),
    .MEM_DEPTH_D(MEM_DEPTH_D),
    .MAT_ADD_MEM_DEPTH(MAT_ADD_MEM_DEPTH),
    .REQ_MEM_DEPTH(M3)
)
`endif
mm_ln_axi_test (
    .clk       (clk),
    .fclk      (fclk),
    .rst_n     (~rst),
    
    .x_TVALID  (in_valid),
    .x_TDATA   (in_data),
    .x_TLAST   (in_last),
    .x_TREADY  (in_ready),

    .y_TVALID  (out_valid),
    .y_TDATA   (out_data_stream),
    .y_TLAST   (out_last),
    .y_TREADY  (1'b1),

    .s_axi_AXILiteS_AWVALID ( s_axi_AXILiteS_AWVALID ),
    .s_axi_AXILiteS_AWREADY ( s_axi_AXILiteS_AWREADY ),
    .s_axi_AXILiteS_AWADDR  ( s_axi_AXILiteS_AWADDR ),
    .s_axi_AXILiteS_WVALID  ( s_axi_AXILiteS_WVALID ),
    .s_axi_AXILiteS_WREADY  ( s_axi_AXILiteS_WREADY ),
    .s_axi_AXILiteS_WDATA   ( s_axi_AXILiteS_WDATA ),
    .s_axi_AXILiteS_WSTRB   ( s_axi_AXILiteS_WSTRB ),
    .s_axi_AXILiteS_ARVALID ( s_axi_AXILiteS_ARVALID ),
    .s_axi_AXILiteS_ARREADY ( s_axi_AXILiteS_ARREADY ),
    .s_axi_AXILiteS_ARADDR  ( s_axi_AXILiteS_ARADDR ),
    .s_axi_AXILiteS_RVALID  ( s_axi_AXILiteS_RVALID ),
    .s_axi_AXILiteS_RREADY  ( s_axi_AXILiteS_RREADY ),
    .s_axi_AXILiteS_RDATA   ( s_axi_AXILiteS_RDATA ),
    .s_axi_AXILiteS_RRESP   ( s_axi_AXILiteS_RRESP ),
    .s_axi_AXILiteS_BVALID  ( s_axi_AXILiteS_BVALID ),
    .s_axi_AXILiteS_BREADY  ( s_axi_AXILiteS_BREADY ),
    .s_axi_AXILiteS_BRESP   ( s_axi_AXILiteS_BRESP )
);

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("mm_ln_axi.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("mm_ln_axi.vcd");
            $dumpvars();
        end
    `endif
`endif

endmodule
/* verilator lint_on UNDRIVEN */
