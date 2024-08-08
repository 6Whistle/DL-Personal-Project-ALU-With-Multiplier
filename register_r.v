module register_r(q, clk, reset_n, d);	//1-bits reset_n register
	input clk, reset_n;
	input d;
	output reg q;
	
	always@(posedge clk or negedge reset_n)		//Operate when clk and reset_n is changed
	begin
		if(reset_n == 0)		q <= 1'b0;			//reset
		else						q <= d;				//store
	end
endmodule
