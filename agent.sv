package fifo_agent_pkg;
    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import fifo_driver_pkg::*;
    import fifo_monitor_pkg::*;
    import fifo_sequencer_pkg::*;
    import fifo_config_pkg::*;
    import fifo_seq_pkg::*;

    class fifo_agent extends uvm_agent;
        `uvm_component_utils(fifo_agent)

        fifo_config cfg;        
        fifo_driver driver;
        fifo_monitor monitor;
        fifo_sequencer sqr;
        uvm_analysis_port #(fifo_seq_item) agent_ap;

        function new(string name = "fifo_agent", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            if (!uvm_config_db#(fifo_config)::get(this, "", "CFG", cfg)) begin
                `uvm_fatal("build_phase", "unable to configration object");
            end
            sqr = fifo_sequencer::type_id::create("sqr", this);
            driver = fifo_driver::type_id::create("driver", this);
            monitor = fifo_monitor::type_id::create("monitor", this);
            agent_ap = new("agent_ap",this);
        endfunction

        function void connect_phase(uvm_phase phase);
            super.connect_phase(phase);
            driver.fifo_vif = cfg.fifo_vif;
            monitor.fifo_vif = cfg.fifo_vif;
            driver.seq_item_port.connect(sqr.seq_item_export);
            monitor.mon_ap.connect(agent_ap);
        endfunction
    endclass
endpackage
