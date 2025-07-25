module complex_alu (
	input logic clk,    // Clock
	input  logic rst_n,
	input logic in_valid,
	input logic signed [15 : 0] a,b,c,d,
	output logic signed [16 : 0] w,x,
	output logic signed [31 : 0] y,z,
	output logic out_valid
);

	always @(posedge clk) begin : proc_
		// if(!rst_n) begin
		// 	w <= 0;
		// 	x <= 0;
		// 	y <= 0;
		// 	z <= 0;		
		// end 
		// else begin
			w <= a + c;
			x <= b + d;

			y <= (a * c) - (b * d);
			z <= (a * d) + (b * c);
    		out_valid <= in_valid ;
		// end 
	end
endmodule : complex_alu