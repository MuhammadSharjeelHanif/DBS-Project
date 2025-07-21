module des(
	input [7:0] number,
	input en,

	output logic [2:0] Y
	);

	always_comb begin
		casez({en,number})
			9'b11???????: Y = 3'b111;
			9'b101??????: Y = 3'b110; 
		    9'b1001?????: Y = 3'b101; 
		    9'b10001????: Y = 3'b100; 
		    9'b100001???: Y = 3'b011; 
		    9'b1000001??: Y = 3'b010; 
		    9'b10000001?: Y = 3'b001; 
		    9'b100000001: Y = 3'b000; 
		    default : Y = 3'b000;
		endcase
	end

endmodule : des