# ALL values are in picosecond

#50MHz
set PERIOD 20000
set ClkTop $DESIGN
set ClkDomain $DESIGN
set ClkName clk_p
set ClkLatency 1000
set ClkRise_uncertainity 1000
set ClkFall_uncertainity 1000
set ClkSlew 1000
set InputDelay 1000
set OutputDelay 1000

# check usr/hidden/cmp/joajox/scripts/ for more detailed scripting

#REMEBER TO CHANGE THE -port ClkxC* to the actual name of clock port/pin in your design

define_clock -name $ClkName -period $PERIOD -design $ClkTop -domain $ClkDomain [find /designs/TOP_LU_PADS/ports_in/clk_p]

set_attribute clock_network_late_latency $ClkLatency $ClkName
set_attribute clock_source_late_latency $ClkLatency $ClkName

set_attribute clock_setup_uncertainty $ClkLatency $ClkName
set_attribute clock_hold_uncertainty $ClkLatency $ClkName

set_attribute slew_rise $ClkRise_uncertainity $ClkName
set_attribute slew_fall $ClkFall_uncertainity $ClkName

external_delay -input $InputDelay -clock [find / -clock $ClkName] -name in_con [find /des* -port ports_in/*]
external_delay -output $OutputDelay -clock [find / -clock $ClkName] -name out_con [find /des* -port ports_out/*]


