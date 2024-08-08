module bus(M_grant, M_din, S0_sel, S1_sel, S_addr, S_wr, S_din,
				clk, reset_n, M_req, M_wr, M_addr, M_dout, S0_dout, S1_dout);
	//1 master, 2 slave bus module
				
	input clk, reset_n, M_req, M_wr;
	input [7:0] M_addr;
	input [31:0] M_dout, S0_dout, S1_dout;
	output M_grant, S0_sel, S1_sel, S_wr;
	output [7:0] S_addr;
	output [31:0] M_din, S_din;
	
	//arbiter
	register_r U0_resgister_r(M_grant, clk, reset_n, M_req);
	
	//MUX with grant
	mx2 U1_mx2(S_wr, 1'b0, M_wr, M_grant);
	mx2_8bits U1_mx2_8bits(S_addr, 8'b0, M_addr, M_grant);
	mx2_32bits U1_mx2_32bits(S_din, 32'b0, M_dout, M_grant);
	
	//address decoder
	address_decoder U2_address_decoder(S0_sel, S1_sel, S_addr);
	
	//master din Mux
	register_r U3_0_register(S0_sel_next, clk, reset_n, S0_sel);
	register_r U3_1_register(S1_sel_next, clk, reset_n, S1_sel);
	mx3_32bits U3_mx3_32bits(M_din, 32'b0, S1_dout, S0_dout, {S0_sel_next, S1_sel_next});
endmodule
