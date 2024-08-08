module mx2_8bits(y, d0, d1, s);		//8bit 2-to-1 mux
	input[7:0] d0, d1;
	input s;
	output[7:0] y;
	
	assign y = (s == 1'b0) ? d0 : d1;
endmodule
