module tb;	
	parameter WIDTH = 16;

	logic clk;
	logic rst_n;

	complex_num #(WIDTH) a_b();
	complex_num #(WIDTH) c_d();

	complex_num #(WIDTH+1) y_z();  //addition
	complex_num #(2*WIDTH) w_x(); //multiplication

	int match = 0;
	int mismatch = 0;

	des #(.WIDTH(WIDTH)) complex(.clk  (clk),
								 .rst_n(rst_n),
								 .a_b(a_b),
								 .c_d(c_d),
        						 .y_z(y_z),
        						 .w_x(w_x)
	);

	always begin
		clk <= 1'b0;
		#50;
		clk <= 1'b1;
		#50;
	end

	initial begin
		rst_n <= 0;
		#100;
		rst_n <= 1;
	end		

	initial begin
		repeat(20);
		begin
			assigning_rand_values();
			#1
			checking_logic();

			$display("Match = %0d",match);
			$display("MisMatch = %0d",mismatch);
		end
	end

	task assigning_rand_values();
		begin
			a_b.real = $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    a_b.imag = $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    c_d.real = $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		    c_d.imag = $urandom_range(-2**(WIDTH-1), 2**(WIDTH-1));
		end
	endtask : assigning_rand_values

	task checking_logic();
		begin
			int signed exp_w, exp_x;
    		int signed exp_y, exp_z;

    		exp_w <= a_b.real + c_d.real;
			exp_x <= a_b.imag + c_d.imag;

			exp_y <= (a_b.real * c_d.real) - (a_b.imag * c_d.imag);
			exp_z <= (a_b.real * c_d.imag) + (a_b.imag * c_d.real);

			if ((w_x.real === exp_w) && (w_x.imag === exp_x) &&
        		(y_z.real === exp_y) && (y_z.imag === exp_z)) begin
      			$display("[MATCH] ADD: (%0d+%0di)+(%0d+%0di) = (%0d+%0di) | MUL: (%0d+%0di)*(%0d+%0di) = (%0d+%0di)",
               	a_b.real, a_b.imag, c_d.real, c_d.imag,
              	w_x.real, w_x.imag,
               	a_b.real, a_b.imag, c_d.real, c_d.imag,
               	y_z.real, y_z.imag);
      match++;
    end else begin
      			$display("[MISMATCH] Expected ADD=(%0d+%0di) MUL=(%0d+%0di) Got ADD=(%0d+%0di) MUL=(%0d+%0di)",
              	exp_w, exp_x, exp_y, exp_z,
               	w_x.real, w_x.imag, y_z.real, y_z.imag);
      mismatch++;
    end
		end
	endtask
endmodule : tb