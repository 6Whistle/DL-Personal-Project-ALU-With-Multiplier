module next_state_mul(next_state, next_multiplier, next_multiplicand, op_done, op_start, op_clear, count, state, cur_multiplier, cur_multiplicand, input_multiplier, input_multiplicand);
//next_state of multiplier
	
	//state
	parameter CLEAR = 2'b00;
	parameter FINISH = 2'b01;
	parameter START = 2'b10;
	parameter DOING = 2'b11;
	
	input op_start, op_clear;
	input [1:0]state;
	input [7:0]count;
	input [31:0]cur_multiplier, cur_multiplicand;
	input [31:0]input_multiplier, input_multiplicand;
	output reg op_done;
	output reg [7:0]next_state;
	output reg [31:0]next_multiplier, next_multiplicand;
	
	always@(state, op_start, op_clear, count, cur_multiplicand) begin
		case(state)
			CLEAR : begin 
				//num clear
				op_done = 1'b0;
				next_multiplier = 32'b0;
				next_multiplicand = 32'b0;
				
				if(op_clear == 1'b1)	next_state = CLEAR;				//clear->clear
				else if(op_start == 1'b0) next_state = CLEAR;		//clear->clear
				else	next_state = START; 									//clear->start
				end
			START : begin
				//set num
				op_done = 1'b0;
				next_multiplier = input_multiplier;
				next_multiplicand = input_multiplicand;
				
				if(op_clear == 1'b1) next_state = CLEAR;				//start->clear
				else next_state = DOING;									//start->doing
				end
			DOING : begin
				//hold num
				next_multiplier = cur_multiplier;
				next_multiplicand = cur_multiplicand;
				
				if(op_clear == 1'b1) begin next_state = CLEAR; op_done = 1'b0; end		//doing->clear
				else if(count == 8'b00000000) begin next_state = FINISH; op_done = 1'b1; end	//doing->finish
				else begin next_state = DOING; op_done = 1'b0; end								//doing->doing
				end
			FINISH : begin
				//hold num and done = 1
				op_done = 1'b1;
				next_multiplier = cur_multiplier;
				next_multiplicand = cur_multiplicand;
				
				if(op_clear == 1'b1) next_state = CLEAR;				//finish->start
				else next_state = FINISH; 									//finish->finish
				end
			default : begin op_done = 1'bx; next_state = 2'bxx; next_multiplier = 32'bx; next_multiplicand = 32'bx; end
		endcase
	end
endmodule
	