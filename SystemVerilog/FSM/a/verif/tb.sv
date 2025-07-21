module tb;
	logic clk;
	logic rst_n;
	logic in;
	logic out;

	des FSM(
			.clk  (clk),
			.in   (in),
			.rst_n(rst_n),
			.out  (out)
		);

	always begin
		clk <= 1'b0;
		#50;
		clk <= 1'b1;
		#50;
	end

	initial begin
		rst_n <= 0;
		@(posedge clk);
		rst_n <= 1;
	end		

	initial begin
    	in = 0;

		repeat(50) begin
		@(posedge clk);
		number_gen();
		end		
	end

	task number_gen();
		begin
		in = $urandom_range(0,1);	
		end
	endtask : number_gen

	
endmodule : tb
