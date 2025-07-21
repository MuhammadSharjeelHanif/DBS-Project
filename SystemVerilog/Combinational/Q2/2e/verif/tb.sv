module tb;

	logic [7:0] num;
	bit e;	
	
	logic [2:0] y;
	logic [2:0] expected_out;

	int match = 0;
 	int mismatch = 0;

	des encoder(
			.number(num), 
			.en(e), 
			.Y(y)
			);

	initial begin
		repeat(100) begin
			number_generation();

		if (e == 1) 
		begin
      		if (num[7]) expected_out = 3'b111;
      		else if (num[6]) expected_out = 3'b110;
      		else if (num[5]) expected_out = 3'b101;
      		else if (num[4]) expected_out = 3'b100;
      		else if (num[3]) expected_out = 3'b011;
      		else if (num[2]) expected_out = 3'b010;
      		else if (num[1]) expected_out = 3'b001;
      		else if (num[0]) expected_out = 3'b000;
    	end 
    	else begin
      		expected_out = 3'b000; // when disabled
    	end

		#1
		checking_logic();

		end

		$display("Match: %0d ", match);
		$display("Mismatch: %0d ", mismatch);
	end


	//generating a number
	task number_generation();
		int temp;
		temp = $urandom_range(0,7);
		num = 8'b00000001 << temp;
		$display("The generated number is: %0b", num);

		e = $urandom_range(0,1);
		$display("The generated SE is: %0b", e);
	endtask : number_generation


	//checking logic
	task checking_logic();
		if (y === expected_out) begin
	          $display("PASS: e=%b num=%b -> y=%b (expected=%b)", e, num, y, expected_out);
	          match++;
	        end 

	    else begin
	          $error("FAIL: e=%b num=%b -> y=%b (expected=%b)", e, num, y, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic


endmodule : tb