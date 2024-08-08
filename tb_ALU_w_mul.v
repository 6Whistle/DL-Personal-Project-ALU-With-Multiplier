`timescale 1ns/100ps

module tb_ALU_w_mul();				//Testbench of ALU_w_mul
	reg clk, reset_n, S_sel, S_wr;
	reg [7:0] S_addr;
	reg [31:0] S_din;

	wire [31:0]S_dout;

ALU_w_mul tb_ALU_w_mul(S_dout, clk, reset_n, S_sel, S_wr, S_addr, S_din);

always begin clk = 0; #5; clk = 1; #5; end

initial begin

	reset_n = 0;
	S_din = 32'h0000_0000; S_sel = 0; S_wr = 0; S_addr = 8'b0000_0000; #10;		//Reset
	
	reset_n = 1;
	S_din = 32'h0123_0123; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0000; #10;		//Input operand1
	S_din = 32'h3210_3210; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0001; #10;		//Input operand2
	S_din = 32'h0000_000B; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0010; #10;		//Input opcode(ADD)
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0110; #10;		//Check op_done
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0101; #10;		//Start
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0110; #10;		//Check op_done
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0011; #10;		//Check result1
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0100; #10;		//Check result2
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0111; #10;		//Clear
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0110; #10;		//Check op_done
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0011; #10;		//Check result1
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0001_0100; #10;		//Check result2
	
	S_din = 32'h0001_2345; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0000; #10;		//Input operand1
	S_din = 32'h0006_7890; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0001; #10;		//Input operand2
	S_din = 32'h0000_000D; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0010; #10;		//Input opcode(MUL)
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 1; S_addr = 8'b0000_0101; #10;		//Start
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0110; #10;		//Check op_done
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0011; #10;		//Check result1
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0001_0100; #200;	//Check result2
	
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0110; #10;		//Check op_done
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0011; #10;		//Check result1
	S_din = 32'h0000_0001; S_sel = 1; S_wr = 0; S_addr = 8'b0000_0100; #40;		//Check result2
	
	$stop;
	
	end
endmodule

	
	
	
	