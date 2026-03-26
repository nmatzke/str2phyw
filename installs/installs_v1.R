

#######################################################
# BASICS
#######################################################
# 
# Code editor: 
# - You need a good text editor for code (NOT WORD, NOTEPAD, Google Docs etc.)
# - Good options: RStudio's code editor (see RStudio, below); BBedit (for Macs); Visual Studio code (VS code)
# 
# GitHub: 
# - Get a free GitHub account
# - Install GitHub Desktop: https://desktop.github.com/download/
# - File -> Clone Repository -> URL -> https://github.com/nmatzke/str2phyw
# 
# - Also, create a symbolic link (or shortcut) so that your GitHub directory
#   is accessible at ~/GitHub/ .  (~ is your home directory)
# 
# e.g.:
#         ln -s /path/to/original /path/to/link 
#         ln -s /Users/nmat471/Documents/GitHub /Users/nmat471/GitHub
# 
# Terminal commands to change directory to home (cd ~), 
# check working directory (pwd)
# list directories (ls -d)
# 
# cd ~
# pwd
# ls -d G*
# 



install_cmds_that_work_as_of_2026='

# Installation-from-scratch commands
install.packages("devtools")
install.packages("ape")
install.packages("Rcpp")
install.packages("ape")
install.packages("FD")
install.packages("snow")

# Install additional dependencies
install.packages(c("plotrix","gdata","minqa","fdrtool","statmod","SparseM","spam","MultinomialCI"))

install.packages("phytools")
install.packages("phangorn")
install.packages("phylobase")
install.packages("optimx")
install.packages("GenSA")

# Install from CRAN Matzke's wrappers for FORTRAN EXPOKIT and C++ cladogenesis calculations
install.packages("rexpokit")
install.packages("cladoRcpp")

# (BioGeoBEARS is pure R, so installation is easy *if* the above 
#  packages have been installed)
library(devtools)
devtools::install_github(repo="nmatzke/BioGeoBEARS")



#######################################################
# R packages useful for bioinformatics
#######################################################
install.packages("BiocManager")
library(BiocManager)
BiocManager::install(c("BiocGenerics", "annotate", "Biostrings" , "genomes", "S4Vectors", "IRanges", "XVector", "zlibbioc"))
BiocManager::install("msa")
BiocManager::install("ginmappeR")

install.packages("rentrez") # for entrez_fetch
install.packages("seqinr")
install.packages("rvest")
install.packages("rexpokit")
install.packages("cladoRcpp")
install.packages("phytools")
install.packages("openxlsx")
install.packages("queryup")

# Install rBLAST
# https://github.com/mhahsler/rBLAST
# 1. Get BLAST tools from:
#    https://blast.ncbi.nlm.nih.gov/Blast.cgi?PAGE_TYPE=BlastDocs&DOC_TYPE=Download
#
# 2. Install .dmg to: 
#    cd /usr/local/ncbi/blast/bin
#
# blast_formatter		deltablast		rpsblast
# blastdb_aliastool	dustmasker		rpstblastn
# blastdbcheck		get_species_taxids.sh	segmasker
# blastdbcmd		legacy_blast.pl		tblastn
# blastn			makeblastdb		tblastx
# blastp			makembindex		update_blastdb.pl
# blastx			makeprofiledb		windowmasker
# convert2blastmask	psiblast
#
# 3. Install rBLAST:
library(devtools)
install_github("mhahsler/rBLAST") 

	
# To install reutils (if needed):
# EXPIRED, use reutils Use genomes::efetch to download genes
# Download from: https://cran.r-project.org/src/contrib/Archive/reutils/
# install.packages(pkgs="~/Downloads/", type="source")

devtools::install_github("brouwern/compbio4all")
' # END install_cmds_that_work_as_of_2026


# Load libraries
library(ape)
library(BioGeoBEARS)	# for cls.df, prt(), etc.
library(gdata)			# for trim
library(rentrez) # Fetching full records: entrez_fetch()

library(seqinr)			# for reading sequences, one version of read.fasta() etc.
library(ginmappeR)  # for ginmappeR::getNCBIIdenticalProteins(), get_info_from_seqIDs_v1.R::get_IDs_identical_proteins
library(queryup)		# for queryup::query_uniprot, get_info_from_seqIDs_v1.R::get_uniprot_data_on_seqids
library(rentrez)		# for rentrez::entrez_fetch(db="protein", id=MotA_seq_ids[1:170], rettype="fasta")
library(bio3d)			# for bio3d::pdbsplit
library(Biostrings)  # for reverseComplement
library(BiocGenerics)
library(annotate)		# for Bioconductors 
						# "genbank" (efetch by 
						# gene Accession #s)
						# "blastSequences"
library(genomes)   # for genomes::efetch to download genes

# library(reutils)  # for efetch
# EXPIRED, use reutils Use genomes::efetch to download genes
# library(compbio4all)# for compbio4all::entrez_fetch_list(), rooted_NJ_tree(), print_msa()

library(restez) # for restez::entrez_fetch, restez:::extract_features
								# restez: Create and Query a Local Copy of GenBank in R
								# Download large sections of GenBank 
								# and generate a local SQL-based database. A user can then 
								# query this database using restez functions or through 
								# rentrez https://CRAN.R-project.org/package=rentrez wrappers.
library(readr) 	# The goal of readr is to provide a fast and friendly way 
								# to read rectangular data (like csv, tsv, and fwf). 
								# It is designed to flexibly parse many types of data found in the wild, 
								# while still cleanly failing when data unexpectedly changes.


sourceall("~/GitHub/str2phy/Rsrc/")
