`timescale 1ps / 1ps

module gelu_top
#(
    parameter integer D_W = 8,
    parameter integer D_W_ACC = 32,
    parameter integer MATRIXSIZE_W = 16,
    parameter integer LAYERS = 12,
    parameter QB_MEM = "data/gelu/gelu_qb.mem",
    parameter QC_MEM = "data/gelu/gelu_qc.mem",
    parameter Q1_MEM = "data/gelu/gelu_q1.mem"
)
(
    input  wire                      clk,
    input  wire                      rst,
    input  wire [$clog2(LAYERS)-1:0] layer,

    axi_stream_if.axi_in             qin,
    axi_stream_if.axi_out            qout,

    input  wire [MATRIXSIZE_W-1:0]   DIM1,
    input  wire [MATRIXSIZE_W-1:0]   DIM2
);

localparam integer SHIFT = 14;

wire [MATRIXSIZE_W-1:0] qout_col_cntr;
wire [MATRIXSIZE_W-1:0] qout_row_cntr;

reg signed [D_W_ACC-1:0] qin_tdata_reg;
reg qin_tvalid_reg = 0;

wire signed [D_W_ACC-1:0] qb_rom_rddata;
wire signed [D_W_ACC-1:0] qc_rom_rddata;
wire signed [D_W_ACC-1:0] q1_rom_rddata;

wire in_tready_s0;
wire in_tready_s1;

assign qout.tlast = (qout_row_cntr == DIM1-1) && (qout_col_cntr == DIM2-1);

// register everyone at least once when in_tready_s0 is low
assign qin.tready = in_tready_s0 | ~qin_tvalid_reg;

// now I need everyone to be valid after first pass
assign in_tready_s0 = in_tready_s1 & qin_tvalid_reg;

// s1 stage
assign in_tready_s1 = qout.tready | ~qout.tvalid;

always @(posedge clk) begin
    if (rst) begin
        qin_tdata_reg <= 0;
        qin_tvalid_reg <= 0;
    end else begin
        if (qin.tready) begin
            qin_tdata_reg <= qin.tdata;
            qin_tvalid_reg <= qin.tvalid;
        end
    end
end

rom #(.D_W(D_W_ACC), .DEPTH(LAYERS), .INIT(QB_MEM))
qb_rom
(
    .clk    ( clk             ),
    .rdaddr ( layer           ),
    .rddata ( qb_rom_rddata   )
);

rom #(.D_W(D_W_ACC), .DEPTH(LAYERS), .INIT(QC_MEM))
qc_rom
(
    .clk    ( clk             ),
    .rdaddr ( layer           ),
    .rddata ( qc_rom_rddata   )
);

rom #(.D_W(D_W_ACC), .DEPTH(LAYERS), .INIT(Q1_MEM))
q1_rom
(
    .clk    ( clk           ),
    .rdaddr ( layer         ),
    .rddata ( q1_rom_rddata )
);

counter #(
    .MATRIXSIZE_W (MATRIXSIZE_W)
)
counter_gelu (
    .clk                (clk),
    .rst                (rst),
    .enable_pixel_count (qout.tvalid & qout.tready),
    .enable_slice_count (1'b1),
    .WIDTH              (DIM2),
    .HEIGHT             (DIM1),
    .pixel_cntr         (qout_col_cntr),
    .slice_cntr         (qout_row_cntr)
);

gelu gelu_unit (
    .clk       ( clk            ), 
    .rst       ( rst            ),
    .enable    ( in_tready_s1   ),
    .in_valid  ( qin_tvalid_reg ),
    .qin       ( qin_tdata_reg  ),
    .qb        ( qb_rom_rddata  ),
    .qc        ( qc_rom_rddata  ),
    .q1        ( q1_rom_rddata  ),
    .out_valid ( qout.tvalid    ),
    .qout      ( qout.tdata     )
);

endmodule
