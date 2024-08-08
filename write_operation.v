module write_operation(to_reg, Addr, we);		//write_operation
	input we;
	output reg [7:0] to_reg;
	input [7:0] Addr;
	
	always@(Addr, we) begin
		if(we == 1'b1)
		begin
			case(Addr)
			8'h00 : to_reg = 8'b0000_0001;
			8'h01 : to_reg = 8'b0000_0010;
			8'h02 : to_reg = 8'b0000_0100;
			8'h03 : to_reg = 8'b0000_1000;
			8'h04 : to_reg = 8'b0001_0000;
			8'h05 : to_reg = 8'b0010_0000;
			8'h06 : to_reg = 8'b0100_0000;
			8'h07 : to_reg = 8'b1000_0000;
			default :  to_reg = 8'b0000_0000;
			endcase
		end
		else  to_reg = 8'b0000_0000;
	end
endmodule

