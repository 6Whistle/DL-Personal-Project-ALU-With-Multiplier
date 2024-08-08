`timescale 1ns/100ps

    module tb_Top();			//Testbench of top

    reg clk, reset_n, M_req, M_wr;
    reg [7:0] M_addr;
    reg [31:0] M_dout;

    wire M_grant;
    wire [31:0]M_din;

    Top tb_Top(M_din, M_grant, clk, reset_n, M_req, M_wr, M_addr, M_dout);

    always begin clk = 0; #5; clk = 1; #5; end

    initial begin
        reset_n = 0; M_req = 0; M_wr = 0; M_addr = 8'h00; M_dout = 32'h0000_0000; #20;			//Reset

        reset_n = 1; M_req = 1; M_wr = 1; M_addr = 8'h01; M_dout = 32'hffff_0000; #20;			//input operand2
        
        reset_n = 1; M_req = 1; M_wr = 1; M_addr = 8'h02; M_dout = 32'h0000_000a; #20;			//input ASR

        reset_n = 1; M_req = 1; M_wr = 1; M_addr = 8'h05; M_dout = 32'h0000_0001; #20;			//start
        
        reset_n = 1; M_req = 1; M_wr = 0; M_addr = 8'h03; #10;											//print result1
		  
		  M_dout = M_din; #10;
        
        reset_n = 1; M_req = 1; M_wr = 1; M_addr = 8'h20; #20;											//input result1 at ram[0]

        reset_n = 1; M_req = 1; M_wr = 0; M_addr = 8'h21; #20;											//read ram[1]
        
        reset_n = 1; M_req = 1; M_wr = 0; M_addr = 8'h20; #20;											//read ram[0]
        
        $stop;
    end
endmodule

        
     