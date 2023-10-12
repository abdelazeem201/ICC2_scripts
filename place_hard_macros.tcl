################################################################################
#
# Created by icc2 write_floorplan on Sun Nov 22 17:07:13 2020
#
################################################################################


set _dirName__0 [file dirname [file normalize [info script]]]

################################################################################
# Cells
################################################################################

set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_8 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 162.1520 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_7 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 87.3330 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_6 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_5 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 915.5280 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 840.7090 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 765.8900 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 691.0710 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_READ_FIFO/PCI_FIFO_RAM_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 919.7860 616.2520 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_8 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 830.4770 915.5280 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_7 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 830.4770 840.7090 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_6 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 830.4770 765.8900 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_5 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 830.4770 691.0710 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 830.4770 616.2520 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 834.7280 162.1520 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 834.7280 87.3330 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_PCI_TOP/I_PCI_WRITE_FIFO/PCI_FIFO_RAM_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 834.7280 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_0_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 274.1890 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_0_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 274.1890 114.8310 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_0_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 274.1890 217.1480 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_0_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 274.1890 319.4650 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_1_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 187.1330 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_1_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 187.1330 114.8310 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_1_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 187.1330 217.1480 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_1_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 187.1330 319.4650 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_2_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 100.0770 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_2_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 100.0770 114.8310 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_2_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 100.0770 217.1480 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_2_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 100.0770 319.4650 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_3_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 13.0210 12.5140 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_3_2 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 13.0210 114.8310 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_3_3 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 13.0210 217.1480 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_CONTEXT_MEM/I_CONTEXT_RAM_3_4 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 13.0210 319.4650 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_RISC_CORE/I_REG_FILE/REG_FILE_D_RAM }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 242.7540 833.1940 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_RISC_CORE/I_REG_FILE/REG_FILE_C_RAM }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 135.1240 833.1940 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_RISC_CORE/I_REG_FILE/REG_FILE_B_RAM }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 27.4940 833.1940 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_RISC_CORE/I_REG_FILE/REG_FILE_A_RAM }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 350.3840 833.1940 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_SDRAM_TOP/I_SDRAM_READ_FIFO/SD_FIFO_RAM_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 516.9950 745.4030 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_SDRAM_TOP/I_SDRAM_READ_FIFO/SD_FIFO_RAM_0 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 669.4560 745.4030 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_SDRAM_TOP/I_SDRAM_WRITE_FIFO/SD_FIFO_RAM_1 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 516.9950 872.8750 }
set_attribute -quiet -objects $cellInst -name status -value placed


set cellInst [get_cells { I_SDRAM_TOP/I_SDRAM_WRITE_FIFO/SD_FIFO_RAM_0 }]
set_attribute -quiet -objects $cellInst -name orientation -value R0
set_attribute -quiet -objects $cellInst -name origin -value { 669.4560 872.8750 }
set_attribute -quiet -objects $cellInst -name status -value placed



