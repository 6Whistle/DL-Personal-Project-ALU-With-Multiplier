`timescale 1ns/100ps

module tb_alu32;			//testbench of alu32
	reg[31:0] a, b, result1_before, result2_before;
	reg[3:0] opcode;
	
	reg clk, reset_n, op_clear, op_start;
	reg[1:0]	op_done_before;
	
	wire[31:0] result1, result2;
	wire[1:0] op_done;


	alu32 tb_alu32(result1, result2, op_done, clk, reset_n, a, b, opcode,
	op_clear, op_start, op_done_before, result1_before, result2_before);	

	always begin
		clk = 0; #5; clk = 1; #5;
	end
	
	initial begin
		reset_n = 0; op_clear = 0; op_start = 0; op_done_before = 2'b11;			//reset
		opcode = 4'h0; a = 32'h0000_1000; b = 32'h0010_1000;							//data
		result1_before = 32'h1234_5678; result2_before = 32'h8765_4321;
		#10;
		
		reset_n = 1; op_start = 1; #10;														//if before op_done is 11, doesn't execute
		
		op_start = 0; op_done_before = 2'b00; #10;										//Before start
		
		op_start = 1;																				//verification of result1
		opcode = 4'h0; #10;																		//NOT A
		opcode = 4'h1; #10;																		//NOT B
		opcode = 4'h2; #10;																		//AND
		opcode = 4'h3; #10;																		//OR
		opcode = 4'h4; #10;																		//XOR
		opcode = 4'h5; #10;																		//XNOR
		opcode = 4'h6; #10;																		//Less than
		opcode = 4'h7; #10;																		//Greater than
		opcode = 4'h8; #10;																		//LSL
		opcode = 4'h9; #10;																		//LSR
		opcode = 4'hA; #10;																		//ASR
		opcode = 4'hB; #10;																		//ADD
		opcode = 4'hC; #10;																		//SUB
		opcode = 4'hD; #10;																		//MUL
		
		op_done_before = 2'b10; op_start = 0; #200;										//Calculating Mul
		$stop;
		
	end

endmodule