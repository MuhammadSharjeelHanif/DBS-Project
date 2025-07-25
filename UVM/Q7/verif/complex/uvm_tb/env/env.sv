class complex_env extends  uvm_env;
	
	`uvm_component_utils(complex_env)

	function new(string name = "complex_env", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new

/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  inp_agent               ingr_agnt     ;
  out_agent               egrs_agnt     ;
  scoreboard              scrbrd        ;
  int                     wd_timer      ;
  common_config           common_cfg    ;
  uvm_event               in_scb_evnt  	;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/

  // =============================
  // Build Phase Method
  // =============================
  	virtual function void build_phase(uvm_phase phase);
	    super.build_phase(phase);

	    // Creating Agents Scoreboard
	    ingr_agnt   = inp_agent::type_id::create("ingr_agnt", this);
	    egrs_agnt   = out_agent::type_id::create("egrs_agnt", this);
	    scrbrd      = scoreboard::type_id::create("scrbrd", this);
	    in_scb_evnt = uvm_event_pool::get_global("ingr_scb_event");

	    // Getting common_config
	    uvm_config_db #(common_config)::get(this, "*", "common_cfg", common_cfg);
	    
	    // Implicit Call for inp_sequence
	    uvm_config_db#(uvm_object_wrapper)::set(this,"ingr_agnt.sqncr.main_phase", "default_sequence", inp_sequence::type_id::get());
  	endfunction  //build_phase


  // =============================
  // Connect Phase Method
  // =============================
  	virtual function void connect_phase(uvm_phase phase);
	    super.connect_phase(phase);
	    //connecting analysis port to scoreboard
	    ingr_agnt.mntr.mon_analysis_port.connect(scrbrd.ingr_imp_export);
	    egrs_agnt.mntr.mon_analysis_port.connect(scrbrd.egrs_imp_export);
  	endfunction  //connect_phase

  // =============================
  // Main Phase Method
  // =============================

	  virtual task main_phase(uvm_phase phase);
	    phase.raise_objection(this);
	    `uvm_info("complex_env", "Starting main_phase.. ", UVM_MEDIUM)
	    super.main_phase(phase);

	    wd_timer = common_cfg.watchdog_timer;

	    fork
	      begin
	        #1000000;
	        `uvm_error("complex_env", $sformatf("wd_timer Timed out"))
	      end
	      begin
	         in_scb_evnt.wait_trigger();
	         #500000; // idle time at the end of simulation
	        `uvm_info("complex_env", "Scoreboard Verification Complete..", UVM_MEDIUM)
	      end
	    join_any
	    `uvm_info("complex_env", "main_phase done.. ", UVM_MEDIUM)
	    phase.drop_objection(this);
 	endtask // main_phase
endclass : complex_env