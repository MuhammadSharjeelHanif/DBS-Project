class inp_agent extends  uvm_agent;
	`uvm_component_utils(inp_agent)

	function new(string name = "inp_agent", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	
	inp_monitor mntr;
	inp_driver drvr;
	uvm_sequencer # (complexnum) sqncr;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/

  // =============================
  // Build Phase Method
  // =============================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sqncr = uvm_sequencer#(complexnum)::type_id::create("sqncr", this);
    mntr = inp_monitor::type_id::create("mntr", this);
    drvr = inp_driver::type_id::create("drvr", this);
  endfunction


  // =============================
  // Connect Phase Method
  // =============================
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    drvr.seq_item_port.connect(sqncr.seq_item_export);
  endfunction

endclass : inp_agent