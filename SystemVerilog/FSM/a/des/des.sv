module des(
	input logic clk,
	input logic rst_n,
	input logic in,
	output logic out
);
typedef enum logic [2:0] {
        S0,
        S1,
        S2,
        S3,
        S4
    } state_t;

    logic [2:0] cur_state, next_state;

	always_ff @(posedge clk or negedge rst_n) begin : proc_
		if(~rst_n) begin
			cur_state <= S0;
		end else begin
			cur_state <= next_state;
		end
	end

	always_comb begin : comb_
		case(cur_state)
			S0: next_state = in ? S1 : S0; 
			S1: next_state = in ? S1 : S2; 
			S2: next_state = in ? S1 : S3; 
			S3: next_state = in ? S4 : S0; 
			S4: next_state = in ? S1 : S2;
			default: next_state = S0; 
		endcase // cur_state
	end

	always_comb begin : out_
		out = next_state == S4;
	end
endmodule : des