module CPU
(
    clk_i, 
    rst_i,
    start_i
);

// Ports
input               clk_i;
input               rst_i;
input               start_i;

// Types
wire [31:0] PC_in, PC_out;
wire [31:0] instruction;
wire [31:0] ALU_result;
wire [31:0] read_data_1, read_data_2;
wire [4:0] write_register;
wire [31:0] sign_extended;
wire [2:0] alu_control;
wire [31:0] alu_src;
wire zero;

Control Control(
    .Op_i       (instruction[31:26]),
    .RegDst_o   (),
    .ALUOp_o    (),
    .ALUSrc_o   (),
    .RegWrite_o ()
);

Adder Add_PC(
    .data1_in   (PC_out),
    .data2_in   (32'd4),
    .data_o     (PC_in) // PC.pc_i = instr_addr + 4 
);


PC PC(
    .clk_i      (clk_i),
    .rst_i      (rst_i),
    .start_i    (start_i),
    .pc_i       (PC_in),
    .pc_o       (PC_out)
);

Instruction_Memory Instruction_Memory(
    .addr_i     (PC_out), 
    .instr_o    (instruction)
);

Registers Registers(
    .clk_i      (clk_i),
    .RSaddr_i   (instruction[25:21]),
    .RTaddr_i   (instruction[20:16]),
    .RDaddr_i   (write_register), 
    .RDdata_i   (ALU_result),
    .RegWrite_i (Control.RegWrite_o), 
    .RSdata_o   (read_data_1), 
    .RTdata_o   (read_data_2) 
);


MUX5 MUX_RegDst(
    .data1_i    (instruction[20:16]), // if false
    .data2_i    (instruction[15:11]), // if true 
    .select_i   (Control.RegDst_o),
    .data_o     (write_register) // Not used in this hw
);



MUX32 MUX_ALUSrc(
    .data1_i    (read_data_2),
    .data2_i    (sign_extended),
    .select_i   (Control.ALUSrc_o),
    .data_o     (alu_src)
);



Sign_Extend Sign_Extend(
    .data_i     (instruction[15:0]),
    .data_o     (sign_extended)
);

  

ALU ALU(
    .data1_i    (read_data_1),
    .data2_i    (alu_src),
    .ALUCtrl_i  (alu_control),
    .data_o     (ALU_result),
    .Zero_o     (zero)
);



ALU_Control ALU_Control(
    .funct_i    (instruction[5:0]), //function bit
    .ALUOp_i    (Control.ALUOp_o),
    .ALUCtrl_o  (alu_control)
);


endmodule

