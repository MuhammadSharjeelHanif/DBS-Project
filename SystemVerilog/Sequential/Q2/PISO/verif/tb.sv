module tb;

	parameter WIDTH =  16;

	logic clk;
	logic rst_n;
 	logic [WIDTH-1:0] parallel_in;
	logic serial_out;
	logic load;

	logic [WIDTH-1 : 0] shift_reg;
	logic expected_out;

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
		rst_n <= 1;
	end

	PISO u_piso(.clk        (clk),
			    .load       (load),
			    .rst_n      (rst_n),
			    .parallel_in(parallel_in),
			    .serial_out (serial_out));

	initial begin
		repeat(2) begin
			$display("==================================");
			$display("New Cycle");
			$display("==================================");
		    number_generation();
			repeat(WIDTH) 
			begin
		    	@(posedge clk);
		    	checking_logic();
		    	load = 0;
		    end		
	end
		$display("==================================");
    	$display("Match: %0d", match);
    	$display("MisMatch: %0d", mismatch);
    	$finish;
	end

	task number_generation();
		parallel_in = $urandom_range(0,2**WIDTH-1);
		load = 1;

		$display("Parallel input is: %0b", parallel_in);
	endtask : number_generation

	task checking_logic();
		$display("Load enable is: %0b", load);

		if(~rst_n) begin
		 shift_reg = 0;
		end
		else if (load) begin
		 shift_reg = parallel_in;
		end
		else begin
		 expected_out = shift_reg[0];
		 shift_reg = {1'b0, shift_reg[WIDTH-1:1]};
		end

		$display("Shift Register = %0b", shift_reg);
		$display("Expected out   = %0b", expected_out);
		$display("DUT serial_out = %0b", serial_out);

		if (expected_out === serial_out) begin
			$display("PASS");
			match++;
		end
		else begin
			$display("FAIL");
			mismatch++;
		end
	endtask
endmodule : tb