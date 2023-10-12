
set synospsy_tech "/data/proj/library/SAED32nm/tech/milkyway/saed32nm_1p9m_mw.v10.tf"

### create workspace
create_workspace -technology $synospsy_tech -flow frame readndmlib

read_lef /data/proj/library/SAED32nm/lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef

check_workspace
commit_workspace

/data/proj/library/SAED32nm/lib/stdcell_hvt/ndm/saed32_hvt_std.ndm/
