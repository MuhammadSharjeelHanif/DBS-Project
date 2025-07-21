module pulse_generator #(
	parameter numOfCycles = 10
	)(
	input clk,    // Clock
	input resetn,  // Asynchronous reset active low
	output logic pulse
);
	logic [$clog2(numOfCycles):0] count;

	always_ff @(posedge clk or negedge resetn) begin : proc_
		if(~resetn) begin
			 pulse <= 0;
			 count <= 0;
		end 
		else if(count == numOfCycles-1) begin
			 pulse <= 1;
			 count <= 0;
		end
		else begin
			 count++;
			 pulse<=0;
		end
	end
endmodule : pulse_generator