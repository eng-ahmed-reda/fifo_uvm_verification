module fifo_reference_model(fifo_if.DUT_gold fifo_vif);

  	int count_n;
	bit [fifo_vif.FIFO_WIDTH-1:0] rd_wr[$] ;
	
	always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
			if (!fifo_vif.rst_n) begin
				fifo_vif.overflow_ref <= 0;
				fifo_vif.wr_ack_ref <= 0;
				rd_wr.delete();
			end
			else if (fifo_vif.wr_en && count_n < fifo_vif.FIFO_DEPTH) begin
				rd_wr.push_back(fifo_vif.data_in);
				fifo_vif.wr_ack_ref <= 1;
				
			end
			else begin 
				fifo_vif.wr_ack_ref <= 0; 
				if (fifo_vif.full_ref & fifo_vif.wr_en)
					fifo_vif.overflow_ref <= 1;
				else
					fifo_vif.overflow_ref <= 0;	
			end
	end

	always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
			if (!fifo_vif.rst_n) begin
			  	fifo_vif.data_out_ref <= 0;
				fifo_vif.underflow_ref <= 0;
    		end
    		else if (fifo_vif.rd_en && count_n != 0) begin
			    fifo_vif.data_out_ref <= rd_wr.pop_front();
    		end
			else begin 
				if (fifo_vif.empty_ref & fifo_vif.rd_en)
					fifo_vif.underflow_ref <= 1;
				else
					fifo_vif.underflow_ref <= 0;
			end		
	end

	always @(posedge fifo_vif.clk or negedge fifo_vif.rst_n) begin
        if (!fifo_vif.rst_n) begin
	        count_n <= 0;
        end
    
        else begin
	        if	( ({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b10) && !fifo_vif.full_ref) 
	    	    count_n  <= count_n + 1;
	        else if ( ({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b01) && !fifo_vif.empty_ref)
	    	    count_n  <= count_n - 1;
            else if (({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b11) && fifo_vif.full_ref)     
	        	count_n  <= count_n - 1;
	        else if (({fifo_vif.wr_en, fifo_vif.rd_en} == 2'b11) && fifo_vif.empty_ref)      
	        	count_n  <= count_n + 1;				
        end
	end

    assign fifo_vif.full_ref = (count_n == fifo_vif.FIFO_DEPTH)? 1 : 0;
    assign fifo_vif.empty_ref = (count_n == 0)? 1 : 0; 
    assign fifo_vif.almostfull_ref = (count_n == fifo_vif.FIFO_DEPTH-1)? 1 : 0; 
    assign fifo_vif.almostempty_ref = (count_n == 1)? 1 : 0;
        
endmodule