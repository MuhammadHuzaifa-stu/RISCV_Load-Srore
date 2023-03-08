module counter(input logic clk, reset, output logic [31:0]pc);
	logic [31:0] counter_up;
	always_ff @(posedge clk)
	begin
		if (reset) counter_up <= 32'd0;
			
		else counter_up <= counter_up + 32'd4;
	end 
	assign pc = counter_up;
endmodule