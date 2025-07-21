module negedge_detector (
	input logic clk,    // Clock
	input logic rst_n,  // Asynchronous reset active low
	input logic sig,
	output logic pulse	
);

	logic sig_d;

	always_ff @(posedge clk or negedge rst_n) begin
	    if (!rst_n) begin
	    	sig_d <= 1'b0;
	    	pulse <= 1'b0;
	     end
	    else begin
	    	pulse <= ~sig & sig_d;
			sig_d <= sig;
	     end
    end
endmodule : negedge_detector