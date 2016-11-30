//MIPS TOP
`timescale 1ns/1ps

module Pipeline_mips_top(i_clk, i_rst_n, i_coproc0_interrupt_i);

input i_clk;
input i_rst_n;
input i_coproc0_interrupt_i;
////////////////////////////////////////////////////////////////////
//					INITIALIZATION VARIABLES
////////////////////////////////////////////////////////////////////
wire			RegDst;					//Rt = 1 or Rd = 0 at RW
wire			RegWr;					//write in Registers = 1
wire			ExtOp;					//signed = 1 or unsigned = 0 extend of Imm16 befor ALU
wire			ALUSrc;					//R  = 0 or I = 1  instruction goes to ALU
wire	[10:0]	ALUCtrl;				//ALU Control
wire			MemRead;				//read from Data memory = 1
wire			MemWrite;				//write to Data Memory = 0
wire			MemtoReg;				//write to Registers from Data memory = 1 ot from ALU = 0
wire			J;						//Jump
wire 			Jr;						//Jump to address in register
wire			Beq;					//beq
wire			Bne;					//bne
wire 	[1:0] 	ASrc;					//bypass_mux for rs
wire 	[1:0] 	BSrc;					//bypass_mux for rt
wire	[31:0]	instruction;
wire			overflow;				//overflow from ALU
wire			zero;					//zero from ALU
wire			interrupt;

wire 	[4:0] 	rw_d;					//RegWr 
wire 	[4:0] 	rw_ex;					//RegWr reg at execute phase
wire 	[4:0] 	rw_mem;					//RegWr reg	at memory phase
wire 	[4:0] 	rw_w;					//RegWr reg	at write back phase
wire			stall;					//stall signal
wire			mc0;
wire			coproc0_invalid_instr;
wire			eret;
wire			coproc0_we;
////////////////////////////////////////////////////////////////////
//					DATA PATH & CONTROL PATH
////////////////////////////////////////////////////////////////////
Pipeline_data_path Pipeline_data_path_inst1(	.i_clk(i_clk),
									.i_rst_n(i_rst_n),
									.i_RegDst(RegDst),				//Rt = 1 or Rd = 0 at RW
									.i_RegWr(RegWr),				//write in Registers = 1
									.i_ExtOp(ExtOp),				//signed = 1 or unsigned = 0 extend of Imm16 befor ALU
									.i_ALUSrc(ALUSrc),				//R  = 0 or I = 1  instruction goes to ALU
									.i_ALUCtrl(ALUCtrl),			//ALU Control
									.i_MemRead(MemRead),			//read from Data memory = 1
									.i_MemWrite(MemWrite),			//write to Data Memory = 0
									.i_MemtoReg(MemtoReg),			//write to Registers from Data memory = 1 ot from ALU = 0
									.i_J(J),						//Jump
									.i_Jr(Jr),						//Jump to address in register
									.i_Beq(Beq),					//beq
									.i_Bne(Bne),					//bne
									.i_ASrc(ASrc),					//bypass_mux for rs
									.i_BSrc(BSrc),					//bypass_mux for rt
									.i_stall(stall),				//stall signal									
									.i_mc0(mc0),						//move coproc0
									.i_coproc0_invalid_instr(coproc0_invalid_instr),	//	invalid instruction interrupt
									.i_coproc0_interrupt_i(i_coproc0_interrupt_i),		//	external interruppt
									.i_eret(eret),						//	eret control flag
									.i_coproc0_we(coproc0_we),				// 	write enable for coproc0
									.o_instruction(instruction),
									.o_overflow(overflow),			//overflow from ALU	
									.o_zero(zero),					//zero from ALU
									.o_rw_d(rw_d),					//RegWr
									.o_rw_ex(rw_ex),				//RegWr reg at execute phase
									.o_rw_mem(rw_mem),				//RegWr reg	at memory phase
									.o_rw_w(rw_w),					//RegWr reg	at write back phase
									.o_interrupt(interrupt)
									);

Pipeline_control_path Pipeline_Control_path_inst1(	.i_clk(i_clk),
											.i_rst_n(i_rst_n),
											.i_interrupt(interrupt),
											.i_instruction(instruction),
											.i_overflow(overflow),		//overflow from ALU	
					 				 		.i_rw_d(rw_d),				//RegWr
											.i_rw_ex(rw_ex),			//RegWr reg at execute phase
											.i_rw_mem(rw_mem),			//RegWr reg	at memory phase
											.i_rw_w(rw_w),				//RegWr reg	at write back phase
					 					 	.o_RegDst(RegDst),			//Rt = 1 or Rd = 0 at RW
											.o_RegWr(RegWr),			//write in Registers = 1
											.o_ExtOp(ExtOp),			//signed = 1 or unsigned = 0 extend of Imm16 befor ALU
											.o_ALUSrc(ALUSrc),			//R  = 0 or I = 1  instruction goes to ALU
											.o_ALUCtrl(ALUCtrl),		//ALU Control
											.o_MemRead(MemRead),		//read from Data memory = 1
											.o_MemWrite(MemWrite),		//write to Data Memory = 0
											.o_MemtoReg(MemtoReg),		//write to Registers from Data memory = 1 ot from ALU = 0
											.o_J(J),					//Jump
											.o_Jr(Jr),					//Jump to address in register
											.o_Beq(Beq),				//beq
											.o_Bne(Bne),				//bne
											.o_ASrc(ASrc),				//bypass_mux for rs
											.o_BSrc(BSrc),				//bypass_mux for rt
											.o_stall(stall),				//stall signal
										 	.o_mc0(mc0),					//move coproc0
											.o_coproc0_invalid_instr(coproc0_invalid_instr),//	invalid instruction interrupt
											.o_eret(eret),					//	eret control flag
											.o_coproc0_we(coproc0_we)			// 	write enable for coproc0
										 	);

endmodule