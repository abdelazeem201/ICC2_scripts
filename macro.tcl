# Script to Create Equivalent Placement Blockages for All Macro Keepout Blockages


# Script Documentation

# The following script creates placement blockages that are equivalent to the areas blocked by macro keepouts. Either soft or hard blockage can be duplicated.

# This script helps in writing Tcl code that can more easily determine whether a specific location is blocked. Without this script, you would have to search all nearby locations for macros, check if they have keepout blockages, and calculate whether that keepout blockage extends to cover the location of interest.

# Covering all macro keepouts with blockages makes finding a legal standard cell location much simpler.

# For usage information, enter the following command after sourcing the script:

#   gen_macro_keepout_equiv_blockage -help

#####################################################################################################################################

proc gen_macro_keepout_equiv_blockage {args} {

    parse_proc_arguments -args $args results

    set verbose [info exists results(-verbose)]

    ## blockage_type
    if {[info exists results(-blockage_type)]} {
	set blockage_type $results(-blockage_type)
    } else {
	set blockage_type hard
    }

    ## keepout_blockage_file
    if {[info exists results(-keepout_blockage_file)]} {
	set keepout_blockage_file $results(-keepout_blockage_file)
    } else {
	set keepout_blockage_file _KEEPOUT_TO_BLOCKAGE.tcl
    }

    ## blockage_prefix
    if {[info exists results(-blockage_prefix)]} {
	set blockage_prefix $results(-blockage_prefix)
    } else {
	set blockage_prefix GEN_MACRO_KEEPOUT_BLOCKAGE
    }

    ## keepout_file
    if {[info exists results(-keepout_file)]} {
	set keepout_file $results(-keepout_file)
    } else {
	set keepout_file _delme_keepout.txt
    }

    set fh_to [open $keepout_blockage_file "w"]
    set macros [get_cells -filter "is_hard_macro==true&&is_hierarchical==false" -hierarchical]
    set cnt 0
    set index 0
    foreach_in_collection macro $macros {
      
      set found_keepout 0
      report_keepout_margin $macro -type $blockage_type > $keepout_file
      if {[file exists $keepout_file]} {
          set fh [open $keepout_file "r"] 
          fconfigure $fh -buffering line
          while {[gets $fh line] != -1} { 
	      if {[regexp {Keepout - ([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)\s+([\d\.]+)} $line match ko_l ko_b ko_r ko_t]} {
                set found_keepout 1
                break
            }
          }
          close $fh
      }
      if {$found_keepout} {
          set bbox [get_attribute $macro bbox]
          set ll [lindex $bbox 0]
          set ur [lindex $bbox 1]

          set llx [lindex $ll 0]
          set lly [lindex $ll 1]
          set urx [lindex $ur 0]
          set ury [lindex $ur 1]

          set llx [expr $llx - $ko_l]
          set lly [expr $lly - $ko_b]
          set urx [expr $urx + $ko_r]
          set ury [expr $ury + $ko_t]

	  set blockage "${blockage_prefix}${index}"
	  set existing_blockage [get_placement_blockages $blockage -quiet]
	  while {[sizeof_collection $existing_blockage]} {
	      incr index
	      set blockage "${blockage_prefix}${index}"
	      set existing_blockage [get_placement_blockages $blockage -quiet]
	  }
          set cmd "create_placement_blockage -bbox \"$llx $lly $urx $ury\" -type $blockage_type -name $blockage"
	  if {$verbose} {
	      puts $cmd
	  }
          puts $fh_to "$cmd ; # [get_object_name $macro]" 
          incr cnt
	  incr index
      }
    }
    close $fh_to
    puts "Created $cnt $blockage_type placement blockages equivalent to macro keepouts with prefix $blockage_prefix."
    puts "Saved in $keepout_blockage_file."
    source $keepout_blockage_file
    puts "sourced $keepout_blockage_file"
}

define_proc_attributes gen_macro_keepout_equiv_blockage \
    -info "Creates placement blockages equivalent to the macro keepouts. An equivalent script is also created." \
    -define_args { 
	{-help "Prints this message" "" boolean optional} 
	{-verbose "Turn on all messages" "" boolean optional} 
	{-blockage_type "Keepout blockage type to reproduce. Defaults to hard." 
           "blockage_type" one_of_string {optional value_help {values {hard soft}}}} 
	{-keepout_blockage_file "Name of created blockage file. Defaults to _KEEPOUT_TO_BLOCKAGE.tcl." 
           "keepout_blockage_file" string optional} 
	{-blockage_prefix "Prefix to use for created blockages. Defaults to GEN_MACRO_KEEPOUT_BLOCKAGE" 
           "blockage_prefix" string optional} 
	{-keepout_file "Name of temp file used for finding keepout blockages. \n\t\t\t\tDefaults to _delme_keepout.txt" 
           "keepout_file" string optional}}
