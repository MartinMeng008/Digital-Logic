# 
# Synthesis run script generated by Vivado
# 

set TIME_start [clock seconds] 
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
set_param chipscope.maxJobs 2
set_param xicom.use_bs_reader 1
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.cache/wt [current_project]
set_property parent.project_path C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
set_property ip_output_repo c:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.cache/ip [current_project]
set_property ip_cache_permissions {read write} [current_project]
read_verilog C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/display640x480.vh
read_mem {
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/bmem_screentest.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/smem_screentest.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/dmem_screentest.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/imem_screentest_nopause.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/imem_screentest.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/dmem_etchasketch.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/imem_etchasketch.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/imem_full-IO-test.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/dmem_full-IO-test.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Final-Project/bmem_finalproject.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Final-Project/smem_finalproject.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Final-Project/dmem_finalproject.mem
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Final-Project/imem_finalproject.mem
}
read_verilog -library xil_defaultlib -sv {
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/ALU.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sources/sources/accelerometer.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/adder.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/addsub.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/clockdiv.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/new/comparator.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/Downloads/controller.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/datapath.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/new/display8digit.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/fulladder.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/new/hexto7seg.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/keyboard.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/logical.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/new/memIO.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/mips.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/ram.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/new/ram2port.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/Downloads/register_file.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/sources_1/imports/Downloads/rom.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/imports/new/shifter.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sound.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/sources_1/new/vgadisplaydriver.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/sources_1/imports/new/vgatimer.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/sources_1/imports/new/xycounter.sv
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/top.sv
}
read_vhdl -library xil_defaultlib {
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sources/sources/ADXL362Ctrl.vhd
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sources/sources/AccelArithmetics.vhd
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sources/sources/AccelerometerCtl.vhd
  C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/sources_1/imports/Downloads/sources/sources/SPI_If.vhd
}
# Mark all dcp files as not used in implementation to prevent them from being
# stitched into the results of this synthesis run. Any black boxes in the
# design are intentionally left as such for best results. Dcp files will be
# stitched into the design at a later time, either when this synthesis run is
# opened, or when it is stitched into a dependent implementation run.
foreach dcp [get_files -quiet -all -filter file_type=="Design\ Checkpoint"] {
  set_property used_in_implementation false $dcp
}
read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/clock.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/clock.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/keyboard_DDR.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/keyboard_DDR.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/segdisplay_DDR.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/segdisplay_DDR.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/accel_DDR.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/accel_DDR.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/led_DDR.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/led_DDR.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/sound.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/sound.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/reset_DDR.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/reset_DDR.xdc]

read_xdc C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/vga.xdc
set_property used_in_implementation false [get_files C:/Labs-in-Vivado/COMP541/LabProject-PartA/LabProject-PartA.srcs/constrs_1/imports/Downloads/vga.xdc]

set_param ips.enableIPCacheLiteLoad 1
close [open __synthesis_is_running__ w]

synth_design -top top -part xc7a100tcsg324-1


# disable binary constraint mode for synth run checkpoints
set_param constraints.enableBinaryConstraints false
write_checkpoint -force -noxdef top.dcp
create_report "synth_1_synth_report_utilization_0" "report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb"
file delete __synthesis_is_running__
close [open __synthesis_is_complete__ w]
