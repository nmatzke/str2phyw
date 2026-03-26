# For these genomes (at bottom), remove and download via wget
# (these genomes have "protein.faa", we'd rather have the consistent
#  format that mirrors what you get from wget ie the exact NCBI FTP filenames)

# Run with:
run_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes/
chmod u+x *.sh
./03b_wget_12genomes_v1.sh
'

genomeIDs_to_wget_fn="2025-10-27_get12genomes.txt"
echo $genomeIDs_to_wget_fn

# genomeID="GCA_000007605.1"


while read genomeID; do
	echo $genomeID
done <"$genomeIDs_to_wget_fn"

while read genomeID; do
	echo $genomeID
	ftp_url=""

	# GCA_ genomes from GebBank
	if [[ $genomeID == GCA_* ]]; then 
		echo "esearch is looking for the FTP url for the GCA_ genome"

		# NOTE: THIS ONE KILLS THE WHILE LOOP (needs <dev/null)
		#ftp_url="$(esearch -query $genomeID -db assembly | esummary | xtract -pattern DocumentSummary -element FtpPath_GenBank)"
		
		# WORKS
		ftp_url=$(esearch -query $genomeID -db assembly </dev/null | esummary | xtract -pattern DocumentSummary -element FtpPath_GenBank)
		echo $ftp_url
	
	# GCF_ genomes from RefSeq
	elif [[ $genomeID == GCF_* ]]; then 
		echo "esearch is looking for the FTP url for the GCF_ genome"
		ftp_url=$(esearch -query $genomeID -db assembly </dev/null | esummary | xtract -pattern DocumentSummary -element FtpPath_RefSeq)
		#head ftp_url.txt
	else
		echo "ERROR: The genomeID '$genomeID' needs to start with either 'GCA_' or 'GCF_'."
		#false || exit 1 # Exit the script
	fi  # End the if/elif/else statement
	
	# Get the last part of ftppath into a directory name ($NF)
	dirname=$(echo "$ftp_url" | awk -F"/" '{print $NF}')
	echo $dirname
	
	# Assemble and run wget command
	#wget -r -nd -nH -np -P $dirname $ftp_url 
	wget -r --no-directories –-no-host-directories --no-parent --directory-prefix=$dirname $ftp_url
	#cp -r $genomeID ~/DropboxUoA/flag/Full_genomes/z_genomes_discard/replacing_wBetter_wget_downloads/
done <"$genomeIDs_to_wget_fn"

echo "Done! (finally!)"

