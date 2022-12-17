set ROOT "/home/radiocad/se5616ca-s/thesis/WORK"

set SYNT_SCRIPT "${ROOT}/syn_scripts"
set SYNT_OUT    "${ROOT}/OUTPUTS"
set SYNT_REPORT "${ROOT}/REPORTS"

puts "\n\n\n DESIGN FILES \n\n\n"
source $SYNT_SCRIPT/design_setup.tcl

puts "\n\n ANALYZING VHDL FILES \n\n"
set_attribute hdl_vhdl_read_version 2008
read_hdl -vhdl   ${Design_Files_VHDL}

puts "\n\n ANALYZING VERILOG FILES \n\n"
read_hdl -v2001 ${Design_Files_verilog}

puts "\n\n\n ELABORATE \n\n\n"
elaborate ${DESIGN}

check_design
report timing -lint

puts "\n\n\n TIMING CONSTRAINTS \n\n\n"
source $SYNT_SCRIPT/clock.tcl

puts "\n\n\n SYN_GENERIC \n\n\n"
syn_generic

puts "\n\n\n SYN_MAP \n\n\n"
syn_map

puts "\n\n\n SYN_OPT \n\n\n"
syn_opt

report timing -lint

puts "\n\n\n EXPORT DESIGN \n\n\n"
write_hdl  > ${SYNT_OUT}/${DESIGN}.v
write_sdc  > ${SYNT_OUT}/${DESIGN}.sdc
write_sdf -version 2.1  > ${SYNT_OUT}/${DESIGN}.sdf

puts "\n\n\n REPORTING \n\n\n"
report qor       > $SYNT_REPORT/qor_${DESIGN}.rpt
report area      > $SYNT_REPORT/area_${DESIGN}.rpt
report datapath  > $SYNT_REPORT/datapath_${DESIGN}.rpt
report messages  > $SYNT_REPORT/messages_${DESIGN}.rpt
report gates     > $SYNT_REPORT/gates_${DESIGN}.rpt
report timing    > $SYNT_REPORT/timing_${DESIGN}.rpt





