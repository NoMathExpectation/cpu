set_property SRC_FILE_INFO {cfile:d:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.xdc rfile:../../../cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports input_clk]] 0.1
