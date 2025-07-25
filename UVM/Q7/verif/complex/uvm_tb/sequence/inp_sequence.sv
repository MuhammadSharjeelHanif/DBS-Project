class inp_sequence extends uvm_sequence # (complexnum);
	`uvm_object_utils(inp_sequence)

	function new(string name = "inp_sequence");
		super.new(name);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  complex_sequence comp_seq ;
  common_config   common_cfg;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // Get common_config
  	virtual task pre_start();
	    if (!uvm_config_db#(common_config)::get(get_sequencer(), "", "common_cfg", common_cfg))
	      `uvm_fatal("inp_sequence", "Did not get common_config")
 	endtask : pre_start

 	virtual task body();
	    `uvm_info("inp_sequence", $sformatf("Starting complex_seq for %0d packets..", common_cfg.inp_num_tx), UVM_MEDIUM)

	    comp_seq = complex_sequence::type_id::create("complex_seq");
	    comp_seq.num_of_tx = common_cfg.inp_num_tx ; 
	    comp_seq.start(get_sequencer());
	    
	    `uvm_info("inp_sequence", $sformatf("comp_seq done.."), UVM_MEDIUM)
  	endtask 
endclass : inp_sequence