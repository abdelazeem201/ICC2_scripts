# Step 1: Create a New Model
dc_shell-topo> create_qtm_model BB

# Step 2: Specify Technology Information
dc_shell-topo> set_qtm_technology -library library_name
dc_shell-topo> set_qtm_technology -max_transition trans_value
dc_shell-topo> set_qtm_technology -max_capacitance cap_value

# Step 3: Specify Global Parameters
dc_shell-topo> set_qtm_global_parameter -param setup -value setup_value
dc_shell-topo> set_qtm_global_parameter -param hold -value hold_value
dc_shell-topo> set_qtm_global_parameter -param clk_to_output -value cto_value

# Step 4: Specify Ports
dc_shell-topo> create_qtm_port -type input A
dc_shell-topo> create_qtm_port -type input B
dc_shell-topo> create_qtm_port -type output OP

# Step 5: Specify Delay Arcs
dc_shell-topo> create_qtm_delay_arc -name A_OP_R -from A -from_edge rise -to OP -value 0.10 -to_edge rise
dc_shell-topo> create_qtm_delay_arc -name A_OP_F -from A -from_edge fall -to OP -value 0.11 -to_edge fall
dc_shell-topo> create_qtm_delay_arc -name B_OP_R -from B -from_edge rise -to OP -value 0.15 -to_edge rise
dc_shell-topo> create_qtm_delay_arc -name B_OP_F -from B -from_edge fall -to OP -value 0.16 -to_edge fall

# Step 6: (Optional) Generate a Report
dc_shell-topo> report_qtm_model

# Step 7: Save the QTM
dc_shell-topo> save_qtm_model

# Step 8: Write Out .db File
dc_shell-topo> write_qtm_model -out_dir QTM

# Step 9: Add .db File to Link Library
dc_shell-topo> lappend link_library "QTM/BB.db"
