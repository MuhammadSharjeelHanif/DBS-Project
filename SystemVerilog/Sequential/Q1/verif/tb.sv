module tb;

	parameter WIDTH = 32;

	logic clk;
	logic rst_n;

	logic [WIDTH-1 : 0] din, dout, expected_dout;
	logic sig, pos_pulse, neg_pulse, change_pulse, pulse_100ns;
	logic expected_pos, expected_neg, expected_change, sig_d_tb;

	logic [WIDTH-1 : 0] change_sig, change_sig_d;

	int match=0, mismatch=0;

	always begin
		clk <= 1'b0;
		#50;
		clk <= 1'b1;
		#50;
	end

	initial begin
		rst_n = 0;
		#100;
		rst_n = 1;
	end

	delay #(4) u_delay(.clk(clk), .resetn(rst_n), .data_in(data_in), .data_out(data_out));
    posedge_detector u_pos(.clk(clk), .rst_n(rst_n), .sig(sig), .pulse(pos_pulse));
    negedge_detector u_neg(.clk(clk), .rst_n(rst_n), .sig(sig), .pulse(neg_pulse));
    change_detector u_change(.clk(clk), .rst_n(rst_n), .sig(change_sig), .pulse(change_pulse));
    pulse_generator u_pulse100ns(.clk(clk), .resetn(rst_n), .pulse(pulse_100ns));

    initial begin
    	repeat(20) 
    	begin
    		@(negedge clk);

    		@(posedge clk);
    		number_generation();
    		calc_expected();
    		checking_logic();
    		update_delays();
    		$display("");
    	end
    	$display("Match: %0d", match);
    	$display("Mismatch: %0d", mismatch);

   		$finish;
    end

    task number_generation();
    	sig = $urandom_range(0,1);
    	change_sig = $urandom();
    	$display("SIG=%b CHANGE_SIG=%h", sig, change_sig);
  	endtask

  	task calc_expected();
  		expected_pos <= sig & ~sig_d_tb;
  		expected_neg <= ~sig & sig_d_tb;
		expected_change <= (change_sig != change_sig_d);
  	endtask

  	task update_delays();
	  sig_d_tb <= sig;
	  change_sig_d <= change_sig;
	endtask

  	task checking_logic();
	    if (expected_pos === pos_pulse) 
	    begin
	      $display("PASS: Posedge");
	      match++;
	    end 
	    else 
	    begin
	      $display("FAIL: Posedge");
	      mismatch++;
	    end

	    if (expected_neg === neg_pulse) 
	    begin
	      $display("PASS: Negedge");
	      match++;
	    end 
	    else 
	    begin
	      $display("FAIL: Negedge");
	      mismatch++;
	    end

	    if (change_pulse===expected_change) 
	    begin
		  $display("PASS: Change");
          match++;	    
        end 
        else 
        begin
      	  $display("FAIL: Change");
      	  mismatch++;
    	end
	endtask
endmodule : tb