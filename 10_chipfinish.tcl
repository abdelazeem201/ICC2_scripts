##################################################################
### Function : Chip Finishing
### Author   : Ahmed Abdelazeem
##################################################################
### load setting
source scripts/00_common_initial_settings.tcl

### variables
set current_step "10_chipfinish"
set last_step    "09_routeopt"

### open database
file delete -force nlib/ORCA_TOP_${current_step}.nlib
copy_lib -from_lib nlib/ORCA_TOP_${last_step}.nlib -to_lib nlib/ORCA_TOP_${current_step}.nlib -force
current_lib ORCA_TOP_${current_step}.nlib
open_block ORCA_TOP

### initialize setting
source scripts/initialization_settings.tcl

### reset upf
reset_upf
load_upf data/ORCA_TOP.upf
commit_upf

#### scenario setup
#set scenarios_list $routeopt_scenarios
#source scripts/scenarios_setup.tcl
#foreach scenario [get_att [all_scenarios] name] {
#    echo "YFT-Information: Setting propagated clock on scenario $scenario"
#    current_scenario $scenario
#    set_propagated_clock [get_clocks -filter "is_virtual==false"]
#}

### routing layer
set_ignored_layers -min_routing_layer M1 -max_routing_layer M9

### insert decap/filler
create_stdcell_fillers -lib_cells $fillers_ref -continue_on_error

#create_stdcell_fillers -lib_cells $decaps_ref -continue_on_error
#remove_stdcell_fillers_with_violation
#route_eco
#create_stdcell_fillers -lib_cells $fillers_ref -continue_on_error

### connect pg
connect_pg_net -all_blocks -automatic

### save
save_block
save_lib -all

foreach mode [get_object_name [all_modes]] {
    write_sdc -mode $mode -nosplit -compress gzip -exclude {annotation clock_gating_check clock_latency clock_latency_2 clock_transition clock_uncertainty drive_info ideal_network path_group pvt pvt_dynamic timing_derate} -output ./data/${design}.${mode}.sdc
}

### write data
# gds/oasis
set gds_file "data/${design}_${current_step}.gds"
if { [get_routing_blockages * -quiet] != "" } {
    remove_routing_blockages *
}
set_app_options -name file.gds.contact_prefix -value "${design}_"
write_gds -long_names -design $design -hierarchy design_lib -compress -lib_cell_view frame -keep_data_type -fill exclude $gds_file

set oasis_file "data/${design}_${current_step}.oasis"
set_app_options -name file.oasis.contact_prefix -value "${design}_"
write_oasis -design $design -hierarchy design_lib -compress 9 -lib_cell_view frame -keep_data_type -fill exclude $oasis_file

# netlist
define_name_rules -map verilog_name_rule {{"MACRO","SRAM"},{"CGK","CLOCK_GATING"}}
change_names -rules verilog_name_rule
set netlist_name "data/${design}_${current_step}.v.gz"
write_verilog -compress gzip $netlist_name -exclude {all_physical_cells analog_pg corner_cells cover_cells diode_cells empty_modules end_cap_cells physical_only_cells filler_cells pg_objects well_tap_cells leaf_module_declarations}

# lvs netlist
set lvs_netlist "data/${design}_${current_step}.lvs.v.gz"
#write_verilog -compress gzip $lvs_netlist -exclude {empty_modules end_cap_cells well_tap_cells supply_statements}
write_verilog -compress gzip $lvs_netlist -exclude {empty_modules end_cap_cells well_tap_cells}

# def
set def_name "data/${design}_${current_step}.def.gz"
write_def -design $design -compress gzip -include_tech_via_definitions -include {blockages bounds cells nets ports routing_rules rows_tracks specialnets vias} $def_name

# lef
set lef_name "data/${design}_${current_step}.lef"
# create_frame
create_frame -block_all auto -hierarchical true -merge_metal_blockage true
# write_lef
write_lef -design ${design}.frame $lef_name -include cell

set techlef_name "data/${design}_${current_step}.tlef"
write_lef -design ${design}.frame $techlef_name -include tech

### exit
