
set output_file "scripts/ORCA_TOP.link_path_per_instance.tcl"
set fileid [open $output_file w]

puts $fileid "set link_path_per_instance \[list \\"

foreach_in_collection cell [get_cells * -hierarchical -filter "is_hierarchical==false"] {
    set cell_name [get_object_name $cell]
    # I_RISC_CORE/I_REG_FILE/REG_FILE_D_RAM
    if { [regexp {UPF_LS} $cell_name] } {
        continue
    }
    set org_lib_name [get_object_name [get_libs -of [get_lib_cells -of [get_cells $cell_name]]]]
    if { [regexp {I_RISC_CORE} $cell_name] } {
        set new_lib_name [regsub -all {0p75v} $org_lib_name {0p95v}]
    } else {
        set new_lib_name $org_lib_name
    }
    if { [get_libs $new_lib_name -quiet] != "" } {
        puts $fileid "\[list \{$cell_name\} \{\* ${new_lib_name}.db\}\] \\" 
    } else {
        puts "CDF-Information: Failed to find lib $new_lib_name for instance $cell_name"
        continue
    }
}

puts $fileid "\]"
close $fileid
