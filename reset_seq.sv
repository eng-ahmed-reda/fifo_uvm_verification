package fifo_seq_pkg_reset;
    import uvm_pkg::*;
    import fifo_seq_pkg::*;
    `include "uvm_macros.svh"

    class fifo_seq_item_reset extends uvm_sequence#(fifo_seq_item);
        `uvm_object_utils(fifo_seq_item_reset)
        fifo_seq_item seq_item_rst;

        function new(string name = "fifo_seq_item_reset");
            super.new(name);
        endfunction

        task body;
        seq_item_rst = fifo_seq_item::type_id::create("seq_item_rst");
        start_item(seq_item_rst);
        seq_item_rst.rst_n=0;             
        seq_item_rst.data_in=0;      
        seq_item_rst.wr_en=0;           
        seq_item_rst.rd_en=0;
        finish_item(seq_item_rst);
        endtask
       
    endclass
endpackage
