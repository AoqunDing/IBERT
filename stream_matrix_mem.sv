`timescale 1ps / 1ps

module stream_matrix_mem
#(
    parameter integer D_W          = 8,
    parameter integer MATRIXSIZE_W = 24,
    parameter integer MEM_DEPTH    = 4096
)
(
    input  wire clk,
    input  wire rst,

    axi_stream_if.axi_in            in_mat,
    axi_stream_if.axi_out           out_mat,

    input  wire [MATRIXSIZE_W-1:0]  DEPTH
);

localparam integer ADDR_W = $clog2(MEM_DEPTH);

wire signed [D_W-1:0] wrdata;
wire signed [D_W-1:0] rddata;

reg  [ADDR_W-1:0] wraddr = 0;
reg  [ADDR_W-1:0] rdaddr = 0;
reg  [ADDR_W-1:0] rdaddr_mem = 0;
wire [ADDR_W-1:0] prerdaddr;

wire write_hs;
wire read_hs;

wire write_last;
wire read_last;
wire read_mem_last;

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

assign wrdata = in_mat.tdata[D_W-1:0];
assign in_mat.tready = (wstate == WRDATA);
assign write_hs = in_mat.tvalid & in_mat.tready;
assign write_last = write_hs & in_mat.tlast;
// assign write_start = (rstate == RDIDLE);
assign write_start = (rstate == RDIDLE) | (wraddr < rdaddr_mem);    // (done reading or first write) or (writing new data behind read pointer of old data)
assign write_stall = (rstate == RDDATA) & (wraddr == rdaddr_mem);   // writing new data caught up read pointer of old data

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
            // wnext = (write_last) ? WRIDLE : WRDATA;
            wnext = (write_last || write_stall) ? WRIDLE : WRDATA;
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

assign out_mat.tdata = rddata;
assign out_mat.tvalid = (rstate == RDDATA);
assign out_mat.tlast = (rdaddr == DEPTH-1);
assign read_hs = out_mat.tvalid & out_mat.tready;
assign read_last = read_hs & out_mat.tlast;
assign read_mem_last = read_hs & (rdaddr_mem == MEM_DEPTH-1);
// assign read_start = write_last;
assign read_start = (rdaddr_mem < wraddr);                          // reading new data behind write pointer of new data
assign read_stall = (wstate == WRDATA) & (wraddr == rdaddr_mem);    // reading new data caught up write pointer of new data

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
            // rnext = (read_last) ? RDIDLE : RDDATA;
            // rnext = (read_mem_last) ? RDIDLE : RDDATA;
            rnext = (read_mem_last || read_stall) ? RDIDLE : RDDATA;
        default:
            rnext = RDIDLE;
    endcase
end

always @(posedge clk) begin
    if (rst) begin
        rdaddr <= 0;
    end else begin
        if (read_hs) begin
            rdaddr <= rdaddr + 1;
            if (read_last) begin
                rdaddr <= 0;
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        rdaddr_mem <= 0;
    end else begin
        if (read_hs) begin
            rdaddr_mem <= rdaddr_mem + 1;
            if (read_mem_last) begin
                rdaddr_mem <= 0;
            end
        end
    end
end

// assign prerdaddr = (rdaddr == DEPTH-1) ? 0 : rdaddr + 1;
assign prerdaddr = (rdaddr_mem == MEM_DEPTH-1) ? 0 : rdaddr_mem + 1;

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
    .addrB ( read_hs ? prerdaddr : rdaddr_mem ),
    .dinA  ( wrdata ),
    .doutB ( rddata )
);

endmodule
