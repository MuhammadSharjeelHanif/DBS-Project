module Q2a (
	input [3:0] number,    // 4 Inputs
	input [1:0] selection, // 2 bit selector
	output logic Y 			   // output
);

	always_comb begin
		case (selection)
			2'b00: Y = number[0];
			2'b01: Y = number[1];
			2'b10: Y = number[2];
			2'b11: Y = number[3];
		endcase // selection
	end

endmodule : Q2a