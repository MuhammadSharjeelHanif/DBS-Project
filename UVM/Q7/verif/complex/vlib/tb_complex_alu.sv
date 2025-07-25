module tb_complex_alu;

	import uvm_pkg::*;
	import complex_pkg::*;
	
// ====================================
// testbench signals
// ====================================

	bit clk = 0;
	bit rst_n;

// ====================================
// Interface instant
// ====================================

	complex_inp_intf complex_inp_if (.clk(clk) , .rst_n(rst_n));
	complex_out_intf complex_out_if (.clk(clk) , .rst_n(rst_n));

// ====================================
// Design instant
// ====================================

	complex_alu complex_inst(
		.rst_n(rst_n),
		.clk  (clk),
		.in_valid(complex_inp_if.valid),
		.a    (complex_inp_if.a),
		.b    (complex_inp_if.b),
		.c    (complex_inp_if.c),
		.d    (complex_inp_if.d),
		.w    (complex_out_if.w),
		.x    (complex_out_if.x),
		.y    (complex_out_if.y),
		.z    (complex_out_if.z),
		.out_valid(complex_out_if.valid)

	);

// ====================================
// Initial Block
// ====================================

	initial begin
		uvm_config_db#(virtual complex_inp_intf)::set(null, "uvm_test_top.env.ingr_agnt.drvr", "complex_in_intf", complex_inp_if);
		uvm_config_db#(virtual complex_inp_intf)::set(null, "uvm_test_top.env.ingr_agnt.mntr", "complex_in_intf", complex_inp_if);
		uvm_config_db#(virtual complex_out_intf)::set(null, "uvm_test_top.env.egrs_agnt.mntr", "complex_out_intf", complex_out_if);
		uvm_config_db#(virtual complex_inp_intf)::set(null, "uvm_test_top"									 , "complex_in_intf", complex_inp_if);
		run_test();

		// rst_n = 0;
		// #15;
		// rst_n = 1;

	end

// ====================================
// Clock generation
// ====================================
always 
  #5 clk = ~clk ;

endmodule : tb_complex_alu