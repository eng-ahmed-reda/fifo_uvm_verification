package fifo_seq_pkg; 
   `include "uvm_macros.svh"
   import uvm_pkg::*;
   
    parameter FIFO_WIDTH = 16;
    parameter FIFO_DEPTH = 8;
    int error_count = 0;
    int correct_count = 0;

class fifo_seq_item extends uvm_sequence_item;
    `uvm_object_utils(fifo_seq_item)
    
    rand bit wr_en, rd_en, rst_n;
    rand bit [FIFO_WIDTH-1:0] data_in;
    bit [FIFO_WIDTH-1:0] data_out,data_out_ref;
    bit full, empty, almostfull,almostempty,wr_ack, overflow, underflow;
    bit full_ref, empty_ref, almostfull_ref, almostempty_ref, wr_ack_ref, overflow_ref, underflow_ref;

    function new(string name = "fifo_sequence_item");
        super.new(name);
    endfunction

    function string convert2string();
        return $sformatf("%s wr_en = 0b%0b , rd_en = 0b%0b , rst_n = 0b%0b , data_in = 0b%0b , data_out = 0b%0b , full = 0b%0b , empty = 0b%0b , almostfull = 0b%0b , almostempty = 0b%0b , wr_ack = 0b%0b , overflow = 0b%0b , underflow = 0b%0b , full_ref = 0b%0b , empty_ref = 0b%0b , almostfull_ref = 0b%0b  , almostempty_ref = 0b%0b , wr_ack_ref = 0b%0b , overflow_ref = 0b%0b , underflow_ref = 0b%0b ", super.convert2string(),wr_en , rd_en , rst_n , data_in , data_out , full , empty , almostfull , almostempty , wr_ack , overflow , underflow ,full_ref, empty_ref, almostfull_ref, almostempty_ref, wr_ack_ref, overflow_ref, underflow_ref);
    endfunction

    function string convert2string_stimulus();
        return $sformatf("wr_en = 0b%0b , rd_en = 0b%0b , rst_n = 0b%0b , data_in = 0b%0b ", wr_en , rd_en , rst_n , data_in);
    endfunction

    constraint reset_c { 
        rst_n dist{ 0:/2 , 1:/98 };
        }

    constraint write_c { 
        wr_en dist { 0:/(30)  , 1:/(70) };
        }

    constraint read_c { 
        rd_en dist { 0:/(70) , 1:/(30) };
        }
    
    constraint write_only { rst_n == 1;  wr_en == 1;  rd_en == 0; } 
    
    constraint read_only { rst_n == 1;  wr_en == 0;  rd_en == 1; } 

endclass

endpackage

