module tb;

	logic [2:0] num;
	bit e;	
	logic [7:0] y;

	logic [7:0] expected_out;

	int match = 0;
 	int mismatch = 0;

	des decoder(
			.number(num), 
			.en(e), 
			.Y(y)
			);

	initial begin
		repeat(10000) begin
			number_generation();

			if (e==1) begin
				expected_out[0] = ~num[2] & ~num[1] & ~num[0]; // 000
				expected_out[1] = ~num[2] & ~num[1] &  num[0]; // 001
				expected_out[2] = ~num[2] &  num[1] & ~num[0]; // 010
				expected_out[3] = ~num[2] &  num[1] &  num[0]; // 011
				expected_out[4] =  num[2] & ~num[1] & ~num[0]; // 100
				expected_out[5] =  num[2] & ~num[1] &  num[0]; // 101
				expected_out[6] =  num[2] &  num[1] & ~num[0]; // 110
				expected_out[7] =  num[2] &  num[1] &  num[0]; // 111
			end
			else begin
  				expected_out = 8'b0;
			end
		#1
		checking_logic();

		end

		$display("Match: %0d ", match);
		$display("Mismatch: %0d ", mismatch);
	end


	//generating a number
	task number_generation();
		num = $urandom_range(0,7);
		$display("The generated number is: %0b", num);

		e = $urandom_range(0,1);
		$display("The generated SE is: %0b", e);
	endtask : number_generation


	//checking logic
	task checking_logic();
		if (y === expected_out) begin
	          $display("PASS: e=%b num=%b -> out=%b (expected=%b)", e, num, y, expected_out);
	          match++;
	        end 

	    else begin
	          $error("FAIL: e=%b num=%b -> out=%b (expected=%b)", e, num, y, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic


endmodule : tb