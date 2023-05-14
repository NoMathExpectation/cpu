vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_clk_wiz.v" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.v" \


vlog -work xil_defaultlib \
"glbl.v"

