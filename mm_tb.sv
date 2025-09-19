`timescale 1ps / 1ps
/* verilator lint_off UNDRIVEN */

`ifdef VERILATOR
module top
`else
module mm_tb
`endif
#(
    parameter integer D_W          = 8,
    parameter integer D_W_ACC      = 32,
    parameter integer M1           = 8,
    parameter integer M2           = 8,
    parameter integer M3           = 8,
    parameter integer N1           = 4,
    parameter integer N2           = 4,
    parameter integer MATRIXSIZE_W = 16,
    parameter integer KEEP_A       = 1,
    parameter integer MEM_DEPTH_A  = 4096,
    parameter integer MEM_DEPTH_B  = 4096,
    parameter integer MEM_DEPTH_D  = 4096,
    parameter integer TRANSPOSE_B  = 0,
    parameter integer BLOCKS       = 1,
    parameter         BLOCKED_D    = 0,
    parameter integer REUSE        = 1
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

localparam integer REP = REUSE*KEEP_A*M1*M2*M3*2;

localparam [MATRIXSIZE_W-1:0] _M2                   = M2;
localparam [MATRIXSIZE_W-1:0] _M3                   = M3;
localparam [MATRIXSIZE_W-1:0] _M1xM3dN1             = M1*M3/N1;
localparam [MATRIXSIZE_W-1:0] _M1dN1                = M1/N1;
localparam [MATRIXSIZE_W-1:0] _M3dN2                = M3/N2;
localparam [MATRIXSIZE_W-1:0] _M1xM3dN1xN2          = (M1*M3)/(N1*N2);
localparam [MATRIXSIZE_W-1:0] _BLOCKS               = BLOCKS;
localparam [MATRIXSIZE_W-1:0] _BLOCK_WIDTH          = M3/BLOCKS;
localparam [MATRIXSIZE_W-1:0] _BLOCK_WIDTHdN2       = (M3/BLOCKS)/N2;
localparam [MATRIXSIZE_W-1:0] _BLOCK_SIZEdN2        = M2*(M3/BLOCKS)/N2;
localparam [MATRIXSIZE_W-1:0] _M1xBLOCK_WIDTHdN1xN2 = (M1*(M3/BLOCKS))/(N1*N2);
localparam [MATRIXSIZE_W-1:0] _M1xBLOCK_WIDTHdN1    = (M1*(M3/BLOCKS))/(N1);

reg                       in_valid_A;
reg  signed [D_W-1:0]     in_data_A;
wire signed [31:0]        in_data_stream_A;
reg                       in_last_A;
wire                      in_ready_A;

wire                      res_in_valid_A;
wire  signed [D_W-1:0]    res_in_data_A;
wire                      res_in_last_A;
wire                      res_in_ready_A;

reg                       in_valid_B;
reg  signed [D_W-1:0]     in_data_B;
wire signed [31:0]        in_data_stream_B;
reg                       in_last_B;
wire                      in_ready_B;

wire                      out_valid;
wire signed [D_W_ACC-1:0] out_data;
wire signed [31:0]        out_data_stream;
wire                      out_last;
reg                       mm_done;

reg  signed [D_W-1:0]     mem_A [0:REUSE*M1*M2-1];
reg  signed [D_W-1:0]     mem_B [0:REUSE*KEEP_A*M2*M3-1];
reg  signed [D_W_ACC-1:0] mem_D [0:REUSE*KEEP_A*M1*M3-1];

reg  [$clog2(REUSE*M1*M2):0]         rdaddr_A;
reg  [$clog2(REUSE*KEEP_A*M2*M3):0]  rdaddr_B;
reg  [$clog2(REUSE*KEEP_A*M1*M3):0]  wraddr;
reg  [$clog2(BLOCKS*REUSE*KEEP_A):0] done_cntr;

