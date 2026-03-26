# For these genomes (at bottom), efetch the taxonomy
# and species / strain

# Run with:
run_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes/
chmod a+x *.sh
./genomes_to_taxonomy_v1.sh

# This works better than e.g.:
# NCBI CLI (Command Line Interface)
# datasets summary genome accession --inputfile 2025-11-27_UnivTranslate_genomes_to_add4_to_spreadsheet.txt --as-json-lines | dataformat excel genome --outputfile temp.xlsx

# Another option:
# esearch -db assembly -query "GCA_001041635" | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" singlequoteBEGIN{ORS=", ";}{print $3;}singlequote
'

genomeIDs_to_wget_fn="tmp_genomeIDs.txt"
echo $genomeIDs_to_wget_fn

# genomeID="GCA_000007605.1"
genomeID="GCA_000212755.3"
genomeID="GCF_000429645.1"

# Output taxonomy
echo "" > genomes_to_match_taxonomy.txt
# Output names
echo "" > genomes_to_match_names.txt

while read genomeID; do
	echo $genomeID
done <"$genomeIDs_to_wget_fn"

echo ""
echo "Getting taxonomy and species names / strain / isolate"

while read genomeID; do
	echo $genomeID
	if [[ $genomeID == GCA_* ]]; then 
		echo "epost/xtract is looking for info for the GCA_ genome"
		echo $genomeID | epost -db assembly | esummary | xtract -pattern DocumentSummary -def "NA" -block Synonym -element Genbank -block DocumentSummary -element AssemblyName FtpPath_GenBank SpeciesName Strain Isolate >> genomes_to_match_names.txt
		echo $genomeID | epost -db assembly | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}' >> genomes_to_match_taxonomy.txt
		#echo "\n" >> genomes_to_match_taxonomy.txt
	# GCF_ genomes from RefSeq
	elif [[ $genomeID == GCF_* ]]; then 
		echo "epost/xtract is looking for info for the GCF_ genome"
		echo $genomeID | epost -db assembly | esummary | xtract -pattern DocumentSummary -def "NA" -block Synonym -element RefSeq -block DocumentSummary -element AssemblyName FtpPath_RefSeq SpeciesName Strain Isolate >> genomes_to_match_names.txt
		echo $genomeID | epost -db assembly | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}' >> genomes_to_match_taxonomy.txt
		#echo "\n" >> genomes_to_match_taxonomy.txt
	else
		echo "ERROR: The genomeID '$genomeID' needs to start with either 'GCA_' or 'GCF_'."
		#false || exit 1 # Exit the script
	fi  # End the if/elif/else statement
done <"$genomeIDs_to_wget_fn" # For these genomes (at bottom), efetch the taxonomy
# and species / strain

echo "Done! (finally!)"


cp genomes_to_match_names.txt genomes_to_match_names_bkup.txt
cp genomes_to_match_taxonomy.txt genomes_to_match_taxonomy_bkup.txt

echo "Done copying to backups."


# WATCH OUT THESE DON'T KEEP INPUT ORDER
# Faster, but slightly less customized:
# cd ~/DropboxUoA/flag/Full_genomes/z_genomes_to_match_/

# Another option -- BUT DOES NOT KEEP GCA order...
# These seemingly don't come out in the same order?!??!?
# epost -db assembly -input tmp_genomeIDs.txt | esummary | xtract -pattern DocumentSummary -def "NA" -block Synonym -element Genbank -block DocumentSummary -element AssemblyName FtpPath_GenBank SpeciesName Strain Isolate > tmp_output_names_FtpPath_GenBank.txt
# epost -db assembly -input tmp_genomeIDs.txt | esummary | xtract -pattern DocumentSummary -def "NA" -block Synonym -element Genbank -block DocumentSummary -element AssemblyName FtpPath_RefSeq SpeciesName Strain Isolate > tmp_output_names_FtpPath_RefSeq.txt
# epost -db assembly -input tmp_genomeIDs.txt | elink -target taxonomy | efetch -format native -mode xml | grep "Lineage>" | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}{print "\n"}' > tmp_output_taxonomy.txt
# 
# more tmp_output_names_FtpPath_GenBank.txt
# more tmp_output_names_FtpPath_RefSeq.txt
# more tmp_output_taxonomy.txt





# These work INDIVIDUALLY, but use EPOST when iterating
#esearch -db assembly -query $genomeID | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate | echo >> genomes_to_match_names.txt
#esearch -db assembly -query $genomeID | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}' | echo >> genomes_to_match_taxonomy.txt

# echo $genomeID | epost -db assembly | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate >> genomes_to_match_names.txt

# esearch -db assembly -query "GCA_020510585.1,GCA_020783165.1" | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate >> genomes_to_match_names.txt


# These work INDIVIDUALLY, but use EPOST when iterating
#esearch -db assembly -query $genomeID | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate | echo >> genomes_to_match_names.txt
#esearch -db assembly -query $genomeID | elink -target taxonomy | efetch -format native -mode xml | grep ScientificName | awk -F ">|<" 'BEGIN{ORS="\t";}{print $3;}' | echo >> genomes_to_match_taxonomy.txt

# echo $genomeID | epost -db assembly | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate >> genomes_to_match_names.txt

# esearch -db assembly -query "GCA_020510585.1,GCA_020783165.1" | esummary | xtract -pattern DocumentSummary -def "NA" -element AssemblyAccession AssemblyName SpeciesName Strain Isolate >> genomes_to_match_names.txt

cp genomes_to_match_names.txt genomes_to_match_names_bkup.txt
cp genomes_to_match_taxonomy.txt genomes_to_match_taxonomy_bkup.txt
