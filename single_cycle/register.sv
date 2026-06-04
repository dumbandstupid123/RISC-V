module registerfile(
    input CLK,
    input [4:0] A1,
    input [4:0] A2,
    input [4:0] A3,
    input [31:0] WD3,
    input WE3,

    output [31:0] RD1,
    output [31:0] RD2

);

logic [31:0] registers [0:31];

assign RD1 = registers[A1];
assign RD2 = registers[A2];

always_ff @ (posedge CLK)
begin
    if (WE3) & if A3 != 0
        registers[A3] <= WD3;
end

endmodule

