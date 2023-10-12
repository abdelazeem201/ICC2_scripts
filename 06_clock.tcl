##############################################################
# Function: Clock Tree Synthesis
# Created by Ahmed Abdelazeem
##############################################################
### load setting
source scripts/00_common_initial_settings.tcl

### variables
set current_step "06_clock"
set scenarios_list $cts_scenarios

### open database
file delete -force nlib/ORCA_TOP_${current_step}.nlib
copy_lib -from_lib nlib/ORCA_TOP_04_placeopt_finished.nlib -to_lib nlib/ORCA_TOP_${current_step}.nlib -force
current_lib ORCA_TOP_${current_step}.nlib
open_block ORCA_TOP

### initialize setting
source scripts/initialization_settings.tcl

### reset upf
reset_upf
load_upf data/ORCA_TOP.upf
commit_upf

### scenario setup
source scripts/scenarios_setup.tcl

### set routing layer
set_ignored_layers -min_routing_layer M1 -max_routing_layer M9

### lib cell purpose (choose CTS cell)
set cts_cells "*/NBUFFX16_LVT */NBUFFX4_LVT */NBUFFX8_LVT */INVX16_LVT */INVX4_LVT */INVX8_LVT */*CG* */*DFF*"
set cts_cells_more "saed32_lvt|saed32_lvt_std/NBUFFX16_LVT saed32_lvt|saed32_lvt_std/NBUFFX2_LVT saed32_lvt|saed32_lvt_std/NBUFFX32_LVT saed32_lvt|saed32_lvt_std/NBUFFX4_LVT saed32_lvt|saed32_lvt_std/NBUFFX8_LVT saed32_rvt|saed32_rvt_std/NBUFFX16_RVT saed32_rvt|saed32_rvt_std/NBUFFX2_RVT saed32_rvt|saed32_rvt_std/NBUFFX32_RVT saed32_rvt|saed32_rvt_std/NBUFFX4_RVT saed32_rvt|saed32_rvt_std/NBUFFX8_RVT saed32_lvt|saed32_lvt_std/AOBUFX2_LVT saed32_lvt|saed32_lvt_std/AOBUFX4_LVT saed32_rvt|saed32_rvt_std/AOBUFX2_RVT saed32_rvt|saed32_rvt_std/AOBUFX4_RVT saed32_lvt|saed32_lvt_std/IBUFFX16_LVT saed32_lvt|saed32_lvt_std/IBUFFX2_LVT saed32_lvt|saed32_lvt_std/IBUFFX4_LVT saed32_lvt|saed32_lvt_std/IBUFFX8_LVT saed32_lvt|saed32_lvt_std/INVX0_LVT saed32_lvt|saed32_lvt_std/INVX16_LVT saed32_lvt|saed32_lvt_std/INVX2_LVT saed32_lvt|saed32_lvt_std/INVX4_LVT saed32_lvt|saed32_lvt_std/INVX8_LVT saed32_rvt|saed32_rvt_std/IBUFFX16_RVT saed32_rvt|saed32_rvt_std/IBUFFX2_RVT saed32_rvt|saed32_rvt_std/IBUFFX4_RVT saed32_rvt|saed32_rvt_std/IBUFFX8_RVT saed32_rvt|saed32_rvt_std/INVX0_RVT saed32_rvt|saed32_rvt_std/INVX16_RVT saed32_rvt|saed32_rvt_std/INVX2_RVT saed32_rvt|saed32_rvt_std/INVX4_RVT saed32_rvt|saed32_rvt_std/INVX8_RVT saed32_lvt|saed32_lvt_std/AOINVX4_LVT saed32_rvt|saed32_rvt_std/AOINVX4_RVT"

set_dont_touch [get_lib_cells $cts_cells] false
set_att [get_lib_cells $cts_cells] dont_use false
set_lib_cell_purpose -exclude cts [get_lib_cells */*]
set_lib_cell_purpose -include cts [get_lib_cells {*/*BUF* */*INV*}]

set all_master_clocks [get_clocks -filter "is_virtual==false&&is_generated==false"]
set all_real_clocks [get_clocks -filter "is_virtual==false"]

### clock tree options
set_clock_tree_options -clocks [get_clocks $all_master_clocks] -target_skew 0.050
set_clock_tree_options -clocks [get_clocks $all_master_clocks] -target_latency 0.500

### CTS NDR (Non-Default-Rules)
create_routing_rule ndr_2w2s -default_reference_rule -multiplier_width 2 -multiplier_spacing 2
create_routing_rule ndr_2w2s_manual -default_reference_rule \
    -widths { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
    -spacings { M1 0.1 M2 0.112 M3 0.112 M4 0.112 M5 0.112 M6 0.112 M7 0.112 M8 0.112 M9 0.32 } \
    -spacing_weight_levels { M1 {medium} M2 {medium} M3 {medium} M4 {medium} M5 {hard} M6 {hard} M7 {hard} M8 {hard} M9 {medium} }
set_clock_routing_rules -min_routing_layer M5 -max_routing_layer M8 -clocks $all_master_clocks -rules ndr_2w2s_manual

### CTS app options
set_app_options -name cts.optimize.enable_local_skew -value true
set_app_options -name cts.compile.enable_local_skew -value true
set_app_options -name cts.compile.enable_global_route -value true
set_app_options -name clock_opt.flow.enable_ccd -value false
set_app_options -name cts.common.user_instance_name_prefix -value "CTS_"

### CTS DRV
set_max_transition -corners [current_corner] -clock_path 0.070 $all_real_clocks

set_clock_balance_points -modes [all_modes] -clock $all_real_clocks -delay 150 -balance_points I_SDRAM_TOP/I_SDRAM_IF/control_bus_reg[7]/CLK
set_clock_balance_points -modes [all_modes] -clock $all_real_clocks -delay -150 -balance_points I_SDRAM_TOP/I_SDRAM_IF/clk_gate_mega_shift_1_reg[0]/latch/CLK

### run CTS command
clock_opt -from build_clock -to route_clock
#synthesize_clock_trees
#synthesize_clock_trees -routed_clock_stage detail

### connect pg
connect_pg_net -all_blocks -automatic

### save data
save_lib -all 

### get CTS reports
file mkdir reports/$current_step
report_clock_qor -type summary > reports/${current_step}/report_clock_qor.summary.rpt
foreach_in_col clk $all_real_clocks {
    set clk_name [get_object_name ${clk}]
    report_clock_qor -clock $clk_name -type latency > reports/${current_step}/report_clock_qor.${clk_name}.latency.rpt
    report_clock_qor -clock $clk_name -type local_skew -largest 1000 > reports/${current_step}/report_clock_qor.${clk_name}.local_skew.rpt
}

foreach_in_col scenario [all_scenario] {
    set sce_name [get_att $scenario name]
    report_constraints -scenarios $sce_name -max_transition -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_transition.${sce_name}.rpt
    report_constraints -scenarios $sce_name -max_capacitance -all_violators -significant_digits 3 -verbose > reports/${current_step}/report_constraints.max_capacitance.${sce_name}.rpt
}

### quit
#quit!
