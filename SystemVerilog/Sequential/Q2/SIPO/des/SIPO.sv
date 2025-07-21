module SIPO #(
	parameter WIDTH = 16
)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input serial_in,
	output [WIDTH-1:0] parallel_out
);

	logic [WIDTH-1:0] shift_reg;

	always_ff @(posedge clk or negedge rst_n) begin
		if(~rst_n) begin
			shift_reg <= 0;
		end 
		else begin
			shift_reg <= {shift_reg[WIDTH-2:0],serial_in};			
		end
	end
	assign parallel_out = shift_reg;
endmodule : SIPO