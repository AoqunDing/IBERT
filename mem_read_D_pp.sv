`timescale 1ps / 1ps

module mem_read_D_pp
#(
    parameter integer N1           = 4,
    parameter integer N2           = 4,
    parameter integer MATRIXSIZE_W = 16,
//    parameter integer _BLOCK_NUM = 1,
    parameter integer ADDR_W       = 12
)
(
    input  logic                    clk,
    input  logic                    rst,
    input  logic [MATRIXSIZE_W-1:0] BLOCK_NUM,
    input  logic [MATRIXSIZE_W-1:0] BLOCK_WIDTH,
    input  logic [MATRIXSIZE_W-1:0] M1dN1,
    input  logic [MATRIXSIZE_W-1:0] M1xBLOCK_WIDTHdN1,
    input  logic                    valid_D,
    output logic  [ADDR_W-1:0]       rd_addr_D,
    output logic  [MATRIXSIZE_W-1:0] block_index,
    output logic  [N1-1:0]           activate_D
);

logic [ADDR_W-1:0] rd_addr_single_block;

logic [MATRIXSIZE_W-1:0]    block_offset;

logic [N1-1:0]           activate_D_r;
logic [MATRIXSIZE_W-1:0] col;
logic [$clog2(N1)-1:0]   sys_row;
logic [MATRIXSIZE_W-1:0] offset;
logic [MATRIXSIZE_W-1:0] phase;
logic [$clog2(N2)-1:0]   mini_col;
logic [MATRIXSIZE_W-1:0] mini_offset;

always_ff @(posedge clk) begin
    if (rst) begin 
        col         <= 0;
        sys_row     <= 0;
        offset      <= 0;
        phase       <= 0;
        mini_col    <= 0;
        mini_offset <= 0;
        rd_addr_D   <= 0;
        block_index <= 0;
        block_offset <= 0;
    end else if (valid_D) begin
        col <= col + 1;
        mini_col <= mini_col + 1;
        
        if (mini_col == N2-1) begin
            mini_col    <= 0;
            mini_offset <= mini_offset + N2;
        end
        
        if (col == BLOCK_WIDTH-1) begin
            mini_offset <= 0;
            col <= 0;
            //sys_row <= sys_row + 1;
            block_index <= block_index + 1'b1;
            block_offset <= block_offset + M1xBLOCK_WIDTHdN1;
            if(block_index == BLOCK_NUM-1) begin
                sys_row <= sys_row + 1'b1;
                block_offset <= 0;
                block_index <=  0;
                if (sys_row == N1-1) begin
                    offset  <= offset + BLOCK_WIDTH;
                    sys_row <= 0;
                    //phase   <= (phase == M1dN1-1)? 0 : (phase + 1'b1);
                    //block_index <= (phase == M1dN1-1)? (block_index + 1'b1): block_index;
                    //block_offset <= (phase == M1dN1-1)? (block_offset + BLOCK_SIZE) : block_offset;

                    phase   <= (phase == M1dN1-1)? 0: (phase + 1'b1);
                    //block_index <= (block_index == BLOCK_NUM-1)? 0 : (block_index + 1'b1);
                    //block_offset <= (block_index == BLOCK_NUM-1)? 0 : (block_offset + BLOCK_SIZE);
                end
            end
        end
        rd_addr_D <= (BLOCK_NUM>0)? (rd_addr_single_block + block_offset) : (rd_addr_single_block);
    end
end

assign rd_addr_single_block = (N2 - mini_col - 1) + mini_offset + offset;

integer x;
always_ff @(posedge clk) begin
    if (rst) begin
        activate_D_r <= 1;      // [0,0,...,1]
        activate_D   <= 0;
    end else begin
        activate_D <= activate_D_r;
        if (valid_D) begin
            if (col == BLOCK_WIDTH-1 && block_index == BLOCK_NUM-1) begin
                activate_D_r[0] <= ((phase == M1dN1-1)) ? 0 : activate_D_r[N1-1];
                for (x = 1; x < N1; x = x + 1) begin
                    activate_D_r[x] <= activate_D_r[x-1];
                end
            end
        end
    end
end

endmodule
