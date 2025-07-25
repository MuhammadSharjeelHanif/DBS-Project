// Implementation ports macros
`uvm_analysis_imp_decl(_ingr)
`uvm_analysis_imp_decl(_egrs)

class scoreboard extends uvm_scoreboard;
	`uvm_component_utils(scoreboard)

	function new(string name = "scoreboard", uvm_component parent=null);
		super.new(name, parent);
	endfunction : new
/*-------------------------------------------------------------------------------
-- Interface, port, fields
-------------------------------------------------------------------------------*/
  uvm_analysis_imp_ingr #(complexnum, scoreboard) ingr_imp_export;
  uvm_analysis_imp_egrs #(complexnum, scoreboard) egrs_imp_export;

  complexnum ingr_comp_q[$]; 

  uvm_event in_scb_evnt;
  common_config common_cfg;
  complexnum exp_comp;
  complexnum comp;

  int match, mismatch, ap_pp_ingr_comp_cnt;

/*-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------*/
  // ============================================
  // Create implementation ports in build phase
  // ============================================

  	virtual function void build_phase(uvm_phase phase);
	    super.build_phase(phase);

	    ingr_imp_export = new ("ingr_imp_export", this);
	    egrs_imp_export = new ("egrs_imp_export", this);
	    in_scb_evnt     = uvm_event_pool::get_global("ingr_scb_event");

	    // getting common config
	    uvm_config_db #(common_config)::get(this, "*", "common_cfg", common_cfg);

	endfunction // build_phase

	virtual function void write_ingr(complexnum comp);
		comp.w = comp.a + comp.c;
		comp.x = comp.b + comp.d;

		comp.y = (comp.a * comp.c) - (comp.b * comp.d);
		comp.z = (comp.a * comp.d) + (comp.b * comp.c);

		ingr_comp_q.push_back(comp);
		ap_pp_ingr_comp_cnt++;
	endfunction : write_ingr

	virtual function void write_egrs(complexnum comp);
	    if (ingr_comp_q.size() == 0)
	      `uvm_error("SCB", $sformatf("Data not Present"))
	    else 
	      exp_comp = ingr_comp_q.pop_front();

		if (comp.compare(exp_comp)) begin
			$display("MATCH");
			match++;
		end
		else begin
			mismatch++;
			display_mismatch_cboids(exp_comp, comp);
		end
	endfunction : write_egrs

  // ========================================
  // Main Phase Task
  // ========================================
  	virtual task main_phase(uvm_phase phase);
	    super.main_phase(phase);
	    wait(common_cfg.inp_num_tx == match + mismatch );
	    in_scb_evnt.trigger();
  	endtask // main_phase


  // ========================================
  // Report Phase Task
  // ========================================
  	virtual function void report_phase (uvm_phase phase);
    	`uvm_info("SCB", $sformatf("Matched=%0d, Mismatched=%0d", match, mismatch), UVM_MEDIUM)
  	endfunction // report_phase


  	virtual function void display_mismatch_cboids(complexnum exp_comp, complexnum comp );
	    string   msg;
	    
	    msg = $sformatf("\nMismatch: Exp Sum = %0d + %0d i ; Actual Sum = %0d + %0d i  Exp Mul = %0d + %0d i ; Actual Mul = %0d + %0d i\n",exp_comp.w, exp_comp.x, comp.w, comp.x, exp_comp.y, exp_comp.z, comp.y, comp.z);
	    msg = {msg, $sformatf("==============================================================================================\n")};
	    `uvm_error("mismatch number", msg)
  	endfunction  

endclass : scoreboard