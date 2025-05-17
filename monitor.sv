package fifo_monitor_pkg;
    import uvm_pkg::*;
    `include "uvm_macros.svh"
    import fifo_seq_pkg::*;

    class fifo_monitor extends uvm_monitor;
        `uvm_component_utils(fifo_monitor)

        virtual fifo_if fifo_vif;   
        uvm_analysis_port #(fifo_seq_item) mon_ap;  
        fifo_seq_item seq_item_mon;

        function new(string name = "fifo_monitor", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            mon_ap = new("mon_ap", this);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase); 
            forever begin
            seq_item_mon = fifo_seq_item::type_id::create("seq_item_mon");
            @(negedge fifo_vif.clk);
            seq_item_mon.rst_n = fifo_vif.rst_n;
            seq_item_mon.wr_en = fifo_vif.wr_en;
            seq_item_mon.rd_en = fifo_vif.rd_en;
            seq_item_mon.data_in = fifo_vif.data_in;
            seq_item_mon.data_out = fifo_vif.data_out;
            seq_item_mon.full = fifo_vif.full;
            seq_item_mon.empty = fifo_vif.empty;
            seq_item_mon.almostfull = fifo_vif.almostfull;
            seq_item_mon.almostempty = fifo_vif.almostempty;
            seq_item_mon.wr_ack = fifo_vif.wr_ack;
            seq_item_mon.overflow = fifo_vif.overflow;
            seq_item_mon.underflow = fifo_vif.underflow;
            seq_item_mon.data_out_ref = fifo_vif.data_out_ref;
            seq_item_mon.full_ref = fifo_vif.full_ref;
            seq_item_mon.empty_ref = fifo_vif.empty_ref;
            seq_item_mon.almostfull_ref = fifo_vif.almostfull_ref;
            seq_item_mon.almostempty_ref = fifo_vif.almostempty_ref;
            seq_item_mon.wr_ack_ref = fifo_vif.wr_ack_ref;
            seq_item_mon.overflow_ref = fifo_vif.overflow_ref;
            seq_item_mon.underflow_ref = fifo_vif.underflow_ref;
            mon_ap.write(seq_item_mon);
            `uvm_info("run_phase", seq_item_mon.convert2string(), UVM_HIGH)
            end
        endtask
    endclass
endpackage
