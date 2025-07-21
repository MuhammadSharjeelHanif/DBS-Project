module Q2a (
	input [3:0] number,    // 4 Inputs
	input [1:0] selection, // 2 bit selector
	output logic Y 			   // output
);

	always_comb begin
			if (selection == 2'b00) 
			begin
	        	Y = number[0];
	      	end 

	      	else if (selection == 2'b01) 
	      	begin
	        	Y = number[1];
	      	end 

	      	else if (selection == 2'b10) 
	      	begin
	        	Y = number[2];
	      	end 

	      	else if (selection == 2'b11) 
	      	begin
	        	Y = number[3];
	      	end
		
	end

endmodule : Q2a