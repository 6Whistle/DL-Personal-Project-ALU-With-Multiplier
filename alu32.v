module alu32(result1, result2, op_done, clk, reset_n, a, b, opcode,
 op_clear, op_start, op_done_before, result1_before, result2_before);
 //alu32
	input[31:0] a, b, result1_before, result2_before;
	input[3:0] opcode;
	input clk, reset_n, op_clear, op_start;
	input[1:0] op_done_before;
	
	output reg[31:0] result1, result2;
	output reg[1:0] op_done;
	
	wire [31:0] w_add_b;
	wire [31:0] w_not_a, w_not_b, w_and, w_or, w_xor, w_xnor, w_add;
	wire [63:0] w_mul;
	wire co_add, w_done_mul, w_sign_b;
	
	assign w_sign_b = b[31];
	assign w_start = op_start & opcode[0] & ~(opcode[1]) & opcode[2] & opcode[3];
	
	_inv_32bits U0_inv_32bits(w_not_a, a);		//invert a
	_inv_32bits U1_inv_32bits(w_not_b, b);		//invert b
	_and2_32bits U2_and2_32bits(w_and, a, b);	//a * b
	_or2_32bits U3_or2_32bits(w_or, a, b);		//a + b
	_xor2_32bits U4_xor2_32bits(w_xor, a, b);	//a ^ b
	_xnor2_32bits U5_xnor2_32bits(w_xnor, a, b);		//~(a ^ b)
	
	mx2_32bits U6_mx2_32bits(w_add_b, b, w_not_b, ~opcode[0]);		//adder and subtracter
	cla32 U7_cla32(w_add, co_add, a, w_add_b, ~opcode[0]);		//select adder's input(b or ~b)
	
	multiplier U8_multiplier(w_done_mul, w_mul, clk, reset_n, a, b, w_start, op_clear);		//Multiplier
	
	always@(clk, reset_n, op_clear, op_start, op_done_before, opcode, w_done_mul, w_mul,
				a, b, w_not_a, w_not_b, w_and, w_or, w_xor, w_xnor, w_add, w_sign_b) begin
		if(op_done_before == 2'b11)				//Finish Cal
		begin
			op_done = op_done_before;	result1 = result1_before;	result2 = result2_before;
		end
		else if(op_done_before == 2'b10)			//Doing Mul
		begin
			result1 = w_mul[31:0]; 	result2 = w_mul[63:32];
			op_done = (w_done_mul == 1'b1) ? 2'b11 : 2'b10;
		end
		else if(op_done_before == 2'b00 & op_start == 1'b1)		//Start
		begin
			result2 = 32'h0;
			case(opcode)
				4'b0000 : begin op_done = 2'b11; result1 = w_not_a; end							//NOT A
				4'b0001 : begin op_done = 2'b11; result1 = w_not_b; end							//NOT B
				4'b0010 : begin op_done = 2'b11; result1 = w_and; end								//AND
				4'b0011 : begin op_done = 2'b11; result1 = w_or; end								//OR
				4'b0100 : begin op_done = 2'b11; result1 = w_xor; end								//XOR
				4'b0101 : begin op_done = 2'b11; result1 = w_xnor; end							//XNOR
				4'b0110 : begin op_done = 2'b11; result1 = (a < b) ? 32'h0000_0001 : 32'h0; end	//Less than
				4'b0111 : begin op_done = 2'b11; result1 = (a > b) ? 32'h0000_0001 : 32'h0; end	//Greater than
				4'b1000 : begin op_done = 2'b11; result1 = b << 1; end							//LSL
				4'b1001 : begin op_done = 2'b11; result1 = b >> 1; end							//LSR
				4'b1010 : begin op_done = 2'b11; result1[30:0] = b[31:1]; result1[31] = w_sign_b; end		//ASR
				4'b1011 : begin op_done = 2'b11; result1 = w_add; end								//ADD
				4'b1100 : begin op_done = 2'b11; result1 = w_add; end								//SUB
				4'b1101 : begin op_done = 2'b10; result1 = 32'h0; end								//MUL
				default : begin op_done = 2'b00; result1 = 32'h0; end
			endcase
		end
		else	begin op_done = op_done_before; result1 = result1_before; result2 = result2_before; end		//before start	
	end
	
endmodule
	