module testbench;

bit out_parity;
parameter WIDTH = 16;
logic [WIDTH-1 : 0] number;
bit correct_parity;
int i = 0;
int match = 0;
int mismatch = 0;


//instantiate the DUT
parity_checker#(WIDTH) parity(.num(number),
					  		  .odd_par(out_parity));


// calling the function 10 times
initial begin

	for (i = 0; i < 2**WIDTH-1; i++) begin
	 driving_parity();
	#1;
	check_parity();
	$display("this is the number:%0d ", number);
	end

	$display("Match: %0d ", match);
	$display("Mismatch: %0d ", mismatch);
 
	$finish;
end


//generating a number
task driving_parity();
	number = i;
	correct_parity = ~(^number);
	
endtask : driving_parity


//checking logic
task check_parity();

	if(correct_parity == out_parity)begin
		$display("Pass...  Number = %0d Parity = %0d",number,out_parity);
		match++;
		end

	else begin
		$error("Fail...   Number = %0d Parity = %0d",number,out_parity);
		mismatch++;
	end
		
endtask : check_parity


endmodule : testbench