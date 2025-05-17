package fifo_env_pkg;
    import uvm_pkg::*;
    import fifo_agent_pkg::*;
    import fifo_coverage_pkg::*;
    import fifo_scoreboard_pkg::*;
    import fifo_seq_pkg::*;
    `include "uvm_macros.svh"

    class fifo_env extends uvm_env;
        `uvm_component_utils(fifo_env)

        fifo_agent agent;
        fifo_coverage cov;
        fifo_scoreboard score;
        uvm_analysis_port #(fifo_seq_item) agent_ap;

        function new(string name = "fifo_env", uvm_component parent = null);
            super.new(name, parent);
        endfunction

        function void build_phase(uvm_phase phase);
            super.build_phase(phase);
            agent = fifo_agent::type_id::create("agent", this);
            cov = fifo_coverage::type_id::create("cov", this); 
            score = fifo_scoreboard::type_id::create("score", this); 
            agent_ap = new ("agent_ap",this);
        endfunction
        
        function void connect_phase(uvm_phase phase);
            agent.agent_ap.connect(cov.cov_export);
            agent.agent_ap.connect(score.score_export);
        endfunction
    endclass
endpackage 
