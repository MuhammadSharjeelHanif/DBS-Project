////////////////////////////////////////////////////////////////////////////////
//
//  Filename      : common_config.sv
//  Author        : MR
//  Creation Date : 11/01/2021
//
//  Copyright 2020 Sahil Semiconductor. All Rights Reserved.
//
//  No portions of this material may be reproduced in any form without
//  the written permission of:
//
//    Sahil Semiconductor
//    1601 McCarthy Blvd
//    Milpitas CA – 95035
//
//  All information contained in this document is Sahil Semiconductor
//  company private, proprietary and trade secret.
//
//  Description
//  ===========
//  Common Configuration Class
////////////////////////////////////////////////////////////////////////////////

class common_config extends uvm_component;

  uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();

  function new(string name = "common_config", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  int inp_num_cboids;
  int watchdog_timer;
  int min_length;
  int max_length;
  int min_width ;
  int max_width ;
  int min_height;
  int max_height;


function void build_phase (uvm_phase phase);
  get_plusarg("inp_num_cboids", inp_num_cboids);
  get_plusarg("watchdog_timer", watchdog_timer);
  // get_plusarg("min_length", min_length);
  // get_plusarg("max_length", max_length);
  // get_plusarg("min_width", min_width);
  // get_plusarg("max_width", max_width);
  // get_plusarg("min_height", min_height);
  // get_plusarg("max_height", max_height);
endfunction

  // constraint inp_num_cboids_c  {inp_num_cboids == 100;}
  // constraint watchdog_timer_c  {watchdog_timer ==   20000;}


  `uvm_component_utils_begin(common_config)
    `uvm_field_int(inp_num_cboids  ,  UVM_DEC)
    `uvm_field_int(watchdog_timer  ,  UVM_DEC)
    `uvm_field_int(min_length  ,  UVM_DEC)
    `uvm_field_int(max_length  ,  UVM_DEC)
    `uvm_field_int(min_height  ,  UVM_DEC)
    `uvm_field_int(max_height  ,  UVM_DEC)
    `uvm_field_int(min_width  ,  UVM_DEC)
    `uvm_field_int(max_width  ,  UVM_DEC)
  `uvm_component_utils_end  

function automatic void get_plusarg(string arg_name, ref int arg_value);
    if ($value$plusargs({arg_name, "=%d"}, arg_value)) begin
        `uvm_info("CONFIG", $sformatf("%s: %d", arg_name, arg_value), UVM_MEDIUM)
    end else begin
        `uvm_fatal("CONFIG", $sformatf("Plusarg %s not provided", arg_name))
    end
endfunction


endclass// common_config


  // function void post_randomize();
  //   string arg_value;
  //   super.post_randomize();
  //   if(clp.get_arg_value("+inp_num_cboids=" , arg_value)) inp_num_cboids = arg_value.atoi();
  //   if(clp.get_arg_value("+watchdog_timer=" , arg_value)) watchdog_timer = arg_value.atoi()*1000000; 

  // endfunction // post_randomize