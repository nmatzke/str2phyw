
# Foldmason commands on alphafold cif files (structure + sequence)

library(openxlsx)
library(ape)
library(phytools)
library(BioGeoBEARS)
library(rentrez) # Fetching full records: entrez_fetch()

sourceall("/GitHub/str2phy/Rsrc/")
source("/GitHub/str2phy/Rsrc/blast/blastR_setup/blastsequences_v4.R")

wd = "/GitHub/str2phy/ex/MitoCOGs/_02_assembled_AFs_v2/"  # removed some non-aligning sequences
setwd(wd)





# Get the list of files for each mitocog
wd = "/GitHub/str2phy/ex/MitoCOGs/_03_foldmason_v2/"
setwd(wd)

structures_dir = "/GitHub/str2phy/ex/MitoCOGs/_02_assembled_AFs_v2/"
cif_fns = list.files(path=structures_dir, pattern="*.cif", full.names=FALSE, recursive=TRUE)
cif_fns = cif_fns[grepl(pattern="z_replaced_by_fixes", x=cif_fns) == FALSE]
cif_fns


mitocogs = sort(unique(firstwords(cif_fns, split="/")))
mitocogs


cmdstrs = NULL
i=1
for (i in 1:length(mitocogs))
	{
	txt_to_find = paste0(mitocogs[i], "/")
	TF = grepl(pattern=txt_to_find, x=cif_fns)
	
	cifs_for_phylo = cif_fns[TF]
	cifs_for_phylo = slashslash(paste0(structures_dir, "/", cifs_for_phylo))
	cifs_for_phylo
	
	cifs_for_phylo = gsub(pattern="/Users/nmat471/HD", replacement="", x=cifs_for_phylo, ignore.case=TRUE)
	cifs_for_phylo
	
	ciffns_txt = paste0(cifs_for_phylo, sep="", collapse=" ")
	ciffns_txt
	
	# https://github.com/steineggerlab/foldmason
	# foldmason easy-msa <PDB/mmCIF files> result.fasta tmpFolder --report-mode 1

		
	cmdstr = paste0("foldmason easy-msa ", ciffns_txt, " ./", mitocogs[i], "/fmalign.fasta ./", mitocogs[i], "/tmpFolder --report-mode 1")
	system(cmdstr)
	
	# 3di file
	fromtxt = paste0("./", mitocogs[i], "/fmalign.fasta_3di.fa")
	fn_3di = paste0("./", mitocogs[i], "/", mitocogs[i], "_", length(cifs_for_phylo), "_fmalign_3di.fasta")
	file.copy(from=fromtxt, to=fn_3di, overwrite=TRUE)
	
	to_txt = paste0("./", mitocogs[i], "/fmalign_3di.fasta")
	file.rename(from=fromtxt, to=to_txt)


	# AA file
	fromtxt = paste0("./", mitocogs[i], "/fmalign.fasta_aa.fa")
	fn_aa = paste0("./", mitocogs[i], "/", mitocogs[i], "_", length(cifs_for_phylo), "_fmalign_aa.fasta")
	file.copy(from=fromtxt, to=fn_aa, overwrite=TRUE)
	
	to_txt = paste0("./", mitocogs[i], "/fmalign_aa.fasta")
	file.rename(from=fromtxt, to=to_txt)

	# Horizontal and vertical concatenation
	outfn = gsub(pattern="_aa.fasta", replacement="_aa3di.fasta", x=fn_aa)
	outfn
	aa3di_alignment = hcat_fastas(fasta_fn1=fn_aa, fasta_fn2=fn_3di, outfn=outfn, type="AA")
	fn_aa3di = paste0("./", mitocogs[i], "/fmalign_aa3di.fasta")
	file.copy(from=outfn, to=fn_aa3di)

	outfn = gsub(pattern="_aa.fasta", replacement="_vcat.fasta", x=fn_aa)
	cmdstr = paste0("cat ", fn_aa, " ", fn_3di, " > ", outfn)
	system(cmdstr)
	} # END for (i in 1:length(mitocogs))




