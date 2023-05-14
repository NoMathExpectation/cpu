vlib work
vlib activehdl

vlib activehdl/xil_defaultlib

vmap xil_defaultlib activehdl/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic" "+incdir+../../../ipstatic" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_clk_wiz.v" \
"../../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.v" \


vlog -work xil_defaultlib \
"glbl.v"

