module PISO #(
	parameter WIDTH = 16
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input [WIDTH-1:0] parallel_in,
	input load,
	output serial_out
);

	logic [WIDTH-1 : 0] shift_reg;

	always_ff @(posedge clk or negedge rst_n) begin : proc_
		if(~rst_n) begin
		 shift_reg <= 0;
		end
		else if (load) begin
		 shift_reg <= parallel_in;
		end
		else begin
			shift_reg <= {1'b0, shift_reg[WIDTH-1:1]};
		end
	end
	assign serial_out = shift_reg[0];
endmodule : PISO