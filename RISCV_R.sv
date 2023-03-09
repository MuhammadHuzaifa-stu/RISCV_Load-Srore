module RISCV_R(input logic clk, reset);
	
	logic [31:0] inst,rdata1,rdata2,result,wdata2,pc,out,y,read_data;
	logic write,sel_B,rd_en,wr_en,wb_sel,cs;
	logic [4:0] aluop;
	logic [3:0]mask;
	
	//PC
	counter c1 (clk, reset, pc);
	
	//Intruction memory
	Instmem I1 (.Address(pc), .Instruction(inst));
	
	//register file
	regfile r1 (.raddr1(inst[19:15]),.raddr2(inst[24:20]),.waddr(inst[11:7]), 
				.wdata(wdata2),.RegWrite(write),.Clk(clk),.rdata1(rdata1),.rdata2(rdata2));
	
	//Immediate generator
	imme_gen im1 (.in(inst),.out(out));
	
	//mux for rs2 and immediate 12'
	mux21 m1 (.a(rdata2),.b(out),.s(sel_B),.y(y));
	
	//ALU
	ALU A1 (.a(rdata1),.b(y),.alu(aluop),.result(result));
	
	// LSU
	LSU L1 (.addr(result),.inst(inst),.mask(mask));

	//data memory
	data_memory dm1 (.addr(result),.write_data(rdata2),.mask(mask),.clk(clk),.reset(reset),
					 .rd_en(rd_en),.wr_en(wr_en),.cs(cs),.read_data(read_data));
	
	//mux for ALU and Data_memory 32'
	mux2x1 m2 (.a(result),.b(read_data),.s(wb_sel),.y(wdata2));
	
	//controller
	controller co1 (.func7(inst[31:25]),.func3(inst[14:12]),.opcode(inst[6:0]),
					.alu_control(aluop),.regwrite_control(write),.sel_B(sel_B),
					.rd_en(rd_en),.wr_en(wr_en),.wb_sel(wb_sel),.cs(cs));
	
endmodule
