module Instmem(input logic [31:0] Address,output logic [31:0] Instruction); 
    logic [31:0] mem[0:20];
	initial
	begin
		$readmemh("D:/6th_Semester/CA_Lab/Lab_5/Code/code.txt",mem);
	end
	assign Instruction = mem[Address[31:2]];	
endmodule

