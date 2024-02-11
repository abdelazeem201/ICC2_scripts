############################################################
# floorplan_details.tcl : Write out information about the
#                         floorplan
############################################################
# (c) Synopsys 2017
############################################################

set boundary [get_attribute [get_designs] boundary]
set core_area_boundary [get_attribute [get_designs] core_area_boundary]
foreach i $core_area_boundary {
    set core_area_bbox [get_attribute [get_designs]  core_area_bbox]
    set a  [lindex $core_area_bbox 00]
    if { $a == $i } {
        set int [lsearch -integer $core_area_boundary $a]
        set new_list ""
        set pointer $int
        while {$pointer > -1} {
            lappend new_list [lindex $core_area_boundary $pointer]
            set pointer [expr $pointer - 1]
        }
        set pointer [llength  $core_area_boundary ]
        set pointer [expr $pointer - 1]
        while {$pointer > 2} {
            lappend new_list [lindex $core_area_boundary $pointer]
            set pointer [expr $pointer - 1]
        }
    }
}
set pointer [llength  $core_area_boundary ]
set core_offset_list ""
for {set x 0} {$x<$pointer} {incr x} {
    set b [expr $x % 2]
    if {$b == 0} {
        set y0 [ lindex $new_list $x 1 ]
        set y1 [ lindex $boundary $x 1 ]
        set sub0 [expr $y0 - $y1]
        set value0 [expr {abs($sub0)}]
        lappend core_offset_list $value0
    }
    if {$b != 0} {
        set x0 [ lindex $new_list $x 0 ]
        set x1 [ lindex $boundary $x 0 ]
        set sub1 [expr $x0 - $x1]
        set value1 [expr {abs($sub1)}]
        lappend core_offset_list $value1
    }
}
set pointer [llength  $boundary ]
set side_length_list ""
for {set y 0} {$y<$pointer} {incr y} {
    set  b1 [expr $y + 1]
    set llx [ lindex $boundary $y 0 ]
    set lly [ lindex $boundary $y 1 ]
    set urx [ lindex $boundary $b1 0 ]
    set ury [ lindex $boundary $b1 1 ]
    if {$llx == $urx} {
        set side0 [ expr $ury - $lly ]
        set value2 [expr {abs($side0)}]
        lappend side_length_list $value2
    }
    if {$lly == $ury} {
        set side1 [ expr $urx - $llx ]
        set value3 [expr {abs($side1)}]
        lappend side_length_list $value3
    }
}
set m [expr $pointer - $pointer]
set n [expr $pointer - 1]
set llx [ lindex $boundary $m 0 ]
set lly [ lindex $boundary $m 1 ]
set urx [ lindex $boundary $n 0 ]
set ury [ lindex $boundary $n 1 ]
if {$llx == $urx} {
    set side0 [ expr $ury - $lly ]
    set value2 [expr {abs($side0)}]
    lappend side_length_list $value2
}
if {$lly == $ury} {
    set side1 [ expr $urx - $llx ]
    set value3 [expr {abs($side1)}]
    lappend side_length_list $value3
}
puts "#######Starting From  Origin########"
puts "Boundary for design :"
puts "\t\t$boundary"
puts "Side lengths of design :"
puts "\t\t$side_length_list"
puts "Core_offset values :"
puts "\t\t$core_offset_list"
