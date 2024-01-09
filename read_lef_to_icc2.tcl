
set synospsy_tech "/data/proj/library/SAED32nm/tech/milkyway/saed32nm_1p9m_mw.v10.tf"

### create workspace
create_workspace -technology $synospsy_tech -flow exploration readndmlib

set_pvt_configuration -voltage {0.95 1.16} -temperatures {125 -40}
read_dc [glob ./libs/DB/*.db]
read_lef /data/proj/library/SAED32nm/lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef

group_libs
process_workspaces

check_workspace
commit_workspace


