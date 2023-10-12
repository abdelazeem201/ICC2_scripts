##############################################################
# Function: Design Planning "PowerPlanning"
# Created by Ahmed Abdelazeem
##############################################################
### load setting
source scripts/00_common_initial_settings.tcl

#### open database
#copy_lib -from_lib nlib/ORCA_TOP_02_floorplan.nlib -to_lib nlib/ORCA_TOP_03_power_routing.nlib -force
## try to use open_lib to open the newly copied nlib
#current_lib ORCA_TOP_03_power_routing.nlib
#open_block ORCA_TOP
#
#### initialize setting
#source scripts/initialization_settings.tcl
#
#### scenario setup
#source scripts/scenarios_setup.tcl
#
### connect pg
connect_pg_net -all_blocks -automatic

### remove before create
remove_pg_patterns -all
remove_pg_strategies -all
remove_pg_strategy_via_rules -all
remove_pg_via_master_rules -all
remove_pg_regions -all
remove_routes -net_types {power ground} -ring -stripe -macro_pin_connect -lib_cell_pin_connect

### pg region
set region_cnt 0
set macros_col [get_cells -physical_context -filter "is_hard_macro==true" -quiet]
set memory_risc [get_cells -physical_context -filter "is_hard_macro==true" I_RISC_CORE/*]
set memory_top [remove_from_col $macros_col $memory_risc]
foreach_in_col _macro $macros_col {
    set macro_bbox [get_att ${_macro} bbox]
    create_pg_region -polygon $macro_bbox MEMORY_REGION_${region_cnt}
    incr region_cnt
}

### basic pattern
set macro_pgregions [get_pg_regions *]
# rail pattern
create_pg_std_cell_conn_pattern pattern_pg_rail -layers M1 -rail_width {@w} -parameters {w}
set_pg_strategy strategy_pg_rail -voltage_areas DEFAULT_VA -pattern "{name : pattern_pg_rail} {nets : VDD VSS} {parameters : 0.06}" -blockage {{pg_regions : $macro_pgregions} {placement_blockages: all}}
compile_pg -strategies {strategy_pg_rail} -tag pg_rail

# stripe
create_pg_wire_pattern pattern_wire_based_on_track -direction @d -layer @l -width @w -spacing @s -pitch @p -parameters {d l w s p} -track_alignment track
create_pg_composite_pattern pattern_core_m6_mesh -net {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track}{nets : {VDD VSS}} {parameters: {vertical M6 0.224 0.112 6.72}}{offset : 0.1}}}
create_pg_composite_pattern pattern_core_m7_mesh -net {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track}{nets : {VDD VSS}} {parameters: {horizontal M7 0.224 0.112 6.72}}{offset : 0.1}}}
create_pg_composite_pattern pattern_core_m8_mesh -net {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track}{nets : {VDD VSS}} {parameters: {vertical M8 0.224 0.112 6.72}}{offset : 0.1}}}
create_pg_composite_pattern pattern_core_m9_mesh -net {VDD VSS} -add_patterns {{{pattern: pattern_wire_based_on_track}{nets : {VDD VSS}} {parameters: {horizontal M9 0.64 0.32 3.2}}{offset : 0.1}}}

set_pg_strategy strategy_m6_pg_mesh -pattern "{name :pattern_core_m6_mesh} {nets: VDD VSS}"  -voltage_areas DEFAULT_VA  -blockage {{pg_regions : $macro_pgregions} {placement_blockages: all}}
set_pg_strategy strategy_m7_pg_mesh -pattern "{name :pattern_core_m7_mesh} {nets: VDD VSS}"  -voltage_areas DEFAULT_VA  -blockage {{pg_regions : $macro_pgregions} {placement_blockages: all}}
set_pg_strategy strategy_m8_pg_mesh -pattern "{name :pattern_core_m8_mesh} {nets: VDD VSS}"  -voltage_areas DEFAULT_VA  -blockage {{pg_regions : $macro_pgregions} {placement_blockages: all}}
#set_pg_strategy strategy_m9_pg_mesh -pattern "{name :pattern_core_m9_mesh} {nets: VDD VSS}"  -voltage_areas DEFAULT_VA  -blockage {{pg_regions : $macro_pgregions} {placement_blockages: all}}
set_pg_strategy strategy_m9_pg_mesh -pattern "{name :pattern_core_m9_mesh} {nets: VDD VSS}"  -voltage_areas DEFAULT_VA 


### via rules
set_pg_strategy_via_rule via_pg_core -via_rule { \
{{{strategies: strategy_m9_pg_mesh} {layers: M9}} {{strategies: strategy_m8_pg_mesh} {layers: M8}} {via_master: default}} \
{{{strategies: strategy_m8_pg_mesh} {layers: M8}} {{strategies: strategy_m7_pg_mesh} {layers: M7}} {via_master: default}} \
{{{strategies: strategy_m7_pg_mesh} {layers: M7}} {{strategies: strategy_m6_pg_mesh} {layers: M6}} {via_master: default}} \
{{{existing: std_conn}}                           {{strategies: strategy_m6_pg_mesh} {layers: M6}} {via_master: default}} \
{{intersection: adjacent} {via_master: default}}
}

### macro ring connection
create_pg_ring_pattern pattern_memory_ring -horizontal_layer M5 -horizontal_width 1.0 -vertical_layer M6 -vertical_width 1.0 -corner_bridge false
set_pg_strategy strategy_memory_ring_top -macros $memory_top -pattern {{pattern: pattern_memory_ring} {nets: {VSS VDD}} {offset : {0.3 0.3}}}
set_pg_strategy_via_rule strategy_memory_ring_via -via_rule {
{{{strategies: strategy_memory_ring_top} {layers: M5}} {existing: strap} {via_master: default}} \
{{{strategies: strategy_memory_ring_top} {layers: M6}} {existing: strap} {via_master: default}} \
}

### macro pin connection
create_pg_macro_conn_pattern pattern_memory_pin -pin_conn_type scattered_pin -layers {M5 M6}
set_pg_strategy strap_top_pins -macros $memory_top -pattern {{pattern: pattern_memory_pin} {nets {VSS VDD}}}

### compile_pg
compile_pg -strategies {strategy_m6_pg_mesh strategy_m7_pg_mesh strategy_m8_pg_mesh strategy_m9_pg_mesh} -tag pg_stripes -ignore_via_drc -via_rule {via_pg_core}
compile_pg -strategies {strategy_memory_ring_top} -tag pg_ring -ignore_via_drc -via_rule {strategy_memory_ring_via}
compile_pg -strategies {strap_top_pins} -tag macro_pins -ignore_via_drc

#### to be done : voltage area 'PD_RISC_CORE'
#### macro ring connection
#create_pg_ring_pattern pattern_memory_ring -horizontal_layer M5 -horizontal_width 1.0 -vertical_layer M6 -vertical_width 1.0 -corner_bridge false
#set_pg_strategy strategy_memory_ring_risc -macros $memory_risc -pattern {{pattern: pattern_memory_ring} {nets: {VSS VDDH}} {offset : {0.3 0.3}}}
#set_pg_strategy_via_rule strategy_memory_ring_via -via_rule {
#{{{strategies: strategy_memory_ring_risc} {layers: M5}} {existing: strap} {via_master: default}} \
#{{{strategies: strategy_memory_ring_risc} {layers: M6}} {existing: strap} {via_master: default}} \
#}
#create_pg_macro_conn_pattern pattern_memory_pin -pin_conn_type scattered_pin -layers {M5 M4}
#set_pg_strategy strap_risc_pins -macros $memory_risc -pattern {{pattern: pattern_memory_pin} {nets {VSS VDDH}}}
#compile_pg -strategies {strategy_memory_ring_risc strap_risc_pins} -tag macro_pins -ignore_via_drc


### save design
save_block
save_lib -all

