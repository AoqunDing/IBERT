`include "names.h"

`timescale 1ps / 1ps
import dims::*;
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
module ibert_axi_tb
`endif
#(
    parameter integer D_W              = 8,
    parameter integer D_W_ACC          = 32,
    parameter integer N1               = 4,
    parameter integer N2               = 4,
    parameter integer sN1              = 4,
    parameter integer sN2              = 4,
    parameter integer MATRIXSIZE_W     = 24,
    parameter integer KEEP_A           = 12,
    parameter integer SLICES           = 8,
    parameter integer LAYERS           = 12,
    parameter integer HEADS            = 12,
    parameter integer TOKENS           = 32,
    parameter integer EMBED_SIZE       = 768,
    parameter integer INTER_SIZE       = 3072,
    parameter integer N1_HEAD          = 8,
    parameter integer N2_HEAD          = 8,
    parameter integer BLOCKS_HEAD      = 8,
    parameter integer BLOCKS_SELF      = 192,
    parameter integer BLOCKS_INTER     = 768,
    parameter integer BLOCKS_LAYER     = 192,
    parameter         BLOCKED_D        = 0,
    parameter integer LN_BITS          = 22,
    parameter integer ONLY_ONCE        = 1,
    parameter integer REUSE            = 1
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

localparam integer HEAD_SIZE = EMBED_SIZE/HEADS;
localparam integer M1_HEAD = TOKENS;
localparam integer M2_HEAD = EMBED_SIZE;
localparam integer M3_HEAD = HEAD_SIZE;

localparam integer M1_SELF = TOKENS/SLICES;
localparam integer M2_SELF = EMBED_SIZE;
localparam integer M3_SELF = EMBED_SIZE;

localparam integer M1_INTER = TOKENS/SLICES;
localparam integer M2_INTER = EMBED_SIZE;
localparam integer M3_INTER = INTER_SIZE;

localparam integer M1_LAYER = TOKENS/SLICES;
localparam integer M2_LAYER = INTER_SIZE;
localparam integer M3_LAYER = EMBED_SIZE;

localparam integer REP = 4*REUSE*12*EMBED_SIZE*EMBED_SIZE;

wire in_valid;
wire signed [31:0] in_data;
wire in_last;
wire in_ready;

wire out_valid;
wire signed [31:0] out_data;
wire out_last;
wire out_ready;

// Head Instance Wires
wire head_in_valid;
wire signed [31:0] head_in_data;
wire head_in_ready;
wire head_save_Q;
wire signed [31:0] head_data_Q;
wire head_save_K;
wire signed [31:0] head_data_K;
wire head_save_V;
wire signed [31:0] head_data_V;
wire head_save_Q_req;
wire signed [31:0] head_data_Q_req;
wire head_save_K_req;
wire signed [31:0] head_data_K_req;
wire head_save_V_req;
wire signed [31:0] head_data_V_req;
wire head_save_S;
wire signed [31:0] head_data_S;
wire head_save_softmax_out;
wire signed [31:0] head_data_softmax_out;
wire head_save_C;
wire signed [31:0] head_data_C;
wire head_out_valid;
wire signed [31:0] head_out_data;
wire head_out_last;

// Self Instance Wires
wire self_in_valid;
wire signed [31:0] self_in_data;
wire self_in_ready;
wire self_save_Y;
wire signed [31:0] self_data_Y;
wire self_save_Y_req;
wire signed [31:0] self_data_Y_req;
wire self_save_R_req;
wire signed [31:0] self_data_R_req;
wire self_save_Z;
wire signed [31:0] self_data_Z;
wire self_save_ln_out;
wire signed [31:0] self_data_ln_out;
wire self_out_valid;
wire signed [31:0] self_out_data;
wire self_out_last;

// Intermediate Instance Wires
wire inter_in_valid;
wire signed [31:0] inter_in_data;
wire inter_in_ready;
wire inter_save_G;
wire signed [31:0] inter_data_G;
wire inter_save_G_req;
wire signed [31:0] inter_data_G_req;
wire inter_save_gelu_out;
wire signed [31:0] inter_data_gelu_out;
wire inter_out_valid;
wire signed [31:0] inter_out_data;
wire inter_out_last;

// Layer Instance Wires
wire layer_in_valid;
wire signed [31:0] layer_in_data;
wire layer_in_ready;
wire layer_save_Y;
wire signed [31:0] layer_data_Y;
wire layer_save_Y_req;
wire signed [31:0] layer_data_Y_req;
wire layer_save_R_req;
wire signed [31:0] layer_data_R_req;
wire layer_save_Z;
wire signed [31:0] layer_data_Z;
wire layer_save_ln_out;
wire signed [31:0] layer_data_ln_out;
wire layer_out_valid;
wire signed [31:0] layer_out_data;
wire layer_out_last;

reg [$clog2(2*REUSE):0] done_cntr;
reg ibert_axi_done;

int ctime = 0;
always @(posedge clk) begin
    ctime <= ctime + 1;
    // if (ctime % (32*768*64) == 0) begin
    //     $display("...");
    // end
    if (ctime > REP) begin
        $display("Error: Timed out!");
        $finish;
    end
    if (ibert_axi_done) begin
        $display("Done at time=%0d", ctime);
        $finish;
    end
end

typedef enum logic [2:0] {
    IDLE = 3'b000,
    TX_HEAD = 3'b001,
    TX_SELF = 3'b010,
    TX_INTER = 3'b011,
    TX_LAYER = 3'b100
} tx_state_t;

tx_state_t current_state, next_state;

always @(posedge clk) begin
    if (rst) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

assign head_in_ready = (current_state == TX_HEAD) & in_ready;
assign self_in_ready = (current_state == TX_SELF) & in_ready;
assign inter_in_ready = (current_state == TX_INTER) & in_ready;
assign layer_in_ready = (current_state == TX_LAYER) & in_ready;

always_comb begin
    case (current_state)
        TX_HEAD:
            next_state = (in_ready &&
                          ibert_attn_head.in_ready_e_C &&
                          ibert_attn_head.in_last_e_C &&
                          ibert_attn_head.keep_A_cntr == KEEP_A-1) ? TX_SELF : TX_HEAD;
        TX_SELF:
            next_state = (in_ready &&
                          ibert_self.in_ready_out_e &&
                          ibert_self.in_last_out_e) ? TX_INTER : TX_SELF;
        TX_INTER:
            next_state = (in_ready &&
                          ibert_inter.in_ready_W &&
                          ibert_inter.in_last_W) ? TX_LAYER : TX_INTER;
        TX_LAYER:
            next_state = (in_ready &&
                          ibert_layer.in_ready_out_e &&
                          ibert_layer.in_last_out_e &&
                          ibert_layer.slice_cntr == SLICES-1) ? TX_HEAD : 
                          (in_ready &&
                          ibert_layer.in_ready_out_e &&
                          ibert_layer.in_last_out_e) ? TX_SELF : TX_LAYER;
        default:
            next_state = TX_HEAD;
    endcase
end

assign in_valid = (current_state == TX_HEAD) ? head_in_valid :
                  (current_state == TX_SELF) ? self_in_valid :
                  (current_state == TX_INTER) ? inter_in_valid :
                  (current_state == TX_LAYER) ? layer_in_valid : 0;

assign in_data = (current_state == TX_HEAD) ? head_in_data :
                 (current_state == TX_SELF) ? self_in_data :
                 (current_state == TX_INTER) ? inter_in_data :
                 (current_state == TX_LAYER) ? layer_in_data : 0;

assign out_ready = 1'b1;

always @(posedge clk) begin
    if (rst) begin
        ibert_axi_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_last) begin
            if (REUSE > 1) begin
                $display("-- Finished ibert_axi Head %0d out of %0d at time=%0d.\n###", done_cntr + 1, 2*REUSE, ctime);
            end
            done_cntr <= done_cntr + 1;
            // attn_head outputs tlast for all heads once per layer and
            // layer_out outputs tlast for all slices once per layer
            if (done_cntr == 2*REUSE-1) begin
                ibert_axi_done <= 1;
            end
        end
    end
end

// Head Instance Wires
assign head_save_Q = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tvalid == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tready == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.fsm_inst.out_next_state == 2'b01;
assign head_data_Q = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tdata;
assign head_save_K = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tvalid == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tready == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.fsm_inst.out_next_state == 2'b10;
assign head_data_K = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tdata;
assign head_save_V = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tvalid == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tready == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.fsm_inst.out_next_state == 2'b11;
assign head_data_V = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.QKV.tdata;
assign head_save_Q_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.Q_req.tvalid == 1'b1 &&
                         ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.Q_req.tready == 1'b1;
assign head_data_Q_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.Q_req.tdata;
assign head_save_K_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.K_req.tvalid == 1'b1 &&
                         ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.K_req.tready == 1'b1;
assign head_data_K_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.K_req.tdata;
assign head_save_V_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.V_req.tvalid == 1'b1 &&
                         ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.V_req.tready == 1'b1;
assign head_data_V_req = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.V_req.tdata;
assign head_save_S = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.S.tvalid == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.S.tready == 1'b1;
assign head_data_S = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.S.tdata;
assign head_save_softmax_out = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.softmax_out.tvalid == 1'b1 &&
                               ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.softmax_out.tready == 1'b1;
assign head_data_softmax_out = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.softmax_out.tdata;
assign head_save_C = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.C.tvalid == 1'b1 &&
                     ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.C.tready == 1'b1;
assign head_data_C = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_inst.C.tdata;
assign head_out_valid = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_out_if.tvalid;
assign head_out_data = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_out_if.tdata;
assign head_out_last = ibert_axi_test.attn_head_axis_inst.attn_head_wrap_inst.attn_head_out_if.tlast;

// Self Instance Wires
assign self_save_Y = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tvalid == 1'b1 &&
            ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tready == 1'b1;
assign self_data_Y = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tdata;
assign self_save_Y_req = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tvalid == 1'b1 &&
            ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tready == 1'b1;
assign self_data_Y_req = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tdata;
assign self_save_R_req = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tvalid == 1'b1 &&
            ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tready == 1'b1;
assign self_data_R_req = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tdata;
assign self_save_Z = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tvalid == 1'b1 &&
            ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tready == 1'b1;
assign self_data_Z = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tdata;
assign self_save_ln_out = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tvalid == 1'b1 &&
            ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tready == 1'b1;
assign self_data_ln_out = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tdata;
assign self_out_valid = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tvalid;
assign self_out_data = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tdata;
assign self_out_last = ibert_axi_test.self_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tlast;

// Intermediate Instance Wires
assign inter_save_G = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G.tvalid == 1'b1 &&
            ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G.tready == 1'b1;
assign inter_data_G = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G.tdata;
assign inter_save_G_req = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G_req.tvalid == 1'b1 &&
            ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G_req.tready == 1'b1;
assign inter_data_G_req = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.G_req.tdata;
assign inter_save_gelu_out = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.gelu_out.tvalid == 1'b1 &&
            ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.gelu_out.tready == 1'b1;
assign inter_data_gelu_out = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_inst.gelu_out.tdata;
assign inter_out_valid = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_out_if.tvalid;
assign inter_out_data = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_out_if.tdata;
assign inter_out_last = ibert_axi_test.inter_inst.mm_gelu_wrap_inst.mm_gelu_out_if.tlast;

// Layer Instance Wires
assign layer_save_Y = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tvalid == 1'b1 &&
            ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tready == 1'b1;
assign layer_data_Y = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y.tdata;
assign layer_save_Y_req = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tvalid == 1'b1 &&
            ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tready == 1'b1;
assign layer_data_Y_req = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Y_req.tdata;
assign layer_save_R_req = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tvalid == 1'b1 &&
            ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tready == 1'b1;
assign layer_data_R_req = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.R_req.tdata;
assign layer_save_Z = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tvalid == 1'b1 &&
            ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tready == 1'b1;
assign layer_data_Z = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.Z.tdata;
assign layer_save_ln_out = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tvalid == 1'b1 &&
            ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tready == 1'b1;
assign layer_data_ln_out = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_inst.ln_out.tdata;
assign layer_out_valid = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tvalid;
assign layer_out_data = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tdata;
assign layer_out_last = ibert_axi_test.layer_out_inst.mm_ln_wrap_inst.mm_ln_out_if.tlast;

ibert_attn_head_tb #(
    .D_W           (D_W),
    .D_W_ACC       (D_W_ACC),
    .M1            (M1_HEAD),
    .M2            (M2_HEAD),
    .M3            (M3_HEAD),
    .BLOCKS        (BLOCKS_HEAD),
    .HEADS         (HEADS),
    .KEEP_A        (KEEP_A),
    .REUSE         (REUSE),
    .ONLY_ONCE     (ONLY_ONCE),
    .DIR           ("tb_head/")
)
ibert_attn_head (
    .clk              (clk),
    .rst              (rst),
    .in_valid         (head_in_valid),
    .in_data          (head_in_data),
    .in_ready         (head_in_ready),
    .save_Q           (head_save_Q),
    .data_Q           (head_data_Q),
    .save_K           (head_save_K),
    .data_K           (head_data_K),
    .save_V           (head_save_V),
    .data_V           (head_data_V),
    .save_Q_req       (head_save_Q_req),
    .data_Q_req       (head_data_Q_req),
    .save_K_req       (head_save_K_req),
    .data_K_req       (head_data_K_req),
    .save_V_req       (head_save_V_req),
    .data_V_req       (head_data_V_req),
    .save_S           (head_save_S),
    .data_S           (head_data_S),
    .save_softmax_out (head_save_softmax_out),
    .data_softmax_out (head_data_softmax_out),
    .save_C           (head_save_C),
    .data_C           (head_data_C),
    .out_valid        (head_out_valid), 
    .out_data         (head_out_data),
    .out_last         (head_out_last)
);

ibert_mm_ln_tb #(
    .D_W          (D_W),
    .D_W_ACC      (D_W_ACC),
    .M1           (M1_SELF),
    .M2           (M2_SELF),
    .M3           (M3_SELF),
    .BLOCKS       (BLOCKS_SELF),
    .REUSE        (REUSE),
    .SLICES       (SLICES),
    .DIR          ("tb_self/")
)
ibert_self (
    .clk           (clk),
    .rst           (rst),
    .in_valid      (self_in_valid),
    .in_data       (self_in_data),
    .in_ready      (self_in_ready),
    .save_Y        (self_save_Y),
    .data_Y        (self_data_Y),
    .save_Y_req    (self_save_Y_req),
    .data_Y_req    (self_data_Y_req),
    .save_R_req    (self_save_R_req),
    .data_R_req    (self_data_R_req),
    .save_Z        (self_save_Z),
    .data_Z        (self_data_Z),
    .save_ln_out   (self_save_ln_out),
    .data_ln_out   (self_data_ln_out),
    .out_valid     (self_out_valid),
    .out_data      (self_out_data),
    .out_last      (self_out_last)
);

ibert_mm_gelu_tb #(
    .D_W          (D_W),
    .D_W_ACC      (D_W_ACC),
    .M1           (M1_INTER),
    .M2           (M2_INTER),
    .M3           (M3_INTER),
    .BLOCKS       (BLOCKS_INTER),
    .REUSE        (REUSE),
    .SLICES       (SLICES),
    .DIR          ("tb_inter/")
)
ibert_inter (
    .clk           (clk),
    .rst           (rst),
    .in_valid      (inter_in_valid),
    .in_data       (inter_in_data),
    .in_ready      (inter_in_ready),
    .save_G        (inter_save_G),
    .data_G        (inter_data_G),
    .save_G_req    (inter_save_G_req),
    .data_G_req    (inter_data_G_req),
    .save_gelu_out (inter_save_gelu_out),
    .data_gelu_out (inter_data_gelu_out),
    .out_valid     (inter_out_valid),
    .out_data      (inter_out_data),
    .out_last      (inter_out_last)
);

ibert_mm_ln_tb #(
    .D_W          (D_W),
    .D_W_ACC      (D_W_ACC),
    .M1           (M1_LAYER),
    .M2           (M2_LAYER),
    .M3           (M3_LAYER),
    .BLOCKS       (BLOCKS_LAYER),
    .REUSE        (REUSE),
    .SLICES       (SLICES),
    .DIR          ("tb_layer/")
)
ibert_layer (
    .clk           (clk),
    .rst           (rst),
    .in_valid      (layer_in_valid),
    .in_data       (layer_in_data),
    .in_ready      (layer_in_ready),
    .save_Y        (layer_save_Y),
    .data_Y        (layer_data_Y),
    .save_Y_req    (layer_save_Y_req),
    .data_Y_req    (layer_data_Y_req),
    .save_R_req    (layer_save_R_req),
    .data_R_req    (layer_data_R_req),
    .save_Z        (layer_save_Z),
    .data_Z        (layer_data_Z),
    .save_ln_out   (layer_save_ln_out),
    .data_ln_out   (layer_data_ln_out),
    .out_valid     (layer_out_valid),
    .out_data      (layer_out_data),
    .out_last      (layer_out_last)
);

ibert_axi
`ifndef XIL_TIMING
#(
    .D_W            (D_W),
    .D_W_ACC        (D_W_ACC),
    .N1_HEAD        (N1_HEAD),
    .N2_HEAD        (N2_HEAD),
    .sN1_HEAD       (sN1),
    .sN2_HEAD       (sN2),
    .N1_SELF        (N1),
    .N2_SELF        (N2),
    .N1_INTER       (N1),
    .N2_INTER       (N2),
    .N1_LAYER       (N1),
    .N2_LAYER       (N2),
    .MATRIXSIZE_W   (MATRIXSIZE_W),
    .LAYERS         (LAYERS),
    .HEADS          (HEADS),
    .TOKENS         (TOKENS),
    .EMBED_SIZE     (EMBED_SIZE),
    .INTER_SIZE     (INTER_SIZE),
    .BLOCKS_HEAD    (BLOCKS_HEAD),
    .BLOCKS_SELF    (BLOCKS_SELF),
    .BLOCKS_INTER   (BLOCKS_INTER),
    .BLOCKS_LAYER   (BLOCKS_LAYER),
    .BLOCKED_D      (BLOCKED_D),
    .KEEP_A         (KEEP_A),
    .SLICES         (SLICES),
    .LN_BITS        (LN_BITS)
)
`endif
ibert_axi_test (
    .clk       (clk),
    .fclk      (clk),
    .rst_n     (~rst),
    
    .x_TDATA   (in_data),
    .x_TVALID  (in_valid),
    .x_TREADY  (in_ready),
    .x_TLAST   (in_last),

    .y_TDATA   (out_data),
    .y_TVALID  (out_valid),
    .y_TREADY  (out_ready),
    .y_TLAST   (out_last)
);

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("ibert_axi.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("ibert_axi.vcd");
            $dumpvars(1,ibert_axi_tb);
        end
    `endif
`endif

endmodule
/* verilator lint_off UNDRIVEN */
