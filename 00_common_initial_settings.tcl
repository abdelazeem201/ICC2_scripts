##############################################################
# Common design settings
# Created by Yanfuti
##############################################################
### design information
set design "ORCA_TOP"

### design data directory
set datadir "/disk/hd01/data/proj/labs/share/ORCA_TOP"

### gate level netlist files
set import_netlists     ""
lappend import_netlists "/disk/hd01/data/proj/design/user/share/design/ORCA_TOP/ORCA_TOP.v"

### SDC files (to be added)

### UPF files
set golden_upf "/disk/hd01/data/proj/design/user/share/design/ORCA_TOP/ORCA_TOP.upf"

### tech files
set synopsys_tech_tf "/data/proj/library/SAED32nm/tech/milkyway/saed32nm_1p9m_mw.v10.tf"

### scandef
set scandef_file "/disk/hd01/data/proj/design/user/share/design/ORCA_TOP/ORCA_TOP.scandef"

### library files
set ndm_files ""
lappend ndm_files "/data/proj/library/SAED32nm/lib/bumps/ndm/bumps.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/sram_lp/ndm/saed32_sram_lp.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_hvt/ndm/saed32_hvt.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_hvt/ndm/saed32_hvt_lsdn.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_hvt/ndm/saed32_hvt_lsup.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_hvt/ndm/saed32_hvt_pg.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_lvt/ndm/saed32_lvt.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_lvt/ndm/saed32_lvt_lsdn.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_lvt/ndm/saed32_lvt_lsup.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_lvt/ndm/saed32_lvt_pg.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_rvt/ndm/saed32_rvt.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_rvt/ndm/saed32_rvt_lsdn.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_rvt/ndm/saed32_rvt_lsup.ndm"
lappend ndm_files "/data/proj/library/SAED32nm/lib/stdcell_rvt/ndm/saed32_rvt_pg.ndm"

set lef_files ""
lappend lef_files "/data/proj/library/SAED32nm/lib/io_sp/lef/saed32io_sp_fc.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/io_sp/lef/saed32io_sp_wb.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/io_std/lef/saed32_io_fc_all.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/io_std/lef/saed32_io_wb_all.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/pll/lef/saed32_PLL.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM16x128.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM22x32.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM32x256_1rw.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM32x64.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM39x32.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM4x32.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM8x1024_1rw.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/ram_des/lef/SRAM8x64.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/sram/lef/saed32sram.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/sram_lp/lef/saed32sram.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/stdcell_lvt/lef/saed32nm_lvt_1p9m.lef"
lappend lef_files "/data/proj/library/SAED32nm/lib/stdcell_rvt/lef/saed32nm_rvt_1p9m.lef"

### PEX tech
set starrc_tech(cmax)       "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_Cmax.nxtgrd"
set starrc_tech(cmin)       "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_Cmin.nxtgrd"
set starrc_tech(nominal)    "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_nominal.nxtgrd"
set icc2rc_tech(cmax)       "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"
set icc2rc_tech(cmin)       "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"
set icc2rc_tech(nominal)    "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_1p9m_nominal.tluplus"
set itf_tluplus_map         "/data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_tf_itf_tluplus.map"

### scenarios of each step
set default_scenarios  "func_ss0p75v125c_cmax"
set placeopt_scenarios "func_ss0p75v125c_cmax test_ss0p75v125c_cmax"
set cts_scenarios      "cts_ss0p75v125c_cmax"
set clockopt_scenarios "func_ss0p75v125c_cmax test_ss0p75v125c_cmax func_ff0p95vm40c_cmin test_ff0p95v125c_cmin"
set routeopt_scenarios "func_ss0p75v125c_cmax test_ss0p75v125c_cmax func_ff0p95vm40c_cmin test_ff0p95v125c_cmin"

### cells type settings
set fillers_ref     "*/SHFILL128_HVT */SHFILL64_HVT */SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set endcap_left     "*/SHFILL2_HVT"
set endcap_right    "*/SHFILL2_HVT"
set endcap_top      "*/SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set endcap_bottom   "*/SHFILL3_HVT */SHFILL2_HVT */SHFILL1_HVT"
set tapcell_ref     "*/SHFILL3_HVT"

### nlib data dir
set nlib_dir "./nlib"

##############################################################
# END
##############################################################
