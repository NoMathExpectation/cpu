vlib modelsim_lib/work
vlib modelsim_lib/msim

vlib modelsim_lib/msim/xil_defaultlib

vmap xil_defaultlib modelsim_lib/msim/xil_defaultlib

vlog -work xil_defaultlib -64 -incr \
"../../../../cpu.srcs/sources_1/ip/uart/uart_bmpg.v" \
"../../../../cpu.srcs/sources_1/ip/uart/upg.v" \
"../../../../cpu.srcs/sources_1/ip/uart/sim/uart.v" \


vlog -work xil_defaultlib \
"glbl.v"

