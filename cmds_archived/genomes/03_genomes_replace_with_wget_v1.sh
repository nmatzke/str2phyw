# For these genomes (at bottom), remove and download via wget
# (these genomes have "protein.faa", we'd rather have the consistent
#  format that mirrors what you get from wget ie the exact NCBI FTP filenames)

# Run with:
run_cmds='
cd ~/DropboxUoA/flag/Full_genomes/genomes/
./03_genomes_replace_with_wget_v1.sh
'

genomeIDs_to_wget_fn="genomes_replace_with_wget.txt"
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
	cp -r $genomeID ~/DropboxUoA/flag/Full_genomes/z_genomes_discard/replacing_wBetter_wget_downloads/
done <"$genomeIDs_to_wget_fn"

echo "Done! (finally!)"

# NOTES 
files_to_fix="GCA_000007605.1/protein.faa
GCA_000009945.1/protein.faa
GCA_000011905.1/protein.faa
GCA_000015565.1/protein.faa
GCA_000017305.1/protein.faa
GCA_000017745.1/protein.faa
GCA_000020005.1/protein.faa
GCA_000021285.1/protein.faa
GCA_000021565.1/protein.faa
GCA_000021645.1/protein.faa
GCA_000085865.1/protein.faa
GCA_000091165.1/protein.faa
GCA_000167135.1/protein.faa
GCA_000169155.1/protein.faa
GCA_000171895.1/protein.faa
GCA_000173615.1/protein.faa
GCA_000174415.1/protein.faa
GCA_000210915.2/protein.faa
GCA_000212395.1/protein.faa
GCA_000214825.1/protein.faa
GCA_000218855.1/protein.faa
GCA_000238915.2/protein.faa
GCA_000284335.1/protein.faa
GCA_000341545.2/protein.faa
GCA_000470775.1/protein.faa
GCA_000513475.1/protein.faa
GCA_000522425.1/protein.faa
GCA_000739515.1/protein.faa
GCA_001399775.1/protein.faa
GCA_001442745.1/protein.faa
GCA_001547735.1/protein.faa
GCA_001618605.1/protein.faa
GCA_001886855.1/protein.faa
GCA_001997065.1/protein.faa
GCA_002081995.1/protein.faa
GCA_002119425.1/protein.faa
GCA_002216005.1/protein.faa
GCA_002355975.1/protein.faa
GCA_002869225.1/protein.faa
GCA_002872415.1/protein.faa
GCA_003057965.1/protein.faa
GCA_003244105.1/protein.faa
GCA_003290465.1/protein.faa
GCA_003599815.1/protein.faa
GCA_003789105.1/protein.faa
GCA_003864455.1/protein.faa
GCA_004195035.1/protein.faa
GCA_004195045.1/protein.faa
GCA_004340685.1/protein.faa
GCA_006716815.1/protein.faa
GCA_008086245.1/protein.faa
GCA_009767585.1/protein.faa
GCA_009917695.1/protein.faa
GCA_014467015.1/protein.faa
GCA_015775515.1/protein.faa
GCA_016185465.1/protein.faa
GCA_018240225.1/protein.faa
GCA_018725125.1/protein.faa
GCA_018885085.1/protein.faa
GCA_022539405.1/protein.faa
GCA_022558445.1/protein.faa
GCA_023617515.1/protein.faa
GCA_030285425.1/protein.faa
GCA_030316605.1/protein.faa
GCA_030765135.1/protein.faa
GCA_030765365.1/protein.faa
GCA_030765405.1/protein.faa
GCA_030765455.1/protein.faa
GCA_030765525.1/protein.faa
GCA_030765645.1/protein.faa
GCA_030765805.1/protein.faa
GCA_030765845.1/protein.faa
GCA_038745945.1/protein.faa
GCA_048320135.1/protein.faa
GCA_900142275.1/protein.faa
GCA_900465355.1/protein.faa
GCA_900637845.1/protein.faa
GCF_000336385.2/protein.faa"


