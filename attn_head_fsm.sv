`timescale 1ps / 1ps

module attn_head_fsm #(
    
) (
    input logic           clk,
    input logic           rst,

    axi_stream_if.axi_in  in_W_Q,
    axi_stream_if.axi_in  in_W_K,
    axi_stream_if.axi_in  in_W_V,

    axi_stream_if.axi_in  in_bias_Q,
    axi_stream_if.axi_in  in_bias_K,
    axi_stream_if.axi_in  in_bias_V,

    axi_stream_if.axi_in  in_m_Q,
    axi_stream_if.axi_in  in_m_K,
    axi_stream_if.axi_in  in_m_V,

    axi_stream_if.axi_in  in_e_Q,
    axi_stream_if.axi_in  in_e_K,
    axi_stream_if.axi_in  in_e_V,

    axi_stream_if.axi_in  in_QKV_req,

    axi_stream_if.axi_out out_W,
    axi_stream_if.axi_out out_bias,
    axi_stream_if.axi_out out_m,
    axi_stream_if.axi_out out_e,

    axi_stream_if.axi_out out_Q_req,
    axi_stream_if.axi_out out_K_req,
    axi_stream_if.axi_out out_V_req
);

typedef enum logic [1:0] {
    STATE_TRANSFER_IDLE = 2'b00,
    STATE_TRANSFER_Q = 2'b01,
    STATE_TRANSFER_K = 2'b10,
    STATE_TRANSFER_V = 2'b11
} transfer_state_t;

transfer_state_t tx_curr_state, tx_next_state;

always @(posedge clk) begin
    if (rst) begin
        tx_curr_state <= STATE_TRANSFER_IDLE;
    end else begin
        tx_curr_state <= tx_next_state;
    end
end

always @* begin
    case (tx_curr_state)
        STATE_TRANSFER_IDLE: begin
            tx_next_state = STATE_TRANSFER_Q;
        end
        STATE_TRANSFER_Q: begin
            tx_next_state = (in_e_Q.tvalid && in_e_Q.tready && in_e_Q.tlast) ? STATE_TRANSFER_K : STATE_TRANSFER_Q;
        end
        STATE_TRANSFER_K: begin
            tx_next_state = (in_e_K.tvalid && in_e_K.tready && in_e_K.tlast) ? STATE_TRANSFER_V : STATE_TRANSFER_K;
        end
        STATE_TRANSFER_V: begin
            tx_next_state = (in_e_V.tvalid && in_e_V.tready && in_e_V.tlast) ? STATE_TRANSFER_Q : STATE_TRANSFER_V;
        end
    endcase
end

// Transfer for W
assign out_W.tdata   = (tx_curr_state == STATE_TRANSFER_Q) ? in_W_Q.tdata :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_W_K.tdata :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_W_V.tdata : 32'b0;

assign out_W.tvalid  = (tx_curr_state == STATE_TRANSFER_Q) ? in_W_Q.tvalid :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_W_K.tvalid :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_W_V.tvalid : 1'b0;

assign out_W.tlast   = (tx_curr_state == STATE_TRANSFER_Q) ? in_W_Q.tlast :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_W_K.tlast :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_W_V.tlast : 1'b0;

assign in_W_Q.tready = (tx_curr_state == STATE_TRANSFER_Q) ? out_W.tready : 1'b0;
assign in_W_K.tready = (tx_curr_state == STATE_TRANSFER_K) ? out_W.tready : 1'b0;
assign in_W_V.tready = (tx_curr_state == STATE_TRANSFER_V) ? out_W.tready : 1'b0;

// Transfer for BIAS
assign out_bias.tdata   = (tx_curr_state == STATE_TRANSFER_Q) ? in_bias_Q.tdata :
                             (tx_curr_state == STATE_TRANSFER_K) ? in_bias_K.tdata :
                             (tx_curr_state == STATE_TRANSFER_V) ? in_bias_V.tdata : 32'b0;

assign out_bias.tvalid  = (tx_curr_state == STATE_TRANSFER_Q) ? in_bias_Q.tvalid :
                             (tx_curr_state == STATE_TRANSFER_K) ? in_bias_K.tvalid :
                             (tx_curr_state == STATE_TRANSFER_V) ? in_bias_V.tvalid : 1'b0;

assign out_bias.tlast   = (tx_curr_state == STATE_TRANSFER_Q) ? in_bias_Q.tlast :
                             (tx_curr_state == STATE_TRANSFER_K) ? in_bias_K.tlast :
                             (tx_curr_state == STATE_TRANSFER_V) ? in_bias_V.tlast : 1'b0;

assign in_bias_Q.tready = (tx_curr_state == STATE_TRANSFER_Q) ? out_bias.tready : 1'b0;
assign in_bias_K.tready = (tx_curr_state == STATE_TRANSFER_K) ? out_bias.tready : 1'b0;
assign in_bias_V.tready = (tx_curr_state == STATE_TRANSFER_V) ? out_bias.tready : 1'b0;

// Transfer for M
assign out_m.tdata   = (tx_curr_state == STATE_TRANSFER_Q) ? in_m_Q.tdata :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_m_K.tdata :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_m_V.tdata : 32'b0;

assign out_m.tvalid  = (tx_curr_state == STATE_TRANSFER_Q) ? in_m_Q.tvalid :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_m_K.tvalid :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_m_V.tvalid : 1'b0;

assign out_m.tlast   = (tx_curr_state == STATE_TRANSFER_Q) ? in_m_Q.tlast :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_m_K.tlast :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_m_V.tlast : 1'b0;

assign in_m_Q.tready = (tx_curr_state == STATE_TRANSFER_Q) ? out_m.tready : 1'b0;
assign in_m_K.tready = (tx_curr_state == STATE_TRANSFER_K) ? out_m.tready : 1'b0;
assign in_m_V.tready = (tx_curr_state == STATE_TRANSFER_V) ? out_m.tready : 1'b0;

// Transfer for E
assign out_e.tdata   = (tx_curr_state == STATE_TRANSFER_Q) ? in_e_Q.tdata :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_e_K.tdata :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_e_V.tdata : 32'b0;

assign out_e.tvalid  = (tx_curr_state == STATE_TRANSFER_Q) ? in_e_Q.tvalid :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_e_K.tvalid :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_e_V.tvalid : 1'b0;

assign out_e.tlast   = (tx_curr_state == STATE_TRANSFER_Q) ? in_e_Q.tlast :
                          (tx_curr_state == STATE_TRANSFER_K) ? in_e_K.tlast :
                          (tx_curr_state == STATE_TRANSFER_V) ? in_e_V.tlast : 1'b0;

assign in_e_Q.tready = (tx_curr_state == STATE_TRANSFER_Q) ? out_e.tready : 1'b0;
assign in_e_K.tready = (tx_curr_state == STATE_TRANSFER_K) ? out_e.tready : 1'b0;
assign in_e_V.tready = (tx_curr_state == STATE_TRANSFER_V) ? out_e.tready : 1'b0;

typedef enum logic [1:0] {
    STATE_OUTPUT_IDLE = 2'b00,
    STATE_OUTPUT_Q = 2'b01,
    STATE_OUTPUT_K = 2'b10,
    STATE_OUTPUT_V = 2'b11
} output_state_t;

output_state_t out_curr_state, out_next_state;

always @(posedge clk) begin
    if (rst) begin
        out_curr_state <= STATE_OUTPUT_IDLE;
    end else begin
        out_curr_state <= out_next_state;
    end
end

always @* begin
    case (out_curr_state)
        STATE_OUTPUT_IDLE: begin
            out_next_state = STATE_OUTPUT_Q;
        end
        STATE_OUTPUT_Q: begin
            out_next_state = (in_QKV_req.tvalid && in_QKV_req.tready && in_QKV_req.tlast) ? STATE_OUTPUT_K : STATE_OUTPUT_Q;
        end
        STATE_OUTPUT_K: begin
            out_next_state = (in_QKV_req.tvalid && in_QKV_req.tready && in_QKV_req.tlast) ? STATE_OUTPUT_V : STATE_OUTPUT_K;
        end
        STATE_OUTPUT_V: begin
            out_next_state = (in_QKV_req.tvalid && in_QKV_req.tready && in_QKV_req.tlast) ? STATE_OUTPUT_Q : STATE_OUTPUT_V;
        end
    endcase
end

assign out_Q_req.tdata   = (out_curr_state == STATE_OUTPUT_Q) ? in_QKV_req.tdata : 0;
assign out_Q_req.tvalid  = (out_curr_state == STATE_OUTPUT_Q) ? in_QKV_req.tvalid : 1'b0;
assign out_Q_req.tlast   = (out_curr_state == STATE_OUTPUT_Q) ? in_QKV_req.tlast : 1'b0;

assign out_K_req.tdata   = (out_curr_state == STATE_OUTPUT_K) ? in_QKV_req.tdata : 0;
assign out_K_req.tvalid  = (out_curr_state == STATE_OUTPUT_K) ? in_QKV_req.tvalid : 1'b0;
assign out_K_req.tlast   = (out_curr_state == STATE_OUTPUT_K) ? in_QKV_req.tlast : 1'b0;

assign out_V_req.tdata   = (out_curr_state == STATE_OUTPUT_V) ? in_QKV_req.tdata : 0;
assign out_V_req.tvalid  = (out_curr_state == STATE_OUTPUT_V) ? in_QKV_req.tvalid : 1'b0;
assign out_V_req.tlast   = (out_curr_state == STATE_OUTPUT_V) ? in_QKV_req.tlast : 1'b0;

assign in_QKV_req.tready = (out_curr_state == STATE_OUTPUT_Q) ? out_Q_req.tready :
                              (out_curr_state == STATE_OUTPUT_K) ? out_K_req.tready :
                              (out_curr_state == STATE_OUTPUT_V) ? out_V_req.tready : 1'b0;

endmodule
