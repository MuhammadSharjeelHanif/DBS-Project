module tb;

	parameter WIDTH =  16;

	logic clk;
	logic rst_n;
 	logic [WIDTH-1:0] parallel_out;
	logic serial_in;

	logic [WIDTH-1:0] shift_reg;
	logic [WIDTH-1:0] expected_out;

	int match = 0, mismatch = 0;

	always begin
		clk <= 1'b0;
		#50;
		clk <= 1'b1;
		#50;
	end

	initial begin
		rst_n <= 0;
		#100;
		rst_n <=1;
	end

	SIPO u_sipo(.clk         (clk),
				.rst_n       (rst_n),
				.parallel_out(parallel_out),
				.serial_in   (serial_in));

	initial begin
		repeat(20) begin
		  $display("==================================");
	      $display("New Cycle");
	      $display("==================================");

	      shift_reg = '0;

	      repeat(WIDTH) begin
		        @(negedge clk);

		        serial_in = $urandom_range(0, 1);
		        shift_reg = {shift_reg[WIDTH-2:0], serial_in};
		        expected_out = shift_reg;
		        $display("Serial In : %0b", serial_in);
		        $display("Expected Shift Register : %0b", shift_reg);

		        @(posedge clk); 
  
	        end
	    #100;    
	    $display("DUT Output     : %0b", parallel_out);
		$display("Expected Output: %0b", expected_out);

		if (expected_out === parallel_out) begin
			$display("PASS");
			match++;
		end 
		else begin
			$display("FAIL");
			mismatch++;
		end

	    end
	    $display("==================================");
	    $display("Match: %0d", match);
	    $display("Mismatch: %0d", mismatch);
	    $display("==================================");
	    $finish;
    end
endmodule : tb