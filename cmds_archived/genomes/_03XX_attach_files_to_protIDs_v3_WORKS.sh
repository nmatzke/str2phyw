#!/bin/sh

# cd ~/DropboxUoA/flag/Full_genomes/genomes/
# ./_03_attach_files_to_protIDs_v3_WORKS.sh

cd ~/DropboxUoA/flag/Full_genomes/genomes

# Overall directory
starting_dir="$HOME/DropboxUoA/flag/Full_genomes/genomes/"
# Output file
outfn1="$HOME/DropboxUoA/flag/Full_genomes/genomes/all_seqnames.txt"
outfn2="$HOME/DropboxUoA/flag/Full_genomes/genomes/all_seqIDs.txt"

# Delete the old files
rm $outfn1
rm $outfn2

# Change to starting directory

cd "$starting_dir" || { echo "Error: Could not change to starting_dir=$starting_dir"; exit 1; }

# Store all the directories (only) in dirslist.txt
rm dirslist.txt
ls -d */ >> dirslist.txt
wc dirslist.txt
# 492 directories

# Go through all of the directories in
# d < dirslist (see after "done")
# 
# Write locations and IDs
echo "while loop is..."
while read d; do
  cd "$starting_dir" || { echo "Error: Could not change to starting_dir=$starting_dir"; exit 1; }
  cd "$d" || { echo "Error: Could not change to subdirector=$d"; exit 1; }
  
  # Get all fasta amino acid (*.faa) files
  filename=`ls -t *tein.faa`
  echo "$d$filename"
  
  # Change dir/filename to dir\/filename
  d2f=$(echo $d$filename | sed 's/\//\\\//g')
  #echo $d2f
  
  # Find every line with ">", output dir/filename tab ID
  grep "^>" "$filename" | cut -d' ' -f1 | sed "s/^>/$d2f\\t/" >> $outfn2
  grep "^>" "$filename" | sed "s/^>/$d2f\\t/" >> $outfn1
done <dirslist.txt

echo "...Done!"

# Change back to home directory
cd "$starting_dir" || { echo "Error: Could not change to starting_dir=$starting_dir"; exit 1; }

head $outfn1
tail $outfn1
wc $outfn1

head $outfn2
tail $outfn2
wc $outfn2


wc $outfn1
wc $outfn2




# R script

wd = "~/DropboxUoA/flag/Full_genomes/genomes"
setwd(wd)
df = read.table("all_seqIDs.txt", header=FALSE)
dim(df)
nrow(df) 							# 1686098 
length(unique(df$V2)) # 1679155


# Make a huge fasta file of all proteins, with genomeID appended in front of each protein ID (for uniqueness)

# # Get all the protein fasta filenames
find GC*_* -name "*protein.faa" > GC_faa_names.txt
find VER*_* -name "*protein.faa" > VER_faa_names.txt
cat VER_faa_names.txt GC_faa_names.txt > faa_names.txt
wc faa_names.txt


