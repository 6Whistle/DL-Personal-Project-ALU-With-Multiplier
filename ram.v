module ram(S_dout, clk, cen, wen, S_addr, S_din);			//ram module
	input clk;
	input cen, wen;
	input [4:0] S_addr;
	input [31:0] S_din;
	output reg [31:0] S_dout;
	
	reg [31:0] mem [0:31];
	integer i;

	initial begin												//Reset
	for(i = 0; i < 32; i = i + 1)	
		mem[i] <= 32'h0000_0000;
	end

	always @(posedge clk)
	begin
		if(cen == 1'b1) begin
			if(wen == 1'b1) begin mem[S_addr] <= S_din; S_dout <= 32'h0; end		//if cen and wen is 1, write
			else S_dout <= mem[S_addr];							//if only cen is 1, read
		end
		else S_dout <= 32'h0;									//if cen is 0, no execute
	end
endmodule
