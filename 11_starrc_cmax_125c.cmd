LEF_FILE                :/data/proj/library/SAED32nm/tech/qrc/saed32nm_1p9m.tech.lef /data/proj/library/SAED32nm/lib/io_sp/lef/saed32io_sp_fc.lef /data/proj/library/SAED32nm/lib/io_sp/lef/saed32io_sp_wb.lef /data/proj/library/SAED32nm/lib/io_std/lef/saed32_io_fc_all.lef /data/proj/library/SAED32nm/lib/io_std/lef/saed32_io_wb_all.lef /data/proj/library/SAED32nm/lib/pll/lef/saed32_PLL.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM16x128.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM22x32.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM32x256_1rw.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM32x64.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM39x32.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM4x32.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM8x1024_1rw.lef /data/proj/library/SAED32nm/lib/ram_des/lef/SRAM8x64.lef /data/proj/library/SAED32nm/lib/sram/lef/saed32sram.lef /data/proj/library/SAED32nm/lib/sram_lp/lef/saed32sram.lef /data/proj/library/SAED32nm/lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef /data/proj/library/SAED32nm/lib/stdcell_lvt/lef/saed32nm_lvt_1p9m.lef /data/proj/library/SAED32nm/lib/stdcell_rvt/lef/saed32nm_rvt_1p9m.lef 
TOP_DEF_FILE            : data/ORCA_TOP_10_chipfinish.def.gz

BLOCK                   : ORCA_TOP
MAPPING_FILE            : /data/proj/library/SAED32nm/tech/star_rcxt/saed32nm_tf_itf_tluplus.map

NETLIST_FORMAT          : SPEF
NETLIST_FILE            : ORCA_TOP.spef

STAR_DIRECTORY          : ./run_starrc
EXTRACTION              : RC
COUPLE_TO_GROUND        : NO 

* extra options
NETLIST_COMPRESS_COMMAND: gzip -9f
LEF_USE_OBS             : YES
COUPLE_TO_GROUND        : NO
COUPLING_ABS_THRESHOLD  : 1e-16
COUPLING_REL_THRESHOLD  : 0.03
GROUND_CROSS_COUPLING   : NO
REMOVE_FLOATING_NETS    : YES
REMOVE_DANGLING_NETS    : YES
MERGE_VIAS_IN_ARRAY     : NO
EXTRACT_VIA_CAPS        : YES
NETLIST_NODE_SECTION    : YES
MAGNIFICATION_FACTOR    : 1.0
TRANSLATE_DEF_BLOCKAGE  :YES
NETLIST_CONNECT_OPENS   :*
REDUCTION_MAX_DELAY_ERROR: 0.1PS

SIMULTANEOUS_MULTI_CORNER: YES
CORNERS_FILE: scripts/corners.cmax.txt
SELECTED_CORNERS: cmax

