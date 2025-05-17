package fifo_test_pkg;
    import uvm_pkg::*;
    import fifo_env_pkg::*;
    import fifo_config_pkg::*;
    import fifo_seq_pkg::*;
    import fifo_seq_write::*;
    import fifo_seq_read::*;
    import fifo_seq_read_write::*;
    import fifo_seq_pkg_reset::*;
    `include "uvm_macros.svh"

    class fifo_test extends uvm_test;
        `uvm_component_utils(fifo_test)

        fifo_env env;
        fifo_config cfg;
        virtual fifo_if fifo_vif;
        write_only_sequence seq_write;
        read_only_sequence seq_read;
        write_read_sequence seq_wr_rd;
        fifo_seq_item_reset seq_reset;

        function new(string name = "fifo_test", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);

            env = fifo_env::type_id::create("env", this);
            cfg = fifo_config::type_id::create("cfg", this);
            seq_write = write_only_sequence::type_id::create("seq_write",this);
            seq_read = read_only_sequence::type_id::create("seq_read",this);
            seq_wr_rd = write_read_sequence::type_id::create("seq_wr_rd",this);
            seq_reset = fifo_seq_item_reset::type_id::create("seq_reset", this);

            if (!uvm_config_db#(virtual fifo_if)::get(this, "", "FIFO_IF", cfg.fifo_vif)) begin // cfg.
                `uvm_fatal("build_phase", "test no vif");
            end

            uvm_config_db#(fifo_config)::set(this, "*", "CFG", cfg);
        endfunction

        task run_phase(uvm_phase phase);
            super.run_phase(phase);
            phase.raise_objection(this);

            `uvm_info("run_phase", "reset asserted", UVM_LOW)
            seq_reset.start(env.agent.sqr);
            `uvm_info("run_phase", "reset deasserted", UVM_LOW)

            `uvm_info("run_phase", "stimulus generation write started", UVM_LOW)
            seq_write.start(env.agent.sqr);
            `uvm_info("run_phase", "stimulus generation write ended", UVM_LOW)

            `uvm_info("run_phase", "stimulus generation read started", UVM_LOW)
            seq_read.start(env.agent.sqr);
            `uvm_info("run_phase", "stimulus generation read ended", UVM_LOW)

            `uvm_info("run_phase", "stimulus generation write_read started", UVM_LOW)
            seq_wr_rd.start(env.agent.sqr);
            `uvm_info("run_phase", "stimulus generation write_read ended", UVM_LOW)

            `uvm_info("fifo_test", "Running FIFO Test", UVM_MEDIUM);
            phase.drop_objection(this);
        endtask
    endclass
endpackage
