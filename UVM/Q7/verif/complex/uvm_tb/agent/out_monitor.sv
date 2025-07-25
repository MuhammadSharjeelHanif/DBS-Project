class out_monitor extends  uvm_monitor;
	`uvm_component_utils(out_monitor)

	function new(string name = "out_monitor", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  uvm_analysis_port#(complexnum) mon_analysis_port;
  virtual complex_out_intf vif;
  
  complexnum comp ;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // =============================
  // Build Phase Method
  // =============================
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual complex_out_intf)::get(this, "", "complex_out_intf", vif)) // getting  the value from tb
      `uvm_fatal("OUT_MONITOR", "Could not get vif")

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
        comp = complexnum::type_id::create("OUT Monitor Pkt");
  			comp.w = vif.w;
  			comp.x = vif.x;
  			comp.y = vif.y;
  			comp.z = vif.z;
        mon_analysis_port.write(comp);
        comp.display_complexnum("OUT_MONITOR");      
  		end
  	end
  endtask
endclass : out_monitor