### initialization settings for icc2
## time unit needs to match with SDC
set_user_units -type time -value 1ns

set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true

### what if this is not set
set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8 MRDL}] routing_direction vertical
get_attribute [get_layers M?] routing_direction

set_ignored_layers -min_routing_layer M1 -max_routing_layer M8
set_message_info -id LGL-003 -limit 10

#************************************************************
# Timer Settings:
# Delay Calculation Style:                   auto
# Signal Integrity Analysis:                 disabled
# Timing Window Analysis:                    disabled
# Advanced Waveform Propagation:             disabled
# Variation Type:                            fixed_derate
# Clock Reconvergence Pessimism Removal:     disabled
# Advanced Receiver Model:                   disabled
#************************************************************
