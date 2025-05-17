////////////////////////////////////////////////////////////////////////////////
// Author: Kareem Waseem
// Course: Digital Verification using SV & UVM
//
// Description: FIFO Design 
// 
////////////////////////////////////////////////////////////////////////////////
module FIFO_DUT (fifo_if.DUT fifo_vif);
 
localparam max_fifo_addr = $clog2(fifo_vif.FIFO_DEPTH);

reg [fifo_vif.FIFO_WIDTH-1:0] mem [fifo_vif.FIFO_DEPTH-1:0];

reg [max_fifo_addr-1:0] wr_ptr, rd_ptr;
reg [max_fifo_addr:0] count;

always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
	if (!fifo_vif.rst_n) begin
		wr_ptr <= 0;
		fifo_vif.wr_ack <= 0;
		fifo_vif.overflow <= 0; //first debug : Reset all sequential outputs in write operation
	end
	else if (fifo_vif.wr_en && count < fifo_vif.FIFO_DEPTH) begin
		mem[wr_ptr] <= fifo_vif.data_in;
		fifo_vif.wr_ack <= 1;
		wr_ptr <= wr_ptr + 1;
	end
	else begin 
		fifo_vif.wr_ack <= 0; 
		if (fifo_vif.full & fifo_vif.wr_en)
			fifo_vif.overflow <= 1;
		else
			fifo_vif.overflow <= 0;
	end
end

always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
	if (!fifo_vif.rst_n) begin
		rd_ptr <= 0;          //second debug : Reset all sequential outputs in read operation
		fifo_vif.underflow <= 0;
		fifo_vif.data_out <= 0;
	end
	else if (fifo_vif.rd_en && count != 0) begin
		fifo_vif.data_out <= mem[rd_ptr];
		rd_ptr <= rd_ptr + 1;
	end
	else begin  
		if (fifo_vif.empty & fifo_vif.rd_en)
			fifo_vif.underflow <= 1;   //third debug : underflow is sequential not combinational (put in alwyas block)
		else
			fifo_vif.underflow <= 0;
	end
end

always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
	if (!fifo_vif.rst_n) begin
		count <= 0;
	end
	else begin
		if	( ({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b10) && !fifo_vif.full) 
			count <= count + 1;
		else if ( ({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b01) && !fifo_vif.empty)
			count <= count - 1;
	    else if (({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b11) && fifo_vif.full)    //fourth debug :  cover all cases for counter (full) 
			count <= count - 1;
		else if (({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b11) && fifo_vif.empty)    //fiveth debug : cover all cases for counter (empty) 
			count <= count + 1;
	end
end

assign fifo_vif.full = (count == fifo_vif.FIFO_DEPTH)? 1 : 0;
assign fifo_vif.empty = (count == 0)? 1 : 0;
assign fifo_vif.almostfull = (count == fifo_vif.FIFO_DEPTH-1)? 1 : 0;  // sexth debug : in case of almostfull (fifo_vif.FIFO_DEPTH-1) not (fifo_vif.FIFO_DEPTH-2)
assign fifo_vif.almostempty = (count == 1)? 1 : 0;

endmodule