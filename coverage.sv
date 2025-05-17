package fifo_coverage_pkg;
    import fifo_seq_pkg::*;
    import uvm_pkg::*;
    `include "uvm_macros.svh"

    class fifo_coverage extends uvm_component;
        `uvm_component_utils(fifo_coverage)
         fifo_seq_item fifo_seq_cov;
        uvm_analysis_export #(fifo_seq_item) cov_export;
        uvm_tlm_analysis_fifo #(fifo_seq_item) cov_fifo;
        
        covergroup cg ;
            coverpoint fifo_seq_cov.wr_en {
                bins wr_en_active = {1'b1};
                bins wr_en_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.rd_en {
                bins rd_en_active = {1'b1};
                bins rd_en_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.full {
                bins full_active = {1'b1};
                bins full_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.empty {
                bins empty_active = {1'b1};
                bins empty_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.almostfull {
                bins almostfull_active = {1'b1};
                bins almostfull_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.almostempty {
                bins almostempty_active = {1'b1};
                bins almostempty_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.overflow {
                bins overflow_active = {1'b1};
                bins overflow_inactive = {1'b0};
            }
            
            coverpoint fifo_seq_cov.underflow {
                bins underflow_active = {1'b1};
                bins underflow_inactive = {1'b0};
            }

            cross fifo_seq_cov.wr_en, fifo_seq_cov.full;
            cross fifo_seq_cov.rd_en, fifo_seq_cov.empty;
            cross fifo_seq_cov.wr_en, fifo_seq_cov.almostfull;
            cross fifo_seq_cov.rd_en, fifo_seq_cov.almostempty;
        endgroup

        function new(string name = "fifo_coverage", uvm_component parent = null);
            super.new(name, parent);
            cg = new();
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            cov_export = new("cov_export", this);
            cov_fifo = new("cov_fifo", this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            cov_export.connect(cov_fifo.analysis_export);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            forever begin
                cov_fifo.get(fifo_seq_cov);
                cg.sample(); 
            end
        endtask
    endclass
endpackage
