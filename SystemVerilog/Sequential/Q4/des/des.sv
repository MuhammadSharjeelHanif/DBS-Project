interface complex_num #(parameter WIDTH = 16);
	logic signed [WIDTH-1 : 0] real;
	logic signed [WIDTH-1 : 0] imag;	
endinterface : complex_num

module des#(
	parameter WIDTH = 16
)(
	input clk,
	input rst_n,

	input complex_num #(WIDTH) a_b, 
	input complex_num #(WIDTH) c_d, 

	output complex_num #(WIDTH+1) y_z,  //addition
	output complex_num #(2*WIDTH) w_x, //multiplication
);

	logic signed [WIDTH-1 : 0] a,b,c,d;

	logic signed [2*WIDTH-1:0] c1, c2, c3;

	always_ff @(posedge clk or negedge rst_n) begin : add_proc_
		if(~rst_n) begin
			w_x.real <= 0;
			w_x.imag <= 0;
		end else begin
			w_x.real <= a_b.real + c_d.real;
			w_x.imag <= a_b.imag + c_d.imag;
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : pipeline_s0
		if(~rst_n) begin
			a <= 0;
			b <= 0;
			c <= 0;
			d <= 0;
		end else begin
 			a <= a_b.real;
            b <= a_b.imag;
            c <= c_d.real;
            d <= c_d.imag;

		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : pipeline_s1
		if(~rst_n) begin
			c1 <= 0; c2 <= 0; c3 <= 0;		
		end else begin
			c1 <= a * (c + d);
			c2 <= d * (a + b);
			c3 <= c * (a - b);
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin : pipeline_s2
		if(~rst_n) begin
			y_z.real <= 0;
			y_z.imag <= 0;
		end else begin
			y_z.real <= c1 - c2;
			y_z.imag <= c1 - c3;
		end
	end
endmodule : des