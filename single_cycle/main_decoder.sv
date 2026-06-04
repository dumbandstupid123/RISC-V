module main_decoder(
    input logic [6:0] opcode,
    output logic RegWrite,
    output logic [1:0] ImmSrc,
    output logic ALUSrc,
    output logic MemWrite,
    output logic [1:0]ResultSrc,
    output logic Branch,
    output logic [1:0] ALUOp,
    output logic Jump
);

always_comb
begin
case(opcode)
// lw (load word instruction)
7'b0000011: begin 
    RegWrite = 1; 
    ImmSrc = 2'b00;
    ALUSrc = 1;
    MemWrite = 0; 
    ResultSrc = 2'b01; 
    Branch = 0;
    ALUOp = 2'b00;
    Jump = 0;
end
// sw (store word instruction)
7'b0100011: begin 
    RegWrite = 0; 
    ImmSrc = 2'b01;
    ALUSrc = 1;
    MemWrite = 1; 
    ResultSrc = 2'b00; // XX can be asserted zero in this cas to present latching  
    Branch = 0; 
    ALUOp = 2'b00;
    Jump = 0;
end
// R Type Instructions
7'b0110011: begin 
    RegWrite = 1; 
    ImmSrc = 2'b00;
    ALUSrc = 0;
    MemWrite = 0; 
    ResultSrc = 2'b00; 
    Branch = 0;
    ALUOp = 2'b10;
    Jump = 0;
end
// beq (branch if equal to instruction)
7'b1100011: begin 
    RegWrite = 0; 
    ImmSrc = 2'b10
    ALUSrc = 0;
    MemWrite = 0; 
    ResultSrc = 2'b00; 
    Branch = 1;
    ALUOp = 2'b01;
    Jump = 0;
end
// I-Type ALU instructions
7'b0010011: begin 
    RegWrite = 1; 
    ImmSrc = 2'b00;
    ALUSrc = 1;
    MemWrite = 0; 
    ResultSrc = 2'b00; 
    Branch = 0;
    ALUOp = 2'b10;
    Jump = 0;
end
// jal ( jump and link instruction)
7'b1101111: begin 
    RegWrite = 1; 
    ImmSrc = 2'b11;
    ALUSrc = 0;
    MemWrite = 0; 
    ResultSrc = 2'b10; 
    Branch = 0;
    ALUOp = 2'b00;
    Jump = 1;
end

// latches gave me a lot of problems so I added a default cover them
default: begin
    RegWrite = 0; 
    ImmSrc = 2'b00;
    ALUSrc = 0;
    MemWrite = 0; 
    ResultSrc = 2'b00; 
    Branch = 0;
    ALUOp = 2'b00;
    Jump = 0;

end


endcase
end 
endmodule
