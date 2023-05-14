vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_clk_wiz.v" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.v" \


vlog -work xil_defaultlib \
"glbl.v"

