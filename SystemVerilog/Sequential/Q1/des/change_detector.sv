module change_detector #(
	parameter WIDTH = 32
)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input logic [WIDTH-1:0] sig,
	output logic pulse
);

	logic [WIDTH-1:0] sig_prev;

	always_ff @(posedge clk or negedge rst_n) begin : proc_
		if(~rst_n) begin
		 sig_prev <= '0;
		end 
		else begin
			if (sig_prev != sig) begin
				pulse <= 1'b1;
			end
			else begin
				pulse <= 1'b0;
			end
		end
		sig_prev <= sig;
	end
endmodule : change_detector