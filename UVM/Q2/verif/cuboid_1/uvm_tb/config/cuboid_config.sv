////////////////////////////////////////////////////////////////////////////////
//
//  Filename      : cuboid_config.sv
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

class cuboid_config extends uvm_component;

  uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();

  function new(string name = "cuboid_config", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // TODO add Configurations
   int       config_1                   ;
   int       config_2                   ;
   int       min_length                 ;
   int       max_length                 ;
   int       min_height                 ;
   int       max_height                 ;
   int       min_width                  ;
   int       max_width                  ;
   

  // constraint config_1_c  {config_1 == 100;}
  // constraint config_2_c  {config_2 ==   0;}


  `uvm_component_utils_begin(cuboid_config)
  `uvm_field_int(config_1  ,  UVM_DEC)
  `uvm_field_int(config_2  ,  UVM_DEC)
  `uvm_field_int(min_length  ,  UVM_DEC)
  `uvm_field_int(max_length  ,  UVM_DEC)
  `uvm_field_int(min_height  ,  UVM_DEC)
  `uvm_field_int(max_height  ,  UVM_DEC)
  `uvm_field_int(min_width  ,  UVM_DEC)
  `uvm_field_int(max_width  ,  UVM_DEC)
  `uvm_component_utils_end  

  function void post_randomize();
    string arg_value;
    super.post_randomize();
    // if(clp.get_arg_value("+config_1=" , arg_value)) config_1 = arg_value.atoi();
    // if(clp.get_arg_value("+config_2=" , arg_value)) config_2 = arg_value.atoi();
    // if (clp.get_arg_value("+min_length=%d", arg_value)) min_length = arg_value.atoi();
    // if (clp.get_arg_value("+max_length=%d", arg_value)) max_length = arg_value.atoi();
    // if (clp.get_arg_value("+min_height=%d", arg_value)) min_height = arg_value.atoi();
    // if (clp.get_arg_value("+max_height=%d", arg_value)) max_height = arg_value.atoi();
    // if (clp.get_arg_value("+min_width=%d", arg_value))  min_width = arg_value.atoi();
    // if (clp.get_arg_value("+max_width=%d", arg_value))  max_width = arg_value.atoi();  

  endfunction // post_randomize

  function void build_phase (uvm_phase phase);
  super.build_phase(phase);    
    get_plusarg("min_length", min_length);
    get_plusarg("max_length", max_length);
    get_plusarg("min_width", min_width);
    get_plusarg("max_width", max_width);
    get_plusarg("min_height", min_height);
    get_plusarg("max_height", max_height);
endfunction

function automatic void get_plusarg(string arg_name, ref int arg_value);
    if ($value$plusargs({arg_name, "=%d"}, arg_value)) begin
        `uvm_info("CONFIG", $sformatf("%s: %d", arg_name, arg_value), UVM_MEDIUM)
    end else begin
        `uvm_fatal("CONFIG", $sformatf("Plusarg %s not provided", arg_name))
    end
endfunction
endclass// cuboid_config