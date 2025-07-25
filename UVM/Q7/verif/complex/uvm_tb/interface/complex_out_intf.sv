interface complex_out_intf (input clk, input rst_n);
	
	logic signed [16 : 0] w,x;
	logic signed [31 : 0] y,z;
	logic valid;
	
endinterface : complex_out_intf