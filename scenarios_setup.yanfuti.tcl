source $datadir/constraints/ORCA_TOP_port_lists.tcl

remove_scenarios -all
remove_corners -all
remove_modes -all 

### create modes, corners and scenarios : check errors
## func_ss0p75v125c_cmax
if { [get_scenarios func_ss0p75v125c_cmax -quiet] == "" && [info exists scenarios_list] && [lsearch $scenarios_list "func_ss0p75v125c_cmax"] != -1 } {
    if { [get_modes func -quiet] == "" } {
        create_mode func
    } 
    if { [get_corner ss0p75v125c_cmax -quiet] == "" } {
        create_corner ss0p75v125c_cmax
    }
    create_scenario -mode func -corner ss0p75v125c_cmax -name func_ss0p75v125c_cmax
    current_scenario func_ss0p75v125c_cmax
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmax) -name maxTLU
    remove_sdc -scenarios [current_scenario]
    source $datadir/constraints/ORCA_TOP_m_func.tcl
    source $datadir/constraints/ORCA_TOP_c_ss_125c.tcl
    source $datadir/constraints/ORCA_TOP_s_func.ss_125c.tcl
    # set clock uncertainty
    if { [regexp {place} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.300 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.200 [get_clocks SDRAM_CLK]
    } elseif { [regexp {clock} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.100 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.300 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.100 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.200 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.100 [get_clocks SDRAM_CLK]
    } elseif { [regexp {route} $current_step] } {
        set_clock_uncertainty -setup 0.200 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.100 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.300 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.100 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.200 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.100 [get_clocks SDRAM_CLK]
    }
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 150 [current_design]
    set_scenario_status func_ss0p75v125c_cmax -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false
}

## test_ss0p75v125c_cmax
if { [get_scenarios test_ss0p75v125c_cmax -quiet] == "" && [info exists scenarios_list] && [lsearch $scenarios_list "test_ss0p75v125c_cmax"] != -1 } {
    if { [get_modes test -quiet] == "" } {
        create_mode test
    } 
    if { [get_corner ss0p75v125c_cmax -quiet] == "" } {
        create_corner ss0p75v125c_cmax
    }
    create_scenario -mode test -corner ss0p75v125c_cmax -name test_ss0p75v125c_cmax
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmax) -name maxTLU
    current_scenario test_ss0p75v125c_cmax
    source $datadir/constraints/ORCA_TOP_m_test.tcl
    source $datadir/constraints/ORCA_TOP_c_ss_125c.tcl
    source $datadir/constraints/ORCA_TOP_s_test.ss_125c.tcl
    # set clock uncertainty
    if { [regexp {place} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
    } elseif { [regexp {clock} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
        set_clock_uncertainty -hold  0.2 [get_clocks ate_clk]
    } elseif { [regexp {route} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
        set_clock_uncertainty -hold  0.2 [get_clocks ate_clk]
    }
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 150 [current_design]
    set_scenario_status test_ss0p75v125c_cmax -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false
}

## func_ff0p95v125c_cmin
if { [get_scenarios func_ff0p95vm40c_cmin -quiet] == "" && [info exists scenarios_list] && [lsearch $scenarios_list "func_ff0p95vm40c_cmin"] != -1 } {
    if { [get_modes func -quiet] == "" } {
        create_mode func
    } 
    if { [get_corner ff0p95vm40c_cmin -quiet] == "" } {
        create_corner ff0p95vm40c_cmin
    }
    create_scenario -mode func -corner ff0p95vm40c_cmin -name func_ff0p95vm40c_cmin
    current_scenario func_ff0p95vm40c_cmin
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmin) -name minTLU
    source $datadir/constraints/ORCA_TOP_m_func.tcl
    source $datadir/constraints/ORCA_TOP_c_ss_m40c.tcl
    source $datadir/constraints/ORCA_TOP_s_func.ss_m40c.tcl
    # set clock uncertainty
    if { [regexp {place} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
    } elseif { [regexp {clock} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
    } elseif { [regexp {route} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
    }
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 150 [current_design]
    set_scenario_status func_ff0p95vm40c_cmin -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false
}

## test_ff0p95v125c_cmin
if { [get_scenarios test_ff0p95v125c_cmin -quiet] == "" && [info exists scenarios_list] && [lsearch $scenarios_list "test_ff0p95v125c_cmin"] != -1 } {
    if { [get_modes test -quiet] == "" } {
        create_mode test
    } 
    if { [get_corner ff0p95v125c_cmin -quiet] == "" } {
        create_corner ff0p95v125c_cmin
    }
    create_scenario -mode test -corner ff0p95v125c_cmin -name test_ff0p95v125c_cmin
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmin) -name minTLU
    current_scenario test_ff0p95v125c_cmin
    source $datadir/constraints/ORCA_TOP_m_test.tcl
    source $datadir/constraints/ORCA_TOP_c_ss_125c.tcl
    source $datadir/constraints/ORCA_TOP_s_test.ss_125c.tcl
    # set clock uncertainty
    if { [regexp {place} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
    } elseif { [regexp {clock} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
        set_clock_uncertainty -hold  0.2 [get_clocks ate_clk]
    } elseif { [regexp {route} $current_step] } {
        set_clock_uncertainty -setup 0.2 [get_clocks SYS_*]
        set_clock_uncertainty -hold  0.1 [get_clocks SYS_*]
        set_clock_uncertainty -setup 0.3 [get_clocks PCI_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks PCI_CLK]
        set_clock_uncertainty -setup 0.2 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -hold  0.1 [get_clocks SDRAM_CLK]
        set_clock_uncertainty -setup 0.3 [get_clocks ate_clk]
        set_clock_uncertainty -hold  0.2 [get_clocks ate_clk]
    }
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 150 [current_design]
    set_scenario_status test_ff0p95v125c_cmin -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false
}

## cts_ss0p75v125c_cmax
if { [get_scenarios cts_ss0p75v125c_cmax -quiet] == "" && [info exists scenarios_list] && [lsearch $scenarios_list "cts_ss0p75v125c_cmax"] != -1 } {
    create_mode cts
    create_corner ss0p75v125c_cmax
    create_scenario -mode cts -corner ss0p75v125c_cmax -name cts_ss0p75v125c_cmax
    read_parasitic_tech -layermap $itf_tluplus_map -tlup $icc2rc_tech(cmax) -name maxTLU
    current_scenario cts_ss0p75v125c_cmax
    remove_sdc -scenarios [current_scenario]
    source $datadir/constraints/ORCA_TOP_m_cts.tcl
    source $datadir/constraints/ORCA_TOP_c_ss_125c.tcl
    source $datadir/constraints/ORCA_TOP_s_func.ss_125c.tcl
    set_max_transition 0.15 [get_clock *] -clock_path
    set_max_transition 0.25 [get_clock *] -data_path
    set_max_capacitance 150 [current_design]
    set_scenario_status cts_ss0p75v125c_cmax -active true -setup true -hold true -max_capacitance true -max_transition true -min_capacitance true -leakage_power false -dynamic_power false
}

