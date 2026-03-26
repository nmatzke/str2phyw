
library(openxlsx)
library(ape)
library(phytools)
library(BioGeoBEARS)
library(rentrez) # Fetching full records: entrez_fetch()

sourceall("/GitHub/str2phy/Rsrc/")
source("/GitHub/str2phy/Rsrc/blast/blastR_setup/blastsequences_v4.R")

wd = "/GitHub/str2phy/ex/MitoCOGs/_02_assembled_AFs_v2/"  # removed some non-aligning sequences
setwd(wd)

fastas_wd = "/GitHub/str2phy/ex/MitoCOGs/_03_foldmason_v2/"

#######################################################
# Make the 3di and AA unaligned files
#######################################################
cif_fns = list.files(path=".", pattern=".cif", full.names=TRUE, recursive=TRUE)
cif_fns
length(cif_fns) # 1872 # 1865

mitocogs = get_secondwords(OTUs=cif_fns, split="/")
table(mitocogs)

# Test
cif_fn = cif_fns[1]
tmp = structure_to_3di(structure_fn=cif_fn, suffix=".cif")

# Run through all
outfns_table = structures_to_3dis(structure_fns=cif_fns, suffix=".cif")
dim(outfns_table)

i = 1
uniq_mitocogs = unique(mitocogs)
aa_fns = NULL
di3_fns = NULL
for (i in 1:length(uniq_mitocogs))
	{
	mitocog = uniq_mitocogs[i]
	
	txt_to_search = paste0("/", mitocog, "/")
	TF = grepl(pattern=txt_to_search, x=cif_fns)
	cif_fns[TF]
	
	# Make a directory for each mitocog
	mitocog_dir = paste0("../_03_foldmason_v2/", mitocog)
	dir.create(path=mitocog_dir, showWarnings=FALSE)
	
	aa_fn = paste0(mitocog, "_", sum(TF), "_aa.fasta")
	aa_fn
	di3_fn = paste0(mitocog, "_", sum(TF), "_3di.fasta")
	di3_fn

	cmd1 = paste0("cat ./", mitocog, "/*_aa.fasta > ", aa_fn)
	cmd1
	print(cmd1)
	system(cmd1)
	aa_fns = c(aa_fns, aa_fn)
	
	cmd2 = paste0("cat ./", mitocog, "/*_3di.fasta > ", di3_fn)
	cmd2
	print(cmd2)
	system(cmd2)
	di3_fns = c(di3_fns, di3_fn)
	
	# Copy these to each mitocog directory
	todir = paste0("../_03_foldmason_v2/", mitocog, "/", aa_fn)
	file.copy(from=aa_fn, to=todir)
	todir = paste0("../_03_foldmason_v2/", mitocog, "/", "seqs_aa.fasta")
	file.copy(from=aa_fn, to=todir)

	todir = paste0("../_03_foldmason_v2/", mitocog, "/", di3_fn)
	file.copy(from=di3_fn, to=todir)
	todir = paste0("../_03_foldmason_v2/", mitocog, "/", "seqs_3di.fasta")
	file.copy(from=di3_fn, to=todir)
	} # END for (i in 1:length(uniq_mitocogs))

catc(aa_fns)

run_deliberately_so_you_dont_overwrite='aa_fns_list = c("ATP1_41_aa.fasta","ATP3_35_aa.fasta","ATP4_45_aa.fasta","ATP8_36_aa.fasta","ATP9_53_aa.fasta","COB_52_aa.fasta","COX2_49_aa.fasta","COX3_48_aa.fasta","EFTU_32_aa.fasta","NAD1_43_aa.fasta","NAD10_35_aa.fasta","NAD11_37_aa.fasta","NAD2_43_aa.fasta","NAD3_42_aa.fasta","NAD4_44_aa.fasta","NAD4L_46_aa.fasta","NAD5_44_aa.fasta","NAD6_42_aa.fasta","NAD7_41_aa.fasta","NAD8_28_aa.fasta","NAD9_41_aa.fasta","RPL1_30_aa.fasta","RPL10_21_aa.fasta","RPL11_37_aa.fasta","RPL14_46_aa.fasta","RPL16_45_aa.fasta","RPL18_14_aa.fasta","RPL19_28_aa.fasta","RPL2_46_aa.fasta","RPL20_27_aa.fasta","RPL27_32_aa.fasta","RPL31_9_aa.fasta","RPL32_18_aa.fasta","RPL34_24_aa.fasta","RPL35_8_aa.fasta","RPL36_17_aa.fasta","RPL5_31_aa.fasta","RPL6_35_aa.fasta","RPS1_18_aa.fasta","RPS10_34_aa.fasta","RPS11_40_aa.fasta","RPS12_41_aa.fasta","RPS13_37_aa.fasta","RPS14_40_aa.fasta","RPS16_20_aa.fasta","RPS19_39_aa.fasta","RPS2_36_aa.fasta","RPS3_9_aa.fasta","RPS4_29_aa.fasta","RPS7_40_aa.fasta","RPS8_25_aa.fasta","SDH2_49_aa.fasta","SDH3_35_aa.fasta","SDH4_28_aa.fasta")

catc(di3_fns)
di3_fns_list = c("ATP1_41_3di.fasta","ATP3_35_3di.fasta","ATP4_45_3di.fasta","ATP8_36_3di.fasta","ATP9_53_3di.fasta","COB_52_3di.fasta","COX2_49_3di.fasta","COX3_48_3di.fasta","EFTU_32_3di.fasta","NAD1_43_3di.fasta","NAD10_35_3di.fasta","NAD11_37_3di.fasta","NAD2_43_3di.fasta","NAD3_42_3di.fasta","NAD4_44_3di.fasta","NAD4L_46_3di.fasta","NAD5_44_3di.fasta","NAD6_42_3di.fasta","NAD7_41_3di.fasta","NAD8_28_3di.fasta","NAD9_41_3di.fasta","RPL1_30_3di.fasta","RPL10_21_3di.fasta","RPL11_37_3di.fasta","RPL14_46_3di.fasta","RPL16_45_3di.fasta","RPL18_14_3di.fasta","RPL19_28_3di.fasta","RPL2_46_3di.fasta","RPL20_27_3di.fasta","RPL27_32_3di.fasta","RPL31_9_3di.fasta","RPL32_18_3di.fasta","RPL34_24_3di.fasta","RPL35_8_3di.fasta","RPL36_17_3di.fasta","RPL5_31_3di.fasta","RPL6_35_3di.fasta","RPS1_18_3di.fasta","RPS10_34_3di.fasta","RPS11_40_3di.fasta","RPS12_41_3di.fasta","RPS13_37_3di.fasta","RPS14_40_3di.fasta","RPS16_20_3di.fasta","RPS19_39_3di.fasta","RPS2_36_3di.fasta","RPS3_9_3di.fasta","RPS4_29_3di.fasta","RPS7_40_3di.fasta","RPS8_25_3di.fasta","SDH2_49_3di.fasta","SDH3_35_3di.fasta","SDH4_28_3di.fasta")

# Copy all of these to the new directory
to_fns = paste("../BLAH/", aa_fns, sep="")
to_fns
file.copy(from=aa_fns, to=to_fns, overwrite=TRUE)
to_fns = paste("../BLAH/", di3_fns, sep="")
to_fns
file.copy(from=di3_fns, to=to_fns, overwrite=TRUE)

'

cmds='
cd /GitHub/str2phy/ex/MitoCOGs/_03_foldmason_v2/
mkdir z_2025-02-03_FASTAs_bkup
cp -r *.fasta z_2025-02-03_FASTAs_bkup

'







