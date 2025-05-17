import fifo_test_pkg::*;
import uvm_pkg::*;
`include "uvm_macros.svh"

module top ();
    bit clk;

    initial begin
        forever begin
            #1 clk = ~clk;
        end
    end    

    fifo_if fifo_vif (clk);
    FIFO_DUT DUT (fifo_vif);
    fifo_reference_model DUT_gold (fifo_vif);
    bind FIFO_DUT fifo_assert fifo_assert_dut(fifo_vif);

    initial begin
        uvm_config_db #(virtual fifo_if)::set(null , "uvm_test_top" , "FIFO_IF", fifo_vif);
        run_test("fifo_test");
    end
    
endmodule