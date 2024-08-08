module ALU_w_mul(S_dout, clk, reset_n, S_sel, S_wr, S_addr, S_din);		//ALU with mul module
 input clk, reset_n, S_sel, S_wr;
 input[7:0] S_addr;
 input[31:0] S_din;
 output reg[31:0] S_dout;
 
 wire [1:0] op_done;
 wire [7:0] to_reg;					//input to register
 wire [31:0] from_reg[7:0];		//output from register
 wire [31:0] result1, result2, result1_before, result2_before;
 
 assign we = S_sel & S_wr;				//write
 assign re = S_sel & ~S_wr;			//read
 assign op_clear = from_reg[7][0];	//clear
 
 
 write_operation U0_write_operation(to_reg, S_addr, we);		//Write operation(Decoding with we)
 
 reg[1:0] next_state;
 wire[1:0] state;
 
 register_r U1_0_register_r(state[0], clk, reset_n, next_state[0]);		//state register
 register_r U1_1_register_r(state[1], clk, reset_n, next_state[1]);
 
 register32_8 U1_register32_8(from_reg[0], from_reg[1], from_reg[2], from_reg[3], from_reg[4],
 from_reg[5], from_reg[6], from_reg[7], clk, reset_n & ~op_clear, to_reg, S_din, result1, result2, op_done);				//data register
 
 alu32 U1_alu32(result1, result2, op_done, clk, reset_n, from_reg[0], from_reg[1], from_reg[2][3:0],
 from_reg[7][0], from_reg[5][0], from_reg[6][1:0], from_reg[3], from_reg[4]);														//Calculate module
 
 always@(clk, reset_n, S_sel, S_wr, S_addr, S_din) begin							//State
 	if(re == 1 && S_addr == 8'b0000_0011) next_state = 2'b01;
	else if(re == 1 && S_addr == 8'b0000_0100) next_state = 2'b10;
	else if(re == 1 && S_addr == 8'b0000_0110) next_state = 2'b11;
	else next_state = 2'b00;
	end
 
 always@(clk, reset_n, state) begin													//output
	if(state == 2'b01) S_dout = result1;
	else if(state == 2'b10) S_dout = result2;
	else if(state == 2'b11) S_dout = {30'b0, op_done};
	else S_dout = 32'b0;
	end
 
endmodule 
