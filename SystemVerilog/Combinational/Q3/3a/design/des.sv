module des
  #(
    parameter WIDTH = 4 
  )(
    input  logic [WIDTH-1:0] binary,
    output logic [WIDTH-1:0] gray
  );

  assign gray[WIDTH-1] = binary[WIDTH-1]; // MSB same

  genvar i;
  generate
    for (i = WIDTH-2; i >= 0; i = i - 1) begin
      assign gray[i] = binary[i+1] ^ binary[i];
    end
  endgenerate

endmodule : des
