////////////////////////////////////////////////////////////////////////////////
//
//  Filename      : test.sv
//  Author        : Sharjeel
//  Creation Date : 24/07/2025
//
//  Copyright 2025 M. Sharjeel Hanif. All Rights Reserved.
//
//  No portions of this material may be reproduced in any form without
//  the written permission of:
//
//    Muhammad Sharjeel Hanif
//
//  Description
//  ===========
//  Basic new_test for constrained inputs
////////////////////////////////////////////////////////////////////////////////
class long_test extends complex_base_test;
  `uvm_component_utils(new_test)
  
  // =============================
  // Costructor Method
  // =============================
  function new(string name = "new_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  // =============================
  // Build Phase Method
  // ============================= 
  function void build_phase(uvm_phase phase);
     super.build_phase(phase);
    `uvm_info("new_test", "Starting new_test.... ", UVM_MEDIUM)
  endfunction

endclass 

