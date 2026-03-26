library(openxlsx)
library(ape)
library(phytools)
library(BioGeoBEARS)
library(rentrez) # Fetching full records: entrez_fetch()

sourceall("/GitHub/str2phy/Rsrc/")
source("/GitHub/str2phy/Rsrc/blast/blastR_setup/blastsequences_v4.R")

wd = "/GitHub/str2phy/ex/MitoCOGs/_03_foldmason_v2/"
setwd(wd)

fns = list.files(path=".", include.dirs=TRUE)
fns = fns[grepl(pattern="\\.", x=fns)==FALSE]  # remove files, leave dirs
fns

i=1

for (i in 1:length(fns))
	{
	tmpwd = slashslash(paste0(wd, "/", fns[i]))
	setwd(tmpwd)
	
	file.rename(from="fmalign.fasta_3di.fasta", to="fmalign_3di.fasta")
	file.rename(from="fmalign.fasta_aa.fasta", to="fmalign_aa.fasta")
	
	tmpfn = list.files(path=".", pattern="_fmalign_aa3di.fasta")
	file.copy(from=tmpfn, to="fmalign_aa3di.fasta")
	}