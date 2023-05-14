onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+clk_adjust -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.clk_adjust xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {clk_adjust.udo}

run -all

endsim

quit -force
