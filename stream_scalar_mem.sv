`timescale 1ps / 1ps

module stream_scalar_mem
#(
    parameter integer D_W          = 8,
    parameter integer MATRIXSIZE_W = 24
)
(
    input  wire clk,
    input  wire rst,

    axi_stream_if.axi_in            in_sca,
    axi_stream_if.axi_out           out_sca,

    input  wire [MATRIXSIZE_W-1:0]  DIM1,
    input  wire [MATRIXSIZE_W-1:0]  DIM2
);

wire signed [D_W-1:0] wrdata;
reg  signed [D_W-1:0] rddata;

// reg [ADDR_W-1:0] wraddr = 0;
reg [MATRIXSIZE_W-1:0] rdaddr = 0;
reg [MATRIXSIZE_W-1:0] rdcntr = 0;

wire write_hs;
wire read_hs;

wire write_last;
wire read_last;

wire write_start;
wire read_start;

wire write_stall;
wire read_stall;

typedef enum logic [1:0] {
    WRRESET = 2'b00,
    WRIDLE = 2'b01,
    WRDATA = 2'b10
} wstate_t;

typedef enum logic [1:0] {
    RDRESET = 2'b00,
    RDIDLE = 2'b01,
    RDDATA = 2'b10
} rstate_t;

wstate_t wstate, wnext;
rstate_t rstate, rnext;

// WRITE

assign wrdata = in_sca.tdata[D_W-1:0];
assign in_sca.tready = (wstate == WRDATA);
assign write_hs = in_sca.tvalid & in_sca.tready;
assign write_last = write_hs & in_sca.tlast;
assign write_start = (rstate == RDIDLE);

always @(posedge clk) begin
    if (rst) begin
        wstate <= WRRESET;
    end else begin
        wstate <= wnext;
    end
end

always @(*) begin
    case (wstate)
        WRIDLE:
            wnext = (write_start) ? WRDATA : WRIDLE;
        WRDATA:
            wnext = (write_last) ? WRIDLE : WRDATA;
        default:
            wnext = WRIDLE;
    endcase
end

// READ

assign out_sca.tdata = rddata;
assign out_sca.tvalid = (rstate == RDDATA);
assign out_sca.tlast = (rdaddr == DIM2-1) & (rdcntr == DIM1-1);
assign read_hs = out_sca.tvalid & out_sca.tready;
assign read_last = read_hs & out_sca.tlast;
assign read_start = write_last;

always @(posedge clk) begin
    if (rst) begin
        rstate <= RDRESET;
    end else begin
        rstate <= rnext;
    end
end

always @(*) begin
    case (rstate)
        RDIDLE:
            rnext = (read_start) ? RDDATA : RDIDLE;
        RDDATA:
            rnext = (read_last) ? RDIDLE : RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        rdaddr <= 0;
        rdcntr <= 0;
    end else begin
        if (read_hs) begin
            rdaddr <= rdaddr + 1;
            if (rdaddr == DIM2-1) begin
                rdaddr <= 0;
                rdcntr <= rdcntr + 1;
                if (rdcntr == DIM1-1) begin
                    rdcntr <= 0;
                end
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        rddata <= 0;
    end else begin
        if (write_hs) begin
            rddata <= wrdata;
        end
    end
end

endmodule
