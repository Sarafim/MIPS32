//MIPS TOP
`timescale 1ns/1ps

module mips_top(i_clk, i_rst_n,i_coproc0_interrupt_i);

input 	i_clk;
input 	i_rst_n;
input	i_coproc0_interrupt_i;
////////////////////////////////////////////////////////////////////
//					INITIALIZATION VARIABLES
////////////////////////////////////////////////////////////////////
wire	RegDst;					
wire	RegWr;					
wire	ExtOp;					
wire	ALUSrc;					
wire	[10:0]	 ALUCtrl;		
wire	MemRead;				
wire	MemWrite;				
wire	MemtoReg;				
wire	J;
wire 	Jr;						
wire	Beq;					
wire	Bne;					
wire	[31:0] instruction;
wire	overflow;
wire	zero;
wire 	mc0;
wire	coproc0_invalid_instr;
wire	eret;
wire	coproc0_we;
////////////////////////////////////////////////////////////////////
//					DATA PATH & CONTROL PATH
////////////////////////////////////////////////////////////////////
data_path data_path_inst1(	.i_clk(i_clk),
							.i_rst_n(i_rst_n),
							.i_RegDst(RegDst),								//Rt = 1 or Rd = 0 at RW
							.i_RegWr(RegWr),								//write in Registers = 1
							.i_ExtOp(ExtOp),								//signed = 1 or unsigned = 0 extend of Imm16 befor ALU
							.i_ALUSrc(ALUSrc),								//R  = 0 or I = 1  instruction goes to ALU
							.i_ALUCtrl(ALUCtrl),							//ALU Control
							.i_MemRead(MemRead),							//read from Data memory = 1
							.i_MemWrite(MemWrite),							//write to Data Memory = 0
							.i_MemtoReg(MemtoReg),							//write to Registers from Data memory = 1 ot from ALU = 0
							.i_J(J),										//Jump
							.i_Jr(Jr),										//Jump to address in register
							.i_Beq(Beq),									//beq
							.i_Bne(Bne),									//bne
							.i_mc0(mc0),									//move coproc0
							.i_coproc0_invalid_instr(coproc0_invalid_instr),//	invalid instruction interrupt
							.i_coproc0_interrupt_i(i_coproc0_interrupt_i),	//	external interruppt
							.i_eret(eret),									//	eret control flag
							.i_coproc0_we(coproc0_we),						// 	write enable for coproc0
							.o_instruction(instruction),
							.o_overflow(overflow),							//overflow from ALU	
							.o_zero(zero)									//zero from ALU
							);

Control_path Control_path_inst1(	.i_instruction(instruction),								//instruction [5:0]
			 				 		.i_overflow(overflow),		
			 				 		.o_RegDst(RegDst),								//Rt = 1 or Rd = 0 at RW
									.o_RegWr(RegWr),								//write in Registers = 1
									.o_ExtOp(ExtOp),								//signed = 1 or unsigned = 0 extend of Imm16 befor ALU
									.o_ALUSrc(ALUSrc),								//R  = 0 or I = 1  instruction goes to ALU
									.o_ALUCtrl(ALUCtrl),							//ALU Control
									.o_MemRead(MemRead),							//read from Data memory = 1
									.o_MemWrite(MemWrite),							//write to Data Memory = 0
									.o_MemtoReg(MemtoReg),							//write to Registers from Data memory = 1 ot from ALU = 0
									.o_J(J),										//Jump
									.o_Jr(Jr),										//Jump to address in register
									.o_Beq(Beq),									//beq
									.o_Bne(Bne),										//bne									//bne
									.o_mc0(mc0),									//move coproc0,
									.o_coproc0_invalid_instr(coproc0_invalid_instr),//	invalid instruction interrupt
									.o_eret(eret),									//	eret control flag
									.o_coproc0_we(coproc0_we)						// 	write enable for coproc0
								 	);

endmodule