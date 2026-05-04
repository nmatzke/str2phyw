
2026-05-03

Download some of the files from the AlltheBacteria dataset:
https://main--allthebacteria.netlify.app/docs/osf_downloads/

Download the tsv of files
Open in Excel
Construct wget queries for desired files


cd ~/DropboxUoA/flag/allbact/fastas

wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partaa https://osf.io/download/6996a253773e9b01047afee7/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partab https://osf.io/download/6996a27524cdbae3b37afff8/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partac https://osf.io/download/6996a296cac5da78967afb52/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partad https://osf.io/download/6996a2bc17bcd9393c505d9e/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partae https://osf.io/download/6996a2e4a4337377f3655c4a/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partaf https://osf.io/download/6996a30a02cc3fd268655c3b/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partag https://osf.io/download/6996a32b713d10c6d8505a9e/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partah https://osf.io/download/6996a3513e4f8dba55505d1f/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partai https://osf.io/download/6996a376713d10c6d8505abf/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partaj https://osf.io/download/6996a396a4337377f3655c7d/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partak https://osf.io/download/6996a3b8713d10c6d8505ae2/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partal https://osf.io/download/6996a3d9a4337377f3655c97/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partam https://osf.io/download/6996a40017bcd9393c505dda/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partan https://osf.io/download/6996a41fcac5da78967afc10/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partao https://osf.io/download/6996a4403e4f8dba55505d56/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partap https://osf.io/download/6996a465a4337377f3655caf/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partaq https://osf.io/download/6996a487713d10c6d8505b6c/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partar https://osf.io/download/6996a4a873ad282cf8506071/
wget -O all_hypotheticals_under_3000AA_unfiltered.fasta.gz_partas https://osf.io/download/6996a4c5cac5da78967afc64/

# Concatenate all files with cat; 19 GB
cat all_hypotheticals_under_3000AA_unfiltered.fasta.gz_part* > all_hypotheticals_under_3000AA_unfiltered.fasta.parts.gz

gunzip all_hypotheticals_under_3000AA_unfiltered.fasta.parts.gz

rm all_hypotheticals_under_3000AA_unfiltered.fasta.gz_part* 


# Easel indexing
cd ~/DropboxUoA/flag/allbact/fastas
esl-sfetch --index all_hypotheticals_under_3000AA_unfiltered.fasta.parts



cd ~/DropboxUoA/flag/allbact
mkdir ATB_AFDB_map_with_batches
cd ~/DropboxUoA/flag/allbact
wget -O ATB_AFDB_map_with_batches.tsv.gz https://osf.io/download/kebs4/
wget -O ATB_every_protein_with_species.tsv.gz_partaa https://osf.io/download/4fwsm/
wget -O ATB_every_protein_with_species.tsv.gz_partab https://osf.io/download/69969c0801d3283b3d655f5f/
wget -O ATB_every_protein_with_species.tsv.gz_partac https://osf.io/download/69969c1bd359b2eb3e6565a8/

cat ATB_every_protein_with_species.tsv.gz_parta* > ATB_every_protein_with_species.tsv.gz_parts.gz
gunzip ATB_every_protein_with_species.tsv.gz_parts.gz

head ATB_every_protein_with_species.tsv.gz_parts


cd ~/DropboxUoA/flag/allbact

# These didnt work, downloaded manually from: https://osf.io/h7wzy/files/osfstorage
# wget -O 0.2/sample_list.txt.gz https://osf.io/download/eg9ya/
# wget -O 0.2/species_calls.tsv.gz https://osf.io/download/5jxqc/
gunzip species_calls.tsv.gz

# This links to the NCBI taxonomy (not the specific assembly; but we can BLAST for that)
mv sample_list.txt.gz sample_list.txt # (not gzipped)




# Mapping between protein FASTA headers and which batch a structure is in
wget -O ATB_AFDB_map_with_batches.tsv.gz https://osf.io/download/kebs4/
head ATB_AFDB_map_with_batches.tsv
tail ATB_AFDB_map_with_batches.tsv


# Download a single batch of structures
cd ~/DropboxUoA/flag/allbact/structs
wget -O batch001.tar.gz https://osf.io/download/cu5v9/




# Search a sequence against a huge database
cd ~/DropboxUoA/flag/allbact/fastas

# mmseqs easy-search examples/QUERY.fasta examples/DB.fasta alnRes.m8 tmp
mmseqs easy-search examples/A0A0C1Y5B5_9BURK.fasta examples/DB.fasta alnRes.m8 tmp --split-memory-limit 7G --compress 1
# This auto-runs: 
# createdb examples/DB.fasta tmp/10997208387309286532/target --write-lookup 0 --gpu 0 

# mmseqs createdb examples/DB.fasta targetDB
ulimit -n 65536
mmseqs createdb all_hypotheticals_under_3000AA_unfiltered.fasta.parts all_bact_targetDB
mmseqs createindex all_bact_targetDB all_bact_targetDB_index
# write error, but proceeding anyway

# mmseqs easy-search examples/QUERY.fasta targetDB alnRes.m8 tmp
mmseqs easy-search examples/A0A0C1Y5B5_9BURK.fasta all_bact_targetDB alnRes.m8 all_bact_targetDB_index


#######################################################
# Memeory issues with mmseqs
#######################################################

# Try the kmer strategy from ChimeraX:
# https://www.rbvi.ucsf.edu/chimerax/data/kmer-aug2022/kmer_search.html
# https://github.com/RBVI/ChimeraX/tree/ee2ae108b114be6b145a11995096e4dc161a7a44/src/bundles/alphafold/src/kmer_search

# Installs
cd ~/DropboxUoA/flag/allbact/kmer/
curl -O https://raw.githubusercontent.com/RBVI/ChimeraX/develop/src/bundles/alphafold/src/kmer_search/single_line_sequences.py

#python3 -m pip install numpy
brew install numpy
curl -O https://raw.githubusercontent.com/RBVI/ChimeraX/develop/src/bundles/alphafold/src/kmer_search/kmer_search.py

cd ~/DropboxUoA/flag/allbact/kmer/
curl -O https://raw.githubusercontent.com/RBVI/ChimeraX/develop/src/bundles/alphafold/src/kmer_search/make_kmer_index.c
cc make_kmer_index.c -shared -o make_kmer_index.dylib -O3


cd ~/DropboxUoA/flag/allbact/kmer/
# The kmer_search.py script requires the fasta file to have each sequence on one line, not multiple lines.
# A few minutes
python3 single_line_sequences.py < ../fastas/examples/DB.fasta > DB_singleLine.fasta

# A few minutes
nohup python3 kmer_search.py makeindex DB_singleLine.fasta >& makeindex.out &

# Run a search
nohup python3 kmer_search.py sequence_search ../fasta/examples/A0A0C1Y5B5_9BURK.fasta DB_singleLine.fasta 15 1 >& results.txt &



