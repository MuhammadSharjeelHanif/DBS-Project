class complex_base_test extends  uvm_test;
	`uvm_component_utils(complex_base_test)

	function new(string name = "complex_base_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  complex_env       env          ;
  common_config    common_cfg   ;
  complex_config    comp_cfg    ;

  virtual complex_inp_intf complex_in_intf;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/

  // =============================
  // Build Phase Method
  // =============================
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);	

		common_cfg = common_config::type_id::create("common_cfg", this);
    	comp_cfg  = complex_config::type_id::create("comp_cfg", this);

    	uvm_config_db #(common_config)::set(null, "*", "common_cfg", common_cfg);
   		uvm_config_db #(complex_config)::set(null, "*", "comp_cfg", comp_cfg);

	    env = complex_env::type_id::create("env", this);

	    // getting virtual interfaces for vif_init_zero tasks
	    if (!uvm_config_db#(virtual complex_inp_intf)::get(this, "", "complex_in_intf", complex_in_intf))
	      `uvm_fatal("TEST", "Did not get complex_in_intf")
	endfunction

  // =============================
  // Reset Phase Method
  // =============================
  virtual task reset_phase(uvm_phase phase);
    phase.raise_objection(this);

    `uvm_info("complex_base_test", $sformatf("Staring reset_phase.."), UVM_MEDIUM)
    super.reset_phase(phase);
    vif_init_zero(); 
    `uvm_info("complex_base_test", $sformatf("reset_phase done.."), UVM_MEDIUM)
    repeat (250) @(posedge complex_in_intf.clk); //idle cycles
    phase.drop_objection(this);
  endtask // reset_phase

  // ==============================================
  // all interfaces needs to intialize with zeros
  // ==============================================
  task vif_init_zero();
    complex_in_intf.a   <= 0 ;
    complex_in_intf.b   <= 0 ;
    complex_in_intf.c   <= 0 ;
    complex_in_intf.d   <= 0 ;
  endtask

endclass : complex_base_test