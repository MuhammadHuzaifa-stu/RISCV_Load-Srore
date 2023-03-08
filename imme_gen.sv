module imme_gen(input logic [31:0]in, output logic [31:0]out);
	
	always_comb 
	begin
		if ((in[6:0] == 6'b0000011) | (in[6:0] == 6'b0010011)) begin
			out[11:0] = in[31:20];
			out[31:12]= in[31] ? 20'hfffff : 20'h00000;	
		end
		else if (in[6:0] == 6'b0100011) begin
			out[4:0] = in[11:7];
			out[11:5] = in[31:25];
			out[31:12]= in[31] ? 20'hfffff : 20'h00000;
		end
	end
	
endmodule