module register32_8(d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7, clk, reset_n, en, d_in, d_result1, d_result2, op_done);		//8 32-bits Register
	input clk, reset_n;
	input [1:0]op_done;
	input [7:0] en;
	input [31:0] d_in, d_result1, d_result2;
	output [31:0]d_out0, d_out1, d_out2, d_out3, d_out4, d_out5, d_out6, d_out7;
	
	register32_r_en U0_register32_r_en(d_out0, clk, reset_n, en[0], d_in);			//1st 32-bits reg
	register32_r_en U1_register32_r_en(d_out1, clk, reset_n, en[1], d_in);			//2nd 32-bits reg
	register32_r_en U2_register32_r_en(d_out2, clk, reset_n, en[2], d_in);			//3rd 32-bits reg
	register32_r_en U3_register32_r_en(d_out3, clk, reset_n, 1'b1, d_result1);			//4th 32-bits reg
	register32_r_en U4_register32_r_en(d_out4, clk, reset_n, 1'b1, d_result2);			//5th 32-bits reg
	register32_r_en U5_register32_r_en(d_out5, clk, reset_n, en[5], d_in);			//6th 32-bits reg
	register32_r_en U6_register32_r_en(d_out6, clk, reset_n, 1'b1, {30'b0, op_done});			//7th 32-bits reg
	register32_r_en U7_register32_r_en(d_out7, clk, reset_n, en[7], d_in);			//8th 32-bits reg
endmodule
	