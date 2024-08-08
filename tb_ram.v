`timescale 1ns/100ps
	
module tb_ram();				//testbench of ram module
	reg clk;
	reg cen, wen;
	reg [4:0] addr;
	reg [31:0] din;
	wire [31:0] dout;
	
	ram U0_ram(dout, clk, cen, wen, addr, din);
	
	always begin clk = 0; #5; clk = 1; #5; end
	
	initial begin
		//initialize
		cen = 1'b0; wen = 1'b0; addr = 5'b00000; din = 32'h0000_0000; #10;
		cen = 1'b0; wen = 1'b0; addr = 5'b00000; din = 32'h0000_0000; #10;
		
		//write data
		cen = 1'b1; wen = 1'b1; addr = 5'b00001; din = 32'h1111_1111; #10;		
		cen = 1'b1; wen = 1'b1; addr = 5'b00010; din = 32'h2222_2222; #10;
		cen = 1'b1; wen = 1'b1; addr = 5'b00011; din = 32'h3333_3333; #10;
		
		//read data
		cen = 1'b1; wen = 1'b0; addr = 5'b00001; din = 32'hffff_ffff; #10;		
		cen = 1'b1; wen = 1'b0; addr = 5'b00010; din = 32'hffff_ffff; #10;
		cen = 1'b1; wen = 1'b0; addr = 5'b00011; din = 32'hffff_ffff; #10;
		
		//no execute
		cen = 1'b0; wen = 1'b0; addr = 5'b00001; din = 32'hffff_ffff; #10;		
		cen = 1'b0; wen = 1'b0; addr = 5'b00010; din = 32'hffff_ffff; #10;
		cen = 1'b0; wen = 1'b0; addr = 5'b00011; din = 32'hffff_ffff; #10;
		
		$stop;
	end
endmodule
