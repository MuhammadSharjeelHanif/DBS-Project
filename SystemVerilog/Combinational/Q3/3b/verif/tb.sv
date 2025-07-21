module tb;

	parameter WIDTH = 4;

	logic [WIDTH-1:0] g;
	logic [WIDTH-1:0] b;
	logic [WIDTH-1:0] expected_out;
	logic [WIDTH-1:0] temp;


	int match = 0;
	int mismatch = 0;

	des#(WIDTH) g2b(.binary(b),
					.gray(g));
	initial begin
		repeat(10) begin
			number_generation();
			temp = g;
		    expected_out = temp;
		    while (temp > 0) begin
		        temp = temp >> 1;
		        expected_out ^= temp;
		    end
			#1
			checking_logic();
		end	
		$display("Match: %0d ", match);
		$display("Mismatch: %0d ", mismatch);  
	end

	//generating a number
	task number_generation();
		g = $urandom_range(0,2**WIDTH-1);
		$display("The generated number is: %0b", g);

	endtask : number_generation


	//checking logic
	task checking_logic();
		if (b === expected_out) begin
	          $display("PASS: input=%b  ->  output=%b (expected=%b)", g, b, expected_out);
	          match++;
	        end 

	    else begin
	          $error("FAIL: num=%b  ->  output=%b (expected=%b)", g, b, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic
endmodule : tb