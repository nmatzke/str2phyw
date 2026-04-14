#!/bin/sh

# cd ~/GitHub/str2phyw/01_searching/genomes/

# # ./attach_genomeIDs_to_protIDs_v4.sh

run_cmds='
cd ~/GitHub/str2phyw/01_searching/
chmod a+x *.sh
./attach_genomeIDs_to_protIDs_v4.sh
' # END 
# Overall directory
starting_dir="$HOME/GitHub/str2phyw/01_searching/genomes/"
# Output file
outfn1="$HOME/GitHub/str2phyw/01_searching/genomes/all_seqnames2.txt"
outfn2="$HOME/GitHub/str2phyw/01_searching/genomes/all_seqIDs2.txt"

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
fn="./GCA_000005845.2_ASM584v2/GCA_000005845.2_ASM584v2_protein.faa"
echo "while loop is starting to accumulate protein FASTA files, with the genomeID| appended before proteinID. Listing files processed..."

cd ~/GitHub/str2phyw/01_searching/genomes/
head faa_names.txt

# While loop
while read fn; do
	#echo $fn
	
	# Extract the genome ID, cut "./", add "|"
	string_to_add="$(echo $fn | sed 's#./##g')"
	echo $string_to_add
  string_to_add="$(echo $string_to_add | cut -d'_' -f1,2)"
  string_to_add="${string_to_add}|"
  echo $string_to_add
	
	# Add the genomeID to the front of every headers
	# output to tmpfn.txt
	sed "s#^>#>$string_to_add#" $fn > tmpfn.txt
	
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
	#rm tmpfn.txt 
done <faa_names.txt
echo "...Done"

head 34_genomes_AAs.fasta

wc 34_genomes_AAs.fasta
wc faa_names.txt
wc $outfn1
wc $outfn2



#      34      34    2312 faa_names.txt
#  693734 1616102 53630340 34_genomes_AAs.fasta
#  127995 1050363 12277565 /Users/nmat471/GitHub/str2phyw/01_searching/genomes/all_seqnames.txt
#  127995  127995 3473617 /Users/nmat471/GitHub/str2phyw/01_searching/genomes/all_seqIDs.txt


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

grep -c AAC73118.1 all_seqnames2.txt
grep AAC73118.1 all_seqnames2.txt

# If you get: Failed to write keys to ssi file /Users/nickm/Downloads/34_genomes_AAs.fasta.ssi:
#  primary keys not unique: 'WP_000135199.1' occurs more than once
#grep -c WP_000135199.1 all_seqnames.txt
#grep WP_000135199.1 all_seqnames.txt
# GCF_000264275.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_000264785.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_000439895.1|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
# GCF_905331265.2|WP_000135199.1 MULTISPECIES: 30S ribosomal protein S18 [Gammaproteobacteria]
#grep WP_000135199.1 all_seqIDs2.txt



# esl-sfetch -f 34_genomes_AAs.fasta unique_MotB_ExbD_TolR_hits_IDs.txt > unique_MotB_ExbD_TolR_hits_IDs.fasta
# grep -c ">" unique_MotB_ExbD_TolR_hits_IDs.fasta




# R script
cmds='
wd = "~/GitHub/str2phyw/01_searching/genomes/"
setwd(wd)
df1 = read.table("all_seqIDs2.txt", header=FALSE)
dim(df1)
nrow(df1) 							# 1686098 

df2 = read.table(file="all_seqnames2.txt", header=FALSE, sep="\t", quote="", row.names=NULL, fill=TRUE, strip.white=TRUE, blank.lines.skip=TRUE, stringsAsFactors=FALSE)
dim(df2)								# 127995      2
nrow(df2) 							# 127995
head(df2)
length(unique(df2$V2)) # 127995


'