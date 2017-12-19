module Control(Op_i, RegDst_o, ALUOp_o, ALUSrc_o, RegWrite_o);
	input [5:0] Op_i;
	output RegDst_o, ALUSrc_o, RegWrite_o;
	output [1:0] ALUOp_o;
	// type
	reg [1:0] ALUOp_o;
	reg RegWrite_o;
	reg ALUSrc_o;
	// 00 0000
	// If it is R-type then choose rd, else choose rt to write
	assign RegDst_o = (~Op_i[5]) & (~Op_i[4]) & (~Op_i[3]) & (~Op_i[2]) & (~Op_i[1]) & (~Op_i[0]);

	always @(Op_i) begin
		case (Op_i)
			// if op code is 00 0000(R-type)
			// and
			// or
			// add
			// sub
			// mul
			6'b000000:
			begin
				RegWrite_o <= 1;
				ALUSrc_o <= 0;
				ALUOp_o <= 2'b11;
			end
			// addi 
			6'b001000:
			begin
				RegWrite_o <= 1;
				ALUSrc_o <= 1; // choose immediate
				ALUOp_o <= 2'b00;
			end
			default:
			begin
				RegWrite_o <= 0;
				ALUSrc_o <= 0;
				ALUOp_o <= 2'b00;
			end
			endcase
	end
	
endmodule
