# Delete genomes replaced with wget genomes

# Run with:
run_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes/
./04_delete_list_of_dirs.sh
'

genomeIDs_to_wget_fn="genomes_replace_with_wget.txt"
echo $genomeIDs_to_wget_fn
wc $genomeIDs_to_wget_fn

while read genomeID; do
	echo $genomeID
	rm -r $genomeID
	# ~/DropboxUoA/flag/Full_genomes/genomes
done <"$genomeIDs_to_wget_fn"

