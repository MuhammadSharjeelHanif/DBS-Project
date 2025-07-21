module dff #(
  parameter WIDTH = 32
)(
  input logic clk,
  input logic resetn,
  input logic [WIDTH-1:0] D,
  output logic [WIDTH-1:0] Q
);

  always_ff @(posedge clk or negedge resetn) begin
    if (!resetn)
      Q <= '0;
    else
      Q <= D;
    end
endmodule : dff


module delay #(
	parameter WIDTH = 32,
	parameter N = 4
)(
	input  logic clk,
    input  logic resetn,
    input  logic [WIDTH-1:0] data_in,
    output logic [WIDTH-1:0] data_out	
);

	logic [WIDTH-1:0] stage [0:N];

	assign stage[0] = data_in;

	genvar i;
	generate
		for (i = 1; i < N; i++) 
		begin
			dff #(.WIDTH(WIDTH)) u_dff (
	        .clk(clk),
	        .resetn(resetn),
	        .D(stage[i]),
	        .Q(stage[i+1]));	
	    end
		endgenerate
    assign data_out = stage[N];
endmodule : delay
