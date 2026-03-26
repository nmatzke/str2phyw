
#######################################################
# 2025-11-18
# The *GOOD* download script
# does GCF or GCA
# gets everything
# all files labeled
# ~/DropboxUoA/flag/Full_genomes/_11a_cmds_downloading_10more_genomes_UnivTranslate_v1.sh
#######################################################

# Run with:
run_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes/
chmod u+x *.sh
./_11a_cmds_downloading_10more_genomes_UnivTranslate_v1.sh
'

genomeIDs_to_wget_fn="2025-11-27_UnivTranslate_genomes_to_add4.txt"
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
	#cp -r $genomeID ~/DropboxUoA/flag/Full_genomes/z_genomes_discard/adding_53_genomes_for_remaining_unmatched/
done <"$genomeIDs_to_wget_fn"

echo "Done! (finally!)"

