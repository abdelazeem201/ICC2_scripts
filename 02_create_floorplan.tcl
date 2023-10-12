
### load setting
source scripts/00_common_initial_settings.tcl

### open database
copy_lib -from_lib nlib/ORCA_TOP_01_import_design.nlib -to_lib nlib/ORCA_TOP_02_floorplan.nlib -force
# try to use open_lib to open the newly copied nlib
current_lib ORCA_TOP_02_floorplan.nlib
open_block ORCA_TOP

### initialize setting
source scripts/initialization_settings.tcl

### scenario setup
source scripts/scenarios_setup.tcl

### create floorplan
#initialize_floorplan -boundary {{0 0} {1000 1000}}
#initialize_floorplan -boundary {{0 0} {999.856 999.856}}
initialize_floorplan -boundary {{0 0} {999.856 999.856}} -core_offset {0 1.6720}

### place port
remove_individual_pin_constraints
set_individual_pin_constraints -ports [all_inputs] -allowed_layers {M5 M7} -sides 1 -offset {400 600}
#set_individual_pin_constraints -ports [all_outputs] -allowed_layers {M5 M7} -sides 3 -offset {400 600}
set_individual_pin_constraints -ports [all_outputs] -allowed_layers {M4 M6} -sides 2 -offset {400 600}
place_pins -self -ports [get_ports *]

### create voltage area
create_voltage_area -power_domains PD_RISC_CORE -guard_band {{10.032 10}} -region {{0.0000 642.0480} {489.1360 999.8560}}

### place hard macros && keepout (manully)
source scripts/place_hard_macros.tcl
# read_def macros.def
create_keepout_margin -outer {5 5 5 5} [get_flat_cells * -filter is_hard_macro==true]

### blockage (GUI)
create_placement_blockage -name pb_0 -type hard -boundary { {489.1360 980.3470} {999.8560 1001.5280} }
create_placement_blockage -name pb_1 -type allow_buffer_only -blocked_percentage 100 -boundary { {27.4940 833.1940} {438.0140 979.2190} }
create_placement_blockage -name pb_2 -type allow_buffer_only -blocked_percentage 100 -boundary { {13.0210 12.5140} {341.2450 411.7820} }
create_placement_blockage -name pb_3 -type allow_buffer_only -blocked_percentage 0 -boundary { {489.1360 745.7120} {999.8560 980.3470} }
create_placement_blockage -name pb_4 -type allow_buffer_only -blocked_percentage 0 -boundary { {830.4770 616.2520} {999.8560 745.7120} }

### boundary cell
remove_boundary_cell_rules -all
remove_cells [get_cells -physical_context *boundarycell* -quiet]
set_boundary_cell_rules -left_boundary_cell $endcap_left -right_boundary_cell $endcap_right -top_boundary_cell $endcap_top -bottom_boundary_cell $endcap_bottom
compile_boundary_cells -voltage_area "PD_RISC_CORE"
compile_boundary_cells -voltage_area "DEFAULT_VA"

### tap cell
create_tap_cells -lib_cell $tapcell_ref -pattern stagger -distance 75 -skip_fixed_cells -voltage_area PD_RISC_CORE
create_tap_cells -lib_cell $tapcell_ref -pattern stagger -distance 75 -skip_fixed_cells -voltage_area DEFAULT_VA

### connect pg
connect_pg_net -automatic 

### save & quit


