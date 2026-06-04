// The ALU combines a variety of mathematical and logical operations inot a single unit, and it forms the heart of most computer systems
// The ALU is often times a glorified MUX controlled by ALUControl in the Control Unit
module ALU(
    input logic [31:0] SrcA,
    input logic [31:0] SrcB,
    input logic [2:0] ALUControl,
    output logic [31:0] ALUResult,
    output logic Zero
    );

    assign Zero = (ALUResult == 32'b0);

    always_comb begin
        case(ALUControl)
        // addition
        3'b000: ALUResult = SrcA + SrcB;
        // subtraction
        3'b001: ALUResult = SrcA - SrcB;
        // Logical AND 
        3'b010: ALUResult = SrcA & SrcB;
        // Logical OR
        3'b011: ALUResult = SrcA | SrcB;
        // Set less than
        3'b101: ALUResult = SrcA < SrcB;
        // Set a default case to cover unexpected values
        default: ALUResult = 32'b0;
        endcase
    end
endmodule