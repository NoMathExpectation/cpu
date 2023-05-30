# 
# Synthesis run script generated by Vivado
# 

proc create_report { reportName command } {
  set status "."
  append status $reportName ".fail"
  if { [file exists $status] } {
    eval file delete [glob $status]
  }
  send_msg_id runtcl-4 info "Executing : $command"
  set retval [eval catch { $command } msg]
  if { $retval != 0 } {
    set fp [open $status w]
    close $fp
    send_msg_id runtcl-5 warning "$msg"
  }
}
create_project -in_memory -part xc7a35tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir D:/CSEFirstYear/CS202CPU/cpu/cpu.cache/wt [current_project]
set_property parent.project_path D:/CSEFirstYear/CS202CPU/cpu/cpu.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_repo_paths d:/CSEFirstYear/CS202CPU/cpu/SEU_CSE_507_user_uart_bmpg_1.3 [current_project]
set_property ip_output_repo d:/CSEFirstYear/CS202CPU/cpu/cpu.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog -library xil_defaultlib {
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/data_memory.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/execute.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/instruction_memory.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/imports/new/led_show.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/imports/new/num_to_led.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/imports/new/number_input_pad.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/registers.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/syscall.v
  D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/new/board.v
}
read_ip -quiet D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/uart/uart.xci

read_ip -quiet D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/data_memory_internal/data_memory_internal.xci
set_property used_in_implementation false [get_files -all d:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/data_memory_internal/data_memory_internal_ooc.xdc]

read_ip -quiet D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.xci
set_property used_in_implementation false [get_files -all d:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_board.xdc]
set_property used_in_implementation false [get_files -all d:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/clk_adjust/clk_adjust.xdc]
set_property used_in_implementation false [get_files -all d:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/sources_1/ip/clk_adjust/clk_adjust_ooc.xdc]

# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/constrs_1/new/constraint_cpu.xdc
set_property used_in_implementation false [get_files D:/CSEFirstYear/CS202CPU/cpu/cpu.srcs/constrs_1/new/constraint_cpu.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top board -part xc7a35tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef board.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file board_utilization_synth.rpt -pb board_utilization_synth.pb"
