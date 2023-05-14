onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+data_memory_internal -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_1 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.data_memory_internal xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {data_memory_internal.udo}

run -all

endsim

quit -force
