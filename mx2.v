module mx2(y, d0, d1, s);		//2-to-1 mux
	input d0, d1, s;
	output y;
	
	wire sb, w0, w1;
	
	_inv U0_inv(sb, s);
	_nand2 U1_nand2(w0, d0, sb);
	_nand2 U2_nand2(w1, d1, s);
	_nand2 U3_nand2(y, w0, w1);
endmodule
