# fifo_uvm_verification
RTL FIFO Design and Verification using SystemVerilog and UVM
FIFO UVM Verification Project
Overview
This repository contains a complete UVM (Universal Verification Methodology) testbench for verifying a parameterized FIFO (First-In-First-Out) design. The testbench implements a comprehensive verification environment with reference model comparison, functional coverage, and formal assertions to ensure proper FIFO behavior.
Project Structure
Design Files

FIFO.sv - FIFO design implementation
fifo_reference_model.sv - Golden reference model for behavioral comparison
interface.sv - SystemVerilog interface definition
fifo_assert.sv - SystemVerilog assertions for FIFO properties

UVM Testbench Files

Sequence Items and Sequences

sequence_item.sv - Base transaction class
reset_seq.sv - Reset sequence
write_seq.sv - Write-only sequence
read_seq.sv - Read-only sequence
read_write_seq.sv - Combined read/write sequence


UVM Components

driver.sv - UVM driver
monitor.sv - UVM monitor
sequencer.sv - UVM sequencer
agent.sv - UVM agent
score_board.sv - UVM scoreboard for comparing DUT with reference model
coverage.sv - Functional coverage collection
config.sv - Configuration class
env.sv - UVM environment
test.sv - UVM test class


Top Level

top.sv - Top-level module connecting DUT and testbench


Build and Run

run.do - ModelSim/QuestaSim simulation script
src_files.txt - List of source files for compilation



Features
The FIFO design implements:

Parameterized width and depth
Standard control signals (write/read enables, reset)
Status flags (full, empty, almost full, almost empty)
Error flags (overflow, underflow)

The verification environment provides:

Reference model comparison
Functional coverage collection
Formal assertions for key FIFO properties
Multiple test sequences for various operating conditions

Verification Strategy
The verification approach includes:

Stimulus Generation: Randomized sequences with constraints to target different FIFO states
Reference Model: Golden model to provide expected outputs
Scoreboard: Comparison between DUT and reference model responses
Functional Coverage: Covering important FIFO states and transitions
Assertions: Formal verification of key FIFO behaviors

Coverage Results
The testbench achieves:

100% functional coverage
100% assertion coverage
81.77% code coverage
Complete toggle coverage for DUT signals

Running the Tests
To run the simulation:

Ensure you have ModelSim/QuestaSim installed
Run the do file:

vsim -do run.do
Acknowledgments
This project was developed as part of learning UVM for hardware verification. It demonstrates standard verification practices for a fundamental digital design component.
Author
Created by eng-ahmed-reda
