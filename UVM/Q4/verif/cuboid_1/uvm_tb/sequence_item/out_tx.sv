class out_tx extends uvm_sequence_item;

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	 bit           [32-1:0] area      ;
 	 bit           [32-1:0] volm      ;
	 cuboid_config          cboid_cfg ;

/*-------------------------------------------------------------------------------
-- UVM Factory register
-------------------------------------------------------------------------------*/
	// Provide implementations of virtual methods such as get_type_name and create
  `uvm_object_utils_begin(out_tx)
    `uvm_field_int(area,   UVM_ALL_ON)
    `uvm_field_int(volm,   UVM_ALL_ON)
  `uvm_object_utils_end


/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
	// Constructor
	function new(string name = "out_tx");
		super.new(name);
	endfunction : new

	function out_tx clone;
	    out_tx p;
	    $cast(p, super.clone());
	    return p;
  	endfunction // clone

  	virtual function void display_cuboid(string name);
	    string msg;
	    
	    msg = $sformatf("\n This is being displayed  from %s \n", name);
	    msg = {msg, $sformatf("================================================================\n")};
	    msg = {msg, $sformatf("Area = %d, volm = %d \n", area, volm)};
	    `uvm_info(name, msg, UVM_MEDIUM)
 	endfunction // display_pkt



endclass : out_tx