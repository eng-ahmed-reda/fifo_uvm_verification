vlib work
vlog -f src_files.txt +cover -covercells
vsim -voptargs=+acc work.top -classdebug -uvmcontrol=all -cover
add wave -position insertpoint sim:/top/fifo_vif/*
coverage save top.ucdb -onexit 
run -all
vcover report top.ucdb -details -annotate -all -output coverage_rpt.txt