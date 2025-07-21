module tb;
	parameter WIDTH = 16;

	logic clk;
	logic rst_n;

	complex_num #(WIDTH) a_b();
	complex_num #(WIDTH) c_d();

	complex_num #(WIDTH*2) y_z(); //multiplication 
	complex_num #(WIDTH+1) w_x(); //addition

	int match = 0;
	int mismatch = 0;

	int queue [$];

	int signed tempw;
	int signed tempx;
	int signed tempy;
	int signed tempz;

	int signed exp_w, exp_x;
  int signed exp_y, exp_z;

	des #(.WIDTH(WIDTH)) complex(.clk  (clk),
															 .rst_n(rst_n),
															 .a_b(a_b),
															 .c_d(c_d),
							        				 .y_z(y_z),
							        				 .w_x(w_x));

	always begin
		clk <= 1'b0;
		#50;
		clk <= 1'b1;
		#50;
	end

	initial begin
		rst_n <= 0;
		@(posedge clk);
		rst_n <= 1;
	end

	initial begin

		repeat(200)
		begin
			@(posedge clk);
			assigning_rand_values();
			
		end
	end

	initial begin
		@(posedge clk);
		repeat(200)
		begin
			@(posedge clk);
			checking_logic();
		end

		$display("Match = %0d",match);
		$display("MisMatch = %0d",mismatch);

		$finish;
	end

	task assigning_rand_values();
		begin
				a_b.riyal <= $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    a_b.imag  <= $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    c_d.riyal <= $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    c_d.imag  <= $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));

    		exp_w <= a_b.riyal + c_d.riyal;
    		queue.push_back(exp_w);
				exp_x <= a_b.imag + c_d.imag;
    		queue.push_back(exp_x);
				exp_y <= (a_b.riyal * c_d.riyal) - (a_b.imag * c_d.imag);
    		queue.push_back(exp_y);
				exp_z <= (a_b.riyal * c_d.imag) + (a_b.imag * c_d.riyal);
    		queue.push_back(exp_z);
		end
	endtask : assigning_rand_values

	task checking_logic();
		begin
			tempw = queue.pop_front();
			tempx = queue.pop_front();
			tempy = queue.pop_front();
			tempz = queue.pop_front();

			if ((w_x.riyal === exp_w) && (w_x.imag === exp_x) &&
        (y_z.riyal === exp_y) && (y_z.imag === exp_z)) begin
      	$display("[MATCH] Expected ADD = (%0h+%0hi) MUL=(%0h+%0hi) Got ADD=(%0h+%0hi) MUL=(%0h+%0hi)",
        exp_w, exp_x, exp_y, exp_z,
        w_x.riyal, w_x.imag, y_z.riyal, y_z.imag);
      	match++;
    	end
    	else begin
      	$display("[MISMATCH] Expected ADD = (%0h+%0hi) MUL=(%0h+%0hi) Got ADD=(%0h+%0hi) MUL=(%0h+%0hi)",
        exp_w, exp_x, exp_y, exp_z,
        w_x.riyal, w_x.imag, y_z.riyal, y_z.imag);
      	mismatch++;
    	end
    end
	endtask
endmodule : tb