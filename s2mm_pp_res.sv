`timescale 1ps / 1ps

module s2mm_pp_res
#(
    parameter integer D_W          = 8,
    parameter integer N1           = 4,
    parameter integer N2           = 4,
    parameter integer MATRIXSIZE_W = 16,
    parameter integer KEEP_A       = 1,
    parameter integer MEM_DEPTH_A  = 4096,
    parameter integer MEM_DEPTH_B  = 4096,
    parameter integer ADDR_W_A     = 12,
    parameter integer ADDR_W_B     = 12,
    parameter         TRANSPOSE_B  = 0
)
(
    input  wire                    clk,
    input  wire                    fclk,
    input  wire                    rst,

    input  wire signed [31:0]      s_axis_s2mm_tdata_A,
    input  wire                    s_axis_s2mm_tlast_A,
    output wire                    s_axis_s2mm_tready_A,
    input  wire                    s_axis_s2mm_tvalid_A,
    
    input  wire signed [31:0]      s_axis_s2mm_tdata_B,
    input  wire                    s_axis_s2mm_tlast_B,
    output wire                    s_axis_s2mm_tready_B,
    input  wire                    s_axis_s2mm_tvalid_B,

    output wire signed [D_W-1:0]   m_axis_mm2s_tdata_A,
    output reg                     m_axis_mm2s_tlast_A,
    input  wire                    m_axis_mm2s_tready_A,
    output wire                    m_axis_mm2s_tvalid_A,

    input  wire [ADDR_W_A-1:0]     rd_addr_A,
    input  wire [ADDR_W_B-1:0]     rd_addr_B,

    output wire signed [D_W-1:0]   A_bram [N1-1:0],
    output wire signed [D_W-1:0]   B_bram [N2-1:0],

    input  wire [MATRIXSIZE_W-1:0] BLOCKS,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_WIDTHdN2,
    input  wire [MATRIXSIZE_W-1:0] BLOCK_SIZEdN2,

    input  wire [MATRIXSIZE_W-1:0] M2,
    input  wire [MATRIXSIZE_W-1:0] M1dN1,
    input  wire [MATRIXSIZE_W-1:0] M3dN2,

    input  wire done_read_control,
    input  wire done_multiply,
    output reg  start_multiply,
    output wire start_multiply_block
);

reg start_multiply_block_r = 0;
reg tlast_A_flag = 0;
reg tlast_B_flag = 0;
reg write_done_A = 0;
reg write_done_B = 0;
reg one_pulse_enable = 1;
reg [1:0] write_done_sync = 2'b00;
reg [1:0] start_multiply_sync = 2'b00;
reg [1:0] done_multiply_sync = 2'b00;

// A signals
reg               [N1-1:0] reg_banked_valid_A;
reg  signed      [D_W-1:0] reg_banked_data_A       [N1-1:0];
reg         [ADDR_W_A-1:0] reg_banked_write_addr_A [N1-1:0];
reg               [N1-1:0] reg_banked_activate_A   [N1-1:0];
wire signed      [D_W-1:0] A_bram_data             [N1-1:0];

wire              [N1-1:0] activate_A;
wire        [ADDR_W_A-1:0] wr_addr_A;
wire        [ADDR_W_A-1:0] rd_addr_A_bram          [N1-1:0];
wire              [N1-1:0] rd_en_A_bram;
reg               [N1-1:0] rd_data_valid_A;

// B signals
reg               [N2-1:0] reg_banked_valid_B;
reg  signed      [D_W-1:0] reg_banked_data_B       [N2-1:0];
reg         [ADDR_W_B-1:0] reg_banked_write_addr_B [N2-1:0];
reg               [N2-1:0] reg_banked_activate_B   [N2-1:0];
wire signed      [D_W-1:0] B_bram_data_0           [N2-1:0];
wire signed      [D_W-1:0] B_bram_data_1           [N2-1:0];

wire              [N2-1:0] activate_B;
wire        [ADDR_W_B-1:0] wr_addr_B;
wire        [ADDR_W_B-1:0] rd_addr_B_bram          [N2-1:0];
wire              [N2-1:0] rd_en_B_bram;
reg               [N2-1:0] rd_data_valid_B;

// Res A signals
reg               [N1-1:0] res_banked_valid_A;
reg  signed      [D_W-1:0] res_banked_data_A       [N1-1:0];
reg         [ADDR_W_A-1:0] res_banked_rd_addr_A    [N1-1:0];
reg               [N1-1:0] res_banked_activate_A   [N1-1:0];
reg               [N1-1:0] res_banked_last_A;

wire                       res_rd_en_A;
wire        [ADDR_W_A-1:0] res_rd_addr_A;
wire                       res_last_addr_A;
wire              [N1-1:0] res_activate_A;
reg               [N1-1:0] res_activate_A_reg;

wire in_tready_A;
wire out_tready_A;
reg  res_rd_addr_A_valid = 0;
reg  res_banked_rd_addr_A_valid = 0;
reg  res_valid_A = 0;
reg  res_banked_last_addr_A_valid = 0;
reg  res_last_A = 0;

// Ping pong management
reg [N2-1:0] ping_pong_rd_en [1:0];   //ping_pong[block0,block1][pipelining] 
reg [N2-1:0] ping_pong_wr_en [1:0];   //ping_pong[block0,block1][pipelining] 

wire stall_ping_pong;
wire early_done_write_pp;
reg  early_done_write_pp_r = 0;
reg  done_write_pp = 0;
reg  start_read_block = 0;

reg signed [D_W-1:0]   s_axis_s2mm_tdata_A_r = 0;
reg                    s_axis_s2mm_tvalid_A_r = 0;
reg signed [D_W-1:0]   s_axis_s2mm_tdata_B_r = 0;
reg                    s_axis_s2mm_tvalid_B_r = 0;
reg                    s_axis_s2mm_tready_A_r = 1;
reg [$clog2(KEEP_A):0] keep_A_cntr = 0;

always @(posedge clk) begin
    if (rst) begin
        s_axis_s2mm_tdata_A_r <= 0;
        s_axis_s2mm_tvalid_A_r <= 0;

        s_axis_s2mm_tdata_B_r <= 0;
        s_axis_s2mm_tvalid_B_r <= 0;
    end else begin
        s_axis_s2mm_tdata_A_r <= s_axis_s2mm_tdata_A;
        s_axis_s2mm_tvalid_A_r <= s_axis_s2mm_tvalid_A;

        s_axis_s2mm_tdata_B_r <= s_axis_s2mm_tdata_B;
        s_axis_s2mm_tvalid_B_r <= s_axis_s2mm_tvalid_B;
    end
end

// A management
genvar x;
for (x = 0; x < N1; x = x + 1) begin: ram_A
    assign A_bram[x] = rd_data_valid_A[x] ? ((ping_pong_rd_en[0][x] || ping_pong_rd_en[1][x]) ? A_bram_data[x] : 0) : 0;

    mem #(
        .WIDTH ( D_W         ),
        .DEPTH ( MEM_DEPTH_A )
    )
    read_ram_A (
        .rst   ( rst                         ),
        .clkA  ( clk                         ),
        .clkB  ( fclk                        ),
        .weA   ( reg_banked_valid_A[x]       ),
        .enA   ( reg_banked_activate_A[x][x] ),
        .enB   ( res_rd_en_A ? res_banked_activate_A[x][x] & out_tready_A : rd_en_A_bram[x] ),
        .addrA ( reg_banked_write_addr_A[x]  ),
        .addrB ( res_rd_en_A ? res_banked_rd_addr_A[x] : rd_addr_A_bram[x] ),
        .dinA  ( reg_banked_data_A[x]        ),
        .doutB ( A_bram_data[x]              )
    );

    always @(posedge fclk) begin
        rd_data_valid_A[x] <= rd_en_A_bram[x];
    end

    if (x==0) begin
        always @(posedge clk) begin
            reg_banked_valid_A[x]      <= s_axis_s2mm_tvalid_A_r;
            reg_banked_data_A[x]       <= s_axis_s2mm_tdata_A_r;
            reg_banked_write_addr_A[x] <= wr_addr_A;
            reg_banked_activate_A[x]   <= activate_A;
        end
    end else begin
        always @(posedge clk) begin
            reg_banked_valid_A[x]      <= reg_banked_valid_A[x-1];
            reg_banked_data_A[x]       <= reg_banked_data_A[x-1];
            reg_banked_write_addr_A[x] <= reg_banked_write_addr_A[x-1];
            reg_banked_activate_A[x]   <= reg_banked_activate_A[x-1];
        end
    end

    // Residual read out
    always @(posedge clk) begin
        if (out_tready_A) begin
            res_activate_A_reg[x] <= res_banked_activate_A[x][x];
        end
    end

    if (x == N1-1) begin
        always @(posedge clk) begin
            if (out_tready_A) begin
                res_banked_data_A[x]     <= A_bram_data[x];
                res_banked_rd_addr_A[x]  <= res_rd_addr_A;
                res_banked_valid_A[x]    <= res_valid_A;
                res_banked_activate_A[x] <= res_activate_A;
                res_banked_last_A[x]     <= res_last_A;
            end
        end
    end else begin
        always @(posedge clk) begin
            if (out_tready_A) begin
                res_banked_data_A[x]     <= (res_activate_A_reg[x] == 1) ? A_bram_data[x] : res_banked_data_A[x+1];
                res_banked_rd_addr_A[x]  <= res_banked_rd_addr_A[x+1];
                res_banked_valid_A[x]    <= res_banked_valid_A[x+1];
                res_banked_activate_A[x] <= res_banked_activate_A[x+1];
                res_banked_last_A[x]     <= res_banked_last_A[x+1];
            end
        end
    end
end

// in_tready_A <- [memA] <- out_tready_A
assign in_tready_A = (res_curr_state == STATE_IDLE);
assign res_rd_en_A = (res_curr_state == STATE_RES_READ_A);
assign out_tready_A = m_axis_mm2s_tready_A | ~m_axis_mm2s_tvalid_A;
assign m_axis_mm2s_tdata_A = res_banked_data_A[0];
assign m_axis_mm2s_tvalid_A = res_banked_valid_A[0];
assign m_axis_mm2s_tlast_A = res_banked_last_A[0];

always @(posedge clk) begin
    if (rst) begin
        res_rd_addr_A_valid <= 0;
        res_banked_rd_addr_A_valid <= 0;
        res_valid_A <= 0;

        res_banked_last_addr_A_valid <= 0;
        res_last_A <= 0;
    end else begin
        if (out_tready_A) begin
            res_rd_addr_A_valid <= res_rd_en_A;
            res_banked_rd_addr_A_valid <= res_rd_addr_A_valid;
            res_valid_A <= res_banked_rd_addr_A_valid;

            res_banked_last_addr_A_valid <= res_last_addr_A;
            res_last_A <= res_banked_last_addr_A_valid;
        end
    end
end

typedef enum logic [2:0] {
    STATE_IDLE,
    STATE_RES_READ_A
} res_state_t;

res_state_t res_curr_state;
res_state_t res_next_state;

always @(posedge clk) begin
    if (rst) begin
        res_curr_state <= STATE_IDLE;
    end else begin
        res_curr_state <= res_next_state;
    end
end

always @(*) begin
    case (res_curr_state)
        STATE_IDLE: begin
            res_next_state = (tlast_A_flag & tlast_B_flag & done_multiply_sync[1] & (keep_A_cntr == KEEP_A-1)) ? STATE_RES_READ_A : STATE_IDLE;
        end
        STATE_RES_READ_A: begin
            res_next_state = (m_axis_mm2s_tvalid_A & m_axis_mm2s_tready_A & m_axis_mm2s_tlast_A) ? STATE_IDLE : STATE_RES_READ_A;
        end
        default: begin
            res_next_state = STATE_IDLE;
        end
    endcase
end

// B management
for (x = 0; x < N2 ; x = x +1) begin: ram_B
    assign B_bram[x] = rd_data_valid_B[x] ? (ping_pong_rd_en[0][x] ? B_bram_data_0[x] : (ping_pong_rd_en[1][x] ? B_bram_data_1[x]: 0)) : 0;

    mem #(
        .WIDTH ( D_W         ),
        .DEPTH ( MEM_DEPTH_B )
    )
    read_ram_B_0 (
        .rst   ( rst                         ),
        .clkA  ( clk                         ),
        .clkB  ( fclk                        ),
        .weA   ( reg_banked_valid_B[x]       ),
        .enA   ( reg_banked_activate_B[x][x] & ping_pong_wr_en[0][x] ),
        .enB   ( rd_en_B_bram[x] & ping_pong_rd_en[0][x] ),
        .addrA ( reg_banked_write_addr_B[x]  ),
        .addrB ( rd_addr_B_bram[x]           ),
        .dinA  ( reg_banked_data_B[x]        ),
        .doutB ( B_bram_data_0[x]            )
    );

    mem #(
        .WIDTH ( D_W         ),
        .DEPTH ( MEM_DEPTH_B )
    )
    read_ram_B_1 (
        .rst   ( rst                         ),
        .clkA  ( clk                         ),
        .clkB  ( fclk                        ),
        .weA   ( reg_banked_valid_B[x]       ),
        .enA   ( reg_banked_activate_B[x][x] & ping_pong_wr_en[1][x] ),
        .enB   ( rd_en_B_bram[x] & ping_pong_rd_en[1][x] ),
        .addrA ( reg_banked_write_addr_B[x]  ),
        .addrB ( rd_addr_B_bram[x]           ),
        .dinA  ( reg_banked_data_B[x]        ),
        .doutB ( B_bram_data_1[x]            )
    );

    always @(posedge fclk) begin
        rd_data_valid_B[x] <= rd_en_B_bram[x];
    end

    if (x==0) begin
        always @(posedge clk) begin
            reg_banked_valid_B[x]      <= s_axis_s2mm_tvalid_B_r;
            reg_banked_data_B[x]       <= s_axis_s2mm_tdata_B_r;
            reg_banked_write_addr_B[x] <= wr_addr_B;
            reg_banked_activate_B[x]   <= activate_B;
        end
    end else begin
        always @(posedge clk) begin
            reg_banked_valid_B[x]      <= reg_banked_valid_B[x-1];
            reg_banked_data_B[x]       <= reg_banked_data_B[x-1];
            reg_banked_write_addr_B[x] <= reg_banked_write_addr_B[x-1];
            reg_banked_activate_B[x]   <= reg_banked_activate_B[x-1];
            
            ping_pong_wr_en[0][x] <= ping_pong_wr_en[0][x-1];
            ping_pong_wr_en[1][x] <= ping_pong_wr_en[1][x-1];
            ping_pong_rd_en[0][x] <= ping_pong_rd_en[0][x-1];
            ping_pong_rd_en[1][x] <= ping_pong_rd_en[1][x-1];
        end
    end
end

// AXI Signals managementreg
reg tready;
always @(posedge clk) begin
    if (rst) begin
        tready <= 0;
    end else begin
        tready <= 1;
    end
end

assign s_axis_s2mm_tready_A = s_axis_s2mm_tready_A_r & in_tready_A & tready;
assign s_axis_s2mm_tready_B = ~stall_ping_pong & ~tlast_B_flag & tready;
assign early_done_write_pp = (wr_addr_B == BLOCK_SIZEdN2-1) & activate_B[N2-2] & s_axis_s2mm_tvalid_B_r;

always @(posedge clk) begin
    if (rst) begin
        early_done_write_pp_r <= 0;
        done_write_pp <= 0;
    end else begin
        early_done_write_pp_r <= early_done_write_pp;
        done_write_pp <= early_done_write_pp_r;
    end
end

always @(posedge clk) begin
    if (rst) begin
        s_axis_s2mm_tready_A_r <= 1;
    end else begin
        if (s_axis_s2mm_tready_A && s_axis_s2mm_tlast_A && s_axis_s2mm_tvalid_A || tlast_A_flag) begin
            s_axis_s2mm_tready_A_r <= 0;
        end else if (done_multiply_sync[1]) begin
            s_axis_s2mm_tready_A_r <= 1;
        end
    end
end

always @(posedge clk) begin
    if (rst) begin
        tlast_A_flag <= 0;
        tlast_B_flag <= 0;
        write_done_A <= 0;
        keep_A_cntr <= 0;
    end else begin
        if (s_axis_s2mm_tready_A && s_axis_s2mm_tlast_A && s_axis_s2mm_tvalid_A) begin
            tlast_A_flag <= 1;
        end

        if (s_axis_s2mm_tready_B && s_axis_s2mm_tlast_B && s_axis_s2mm_tvalid_B) begin
            tlast_B_flag <= 1;
        end

        if (~reg_banked_valid_A[N1-1] && tlast_A_flag) begin
            write_done_A <= 1;
        end

        if (tlast_A_flag && tlast_B_flag && done_multiply_sync[1]) begin
            if (KEEP_A > 1) begin
                keep_A_cntr <= keep_A_cntr + 1;
                if (keep_A_cntr == KEEP_A-1) begin
                    keep_A_cntr <= 0;
                    write_done_A <= 0;
                    tlast_A_flag <= 0;
                end
            end else begin
                write_done_A <= 0;
                tlast_A_flag <= 0;
            end
            tlast_B_flag <= 0;
        end
    end
end

assign start_multiply_block = start_multiply_block_r;

always @(posedge clk) begin
    if (rst) begin
        one_pulse_enable <= 1;
        write_done_B <= 0;
        start_multiply_block_r <= 0;
        start_read_block <= 0;
    end else begin
        // write_done_B - finished multiplying previous block & writing current B
        if (((ping_pong_rd_en[0][N2-1] && ping_pong_rd_en[0][0]) || (ping_pong_rd_en[1][N2-1] && ping_pong_rd_en[1][0])) && one_pulse_enable) begin
            write_done_B <= 1;
            one_pulse_enable <= 0;
        end

        // done_read_control - finished multiplying one block
        if (done_read_control) begin
            one_pulse_enable <= 1;
            start_read_block <= 0;
        end

        if (start_multiply_block_r && start_multiply_sync[1]) begin
            start_multiply_block_r <= 0;
            start_read_block <= 1;
            write_done_B <= 0;
        end else if (write_done_A && write_done_B) begin
            start_multiply_block_r <= 1;
        end
    end
end

typedef enum logic [1:0] {
    IDLE = 2'b00,
    START_MULTIPLY = 2'b01,
    DONE_MULTIPLY = 2'b10
} state_t;

state_t current_state, next_state;

always @(posedge fclk) begin
    if (rst) begin
        current_state <= IDLE;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            // check if write is done and multiplication should start
            start_multiply = 0;
            next_state = (write_done_sync[1]) ? START_MULTIPLY : IDLE;
        end
        START_MULTIPLY: begin
            // start the multiply process and wait for done_multiply
            start_multiply = 1;
            next_state = (done_multiply) ? DONE_MULTIPLY : START_MULTIPLY;
        end
        DONE_MULTIPLY: begin
            // wait until output D is fully read out
            start_multiply = 0;
            next_state = (done_multiply) ? DONE_MULTIPLY : IDLE;
        end
        default: begin
            start_multiply = 0;
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk) begin
    start_multiply_sync <= {start_multiply_sync[0], start_multiply};
    done_multiply_sync <= {done_multiply_sync[0], done_multiply};
end

always @(posedge fclk) begin
    write_done_sync <= {write_done_sync[0], start_multiply_block_r};
end

ping_pong_control ping_pong_ctrl_inst (
    .clk(clk),
    .rst(rst),
    .tlast_A_flag(tlast_A_flag),
    .done_rd(done_read_control),
    .done_wr_early(early_done_write_pp),
    .done_wr(done_write_pp),
    .blk_0({ping_pong_rd_en[0][0],ping_pong_wr_en[0][0]}),
    .blk_1({ping_pong_rd_en[1][0],ping_pong_wr_en[1][0]}),
    .stall_axi_b(stall_ping_pong)
);

mem_write_A #(
    .N1           ( N1           ),
    .MATRIXSIZE_W ( MATRIXSIZE_W ),
    .ADDR_W       ( ADDR_W_A     )
)
mem_write_A_inst (
    .clk        ( clk        ),
    .rst        ( rst | tlast_A_flag ),
    .M2         ( M2         ),
    .M1dN1      ( M1dN1      ),
    .valid_A    ( s_axis_s2mm_tvalid_A & s_axis_s2mm_tready_A ),
    .wr_addr_A  ( wr_addr_A  ),
    .activate_A ( activate_A )
);

generate
    if (TRANSPOSE_B) begin: transpose
        mem_write_A #(
            .N1           ( N2           ),
            .MATRIXSIZE_W ( MATRIXSIZE_W ),
            .ADDR_W       ( ADDR_W_B     )
        )
        mem_write_B_inst (
            .clk        ( clk        ),
            .rst        ( rst | tlast_B_flag ),
            .M2         ( M2         ),
            .M1dN1      ( M3dN2      ),
            .valid_A    ( s_axis_s2mm_tvalid_B & s_axis_s2mm_tready_B ),
            .wr_addr_A  ( wr_addr_B  ),
            .activate_A ( activate_B )
        );
    end else begin: simple
        mem_write_B_pp #(
            .N2           ( N2           ),
            .MATRIXSIZE_W ( MATRIXSIZE_W ),
            .ADDR_W       ( ADDR_W_B     )
        )
        mem_write_B_inst (
            .clk        ( clk        ),
            .rst        ( rst | tlast_B_flag ),
            .M2         ( M2         ),
            .M3dN2      ( BLOCK_WIDTHdN2 ),
            .BLOCKS     ( BLOCKS     ),
            .valid_B    ( s_axis_s2mm_tvalid_B & s_axis_s2mm_tready_B ),
            .wr_addr_B  ( wr_addr_B  ),
            .activate_B ( activate_B )
        );
    end
endgenerate

mem_read #(
    .D_W    (D_W),
    .N      (N1),
    .ADDR_W (ADDR_W_A)
)
mem_read_A (
    .clk          ( fclk           ),
    .rd_addr      ( rd_addr_A      ),
    .rd_en        ( start_multiply & start_read_block ),
    .rd_addr_bram ( rd_addr_A_bram ),
    .rd_en_bram   ( rd_en_A_bram   )
);

mem_read #(
    .D_W    (D_W),
    .N      (N2),
    .ADDR_W (ADDR_W_B)
)
mem_read_B (
    .clk          ( fclk           ),
    .rd_addr      ( rd_addr_B      ),
    .rd_en        ( start_multiply & start_read_block ),
    .rd_addr_bram ( rd_addr_B_bram ),
    .rd_en_bram   ( rd_en_B_bram   )
);

mem_res_read_A #(
    .N1           ( N1           ),
    .MATRIXSIZE_W ( MATRIXSIZE_W ),
    .ADDR_W       ( ADDR_W_A     )
)
mem_res_read_A_inst (
    .clk          ( clk             ),
    .rst          ( rst | ~res_rd_en_A ),
    .M2           ( M2              ),
    .M1dN1        ( M1dN1           ),
    .rd_en_A      ( out_tready_A & res_rd_en_A ),
    .rd_addr_A    ( res_rd_addr_A   ),
    .last_addr_A  ( res_last_addr_A ),
    .activate_A   ( res_activate_A  )
);

endmodule
