module des(
	input [7:0] number,
	input en,

	output logic [2:0] Y
);

	always_comb begin
		case ({en, number})
			9'b000000001,
			9'b000000010,
			9'b000000100,
			9'b000001000,
			9'b000010000,
			9'b000100000,
			9'b001000000,
			9'b010000000: Y = 3'b000;

			9'b100000001 : Y = 3'b000; 
	        9'b100000010 : Y = 3'b001; 
	        9'b100000100 : Y = 3'b010; 
	        9'b100001000 : Y = 3'b011; 
	        9'b100010000 : Y = 3'b100; 
	        9'b100100000 : Y = 3'b101; 
	        9'b101000000 : Y = 3'b110; 
	        9'b110000000 : Y = 3'b111; 
		endcase // selection
	end
endmodule : des