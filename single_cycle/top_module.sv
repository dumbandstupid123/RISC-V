// the top module brings the entire processor together through instantiations and wire connections 
module topmodule(
    input logic CLK,
    input logic reset
);

logic [31:0] PC, PCNext;

program_counter pc_reg(
    .PCNext(PCNext),
    .PC(PC),
    .CLK(CLK),
    .reset(reset)
);

logic [31:0] Instr;
instruction_memory im(
    .A(PC),
    .RD(Instr)

);

logic [31:0] RD1, RD2;
logic RegWrite;

registerfile rf(
    .A1(Instr[19:15]),
    .A2(Instr[24:20]),
    .A3(Instr[11:7]),
    .WD3(Result),
    .WE3(RegWrite),
    .RD1(RD1),
    .RD2(RD2),
    .CLK(CLK)
);

logic [1:0] ImmSrc;
logic [31:0] ImmExt;

signextender se(
    .ImmSrc(ImmSrc),
    .ImmExt(ImmExt),
    .Instr(Instr[31:7])
);

logic [31:0] SrcB;
logic [31:0] ALUResult;
logic ALUSrc;
logic Zero;
logic [2:0] ALUControl;

assign SrcB = ALUSrc ? ImmExt : RD2;

ALU alu(
    .SrcA(RD1),
    .ALUControl(ALUControl),
    .SrcB(SrcB),
    .ALUResult(ALUResult),
    .Zero(Zero)
);


logic MemWrite;
logic [31:0] ReadData;

datamemory dm(
    .A(ALUResult),
    .WD(RD2),
    .CLK(CLK),
    .WE(MemWrite),
    .RD(ReadData)

);


logic Branch, Jump;
logic [1:0]ALUOp;
logic [1:0]ResultSrc;


main_decoder md(
    .ResultSrc(ResultSrc),
    .MemWrite(MemWrite),
    .opcode(Instr[6:0]),
    .ALUSrc(ALUSrc),
    .ImmSrc(ImmSrc),
    .RegWrite(RegWrite),
    .Branch(Branch),
    .Jump(Jump),
    .ALUOp(ALUOp)
);

ALU_decoder alu_d(
    .ALUOp(ALUOp),
    .funct3(Instr[14:12]),
    .funct7b5(Instr[30]),
    .ALUControl(ALUControl)

);

logic [31:0] Result;


assign Result = (ResultSrc == 2'b00) ? ALUResult :
                (ResultSrc == 2'b01) ? ReadData :
                PCPlus4;


logic [31:0] PCPlus4, PCTarget;
logic PCSrc;

assign PCPlus4 = PC + 4;
assign PCTarget = PC + ImmExt;
assign PCSrc = (Branch & Zero) | Jump;
assign PCNext = PCSrc ? PCTarget : PCPlus4;

endmodule
