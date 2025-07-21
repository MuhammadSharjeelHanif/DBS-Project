module tb;

	logic [3:0] num;
	logic [1:0] sel;	
	logic y;
	logic expected_out;
	int match = 0;
 	int mismatch = 0;

	// Instantiate the DUT
	Q2a mux(
			.number(num), 
			.selection(sel), 
			.Y(y)
		);

	initial begin

		repeat(100) 
		begin
			number_generation();
			case (sel)
				2'b00: expected_out = num[0];
				2'b01: expected_out = num[1];
				2'b10: expected_out = num[2];
				2'b11: expected_out = num[3];
			endcase // selection
			#1
			checking_logic();
		end
		
		$display("Match: %0d ", match);
		$display("Mismatch: %0d ", mismatch);
	end
	

	//generating a number
	task number_generation();
		num = $urandom_range(0,15);
		$display("The generated number is: %0b", num);

		sel = $urandom_range(0,3);
		$display("The generated SE is: %0b", sel);
	endtask : number_generation

	//checking logic
	task checking_logic();
		if (y === expected_out) begin
	          $display("PASS: sel=%b num=%b -> out=%b (expected=%b)", sel, num, y, expected_out);
	          match++;
	        end 

	    else begin
	          $display("FAIL: sel=%b num=%b -> out=%b (expected=%b)", sel, num, y, expected_out);
	          mismatch++;  
	    end
	endtask : checking_logic

endmodule : tb
