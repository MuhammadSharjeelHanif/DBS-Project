class complexnum extends uvm_sequence_item;

	function new(string name = "complexnum");
		super.new(name);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	
  rand bit signed      [16-1:0] a;
  rand bit signed      [16-1:0] b;
  rand bit signed      [16-1:0] c;
  rand bit signed      [16-1:0] d;
  bit signed           [32-1:0] w;
  bit signed           [32-1:0] x;
  bit signed           [32-1:0] y;
  bit signed           [32-1:0] z;

  complex_config  comp_cfg;

  `uvm_object_utils_begin(complexnum)
    `uvm_field_int(a, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(b, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(c, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(d, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(w,   UVM_ALL_ON)
    `uvm_field_int(x,   UVM_ALL_ON)
    `uvm_field_int(y,   UVM_ALL_ON)
    `uvm_field_int(z,   UVM_ALL_ON)
  `uvm_object_utils_end

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  task complexnum_randomize();
	    a      = $urandom();
	    b      = $urandom();
	    c      = $urandom();
	    d      = $urandom();
  endtask : complexnum_randomize

  function complexnum clone;
	    complexnum p;
	    $cast(p, super.clone());
	    return p;
  endfunction // clone

  virtual function void display_complexnum(string name);
	    string msg;
	    
	    msg = $sformatf("\n\n This is being displayed  from %s \n", name);
	    msg = {msg, $sformatf("================================================================\n")};
	    msg = {msg, $sformatf("a = %d, b = %d, c = %d, d = %d \n", a, b, c, d)};
	    msg = {msg, $sformatf("Addition result = %d + %di \nMultiplication result = %d + %di \n", w, x, y, z)};
	    `uvm_info(name, msg, UVM_MEDIUM)
  endfunction // display_pkt

endclass : complexnum