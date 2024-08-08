module Top(M_din, M_grant, clk, reset_n, M_req, M_wr, M_addr, M_dout);			//Top module
	input clk, reset_n, M_req, M_wr;				//Master
	input [7:0] M_addr;
	input [31:0] M_dout;
	
	output M_grant;
	output [31:0] M_din;
	
	wire S0_sel, S1_sel, S_wr;						//Slave
	wire [7:0] S_addr;
	wire [31:0] S_din, S0_dout, S1_dout;
	
	bus U0_bus(M_grant, M_din, S0_sel, S1_sel, S_addr, S_wr, S_din,					//Bus
				clk, reset_n, M_req, M_wr, M_addr, M_dout, S0_dout, S1_dout);
	
	ALU_w_mul U1_ALU_w_mul(S0_dout, clk, reset_n, S0_sel, S_wr, S_addr, S_din);	//ALU
	
	ram U2_ram(S1_dout, clk, S1_sel, S_wr, S_addr[4:0], S_din);							//Ram
		
	endmodule
	