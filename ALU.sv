module ALU(input logic [31:0] a,b,input logic [3:0] alu,output logic [31:0] result);
	//output logic zero
	always_comb
	begin 
		case(alu)
			3'b0000: result = a + b; //ADD
			3'b0001: result = a - b; //SUB
			3'b0010: result = a << b[4:0]; //SLL
			3'b0011: begin 
					if ($signed(a) < $signed(b)) result = 32'd1; //SLT
					else result = 32'd0;
					end
			3'b0100: begin 
					if (a < b) result = 32'd1; //SLTU
					else result = 32'd0;
					end 
			3'b0101: result = a ^ b; //XOR 
			3'b0110: result = a >> b[4:0]; //SRL
			3'b0111: result = a >>> b; //SRA
			3'b1000: result = a | b; //OR
			3'b1001: result = a & b; //AND
			default:result = a + b; 
		endcase
	end
endmodule