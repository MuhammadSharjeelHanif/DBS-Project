module des #(
	parameter DEPTH = 128,
	parameter WIDTH = 32
	)(
	input clk,    // Clock
	input rst_n,  // Asynchronous reset active low
	input cs,
	input wr_en,
	input rd_en,
	input [WIDTH-1 : 0] data_in,
	output logic [WIDTH-1 : 0] data_out,
	output empty,
	output full
);
	localparam FIFO_DEPTH_LOG = $clog2(DEPTH);

	logic [WIDTH-1 : 0] fifo [0 : DEPTH-1];

	logic [FIFO_DEPTH_LOG : 0] write_pointer;
	logic [FIFO_DEPTH_LOG : 0] read_pointer;

	always_ff @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			 write_pointer <= 0;
		end else if(wr_en && !full) begin
			fifo[write_pointer[FIFO_DEPTH_LOG-1:0]] <= data_in;
			write_pointer <= write_pointer + 1'b1;
		end
	end

	always_ff @(posedge clk or negedge rst_n) begin 
		if(~rst_n) begin
			read_pointer <= 0;
		end 
		else if (cs && rd_en && !empty) begin
			data_out <= fifo[read_pointer[FIFO_DEPTH_LOG-1:0]];
			read_pointer <= read_pointer + 1'b1;
		end
	end

	assign empty = (read_pointer == write_pointer);
	assign full = (read_pointer == {~write_pointer[FIFO_DEPTH_LOG], write_pointer[FIFO_DEPTH_LOG-1:0]});

endmodule : des