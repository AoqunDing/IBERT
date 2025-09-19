`timescale 1ps / 1ps

module mat_add
#(
    parameter integer D_W      = 8,
    parameter integer MAX_BITS = 22
)
(
    input  wire clk,
    input  wire rst,

    axi_stream_if.axi_in              in_R,
    axi_stream_if.axi_in              in_Y,

    axi_stream_if.axi_out             out_Z
);

localparam signed [D_W-1:0] UPPER_BOUND = (1 << (MAX_BITS - 1)) - 1;
localparam signed [D_W-1:0] LOWER_BOUND = - UPPER_BOUND - 1;

reg  signed [D_W-1:0] in_data_R_reg = 0;
reg  signed [D_W-1:0] in_data_Y_reg = 0;
reg  signed [D_W-1:0] out_data_Z_reg = 0;
wire signed [D_W-1:0] result;

reg in_tvalid_R_reg = 0;
reg in_tvalid_Y_reg = 0;
reg out_tvalid_Z_reg = 0;

reg in_tlast_R_reg = 0;
reg in_tlast_Y_reg = 0;
reg out_tlast_Z_reg = 0;

wire in_tvalid_s0;
wire in_tlast_s0;
wire in_tready_s0;
wire in_tready_s1;

assign out_Z.tvalid = out_tvalid_Z_reg;
assign out_Z.tdata = out_data_Z_reg;
assign out_Z.tlast = out_tlast_Z_reg;

// pass everyone once - src
assign in_R.tready = in_tready_s0 | ~in_tvalid_R_reg;
assign in_Y.tready = in_tready_s0 | ~in_tvalid_Y_reg;

// now need everyone - s0 stage
assign in_tvalid_s0 = in_tvalid_R_reg & in_tvalid_Y_reg;
assign in_tlast_s0 = in_tlast_R_reg & in_tlast_Y_reg;
assign in_tready_s0 = in_tready_s1 & in_tvalid_s0;

// output s1 stage
assign in_tready_s1 = out_Z.tready | ~out_Z.tvalid;

always @(posedge clk) begin
    if (rst) begin
        in_tvalid_R_reg <= 0;
        in_tvalid_Y_reg <= 0;
        in_tlast_R_reg <= 0;
        in_tlast_Y_reg <= 0;
        in_data_R_reg <= 0;
        in_data_Y_reg <= 0;
    end else begin
        if (in_R.tready) begin
            in_tvalid_R_reg <= in_R.tvalid;
            in_tlast_R_reg <= in_R.tlast;
            in_data_R_reg <= in_R.tdata;
        end

        if (in_Y.tready) begin
            in_tvalid_Y_reg <= in_Y.tvalid;
            in_tlast_Y_reg <= in_Y.tlast;
            in_data_Y_reg <= in_Y.tdata;
        end
    end
end

assign result = in_data_R_reg + in_data_Y_reg;

always @(posedge clk) begin
    if (rst) begin
        out_tvalid_Z_reg <= 0;
        out_tlast_Z_reg <= 0;
        out_data_Z_reg <= 0;
    end else begin
        if (in_tready_s1) begin
            out_tvalid_Z_reg <= in_tvalid_s0;
            out_tlast_Z_reg <= in_tlast_s0;
            out_data_Z_reg <= (result < LOWER_BOUND) ? LOWER_BOUND :
                              (result > UPPER_BOUND) ? UPPER_BOUND : result;
        end
    end
end

endmodule
