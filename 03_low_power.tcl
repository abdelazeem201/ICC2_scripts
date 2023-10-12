##############################################################
# Function: Low Power
# Created by Ahmed Abdelazeem
##############################################################

set lvl_buf_ref    "*/NBUFFX8_LVT"
set lvl_buf_prefix "USER_LS_BUF"

if { [get_bounds *_BOUND -quiet] != "" } {
    remove_bound [get_bounds *_BOUND -quiet]
}

set risc_lvl_cells ""
append_to_collection risc_lvl_cells [get_flat_cells I_RISC_CORE/*UPF_LS]
append_to_collection risc_lvl_cells [get_flat_cells I_RISC_CORE/${lvl_buf_prefix}_CELL*]
create_bound -name LS_PD_RISC_CORE_BOUND -boundary {{0.0000 642.0480} {489.1360 653.7520}} -type hard -exclusive $risc_lvl_cells

set top_lvl_cells [get_cells *UPF_LS]
create_bound -name LS_TOP_BOUND -boundary {{0.0000 615.2960} {488.3760 632.0160}} -type hard -exclusive $top_lvl_cells

set lvl_cell_name "Xecutng_Instrn[24]_UPF_LS"
set driver_pin [get_flat_pin -of [get_flat_nets -of [get_flat_pins $lvl_cell_name/A]] -filter "direction==out"]
add_buffer -lib_cell $lvl_buf_ref -new_net_names ${lvl_buf_prefix}_NET -new_cell_names ${lvl_buf_prefix}_CELL $driver_pin

set_dont_touch [get_flat_nets {n355}] true



