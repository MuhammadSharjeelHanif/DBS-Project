class new_seq extends cuboid;

	`uvm_object_utils(new_seq)
	// Constructor
	function new(string name = "new_seq");
		super.new(name);
	endfunction : new

	virtual task cuboid_randomize();
		`uvm_info("New Seq item", "Starting sequence", UVM_MEDIUM);
		length = $urandom_range(1, 100);
		height = 10000;
		case ($urandom_range(0, 3))
			0: width = 1000;
			1: width = 2000;
			2: width = 3000;
			3: width = 5000;
			default : width = 0;
		endcase

        `uvm_info("new_sequence", $sformatf("Generated cuboid: Length=%d, Width=%d, Height=%d", length, width, height), UVM_MEDIUM);
	endtask : cuboid_randomize

endclass : new_seq

