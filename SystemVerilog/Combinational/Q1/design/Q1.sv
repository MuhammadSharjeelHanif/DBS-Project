module Q1 #(
	parameter WIDTH = 16
)(
  input [WIDTH-1:0] num,
  output odd_par
);

assign odd_par = ~(^num);

endmodule