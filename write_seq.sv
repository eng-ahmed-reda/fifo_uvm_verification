package fifo_seq_write;
    import uvm_pkg::*;
    import fifo_seq_pkg::*;
    `include "uvm_macros.svh"

    class write_only_sequence extends uvm_sequence#(fifo_seq_item);
        `uvm_object_utils(write_only_sequence)

        function new(string name = "write_only_sequence");
            super.new(name);
        endfunction
        
        task body;
        fifo_seq_item wr_seq_item;
        repeat(500) begin 
            wr_seq_item = fifo_seq_item::type_id::create("wr_seq_item");
            start_item(wr_seq_item);
              wr_seq_item.constraint_mode(0);
              wr_seq_item.write_only.constraint_mode(1);
              assert(wr_seq_item.randomize());
            finish_item(wr_seq_item);
            end
        endtask

    endclass
endpackage




