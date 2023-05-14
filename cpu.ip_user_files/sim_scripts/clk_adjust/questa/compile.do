vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib

vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_clk_wiz.v" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.v" \


vlog -work xil_defaultlib \
"glbl.v"

