module address_decoder(s0_sel, s1_sel, address);		//address decoder
	input [7:0]address;
	output reg s0_sel, s1_sel;
	
	always@(address) begin
		if(address[7:4] == 3'b0000) {s0_sel, s1_sel} = 2'b10;	//00 ~ 0F -> s0
		else if(address[7:5] == 3'b001) {s0_sel, s1_sel} = 2'b01;	//20 ~ 3F -> s1
		else {s0_sel, s1_sel} = 2'b00;
	end
endmodule
