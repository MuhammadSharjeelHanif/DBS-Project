module tb;

	parameter WIDTH = 4;

	logic [WIDTH-1:0] b;
	logic [WIDTH-1:0] g;
	logic [WIDTH-1:0] expected_out;

	int match = 0;
	int mismatch = 0;

	des#(WIDTH) b2g(.binary(b),
					.gray(g));

	initial begin
		repeat(10) begin
			number_generation();
			expected_out = b ^ (b >> 1);
			#1
			checking_logic();
		end	
		$display("Match: %0d ", match);
		$display("Mismatch: %0d ", mismatch);  
	end

	//generating a number
	task number_generation();
		b = $urandom_range(0,WIDTH-1);
		$display("The generated number is: %0b", b);

	endtask : number_generation


	//checking logic
	task checking_logic();
		if (g === expected_out) begin
	          $display("PASS: input=%b  ->  output=%b (expected=%b)", b, g, expected_out);
	          match++;
	        end 

	    else begin
	          $error("FAIL: num=%b  ->  y=%b (expected=%b)", b, g, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic
endmodule : tb

