#Clock
# Clock signal 
set_property PACKAGE_PIN W5 [get_ports clk] 
set_property IOSTANDARD LVCMOS33 [get_ports clk] 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

#Control Switches 
set_property PACKAGE_PIN T2 [get_ports {sw[0]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[0]}] 
set_property PACKAGE_PIN R3 [get_ports {sw[1]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[1]}] 
set_property PACKAGE_PIN W2 [get_ports {sw[2]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[2]}] 
set_property PACKAGE_PIN U1 [get_ports {sw[3]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[3]}] 
set_property PACKAGE_PIN T1 [get_ports {sw[4]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[4]}] 
set_property PACKAGE_PIN R2 [get_ports {sw[5]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {sw[5]}] 

#Reset Switches
set_property PACKAGE_PIN V17 [get_ports {reset}] 
set_property IOSTANDARD LVCMOS33 [get_ports {reset}]

#PMOD Header JB
#Sch name = JB1 
set_property PACKAGE_PIN A14 [get_ports {servo[3]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {servo[3]}]
##Sch name = JB7 
set_property PACKAGE_PIN A15 [get_ports {servo[2]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {servo[2]}]

#Pmod Header JC 
#Sch name = JC1 
set_property PACKAGE_PIN K17 [get_ports {servo[1]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {servo[1]}]
#Sch name = JC7
set_property PACKAGE_PIN L17 [get_ports {servo[0]}] 
set_property IOSTANDARD LVCMOS33 [get_ports {servo[0]}]
