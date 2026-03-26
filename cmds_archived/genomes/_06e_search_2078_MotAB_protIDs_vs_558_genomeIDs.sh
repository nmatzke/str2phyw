# cd ~/DropboxUoA/flag/Full_genomes/genomes
# chmod u+x *.sh
# ./_06e_search_2078_MotAB_protIDs_vs_558_genomeIDs.sh

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

echo "" > IPGs_2078_match_to_558genomes_MATCHES_forloop.txt
rm IPGs_2078_match_to_558genomes_MATCHES_forloop.txt
declare -i i=0
protID="ADC48070.1_GCA_000005825.2"
while read protID; do
	i=$((i+1))
	line_to_output="$i: $protID"
	echo $line_to_output
	
	# Cat to big protein file
	result="$(grep -F $protID all_seqnames_wUnderscores.txt)"
	#echo "" > tmp_grep_output.txt
	#rm tmp_grep_output.txt
	# grep patterns with spaces
	#grep -F "$protID" all_seqnames.txt > tmp_grep_output.txt
	#result=`cat tmp_grep_output.txt`
	#echo "$result"
	
	if [[ -n "$result" ]]; then
   # $result is empty, do what you want
		line_to_output="$i|$protID|$result"
		echo $line_to_output
		echo $line_to_output > tmpfn.txt
		cat tmpfn.txt >> IPGs_2078_match_to_558genomes_MATCHES_forloop.txt
	fi	
done <IPGs_2078_match_to_558genomes.txt

ls -la IPGs_2078_match_to_558genomes_MATCHES_forloop.txt
head IPGs_2078_match_to_558genomes_MATCHES_forloop.txt
wc -l IPGs_2078_match_to_558genomes_MATCHES_forloop.txt

cp IPGs_2078_match_to_558genomes_MATCHES_forloop.txt IPGs_2078_match_to_558genomes_MATCHES_forloop_ARCHIVE.txt
# 66 hits