initial begin
    $readmemh({`DIR,"A.mem"}, mem_A);
    if (BLOCKS > 1) begin
        $display("Using Ping Pong Buffer with BLOCKS=%0d", BLOCKS);
        $readmemh({`DIR,"B_pp.mem"}, mem_B);
    end else begin
        $readmemh({`DIR,"B.mem"}, mem_B);
    end
end

final begin
    $writememh({`DIR,"D.mem"}, mem_D);
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
    if (mm_done) begin
        $finish;
    end
end

// send data into mm.sv
assign in_data_stream_A = {{32-D_W{in_data_A[D_W-1]}}, in_data_A};
assign in_data_stream_B = {{32-D_W{in_data_B[D_W-1]}}, in_data_B};

always @(posedge clk) begin
    if (rst) begin
        in_valid_A <= 0;
        in_last_A  <= 0;
        rdaddr_A   <= 0;
        in_data_A  <= mem_A[rdaddr_A];
    end else begin
        if (rdaddr_A < REUSE*M1*M2-1) begin
            in_valid_A <= 1;
        end

        if (in_valid_A && in_ready_A) begin
            in_data_A <= mem_A[rdaddr_A + 1];
            if (rdaddr_A < REUSE*M1*M2-1) begin
                rdaddr_A <= rdaddr_A + 1;
            end

            if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-2) begin
                in_last_A <= 1;
            end else if (rdaddr_A == (M1*M2)*(rdaddr_A/(M1*M2))+M1*M2-1) begin
                in_valid_A <= 0;
                in_last_A <= 0;
            end
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        in_valid_B <= 0;
        in_last_B  <= 0;
        rdaddr_B   <= 0;
        in_data_B  <= mem_B[rdaddr_B];
    end else begin
        if (rdaddr_B < REUSE*KEEP_A*M2*M3-1) begin
            in_valid_B <= 1;
        end

        if (in_valid_B && in_ready_B) begin
            in_data_B <= mem_B[rdaddr_B + 1];
            if (rdaddr_B < REUSE*KEEP_A*M2*M3-1) begin
                rdaddr_B <= rdaddr_B + 1;
            end

            if (rdaddr_B == (M2*M3)*(rdaddr_B/(M2*M3))+M2*M3-2) begin
                in_last_B <= 1;
            end else if (rdaddr_B == (M2*M3)*(rdaddr_B/(M2*M3))+M2*M3-1) begin
                in_valid_B <= 0;
                in_last_B <= 0;
            end
        end
    end
end

// receive data from mm.sv
assign out_data = out_data_stream[D_W_ACC-1:0];

always @(posedge clk) begin
    if (rst) begin
        wraddr <= 0;
        mm_done <= 0;
        done_cntr <= 0;
    end else begin
        if (out_valid && out_last) begin
            $display("-- Finished Layer %0d out of %0d at time=%0d.\n###\n", done_cntr + 1, REUSE*KEEP_A, ctime);
            done_cntr <= done_cntr + 1;
            if (BLOCKED_D) begin
                if (done_cntr == BLOCKS*REUSE*KEEP_A-1) begin
                    mm_done <= 1;
                end
            end else begin
                if (done_cntr == REUSE*KEEP_A-1) begin
                    mm_done <= 1;
                end
            end
        end
        
        if (out_valid) begin
            wraddr <= (wraddr == REUSE*KEEP_A*M1*M3-1) ? 0 : wraddr + 1;
            mem_D[wraddr] <= out_data;
        end
    end
end

`ifdef PING_PONG
`ifdef READ_A
    mm_pp_res
