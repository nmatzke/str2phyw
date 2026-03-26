
#######################################################
# 2025-10-29: Everything matches, 494 directories!
#######################################################


#######################################################
# Count the directories, check against Excel file
#######################################################
terminal_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes

# List all the 1st-level directories, nothing else, and count
ls -d */ | wc
# 496 - compare to 509 in Excel (!)
# 495 - compare to 494 in Excel (!)

# Pipe to dirslist.txt
ls -d */ > dirslist.txt
wc dirslist.txt

# Check for directories without _protein.faa
Rscript _Rscript_genome_dirs_without_faa_files_v1.R
# None found

# Unzip all of the protein files in a bunch of downloaded directories
# https://stackoverflow.com/questions/32307136/unzip-files-in-subdirectories-bash

cd ~/DropboxUoA/flag/Full_genomes/genomes

# Find the protein zipfiles
find GC*_* -name "*protein.faa.gz"

# Find the files and unzip
find GC*_* -name "*protein.faa.gz" -execdir gunzip '{}' \;

# Concatenate (cat) the unzipped protein files
rm genomes_wLitLinks_GC.fasta  # GCA_, GCF_
rm genomes_wLitLinks_VER.fasta
rm genomes_wLitLinks.fasta

find GC*_* -name "*protein.faa" -execdir cat '{}' \; > genomes_wLitLinks_GC.fasta
find VER*_* -name "*protein.faa" -execdir cat '{}' \; > genomes_wLitLinks_VER.fasta

cat genomes_wLitLinks_VER.fasta genomes_wLitLinks_GC.fasta > genomes_wLitLinks.fasta
rm genomes_wLitLinks_GC.fasta  # GCA_, GCF_
rm genomes_wLitLinks_VER.fasta
'# END terminal_cmds

# R - check against Excel
library(openxlsx)

wd = "~/DropboxUoA/flag/Full_genomes/genomes"
setwd(wd)

dirslist = read.table("dirslist.txt", header=FALSE)
dirslist = dirslist[,1]
length(dirslist)
# 499

xlsfn = "~/DropboxUoA/flag/Full_genomes/species_list_2025-10-26_NJMl.xlsx"
xls = openxlsx::read.xlsx(xlsfn, sheet=1)
head(xls)
tail(xls)
dim(xls)
# 494

xlsfound_TF = rep(FALSE, times=nrow(xls))
xls_GCA_TF = rep(FALSE, times=nrow(xls))
xls_GCF_TF = rep(FALSE, times=nrow(xls))

dirslist_found_TF = rep(FALSE, times=length(dirslist))
dirslist_found_GCA = rep(0, times=length(dirslist))
dirslist_found_GCF = rep(0, times=length(dirslist))

for (i in 1:length(dirslist))
	{
	tmpstr = dirslist[i]
	# Remove _ to |
	tmpstr = gsub(pattern="/", replacement="", x=tmpstr, ignore.case=TRUE)
	tmpstr = gsub(pattern="GCA_", replacement="GCA|", x=tmpstr, ignore.case=TRUE)
	tmpstr = gsub(pattern="GCF_", replacement="GCF|", x=tmpstr, ignore.case=TRUE)
	tmpstr = gsub(pattern="VER_", replacement="VER|", x=tmpstr, ignore.case=TRUE)
	
	# Get the first word, ie GCA_001551835.1
	words = strsplit(tmpstr, split="_")[[1]]
	tmpID = words[1]
	
	# Go back to _
	tmpID = gsub(pattern="GCA\\|", replacement="GCA_", x=tmpID, ignore.case=TRUE)
	tmpID = gsub(pattern="GCF\\|", replacement="GCF_", x=tmpID, ignore.case=TRUE)
	tmpID = gsub(pattern="VER\\|", replacement="VER_", x=tmpID, ignore.case=TRUE)

	
	TF1 = grepl(pattern=tmpID, x=xls$GenBank.ID)
	TF2 = grepl(pattern=tmpID, x=xls$RefSeq)
	xls_nums_TF1 = (1:length(TF1))[TF1]
	xls_nums_TF2 = (1:length(TF2))[TF2]
	
	if (sum(TF1) > 0)
		{
		xls_GCA_TF[xls_nums_TF1] = TRUE
		dirslist_found_GCA[i] = (1:length(TF1))[TF1]
		}
	if (sum(TF2) > 0)
		{
		xls_GCF_TF[xls_nums_TF2] = TRUE
		dirslist_found_GCF[i] = (1:length(TF2))[TF2]
		}

	TF = (TF1 + TF2) > 0
	nums = (1:length(TF))[TF]
	
	if (length(nums) > 0)
		{
		dirslist_found_TF[i] = TRUE
		}
	
	if (length(nums) > 1)
		{
		cat("\n\n")
		print(nums)
		print(xls[nums,])
		}

	if (length(nums) == 0)
		{
		cat("\n")
		cat(paste0(i, ": ", tmpID))
		}

	if (length(nums) == 1)
		{
		xlsfound_TF[nums] = TRUE
		}
	
	TF_both_GCA_GCF = (TF1 + TF2) >= 2
	if (sum(TF_both_GCA_GCF) > 0)
		{
		nums = (1:length(TF_both_GCA_GCF))[TF_both_GCA_GCF]

		cat("\n")
		cat(paste0(i, ": ", tmpID))
		cat("\n")
		cat(nums)
		cat("\n")
		print(xls[nums,])
		}
	} # END for (i in 1:length(dirslist))

# xls genomes NOT found in dirslist
length(xlsfound_TF)
sum(xlsfound_TF)

# Downloaded genome directories NOT found in xls
dirslist[dirslist_found_TF == FALSE]

xls[xlsfound_TF == FALSE,]
sum(xlsfound_TF == FALSE)


dirslist_found_GCA
dirslist_found_GCF

sum_dirs_not_found = (dirslist_found_GCA != 0) + (dirslist_found_GCF != 0)
sum_dirs_not_found
double_TF = sum_dirs_not_found == 2
sum(double_TF)





xls_GCA_TF
xls_GCF_TF
xls_both = (xls_GCA_TF + xls_GCF_TF) == 2
xls[xls_both,]


TF_GCA_nonzero = dirslist_found_GCA != 0
TF_GCF_nonzero = dirslist_found_GCF != 0
tmp = TF_GCA_nonzero + TF_GCF_nonzero
max(tmp)


length(dirslist_found_GCA[TF_GCA_nonzero])
length(unique(dirslist_found_GCA[TF_GCA_nonzero]))

length(dirslist_found_GCF[TF_GCF_nonzero])
length(unique(dirslist_found_GCF[TF_GCF_nonzero]))



