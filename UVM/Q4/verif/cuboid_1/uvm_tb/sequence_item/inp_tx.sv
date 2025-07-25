class inp_tx extends  uvm_sequence_item;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	rand bit      [16-1:0] length    ;
	rand bit      [16-1:0] width     ;
	rand bit      [16-1:0] height    ;

  	cuboid_config          cboid_cfg ;


/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils_begin(inp_tx)
    `uvm_field_int(length, UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(width,  UVM_ALL_ON|UVM_NOCOMPARE)
    `uvm_field_int(height, UVM_ALL_ON|UVM_NOCOMPARE)
  `uvm_object_utils_end

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "inp_tx");
		super.new(name);
	endfunction : new

	task cuboid_randomize();
	    length      = $urandom();
	    width       = $urandom();
	    height      = $urandom();
  	endtask : cuboid_randomize

  	function inp_tx clone;
	    inp_tx p;
	    $cast(p, super.clone());
	    return p;
 	endfunction // clone

  virtual function void display_cuboid(string name);
    string msg;
    
    msg = $sformatf("\n This is being displayed  from %s \n", name);
    msg = {msg, $sformatf("================================================================\n")};
    msg = {msg, $sformatf("Length = %d, Width = %d, Height =%d \n", length, width, height)};
    `uvm_info(name, msg, UVM_MEDIUM)
  endfunction // display_pkt

endclass : inp_tx