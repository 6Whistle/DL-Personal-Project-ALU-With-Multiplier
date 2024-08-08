module mx3_32bits(y, d0, d1, d2, s);		//32bit 3-to-1 mux
	input[31:0] d0, d1, d2;
	input[1:0] s;
	output[31:0] y;
	
	assign y = (s == 2'b00) ? d0 : ((s == 2'b01) ? d1 : d2) ;
endmodule
