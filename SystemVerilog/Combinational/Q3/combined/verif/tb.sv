module tb;

	parameter WIDTH = 4;

	logic [WIDTH-1:0] g;
	logic [WIDTH-1:0] b;
	logic [WIDTH-1:0] expected_out;
	logic [WIDTH-1:0] temp;
	logic [WIDTH-1:0] b1;
	logic [WIDTH-1:0] expected_outg;

	int match = 0;
	int mismatch = 0;


	desb2g#(WIDTH) b2g(.binary(b1),
					   .gray(g));
	desg2b#(WIDTH) g2b(.binary(b),
					   .gray(g));

	initial begin
		repeat(100) begin
			number_generation();

			expected_outg = b1 ^ (b1 >> 1);

			temp = expected_outg;
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
		b1 = $urandom_range(0,2**WIDTH-1);
		$display("The generated number is: %0b", b1);

	endtask : number_generation


	//checking logic
	task checking_logic();
		if (b === b1) begin
	          $display("PASS: binary=%b  ->  gray=%b >  binary=%b  (expected=%b)", b1, g, b, expected_out);
	          match++;
	        end 

	    else begin
	          $error("FAIL: binary=%b  ->  gray=%b >  binary=%b  (expected=%b)", b1, g, b, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic
endmodule : tb