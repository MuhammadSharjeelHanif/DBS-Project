class complex_sequence extends uvm_sequence #(complexnum);
	`uvm_object_utils(complex_sequence)

	function new(string name = "complex_sequence");
		super.new(name);
	endfunction : new
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	complexnum comp;
	complex_config comp_cfg;
	int num_of_tx;
	int i;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  virtual task pre_start();

    if (!uvm_config_db#(complex_config)::get(get_sequencer(), "", "comp_cfg", comp_cfg)) //
      `uvm_fatal("cuboid_sequence", "Did not get complex Config")

  endtask 
  
  virtual task body();
    comp = complexnum::type_id::create("comp");
    `uvm_info("complex_sequence", $sformatf("Generating Numbers = %0d", num_of_tx), UVM_MEDIUM)
    for (i = 0; i < num_of_tx; i++)  begin
      
      start_item(comp);
      // if (!comp_cfg.randomize()) `uvm_fatal("complex_sequence", "comp_cfg Randomization Failed");

      comp.comp_cfg = comp_cfg;		//not needed in this case 
      comp.complexnum_randomize();  // calling from seq item class

      `uvm_info("complex_sequence", $sformatf("Done generation of %0d comp items", i), UVM_LOW)

      // if(!comp.randomize()) `uvm_fatal("cuboid_sequence", "comp Randomization Failed");
            
      finish_item(comp);  
    end 
    // for (i = 0; i < num_of_tx; i++)
    // `uvm_info("cuboid_sequence", $sformatf("Done generation of %0d comp items", i), UVM_LOW)
  endtask // body

endclass : complex_sequence