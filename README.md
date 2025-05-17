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

Simulation Results
Cover Directives
![Screenshot 2025-05-17 151709](https://github.com/user-attachments/assets/c19b21b0-b4d9-45e9-a261-09dc61698eee)
The screenshot shows 100% coverage for all assertion cover points in the testbench, verifying key FIFO behaviors including full/empty conditions, read/write operations, and error states.
Covergroups
![Screenshot 2025-05-17 151648](https://github.com/user-attachments/assets/970a7068-ac41-4890-a63c-ff915d95d1de)

All functional coverage groups have reached 100% coverage, ensuring that all important FIFO operational states and transitions were exercised during verification.
Waveform Analysis
![Screenshot 2025-05-17 151630](https://github.com/user-attachments/assets/4f9a3e97-23a4-42ab-aa78-e9f512379b4a)

Waveform view showing FIFO interface signals during simulation, including control signals, data paths, and status flags from both the DUT and reference model.
Running the Tests
To run the simulation:

Ensure you have ModelSim/QuestaSim installed
Run the do file:

vsim -do run.do
Acknowledgments
This project was developed as part of learning UVM for hardware verification. It demonstrates standard verification practices for a fundamental digital design component.
Author
Created by eng-ahmed-reda
