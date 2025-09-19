`timescale 1ps / 1ps

module stream_vector_mem_blocked
#(
    parameter integer D_W          = 8,
    parameter integer MATRIXSIZE_W = 24,
    parameter integer MEM_DEPTH    = 4096
)
(
    input  wire clk,
    input  wire rst,

    axi_stream_if.axi_in            in_vec,
    axi_stream_if.axi_out           out_vec,

    input  wire [MATRIXSIZE_W-1:0]  DIM1,
    input  wire [MATRIXSIZE_W-1:0]  DIM2,
    input  wire [MATRIXSIZE_W-1:0]  BLOCKS,
    input  wire [MATRIXSIZE_W-1:0]  BLOCK_WIDTH
);

localparam integer ADDR_W = $clog2(MEM_DEPTH);

wire signed [D_W-1:0] wrdata;
wire signed [D_W-1:0] rddata;

reg  [ADDR_W-1:0] wraddr = 0;
reg  [ADDR_W-1:0] rdaddr = 0;
wire [ADDR_W-1:0] rdaddr_mem;
wire [ADDR_W-1:0] prerdaddr;
wire [ADDR_W-1:0] preoffset;
wire [ADDR_W-1:0] prerdaddr_mem;

reg [MATRIXSIZE_W-1:0] rdcntr = 0;
reg [MATRIXSIZE_W-1:0] block_cntr = 0;
reg [MATRIXSIZE_W-1:0] block_offset = 0;

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

assign wrdata = in_vec.tdata[D_W-1:0];
assign in_vec.tready = (wstate == WRDATA);
assign write_hs = in_vec.tvalid & in_vec.tready;
assign write_last = write_hs & in_vec.tlast;
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

always @(posedge clk) begin
    if (rst) begin
        wraddr <= 0;
    end else begin
        if (write_hs) begin
            wraddr <= wraddr + 1;
            if (write_last) begin
                wraddr <= 0;
            end
        end
    end
end

// READ

assign out_vec.tdata = rddata;
assign out_vec.tvalid = (rstate == RDDATA);
assign out_vec.tlast = (rdaddr_mem == DIM2-1) & (rdcntr == DIM1-1);
assign read_hs = out_vec.tvalid & out_vec.tready;
assign read_last = read_hs & out_vec.tlast;
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
        block_cntr <= 0;
        block_offset <= 0;
    end else begin
        if (read_hs) begin
            rdaddr <= rdaddr + 1;
            if (rdaddr == BLOCK_WIDTH-1) begin
                rdaddr <= 0;
                rdcntr <= rdcntr + 1;
                if (rdcntr == DIM1-1) begin
                    rdcntr <= 0;
                    block_cntr <= block_cntr + 1;
                    block_offset <= block_offset + BLOCK_WIDTH;
                    if (block_cntr == BLOCKS-1) begin
                        block_cntr <= 0;
                        block_offset <= 0;
                    end
                end
            end
        end
    end
end

assign rdaddr_mem = rdaddr + block_offset;
assign prerdaddr = (rdaddr == BLOCK_WIDTH-1) ? 0 : rdaddr + 1;
assign preoffset = (rdaddr == BLOCK_WIDTH-1 && rdcntr == DIM1-1) ?
                   (block_cntr == BLOCKS-1) ? 0 : block_offset + BLOCK_WIDTH : block_offset;
assign prerdaddr_mem = prerdaddr + preoffset;

mem_top #(
    .WIDTH ( D_W       ),
    .DEPTH ( MEM_DEPTH )
)
ram (
    .rst   ( rst ),
    .clkA  ( clk ),
    .clkB  ( clk ),
    .weA   ( write_hs ),
    .enA   ( 1'b1 ),
    .enB   ( 1'b1 ),
    .addrA ( wraddr ),
    .addrB ( read_hs ? prerdaddr_mem : rdaddr_mem ),
    .dinA  ( wrdata ),
    .doutB ( rddata )
);

endmodule
