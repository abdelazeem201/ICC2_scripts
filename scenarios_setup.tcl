### read settings
source scripts/00_common_initial_settings.tcl

### initialize setting
source scripts/initialization_settings.tcl



#--------------------------------------------------------
# Scenario Setup
#--------------------------------------------------------
### sceanrio = mode + corner
# mode == SDC
# corner = lib_corner (PVT) + rc_corner (rc_variation + temp)
# mode_libcorner_rccorner
# modeLibcornerRccorner


remove_modes -all
remove_corners -all
remove_scenarios -all

create_mode func
create_corner ss0p75v125c_cmax
create_scenario -mode func -corner ss0p75v125c_cmax -name func_ss0p75v125c_cmax

current_mode func
current_corner ss0p75v125c_cmax
current_scenario func_ss0p75v125c_cmax

### rc tech
read_parasitic_tech -tlup $icc2rc_tech(cmax) -layermap $itf_tluplus_map -name maxTLU

### SDC
remove_sdc -scenarios [current_scenario ]
source data/constraints/ORCA_TOP_m_func.tcl

### PVT & RC conditions
set_process_number -corners [current_corner] 0.99
set_process_label  -corners [current_corner] slow
set_voltage -object_list {VDD}  0.75
set_voltage -object_list {VDDH} 0.95
set_voltage -object_list {VSS}  0
set_temperature -corners [current_corner] 125
set_parasitic_parameters -corners [current_corner] -late_spec maxTLU -early_spec maxTLU

### boundary constraints
set input_ports [all_inputs]
set data_inputs [remove_from_col $input_ports [get_ports [get_attribute [get_clocks] sources -quiet] -quiet]]
set_input_delay 0.6 -max $data_inputs
set_input_delay 0.4 -min $data_inputs

set output_ports [all_outputs]
set_output_delay 0.6 -max $output_ports
set_output_delay 0.4 -min $output_ports

set_driving_cell -lib_cell NBUFFX4_RVT $data_inputs
set_load 20 $output_ports

### DRV constraints
set_max_transition 0.10 SYS_2x_CLK -scenarios func_ss0p75v125c_cmax -clock_path
set_max_transition 0.25 SYS_2x_CLK -scenarios func_ss0p75v125c_cmax -data_path
set_max_capacitance 200 SYS_2x_CLK -scenarios func_ss0p75v125c_cmax

### margin : derate & uncertainty
set_timing_derate -early 0.95 -cell_delay -net_delay
set_timing_derate -late  1.05 -cell_delay -net_delay
set_clock_uncertainty 0.200 [get_clocks *]

### scenario status
set_scenario_status func_ss0p75v125c_cmax -active true -setup true -hold false -leakage_power false -dynamic_power false -max_transition true -max_capacitance true -min_capacitance true

### report
report_pvt
report_scenarios

#--------------------------------------------------------
# End
#--------------------------------------------------------