`else
    mm_pp
`endif
    `ifndef XIL_TIMING
    #(
        .D_W          (D_W),
        .D_W_ACC      (D_W_ACC),
        .N1           (N1),
        .N2           (N2),
        .MATRIXSIZE_W (MATRIXSIZE_W),
        .KEEP_A       (KEEP_A),
        .TRANSPOSE_B  (TRANSPOSE_B),
        .MEM_DEPTH_A  (MEM_DEPTH_A),
        .MEM_DEPTH_B  (MEM_DEPTH_B),
        .MEM_DEPTH_D  (MEM_DEPTH_D),
        .BLOCKED_D    (BLOCKED_D)
    )
    `endif
    mm_test (
        .mm_clk                (clk),
        .mm_fclk               (clk),
        .mm_rst_n              (~rst),

        .s_axis_s2mm_tvalid_A  (in_valid_A),
        .s_axis_s2mm_tdata_A   (in_data_stream_A),
        .s_axis_s2mm_tlast_A   (in_last_A),
        .s_axis_s2mm_tready_A  (in_ready_A),

        .s_axis_s2mm_tvalid_B  (in_valid_B),
        .s_axis_s2mm_tdata_B   (in_data_stream_B),
        .s_axis_s2mm_tlast_B   (in_last_B),
        .s_axis_s2mm_tready_B  (in_ready_B),

        `ifdef READ_A
        .m_axis_mm2s_tvalid_A  (res_in_valid_A),
        .m_axis_mm2s_tdata_A   (res_in_data_A),
        .m_axis_mm2s_tlast_A   (res_in_last_A),
        .m_axis_mm2s_tready_A  (1'b1),
        `endif

        .m_axis_mm2s_tvalid    (out_valid),
        .m_axis_mm2s_tdata     (out_data_stream),
        .m_axis_mm2s_tlast     (out_last),
        .m_axis_mm2s_tready    (1'b1),

        .BLOCKS                (_BLOCKS),
        .BLOCK_WIDTH           (_BLOCK_WIDTH),
        .BLOCK_WIDTHdN2        (_BLOCK_WIDTHdN2),
        .BLOCK_SIZEdN2         (_BLOCK_SIZEdN2 ),
        .M1xBLOCK_WIDTHdN1xN2  (_M1xBLOCK_WIDTHdN1xN2),
        .M1xBLOCK_WIDTHdN1     (_M1xBLOCK_WIDTHdN1),

        .M2                    (_M2),
        .M3dN2                 (_M3dN2),
        .M1xM3dN1              (_M1xM3dN1),
        .M1dN1                 (_M1dN1)
    );
`else
    mm
    `ifndef XIL_TIMING
    #(
        .D_W          (D_W),
        .D_W_ACC      (D_W_ACC),
        .N1           (N1),
        .N2           (N2),
        .MATRIXSIZE_W (MATRIXSIZE_W),
        .KEEP_A       (KEEP_A),
        .TRANSPOSE_B  (TRANSPOSE_B),
        .MEM_DEPTH_A  (MEM_DEPTH_A),
        .MEM_DEPTH_B  (MEM_DEPTH_B),
        .MEM_DEPTH_D  (MEM_DEPTH_D)
    )
    `endif
    mm_test (
        .mm_clk                (clk),
        .mm_fclk               (fclk),
        .mm_rst_n              (~rst),
        
        .s_axis_s2mm_tvalid_A  (in_valid_A),
        .s_axis_s2mm_tdata_A   (in_data_stream_A),
        .s_axis_s2mm_tlast_A   (in_last_A),
        .s_axis_s2mm_tready_A  (in_ready_A),

        .s_axis_s2mm_tvalid_B  (in_valid_B),
        .s_axis_s2mm_tdata_B   (in_data_stream_B),
        .s_axis_s2mm_tlast_B   (in_last_B),
        .s_axis_s2mm_tready_B  (in_ready_B),

        .m_axis_mm2s_tvalid    (out_valid),
        .m_axis_mm2s_tdata     (out_data_stream),
        .m_axis_mm2s_tlast     (out_last),
        .m_axis_mm2s_tready    (1'b1),

        .M2                    (_M2),
        .M3                    (_M3),
        .M1xM3dN1              (_M1xM3dN1),
        .M1dN1                 (_M1dN1),
        .M3dN2                 (_M3dN2),
        .M1xM3dN1xN2           (_M1xM3dN1xN2)
    );
`endif

`ifdef TRACE
    `ifdef VERILATOR
        initial begin
            $dumpfile("mm.fst");
            $dumpvars();
        end
    `else
        initial begin
            $dumpfile("mm.vcd");
            $dumpvars();
        end
    `endif
`endif

endmodule
/* verilator lint_off UNDRIVEN */
