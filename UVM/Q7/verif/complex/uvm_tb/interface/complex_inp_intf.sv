interface complex_inp_intf (input clk, input rst_n);
	
	logic valid;
	logic signed [15 : 0] a,b,c,d;

endinterface : complex_inp_intf