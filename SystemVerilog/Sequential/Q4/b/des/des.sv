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

	logic signed [WIDTH-1 : 0] a,b,c,d;

	logic signed [2*WIDTH-1:0] c1, c2, c3, c4;

	always_ff @(posedge clk or negedge rst_n) begin : pipeline_s0
		if(~rst_n) begin
			a <= 0;
			b <= 0;
			c <= 0;
			d <= 0;
		end else begin
 			a <= a_b.riyal;
            b <= a_b.imag;
            c <= c_d.riyal;
            d <= c_d.imag;

            c1 <= a_b.riyal * c_d.riyal;
			c2 <= a_b.imag * c_d.imag;
			c3 <= a_b.riyal * c_d.imag;
			c4 <= a_b.imag * c_d.riyal;

		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : pipeline_s1
		if(~rst_n) begin
			y_z.riyal <= 0;
			y_z.imag <= 0;
			w_x.riyal <= 0;
			w_x.imag <= 0;
		end else begin
			w_x.riyal <= a + c;
			w_x.imag <= b + d;

			y_z.riyal <= c1 - c2;
			y_z.imag <= c3 + c4;
		end
	end
endmodule : des