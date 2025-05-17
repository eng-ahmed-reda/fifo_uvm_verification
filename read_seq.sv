package fifo_seq_read;
    import uvm_pkg::*;
    import fifo_seq_pkg::*;
    `include "uvm_macros.svh"

    class read_only_sequence extends uvm_sequence#(fifo_seq_item);
        `uvm_object_utils(read_only_sequence)

        function new(string name = "read_only_sequence");
            super.new(name);
        endfunction
        
            task body;
                fifo_seq_item rd_seq_item;
                repeat(500) begin 
                rd_seq_item = fifo_seq_item::type_id::create("rd_seq_item");
                start_item(rd_seq_item);
                rd_seq_item.constraint_mode(0);
                rd_seq_item.data_in.rand_mode(0);
                rd_seq_item.read_only.constraint_mode(1);
                assert(rd_seq_item.randomize());
                finish_item(rd_seq_item);
                end
            endtask
    endclass
endpackage
