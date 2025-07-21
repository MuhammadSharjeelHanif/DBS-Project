module des
  #(
    parameter WIDTH = 4 
  )(
    input  logic [WIDTH-1:0] gray,
    output logic [WIDTH-1:0] binary
  );

  assign binary[WIDTH-1] = gray[WIDTH-1]; // MSB same

  genvar i;
  generate
    for (i = WIDTH-2; i >= 0; i = i - 1) begin 
      assign binary[i] = binary[i+1] ^ gray[i];
    end
  endgenerate

endmodule : des
