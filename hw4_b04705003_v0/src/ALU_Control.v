module ALU_Control(funct_i, ALUOp_i, ALUCtrl_o);
	input [5:0] funct_i;
	input [1:0] ALUOp_i;
	output [2:0] ALUCtrl_o;

	reg [2:0] ALUCtrl_o;

	always @(funct_i or ALUOp_i) begin
		if (ALUOp_i == 2'b11) begin
			case (funct_i[5:0])
			// add
			6'b100000:
				begin
					ALUCtrl_o <= 3'b010;
				end
			// subtract
			6'b100010:
				begin
					ALUCtrl_o <= 3'b110;
				end
			// and
			6'b100100:
				begin
					ALUCtrl_o <= 3'b000;
				end
			// or
			6'b100101:
				begin
					ALUCtrl_o <= 3'b001;
				end
			// mul
			6'b011000:
				begin
					ALUCtrl_o <= 3'b111;
				end
			endcase
		end
		// won't be use in this homework
		else if(ALUOp_i == 2'b00) begin
			ALUCtrl_o <= 3'b010; // addi will go into this 
		end
		else if(ALUOp_i == 2'b01) begin
			ALUCtrl_o <= 3'b110;			
		end
		else if(ALUOp_i == 2'b10) begin
			ALUCtrl_o <= 3'b001;		
		end
	end
endmodule