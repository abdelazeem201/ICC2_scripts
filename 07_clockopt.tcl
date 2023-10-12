##############################################################
# Function: Clock Tree Optimization
# Created by Ahmed Abdelazeem
##############################################################
### load setting
source scripts/00_common_initial_settings.tcl

### variables
set current_step "07_clockopt"

### open database
file delete -force nlib/ORCA_TOP_${current_step}.nlib
copy_lib -from_lib nlib/ORCA_TOP_06_clock.nlib -to_lib nlib/ORCA_TOP_${current_step}.nlib -force
current_lib ORCA_TOP_${current_step}.nlib
open_block ORCA_TOP

### initialize setting
source scripts/initialization_settings.tcl

### reset upf
reset_upf
load_upf data/ORCA_TOP.upf
commit_upf

### scenario setup
set scenarios_list $clockopt_scenarios
source scripts/scenarios_setup.tcl
foreach scenario [get_att [all_scenarios] name] {
    echo "YFT-Information: Setting propagated clock on scenario $scenario"
    current_scenario $scenario
    set_propagated_clock [get_clocks -filter "is_virtual==false"]
}

### routing layer
set_ignored_layers -min_routing_layer M1 -max_routing_layer M9

### lib cell selection (tie, cts cells, hold fix)
set_dont_touch [get_lib_cells */*TIE*] false
set_attribute [get_lib_cells */*TIE*] dont_use false
set_lib_cell_purpose -include {optimization} [get_lib_cells */*TIE*]
set cts_cells "*/NBUFFX16_LVT */NBUFFX4_LVT */NBUFFX8_LVT */INVX16_LVT */INVX4_LVT */INVX8_LVT */*CG* */*DFF*"
set cts_cells_more "saed32_lvt|saed32_lvt_std/NBUFFX16_LVT saed32_lvt|saed32_lvt_std/NBUFFX2_LVT saed32_lvt|saed32_lvt_std/NBUFFX32_LVT saed32_lvt|saed32_lvt_std/NBUFFX4_LVT saed32_lvt|saed32_lvt_std/NBUFFX8_LVT saed32_rvt|saed32_rvt_std/NBUFFX16_RVT saed32_rvt|saed32_rvt_std/NBUFFX2_RVT saed32_rvt|saed32_rvt_std/NBUFFX32_RVT saed32_rvt|saed32_rvt_std/NBUFFX4_RVT saed32_rvt|saed32_rvt_std/NBUFFX8_RVT saed32_lvt|saed32_lvt_std/AOBUFX2_LVT saed32_lvt|saed32_lvt_std/AOBUFX4_LVT saed32_rvt|saed32_rvt_std/AOBUFX2_RVT saed32_rvt|saed32_rvt_std/AOBUFX4_RVT saed32_lvt|saed32_lvt_std/IBUFFX16_LVT saed32_lvt|saed32_lvt_std/IBUFFX2_LVT saed32_lvt|saed32_lvt_std/IBUFFX4_LVT saed32_lvt|saed32_lvt_std/IBUFFX8_LVT saed32_lvt|saed32_lvt_std/INVX0_LVT saed32_lvt|saed32_lvt_std/INVX16_LVT saed32_lvt|saed32_lvt_std/INVX2_LVT saed32_lvt|saed32_lvt_std/INVX4_LVT saed32_lvt|saed32_lvt_std/INVX8_LVT saed32_rvt|saed32_rvt_std/IBUFFX16_RVT saed32_rvt|saed32_rvt_std/IBUFFX2_RVT saed32_rvt|saed32_rvt_std/IBUFFX4_RVT saed32_rvt|saed32_rvt_std/IBUFFX8_RVT saed32_rvt|saed32_rvt_std/INVX0_RVT saed32_rvt|saed32_rvt_std/INVX16_RVT saed32_rvt|saed32_rvt_std/INVX2_RVT saed32_rvt|saed32_rvt_std/INVX4_RVT saed32_rvt|saed32_rvt_std/INVX8_RVT saed32_lvt|saed32_lvt_std/AOINVX4_LVT saed32_rvt|saed32_rvt_std/AOINVX4_RVT"

set_dont_touch [get_lib_cells $cts_cells] false
set_att [get_lib_cells $cts_cells] dont_use false
set_lib_cell_purpose -exclude cts [get_lib_cells */*]
set_lib_cell_purpose -include cts [get_lib_cells {*/*BUF* */*INV*}]

### CTS NDR (Reminder: )
if { [get_routing_rule ndr_2w2s -quiet] == "" } {
    create_routing_rule ndr_2w2s -default_reference_rule -multiplier_width 2 -multiplier_spacing 2
}
if { [get_routing_rule ndr_2w2s_manual -quiet] == "" } {
    create_routing_rule ndr_2w2s_manual -default_reference_rule \
        -widths { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
        -spacings { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
        -spacing_weight_levels { M1 {medium} M2 {medium} M3 {medium} M4 {medium} M5 {hard} M6 {hard} M7 {hard} M8 {hard} M9 {medium} }
}
set all_master_clocks [get_clocks -filter "is_virtual==false&&is_generated==false"]
set all_real_clocks [get_clocks -filter "is_virtual==false"]
set_clock_routing_rules -min_routing_layer M5 -max_routing_layer M8 -clocks $all_master_clocks -rules ndr_2w2s_manual

### post cts app option
set_app_options -name clock_opt.flow.enable_ccd -value false
set_app_options -name clock_opt.hold.effort -value high
set_app_options -name clock_opt.place.congestion_effort -value high
set_app_options -name clock_opt.place.effort -value high
set_app_options -name opt.common.user_instance_name_prefix -value "CLKOPT_"
set_app_options -name cts.common.user_instance_name_prefix -value "CCDOPT_"

### run clock opt
clock_opt -from final_opto -to final_opto

### connect pg
connect_pg_net -all_blocks -automatic

### save
save_block
save_lib -all

### report
set reports_dir "./reports/${current_step}"
file mkdir $reports_dir
check_legality -verbose > ${reports_dir}/check_legality.rpt
check_mv_design > ${reports_dir}/check_mv_design.rpt
report_qor -summary -significant_digits 4 > ${reports_dir}/report_qor.summary.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -path_type full_clock_expanded -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.full.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.data.rpt
foreach_in_col scenario [all_scenario] {
    set sce_name [get_att $scenario name]
    report_constraints -scenarios $sce_name -max_transition -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_transition.${sce_name}.rpt
    report_constraints -scenarios $sce_name -max_capacitance -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_capacitance.${sce_name}.rpt
}

### how to fix remained setup
# a) bound startpoint and endpoint together
# b) launch clock - 150
# c) capture clock + 150
# d) enable ccd

### exit
#quit!
