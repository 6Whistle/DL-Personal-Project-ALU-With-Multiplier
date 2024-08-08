module add_logic(next_result, multiplier, multiplicand, result, x_before);		//add result + booth num
 input [31:0] multiplier, multiplicand;
 input [63:0] result;
 input x_before;
 
 output reg [63:0] next_result;
 
 //pattern
 parameter ADD_0 = 3'b000;
 parameter ADD_M_1 = 3'b001;
 parameter ADD_M_2 = 3'b010;
 parameter ADD_2M = 3'b011;
 parameter SUB_2M = 3'b100;
 parameter SUB_M_1 = 3'b101;
 parameter SUB_M_2 = 3'b110;
 parameter SUB_0 = 3'b111;

 
 wire [31:0]mul_0, mul_add_m, mul_add_2m, mul_sub_2m, mul_sub_m;
 wire [31:0] m2;
 
 assign m2 = multiplier << 1;			//multiplier * 2

 assign mul_0 = result[63:32];		//add 0 and sub 0
 
 //Add pattern
 cla32 U0_cla32(mul_add_m, w0, result[63:32], multiplier, 1'b0);		//ADD_M
 cla32 U1_cla32(mul_add_2m, w0, result[63:32], m2, 1'b0);				//ADD_2M
 cla32 U2_cla32(mul_sub_m, w0, result[63:32], ~(multiplier), 1'b1);	//SUB_M
 cla32 U3_cla32(mul_sub_2m, w0, result[63:32], ~m2, 1'b1);				//SUB_2M
 
 always@(multiplicand, x_before, result) begin
	next_result[31:0] = result[31:0];
	case({multiplicand[1:0], x_before})
		ADD_0 : next_result[63:32] = mul_0;			//add 0
		ADD_M_1 : next_result[63:32] = mul_add_m;	//add multiplier
		ADD_M_2 : next_result[63:32] = mul_add_m;	//add multiplier
		ADD_2M : next_result[63:32] = mul_add_2m;	//add multiplier * 2
		SUB_2M : next_result[63:32] = mul_sub_2m;	//sub multiplier * 2
		SUB_M_1 : next_result[63:32] = mul_sub_m;	//sub multiplier
		SUB_M_2 : next_result[63:32] = mul_sub_m;	//sub multiplier
		SUB_0 : next_result[63:32] = mul_0;			//sub 0
		default : next_result[63:32] = 32'bx;
	endcase
	end
endmodule
 