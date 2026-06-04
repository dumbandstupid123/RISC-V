// this is a sign extender which was built as a 3-1 mux: this mux decodes the instruction format and allows for extension of immediates to allow smooth processing
module signextender(
    input logic [1:0] ImmSrc,
    input logic [31:7] Instr,
    output logic [31:0] ImmExt
);
// MUX Implementation using always_combinational version
always_comb begin
    case(ImmSrc)
    // I-TYPE CASE
    2'b00:ImmExt = {{20{Instr[31]}}, Instr[31:20]};
    // S-TYPE CASE
    2'b01:ImmExt = {{20{Instr[31]}}, Instr[31:25], Instr[11:7]};
    // B-TYPE CASE
    2'b10:ImmExt = {{20{Instr[31]}}, Instr[7], Instr[30:25], Instr[11:8], 1'b0};
    endcase
end

endmodule