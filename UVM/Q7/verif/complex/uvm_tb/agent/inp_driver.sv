class inp_driver extends uvm_driver#(complexnum);
	`uvm_component_utils(inp_driver)

	function new(string name = "inp_driver", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	virtual complex_inp_intf vif;	// to send the values from here to DUT

	complexnum comp;
/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // =============================
  // Build Phase Method
  // =============================  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    comp = complexnum::type_id::create("comp", this);

    // sqncr = uvm_sequencer#(complexnum)::type_id::create("sqncr", this);

    if (!uvm_config_db#(virtual complex_inp_intf)::get(this, "", "complex_in_intf", vif))  // getting  the value from tb
      `uvm_fatal("INP_DRIVER", "Could not get vif")

   endfunction // build_phase

  // =============================
  // Main Phase Method
  // =============================
  virtual task main_phase(uvm_phase phase);
	    super.main_phase(phase);

	    forever begin
	      seq_item_port.get_next_item(comp);
	      drive_item(comp);
	      seq_item_port.item_done();
	end

  endtask // main_phase

  virtual task drive_item(complexnum drv_comp);
	    vif.valid  <= 1;
	    vif.a <= drv_comp.a;
	    vif.b <= drv_comp.b;
	    vif.c <= drv_comp.c;
	    vif.d <= drv_comp.d;
	    @(posedge vif.clk);
		`uvm_info("INP_DRIVER", $sformatf("Driving a=%0d b=%0d c=%0d d=%0d", drv_comp.a, drv_comp.b, drv_comp.c, drv_comp.d), UVM_MEDIUM)
	    vif.valid  <= 0;
	    vif.a <= 0;
	    vif.b <= 0;
	    vif.c <= 0;    
	    vif.d <= 0;     
	endtask // drive_item  
endclass : inp_driver