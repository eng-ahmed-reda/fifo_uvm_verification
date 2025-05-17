package fifo_seq_read_write;
    import uvm_pkg::*;
    import fifo_seq_pkg::*;
    `include "uvm_macros.svh"

    class write_read_sequence extends uvm_sequence#(fifo_seq_item);
        `uvm_object_utils(write_read_sequence)

        function new(string name = "write_read_sequence");
            super.new(name);
        endfunction
        
        task body;
            fifo_seq_item seq_item;
            repeat(500) begin 
                seq_item = fifo_seq_item::type_id::create("seq_item");
                start_item(seq_item);
                seq_item.constraint_mode(1);
                seq_item.data_in.rand_mode(1);
                seq_item.read_only.constraint_mode(0);
                seq_item.write_only.constraint_mode(0);
                assert(seq_item.randomize());
                finish_item(seq_item);
            end
        endtask
    endclass
endpackage
