module des(
	input logic clk,
	input logic rst_n,
	input logic in,
	output logic out
);
typedef enum logic [2:0] {
        A,
        B,
        C,
        D,
        E
    } state_t;

    logic [2:0] cur_state, next_state;

	always_ff @(posedge clk or negedge rst_n) begin : proc_
		if(~rst_n) begin
			cur_state <= A;
		end else begin
			cur_state <= next_state;
		end
	end

	always_comb begin : comb_
		case(cur_state)
			A: next_state = in ? B : A; 
			B: next_state = in ? D : C; 
			C: next_state = in ? A : E; 
			D: next_state = in ? C : B; 
			E: next_state = in ? E : D;
			//default: next_state = A; 
		endcase // cur_state
	end

	always_comb begin : out_
		out = next_state == A;
	end
endmodule : des