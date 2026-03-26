# Copy proteomes of original genomes to z_proteomes_wFns
cd ~/DropboxUoA/flag/Full_genomes/genomes

# Find all gzips and unzip

# Find
find . -type f -name "*_protein.faa.gz" | wc 
# 78, then 0
find . -type f -name "*_protein.faa" | wc
# 416, then 493
# Zip the few you find, for backup
# find . -type f -name "*.faa" -execdir gzip '{}' \;

# Unzip all
find . -type f -name "*_protein.faa.gz" -execdir gunzip '{}' \;

# Cat all genomes - see 
find . -type f -name "*_protein.faa" | cat > 620_genomes.fasta
