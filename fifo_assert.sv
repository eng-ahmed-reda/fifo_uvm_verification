module fifo_assert (fifo_if.DUT fifo_vif);
    

  property prop1;
	@(posedge fifo_vif.clk) disable iff(!fifo_vif.rst_n) (fifo_vif.wr_en &&  !fifo_vif.full) |=> fifo_vif.wr_ack ;
  endproperty

  as1:assert property (prop1);
  co1:cover property (prop1);

  property prop2;
    @(posedge fifo_vif.clk) disable iff (!fifo_vif.rst_n) (fifo_vif.full && fifo_vif.wr_en) |=> fifo_vif.overflow;
  endproperty

  as2:assert property (prop2);
  co2:cover property (prop2);
  
  property prop3;
    @(posedge fifo_vif.clk) disable iff (!fifo_vif.rst_n) (fifo_vif.empty && fifo_vif.rd_en) |=> fifo_vif.underflow;
  endproperty
    
  as3:assert property (prop3);
  co3:cover property (prop3);
  
  property prop4;
    @(posedge fifo_vif.clk) disable iff (!fifo_vif.rst_n) (fifo_vif.wr_en  && !fifo_vif.rd_en && !fifo_vif.full) |=> DUT.count <= $past(DUT.count) + 4'b0001;
  endproperty
    
  as4:assert property (prop4);
  co4:cover property (prop4);
  
  property prop5;
    @(posedge fifo_vif.clk) disable iff (!fifo_vif.rst_n) (!fifo_vif.wr_en && fifo_vif.rd_en && !fifo_vif.empty) |=> DUT.count <= $past(DUT.count) - 4'b0001;
  	
  endproperty
    
  as5:assert property (prop5);
  co5:cover property (prop5);

  always_comb begin
    if (fifo_vif.rst_n && (DUT.count == fifo_vif.FIFO_DEPTH)) begin
       as6: assert final(fifo_vif.full == 1);
       co6: cover (fifo_vif.full == 1);
    end
  end

  always_comb begin
    if (fifo_vif.rst_n && !DUT.count) begin
       as7: assert final(fifo_vif.empty == 1);
       co7: cover (fifo_vif.empty == 1);
    end
  end

  always_comb begin
    if (fifo_vif.rst_n && (DUT.count == fifo_vif.FIFO_DEPTH - 4'b0001)) begin
       as8: assert final(fifo_vif.almostfull == 1);
       co8: cover (fifo_vif.almostfull == 1);
    end
  end

  always_comb begin
    if (fifo_vif.rst_n && (DUT.count == 4'b0001)) begin
       as9: assert final(fifo_vif.almostempty == 1);
       co9: cover (fifo_vif.almostempty == 1);
    end
  end

  always_comb begin
    if(!fifo_vif.rst_n)
       a_reset:assert final(fifo_vif.data_out == 0 && fifo_vif.overflow == 0 && fifo_vif.underflow == 0 && fifo_vif.wr_ack == 0 );
       a_cover:cover (fifo_vif.data_out == 0 && fifo_vif.overflow == 0 && fifo_vif.underflow == 0 && fifo_vif.wr_ack == 0 );
  end

endmodule




