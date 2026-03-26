
#######################################################
# Find NCBI genome directories with no .faa files
# Nick Matzke
# 2025-10-23
#######################################################
ex = '
cd ~/DropboxUoA/flag/Full_genomes/genomes

# Get the directories into a list in a file; remove last "/" and anything after
wc dirslist.txt
ls -d */ | cut -d "/" -f 1 > dirslist.txt
wc dirslist.txt
Rscript _Rscript_genome_dirs_without_faa_files_v1.R

...done.
WORKED
'


#wd = "~/DropboxUoA/flag/Full_genomes/genomes/"
#setwd(wd)

dirslist = read.table("dirslist.txt", header=FALSE)

for (i in 1:nrow(dirslist))
	{
	faa_list = list.files(path=dirslist[i,1], pattern="*tein.faa")
	if (length(faa_list) < 1)
		{
		cat("\n")
		cat(dirslist[i,1])
		}
	}


cat("\n...done.\n")


# For missing files, submit fna file to 
#
# BACTERIAL AND VIRAL BIOINFORMATICS RESOURCE CENTER
# https://www.bv-brc.org/
# ...to get an faa

# Or, just get the GCF and use their faa