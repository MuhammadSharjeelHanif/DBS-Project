class inp_monitor extends uvm_monitor;
	`uvm_component_utils(inp_monitor)

	function new(string name = "inp_monitor", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
	uvm_analysis_port#(complexnum) mon_analysis_port; // defined in env(cnnected to scoreboard)
	virtual complex_inp_intf vif;  // to get values from here and put it in mon_analysis_port

	complexnum comp;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // =============================
  // Build Phase Method
  // =============================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if (!uvm_config_db#(virtual complex_inp_intf)::get(this, "", "complex_in_intf", vif)) // getting  the value from tb
      `uvm_fatal("INP_MONITOR", "Could not get vif")
    
    mon_analysis_port = new ("mon_analysis_port", this);
  endfunction // build_phase


  // =============================
  // Main Phase Method
  // =============================
  virtual task main_phase(uvm_phase phase);
    super.main_phase(phase);
    fork
      collect_data();
    join_none
    
  endtask // main_phase

  // =============================
  // Collecting data
  // =============================
  task collect_data;
  	forever begin
      @(posedge vif.clk);
  		if (vif.valid) begin
        comp = complexnum::type_id::create("INP Monitor Pkt");
  			comp.a = vif.a;
  			comp.b = vif.b;
  			comp.c = vif.c;
  			comp.d = vif.d;
        mon_analysis_port.write(comp);
        comp.display_complexnum("INPUT_MONITOR");      
  		end
  	end
  endtask
endclass : inp_monitor