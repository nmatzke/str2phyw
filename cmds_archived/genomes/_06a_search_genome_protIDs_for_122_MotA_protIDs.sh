# cd ~/DropboxUoA/flag/Full_genomes/genomes
# ./_06a_search_genome_protIDs_for_122_MotA_protIDs.sh

# Test for blank string
var=""
if [ -n "$var" ]; then
    echo "not empty"
else
    echo "empty"
fi

# Test for actual empty variable
var=""
if [ -z "$var" ]; then
    echo "not empty"
else
    echo "empty"
fi

echo "" > motA_470_identicals_for_122_ids_MATCHES_forloop.txt
declare -i i=0
protID="WP_444497551.1"
while read protID; do
	i=$((i+1))
	line_to_output="$i: $protID"
	echo $line_to_output
	
	# Cat to big protein file
	result="$(grep -F $protID 558_genomes_AAs_all_seqIDs.txt)"
	
	if [[ -n "$result" ]]; then
   # $result is empty, do what you want
		line_to_output="$i|$protID|$result"
		echo $line_to_output
		echo $line_to_output > tmpfn.txt
		cat tmpfn.txt >> motA_470_identicals_for_122_ids_MATCHES_forloop.txt
	fi	
done <motA_470_identicals_for_122_ids_to_esl_sfetch_txt.txt

wc -l motA_470_identicals_for_122_ids_MATCHES_forloop.txt
cp motA_470_identicals_for_122_ids_MATCHES_forloop.txt motA_470_identicals_for_122_ids_MATCHES_forloop_ARCHIVE.txt
# 66