module mx2_32bits(y, d0, d1, s);		//32bit 2-to-1 mux
	input[31:0] d0, d1;
	input s;
	output[31:0] y;
	
	assign y = (s == 1'b0) ? d0 : d1;
endmodule
