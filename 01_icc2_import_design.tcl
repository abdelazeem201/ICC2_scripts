##############################################################
# Function: read gate level netlist into ICC2
# Created by Yanfuti
##############################################################
source scripts/00_common_initial_settings.tcl

### variables
set current_step "01_import_design"

### create nlib
file mkdir $nlib_dir
file delete -force $nlib_dir/${design}_01_import.nlib
create_lib -technology $synopsys_tech_tf -ref_libs $ndm_files $nlib_dir/${design}_01_import.nlib

### read verilog
read_verilog -library ${design}_01_import.nlib -design ${design} -top $design $import_netlists
link_block
report_design_mismatch -verbose
get_cells -hierarchical -filter is_unbound
### initialization script
source scripts/initialization_settings.tcl

### load upf
set_app_options -name mv.upf.enable_golden_upf -value true
reset_upf
load_upf $golden_upf
commit_upf

### connect pg
connect_pg_net -automatic

### save design
save_block
save_lib

### exit icc2
#quit!

##############################################################
# END
##############################################################
