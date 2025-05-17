package fifo_driver_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import fifo_seq_pkg::*; 
    import fifo_config_pkg::*;

    class fifo_driver extends uvm_driver#(fifo_seq_item); 
        `uvm_component_utils(fifo_driver)

        virtual fifo_if fifo_vif; 
        fifo_seq_item fifo_seq_driv; 

        function new(string name = "fifo_driver", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        task run_phase(uvm_phase phase);
            forever begin
            fifo_seq_driv = fifo_seq_item::type_id::create("fifo_seq_driv");
            seq_item_port.get_next_item(fifo_seq_driv);
            fifo_vif.rst_n = fifo_seq_driv.rst_n;
            fifo_vif.wr_en = fifo_seq_driv.wr_en;
            fifo_vif.rd_en = fifo_seq_driv.rd_en;
            fifo_vif.data_in = fifo_seq_driv.data_in;
            @(negedge fifo_vif.clk);
            fifo_seq_driv.data_out = fifo_vif.data_out;
            fifo_seq_driv.full = fifo_vif.full;
            fifo_seq_driv.empty = fifo_vif.empty;
            fifo_seq_driv.almostfull = fifo_vif.almostfull;  
            fifo_seq_driv.almostempty = fifo_vif.almostempty;
            fifo_seq_driv.wr_ack = fifo_vif.wr_ack;
            fifo_seq_driv.overflow = fifo_vif.overflow;
            fifo_seq_driv.underflow = fifo_vif.underflow;
            fifo_seq_driv.data_out_ref = fifo_vif.data_out_ref;
            fifo_seq_driv.full_ref = fifo_vif.full_ref;
            fifo_seq_driv.empty_ref =fifo_vif.empty_ref;
            fifo_seq_driv.almostfull_ref = fifo_vif.almostfull_ref;
            fifo_seq_driv.almostempty_ref = fifo_vif.almostempty_ref;
            fifo_seq_driv.wr_ack_ref = fifo_vif.wr_ack_ref;
            fifo_seq_driv.overflow_ref = fifo_vif.overflow_ref;
            fifo_seq_driv.underflow_ref =fifo_vif.underflow_ref;
            seq_item_port.item_done();
            `uvm_info("run_phase", fifo_seq_driv.convert2string_stimulus(), UVM_HIGH)
            end
        endtask
    endclass
endpackage

