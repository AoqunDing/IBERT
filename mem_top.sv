`timescale 1ps / 1ps

/*
mem_top - top mem module, instantiates different memories depending on MEM_SIZE
*/

module mem_top
#(
    parameter WIDTH = 32,
    parameter DEPTH = 512,
    parameter DIST = 4096   // threshold for distributed memory: 128x32b, 512x8b
)
(
    input  wire                     rst,
    input  wire                     clkA,
    input  wire                     clkB,
    input  wire                     weA,
    input  wire                     enA,
    input  wire                     enB,
    input  wire [$clog2(DEPTH)-1:0] addrA,
    input  wire [$clog2(DEPTH)-1:0] addrB,
    input  wire [WIDTH-1:0]         dinA,
    output wire [WIDTH-1:0]         doutB
);

localparam int MEM_SIZE = WIDTH * DEPTH;

generate
    if (MEM_SIZE <= DIST) begin: distr_mem
        mem_dist #(
            .WIDTH ( WIDTH ),
            .DEPTH ( DEPTH )
        )
        mem_inst (
            .rst   ( rst   ),
            .clkA  ( clkA  ),
            .clkB  ( clkB  ),
            .weA   ( weA   ),
            .enA   ( enA   ),
            .enB   ( enB   ),
            .addrA ( addrA ),
            .addrB ( addrB ),
            .dinA  ( dinA  ),
            .doutB ( doutB )
        );
    end else begin: bram_mem
        mem_par #(
            .WIDTH ( WIDTH ),
            .DEPTH ( DEPTH )
        )
        mem_inst (
            .rst   ( rst   ),
            .clkA  ( clkA  ),
            .clkB  ( clkB  ),
            .weA   ( weA   ),
            .enA   ( enA   ),
            .enB   ( enB   ),
            .addrA ( addrA ),
            .addrB ( addrB ),
            .dinA  ( dinA  ),
            .doutB ( doutB )
        );
    end
endgenerate

endmodule
