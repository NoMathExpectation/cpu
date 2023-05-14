vlib work
vlib riviera

vlib riviera/xil_defaultlib

vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xil_defaultlib  -v2k5 \
"../../../../cpu.srcs/sources_1/ip/uart/uart_bmpg.v" \
"../../../../cpu.srcs/sources_1/ip/uart/upg.v" \
"../../../../cpu.srcs/sources_1/ip/uart/sim/uart.v" \


vlog -work xil_defaultlib \
"glbl.v"

