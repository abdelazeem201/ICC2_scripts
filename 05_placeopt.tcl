##############################################################
# Function: Placement
# Created by Ahmed Abdelazeem
##############################################################
### load setting
source scripts/00_common_initial_settings.tcl

### variables
set current_step "05_placeopt"
set scenarios_list $placeopt_scenarios

### open database
file delete -force nlib/ORCA_TOP_${current_step}.nlib
copy_lib -from_lib nlib/ORCA_TOP_03_pgrouting.nlib -to_lib nlib/ORCA_TOP_${current_step}.nlib -force
current_lib ORCA_TOP_${current_step}.nlib
open_block ORCA_TOP

### initialize setting
source scripts/initialization_settings.tcl

### scenario setup
source scripts/scenarios_setup.tcl

### opt cell selection : TIE
set_dont_touch [get_lib_cells */*TIE*] false
set_attribute [get_lib_cells */*TIE*] dont_use false
set_lib_cell_purpose -include {optimization} [get_lib_cells */*TIE*]

### routing layers
set_ignored_layers -min_routing_layer M1 -max_routing_layer M9

### app options
set_app_option -name opt.common.user_instance_name_prefix -value "POPT_"
set_app_option -name place_opt.final_place.effort -value "medium"
set_app_option -name place_opt.flow.clock_aware_placement -value "true"
set_app_option -name place_opt.flow.enable_ccd -value "false"
set_app_option -name place_opt.flow.estimate_clock_gate_latency -value "false"
set_app_option -name place_opt.flow.optimize_icgs -value "false"
set_app_option -name place_opt.flow.trial_clock_tree -value "false"
set_app_option -name place_opt.place.congestion_effort -value "high"

# auto density
set_app_option -name place.coarse.enhanced_auto_density_control -value "true"

# dont read scandef, set below to false
set_app_option -name place.coarse.continue_on_missing_scandef -value "false"

# manually control density
#set_app_option -name place.coarse.congestion_driven_max_util -value 0.70
#set_app_option -name place.coarse.max_density -value 0.50

set_app_option -name place.legalize.enable_advanced_legalizer -value "false"

set_app_option -name opt.area.effort -value "high"
set_app_option -name opt.common.enable_rde -value "high"
set_app_option -name opt.common.max_net_length -value "1000"
set_app_option -name opt.timing.effort -value "high"
set_app_option -name opt.tie_cell.max_fanout -value 8

### scandef
remove_scan_def
read_def $scandef_file

### group paths
#group_path -name reg2reg
#group_path -name reg2gating

### run placeopt
place_opt -from initial_place -to final_opto    ;# standard
#create_placement -effort high -timing_driven -buffering_aware_timing_driven -congestion -congestion_effort high
#place_opt -from initial_place -to initial_drc
#create_placement -effort high -congestion -congestion_effort high -incremental
#place_opt -from initial_drc

# initial_place
# initial_drc
# initial_opto
# final_place
# final_opto

### to be done : shrink core size to find out the area limitation

### connect pg
connect_pg_net -all_blocks -automatic 

### check & reports
set reports_dir "./reports/${current_step}"
file mkdir $reports_dir
check_legality -verbose > ${reports_dir}/check_legality.rpt
check_mv_design > ${reports_dir}/check_mv_design.rpt
report_qor -summary > ${reports_dir}/report_qor.summary.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -path_type full_clock_expanded -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.full.rpt
report_timing -nosplit -transition_time -capacitance -input_pins -nets -derate -delay_type max -voltage -significant_digits 4 -nworst 1 -physical -max_paths 100 > ${reports_dir}/report_timing.data.rpt
# create_utilization_configuration
report_utilization > ${reports_dir}/report_utilization.rpt
report_congestion > ${reports_dir}/report_congestion.rpt

### save & quit
