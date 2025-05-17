interface fifo_if (clk);
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    input bit clk;
    bit wr_en, rd_en, rst_n, full, empty, almostfull,almostempty, wr_ack, overflow, underflow;
    bit [FIFO_WIDTH-1:0] data_in , data_out , data_out_ref;
    bit full_ref, empty_ref, almostfull_ref, almostempty_ref, wr_ack_ref, overflow_ref, underflow_ref;

    modport DUT (
    input data_in, wr_en, rd_en, clk, rst_n,
    output full, empty, almostfull,almostempty,wr_ack, overflow, underflow, data_out
    );

    modport DUT_gold (
    input data_in, wr_en, rd_en, clk, rst_n,
    output full_ref, empty_ref, almostfull_ref, almostempty_ref, wr_ack_ref, overflow_ref, underflow_ref, data_out_ref
    );
    
endinterface  
