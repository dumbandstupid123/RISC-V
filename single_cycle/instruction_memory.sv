// now the program counter gave us the address of the instruction, we use it to fetch the specific instruction
// instruction memory is ROM: address in, instruction out: read only, no write port, no CLK

module instructionmemory(A, RD);

    input logic [31:0] A;
    output logic [31:0] RD;

    logic [31:0] mem [0:255];
    assign RD = mem[A[31:2]];

endmodule