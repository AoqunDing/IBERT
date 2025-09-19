`timescale 1ps / 1ps

module sreg
#(
    parameter integer D_W = 32,
    parameter integer DEPTH = 8
)
(
    input wire clk,
    input wire rst,
    input wire shift_en,
    input wire signed [D_W-1:0] data_in,
    output reg signed [D_W-1:0] data_out
);

wire signed [D_W-1:0] rddata;
reg [$clog2(DEPTH)-1:0] rdaddr = 1;
reg [$clog2(DEPTH)-1:0] wraddr = 0;

(* ram_style = "distributed" *) reg [D_W-1:0] mem[DEPTH-1:0];

assign rddata = mem[rdaddr];

always @(posedge clk) begin
    if (rst) begin
        data_out <= 0;
    end else if (shift_en) begin
        data_out <= rddata;
        mem[wraddr] <= data_in;
    end
end

// initial begin
//     $monitor("#time=%0d,shift_en=%b,rdaddr=%0d,wraddr=%0d,data_in=%0d,data_out=%0d",
//             $time,shift_en,rdaddr,wraddr,data_in,data_out);
// end

always @(posedge clk) begin
    if (rst) begin
        rdaddr <= 1;
        wraddr <= 0;
    end else begin
        if (shift_en) begin
            wraddr <= wraddr + 1;
            if (wraddr == DEPTH-1)
                wraddr <= 0;
        end
        if (shift_en) begin
            rdaddr <= rdaddr + 1;
            if (rdaddr == DEPTH-1)
                rdaddr <= 0;
        end
    end
end

// integer i;
// always @(posedge clk) begin
//     if (rst) begin
//         for (i=0; i<=DEPTH-1; i=i+1) begin
//             mem[i] <= 0;
//         end
//     end else begin
//         if (shift_en) begin
//             mem[0] <= data_in;
//             for(i=0; i<DEPTH-1; i=i+1) begin
//                 mem[i+1] <= mem[i];
//             end
//         end
//     end
// end

// assign data_out = mem[DEPTH-1];

endmodule
