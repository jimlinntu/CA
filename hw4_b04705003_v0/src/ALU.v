module ALU
(
	data1_i,
	data2_i,
	ALUCtrl_i,
	data_o,
	Zero_o
);
// Port 
input [31:0] data1_i;
input [31:0] data2_i;
input [2:0] ALUCtrl_i;
output [31:0] data_o;
output Zero_o;

// Type
reg Zero_o;
reg [31:0] data_o;

// Behavior block
always @(data1_i or data2_i or ALUCtrl_i) 
	begin
	case (ALUCtrl_i)
		// add
		3'b010:
			begin
				Zero_o <= 0;
				data_o <= data1_i + data2_i;
			end
		// substract
		3'b110:
			begin
				if (data1_i == data2_i)
					Zero_o <= 1;
				else
					Zero_o <= 0;

				data_o <= data1_i - data2_i; 
			end
		// and
		3'b000:
			begin
				Zero_o <= 0;
				data_o <= data1_i & data2_i;
			end
		// or
		3'b001:
			begin
				Zero_o <= 0;
				data_o <= data1_i | data2_i;
			end
		// mul 
		3'b111:
			begin
				Zero_o <= 0;
				data_o <= data1_i * data2_i;
			end
		default: 
			begin 
				Zero_o <= 0;
				data_o <= data1_i;
			end
		endcase
	end




endmodule