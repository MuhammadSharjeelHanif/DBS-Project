module tb;

	parameter DEPTH = 128;
	parameter WIDTH = 32;

	logic clk;
	logic rst_n;
	logic cs;
	logic wr_en;
	logic rd_en;
	logic [WIDTH-1 : 0] data_in;
	logic [WIDTH-1 : 0] data_out;
	logic empty;
	logic full;

	int i;

	int match = 0; int mismatch = 0;
	int warning = 0;

	logic [WIDTH-1:0] ref_queue[$];

	des #(.WIDTH(WIDTH), .DEPTH(DEPTH)) fifo(.clk     (clk),
											 .cs      (cs),
											 .rst_n   (rst_n),
											 .wr_en   (wr_en),
											 .rd_en   (rd_en),
											 .data_in (data_in),
											 .data_out(data_out),
											 .empty   (empty),
											 .full    (full));

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
		#1;
		rst_n = 0; rd_en = 0; wr_en = 0;

		@(posedge clk);
		write_data('d1);
		write_data('d100);
		write_data('d10000);
		read_data();
		read_data();
		read_data();

		for (i = 0; i < 128; i++) begin
      	 write_data($urandom_range(0,2**WIDTH-1));
    	end

	    for (i = 0; i < 129; i++) begin
	      read_data();
	    end

	    if (ref_queue.size() == 0 && empty)
      	$display("FIFO is empty as expected!");
    	else
      	$display("FIFO EMPTY mismatch: Queue size=%0d, FIFO empty=%0b", ref_queue.size(), empty);

      	$display("=====================================");
      	$display("Match = %0d",match);
      	$display("MisMatch = %0d",mismatch);
      	$display("Warnings = %0d",warning);
      	$display("=====================================");

      	$finish;
	end

	task write_data(input [WIDTH-1 : 0] d_in);
		begin
			@(posedge clk);
			cs=1;
			wr_en = 1;
			data_in = d_in;
			ref_queue.push_back(d_in);
			@(posedge clk);
			cs=1;
			wr_en = 0;
		end
	endtask : write_data

	task read_data();
		begin
			@(posedge clk);
			cs=1;
			rd_en = 1;
			//$display("data out = %0b", data_out);
			@(posedge clk);
			cs=1;
			rd_en = 0;

			if (ref_queue.size() > 0) begin
				logic [WIDTH-1:0] expected_out;
		        expected_out = ref_queue.pop_front();
		        #50;
		        if (data_out === expected_out) begin
		          $display("READ PASS: DUT=%0d, Expected=%0d", data_out, expected_out);
		          match++;
		        end 
		        else begin
		          $display("READ FAIL: DUT=%0d, Expected=%0d", data_out, expected_out);
		          mismatch++;
		        end
	      	end else begin
	         $display("WARNING: Tried to read but queue empty");
	         warning++;
	      	end
    	end
	endtask : read_data

endmodule : tb