module counter_mul(next_count, state, count); //32~0 counter 
	input [1:0]state;
	input [7:0]count;
	output reg [7:0]next_count;
	
	wire [7:0]dec_count;
	
	cla64 U0_cla64(dec_count, w0, count, 8'hFF, 1'b0);			//decrease count
	
	always@(state, count) begin
		if(state[1] == 1'b0) next_count = 8'b00000000;		//clear
		else if(state == 2'b10)	next_count = 8'b0010000;	//start
		else if(state == 2'b11) next_count = dec_count;		//doing
		else next_count = count;
	end
endmodule
