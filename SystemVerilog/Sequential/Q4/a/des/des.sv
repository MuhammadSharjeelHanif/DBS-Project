interface complex_num #(parameter WIDTH = 16);
	logic signed [WIDTH-1 : 0] riyal;
	logic signed [WIDTH-1 : 0] imag;

	modport IN (input riyal, imag);	
	modport OUT (output riyal, imag);	
endinterface : complex_num


module des#(
	parameter WIDTH = 16
)(
	input clk,
	input rst_n,

	complex_num.IN a_b, 
	complex_num.IN c_d, 

	complex_num.OUT w_x,      // Addition output
  	complex_num.OUT y_z      // Multiplication output
);


	always @(posedge clk) begin : proc_
		if(~rst_n) begin
			w_x.riyal <= 0;
			w_x.imag <= 0;
			y_z.riyal <= 0;
			y_z.imag <= 0;
		end else begin
			w_x.riyal <= a_b.riyal + c_d.riyal;
			w_x.imag <= a_b.imag + c_d.imag;

			y_z.riyal <= (a_b.riyal * c_d.riyal) - (a_b.imag * c_d.imag);
			y_z.imag <= (a_b.riyal * c_d.imag) + (a_b.imag * c_d.riyal);
		end
	end

endmodule : des
