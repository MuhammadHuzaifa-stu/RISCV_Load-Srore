module LSU (input logic [31:0] addr, inst,output logic [3:0]mask);
	
	logic [3:0] func3;
	
	assign func3 = inst[14:12];
	
	always_comb
	begin
		case(func3)
			3'b000: //Load Byte Signed
				begin 
					if (addr[1:0] == 2'b00) mask = 4'd0;
					else if (addr[1:0] == 2'b01) mask = 4'd1;
					else if (addr[1:0] == 2'b10) mask = 4'd2;
					else if (addr[1:0] == 2'b11) mask = 4'd3;
				end
			3'b001: //Load Half world signed
				begin 
					if (addr[1] == 1'b1) mask = 4'd4;
					else mask = 4'd5;
				end
			3'b010: mask = 4'd6; //Load World
			3'b100: // Load Byte Unsigned
				begin  
					if (addr[1:0] == 2'b00) mask = 4'd7;
					else if (addr[1:0] == 2'b01) mask = 4'd8;
					else if (addr[1:0] == 2'b10) mask = 4'd9;
					else if (addr[1:0] == 2'b11) mask = 4'd10;
				end 
			3'b101: //Load Half world unsigned
				begin
					if (addr[1] == 1'b1) mask = 4'd11;
					else mask = 4'd12; 
				end
		endcase
	end
endmodule