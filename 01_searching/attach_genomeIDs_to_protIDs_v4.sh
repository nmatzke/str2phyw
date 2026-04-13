#!/bin/sh

# cd ~/GitHub/str2phyw/01_searching/genomes/

# # ./attach_genomeIDs_to_protIDs_v4.sh

run_cmds='
cd ~/GitHub/str2phyw/01_searching/genomes/
chmod a+x *.sh
./attach_genomeIDs_to_protIDs_v4.sh
' # END 
# Overall directory
starting_dir="$HOME/GitHub/str2phyw/01_searching/genomes/"
# Output file
outfn1="$HOME/GitHub/str2phyw/01_searching/genomes/all_seqnames.txt"
outfn2="$HOME/GitHub/str2phyw/01_searching/genomes/all_seqIDs.txt"

# Delete the old files
rm $outfn1
rm $outfn2

# Change to starting directory

cd "$starting_dir" || { echo "Error: Could not change to starting_dir=$starting_dir"; exit 1; }

# Store all the directories (only) in dirslist.txt
rm dirslist.txt
ls -d GC*/ > dirslist.txt
wc dirslist.txt
# 34 directories, now all matched to Excel

# Go through all of the directories in
# d < dirslist (see after "done")
# 
# Write genomeIDs and IDs, along with file locations to a table

# None with names of just "protein.faa"
find . -name "*_protein.faa" | wc

cd ~/GitHub/str2phyw/01_searching/genomes/

# Make a huge fasta file of all proteins, with genomeID appended in front of each protein ID (for uniqueness)

# # Get all the protein fasta filenames
find . -name "*_protein.faa" > faa_names.txt
head faa_names.txt
wc faa_names.txt
# 34

# All proteins
rm 34_genomes_AAs.fasta
rm 34_genomes_AAs.fasta.ssi

# Test a message
fn="GCA_000005825.2_ASM582v2/GCA_000005825.2_ASM582v2_protein.faa"
echo "while loop is starting to accumulate protein FASTA files, with the genomeID| appended before proteinID. Listing files processed..."

cd ~/GitHub/str2phyw/01_searching/


# While loop
while read fn; do
	#echo $fn
	
	# Extract the genome ID, add "|"
  string_to_add="$(echo $fn | cut -d'_' -f1,2)"
  string_to_add="${string_to_add}|"
  echo $string_to_add
	
	# Add the genomeID to the front of every headers
	# output to tmpfn.txt
	sed "s/^>/>$string_to_add/" $fn > tmpfn.txt
	
	#echo "This is a sample line." | sed "s/^\([^ ]*\)/\1 $string_to_add/"
	#sed "s/^\([^ ]*\)/\1 $string_to_add/" $fn > tmpfn.txt
	#head tmpfn.txt

  # Find every line with ">", output dir/filename tab ID
  grep "^>" tmpfn.txt | cut -d' ' -f1 | sed "s/^>//" >> $outfn2
  grep "^>" tmpfn.txt | sed "s/^>//" >> $outfn1
	
	# Cat to big protein file
	cat tmpfn.txt >> 34_genomes_AAs.fasta
	#cat $fn >> 34_genomes_AAs.fasta
	
	# Remove temporary file
	rm tmpfn.txt 
done <genomes/faa_names.txt
echo "...Done!"

cd genomes
head 34_genomes_AAs.fasta

wc 34_genomes_AAs.fasta
wc faa_names.txt
wc $outfn1
wc $outfn2

stop

# 9304779 20314984 713894367 34_genomes_AAs.fasta
#        494     494   33088 faa_names.txt
# 1690668 12700874 158107802 /Users/nmat471/DropboxUoA/flag/Full_genomes/genomes/34_genomes_AAs_all_seqnames.txt
#  1690668 1690668  46295900 /Users/nmat471/DropboxUoA/flag/Full_genomes/genomes/34_genomes_AAs_all_seqIDs.txt


#######################################################
# Make a super-fast lookup table with hmmer/esl (easel)
#######################################################
# ~/DropboxUoA/flag/Full_genomes/genomes/_06_attach_genomeIDs_to_protIDs_v3_WORKS.sh
#######################################################
cd ~/GitHub/str2phyw/01_searching/genomes/
esl-sfetch --index 34_genomes_AAs.fasta
# Indexed 1230794 sequences (1230794 names).
# SSI index written to file 34_genomes_AAs.fasta.ssi

# cp ~/Downloads/34_genomes_AAs.fasta .
# cp ~/Downloads/34_genomes_AAs.fasta.ssi .
# cp 34_genomes_AAs_all_seqnames.txt ~/Downloads/
# cp 34_genomes_AAs_all_seqIDs.txt ~/Downloads/ # for fast grepping

grep -c WP_444497551.1 34_genomes_AAs_all_seqnames.txt
grep WP_444497551.1 34_genomes_AAs_all_seqnames.txt

# Failed to write keys to ssi file /Users/nickm/Downloads/34_genomes_AAs.fasta.ssi:
#  primary keys not unique: 'WP_000135199.1' occurs more than once
grep -c WP_000135199.1 34_genomes_AAs_all_seqnames.txt
grep WP_000135199.1 34_genomes_AAs_all_seqnames.txt
# GCF_000264275.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_000264785.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_000439895.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_905331265.2|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
grep WP_000135199.1 34_genomes_AAs_all_seqIDs.txt



# esl-sfetch -f 34_genomes_AAs.fasta unique_MotB_ExbD_TolR_hits_IDs.txt > unique_MotB_ExbD_TolR_hits_IDs.fasta
# grep -c ">" unique_MotB_ExbD_TolR_hits_IDs.fasta




# R script
cmds='
wd = "~/DropboxUoA/flag/Full_genomes/genomes"
setwd(wd)
df = read.table("all_seqIDs.txt", header=FALSE)
dim(df)
nrow(df) 							# 1686098 
length(unique(df$V2)) # 1679155
'